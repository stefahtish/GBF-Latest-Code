codeunit 50124 "Laboratory Management"
{
    trigger OnRun()
    var
    begin
        DeletSampleIds()end;
    procedure DeletSampleIds()
    var
        SampleRec: Record "Sample Reception Header";
    begin
        SampleRec.Reset();
        SampleRec.SetRange(SampleID, '=%1', '');
        if SampleRec.Find('-')then repeat SampleRec.SampleID:='';
                SampleRec.Modify();
            until SampleRec.Next() = 0;
    end;
    procedure TransferSampleToAnalysis(var SampleRec: Record "Sample Reception Header")
    var
        SampleRecTest: Record "Sample Test Lines";
        SampleRecCond: Record "Sample Conditions Line";
        SampleAnalysisH: Record "Sample Analysis And Reporting";
        SampleAnalysisTest: Record "Sample Test Lines";
        SampleAnalysisCond: Record "Sample Conditions Line";
        AnalysisNo: Code[20];
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Labsetup: Record "Lab Setup";
        LabSections: Record "Laboratory Setup Type";
    begin
        Labsetup.get;
        SampleAnalysisH.Init();
        SampleAnalysisH."Sample ID":=SampleRec.SampleID;
        SampleAnalysisH.Validate("Lab section received");
        SampleAnalysisH."Batch No.":=SampleRec."Batch No.";
        SampleAnalysisH."Manufacture Date":=SampleRec."Manufacture Date";
        SampleAnalysisH."Sample Reception No":=SampleRec."Entry No.";
        SampleAnalysisH."Expiry Date":=SampleRec."Expiry Date";
        SampleAnalysisH.Client:=SampleRec.Client;
        SampleAnalysisH."KDB License number":=SampleRec."KDB License number";
        SampleAnalysisH."Schedule No.":=SampleRec."Schedule No.";
        SampleAnalysisH.Cluster:=SampleRec.Cluster;
        SampleAnalysisH."Cluster Option":=SampleRec."Cluster Option";
        SampleAnalysisH."Client Name":=SampleRec."Client Name";
        SampleAnalysisH."Expiry Date":=SampleRec."Expiry Date";
        SampleAnalysisH."Manufacture Date":=SampleRec."Manufacture Date";
        SampleAnalysisH."Sample Type":=SampleRec."Sample Type";
        SampleAnalysisH.Insert(true);
        //Get analysis no        
        AnalysisNo:=SampleAnalysisH."Analysis No.";
        //insert condition lines
        SampleRecCond.Reset();
        SampleRecCond.SetRange("Entry No.", SampleRec."Entry No.");
        if SampleRecCond.Find('-')then begin
            repeat SampleAnalysisCond.Init();
                SampleAnalysisCond.Code:=SampleRecCond.Code;
                SampleAnalysisCond.Description:=SampleRecCond.Description;
                SampleAnalysisCond."Entry No.":=AnalysisNo;
                SampleAnalysisCond.Insert();
            until SampleRecCond.Next() = 0;
        end;
        //insert test lines
        SampleRecTest.Reset();
        SampleRecTest.SetRange("Entry No.", SampleRec."Entry No.");
        if SampleRecTest.Find('-')then begin
            repeat SampleAnalysisTest.Init();
                SampleAnalysisTest.TransferFields(SampleRecTest);
                SampleAnalysisTest."Entry No.":=AnalysisNo;
                SampleAnalysisTest.Insert();
            until SampleRecTest.Next() = 0;
        end;
        SampleRec."Sent to Lab":=true;
        SampleRec.Modify();
    end;
    procedure TransferSampleToLab(var SampleRec: Record "Sample Analysis And Reporting")
    var
        SampleRecTest: Record "Sample Test Lines";
        SampleTestHeader: Record "Sample Test Header";
        SampleTestLines: Record "Sample Test";
        TestNo: Code[20];
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Labsetup: Record "Lab Setup";
        LabSections: Record "Laboratory Setup Type";
    begin
        Labsetup.get;
        //create test header and lines
        SampleRecTest.Reset();
        SampleRecTest.SetRange("Entry No.", SampleRec."Analysis No.");
        //SampleRecTest.SetRange("To be tested", true);
        SampleRecTest.setrange("Cannot be done", false);
        if SampleRecTest.Find('-')then repeat Labsetup.Get();
                SampleTestHeader.Init();
                SampleTestHeader."Test No.":=NoSeriesManagement.GetNextNo(Labsetup."Test No.", 0D, TRUE);
                SampleTestHeader."Lab section":=SampleRecTest.Lab;
                SampleTestHeader."Sample Code":=SampleRecTest."Sample ID";
                if LabSections.Get(SampleTestHeader."Lab section")then SampleTestHeader."Done By":=LabSections."Employee Name";
                SampleTestHeader."Sample Name":=SampleRecTest."Sample Name";
                SampleTestHeader."Lab section":=SampleRecTest.Lab;
                SampleTestHeader."Test to be conducted":=SampleRecTest.Test;
                SampleTestHeader."Sample Reception No":=SampleRec."Analysis No.";
                SampleTestHeader.Validate("Test to be conducted");
                SampleTestHeader.Insert(true);
                SetControlAppearance(SampleTestHeader);
                SampleTestLines.Init();
                SampleTestLines."Test No.":=SampleTestHeader."Test No.";
                SampleTestLines."Sample ID":=SampleRecTest."Sample ID";
                SampleTestLines."Sample Name":=SampleRecTest."Sample Name";
                SampleTestLines.TestToConduct:=SampleTestHeader."Test to be conducted";
                SampleTestLines.testtoconduct2:=SampleTestHeader.TestForm;
                SampleTestLines."Done By":=SampleTestHeader."Done By";
                SampleTestLines."Analysis No.":=SampleRec."Analysis No.";
                SampleTestLines."Checked By":=SampleTestHeader."Checked By";
                SampleTestLines.Insert(true);
            until SampleRecTest.Next() = 0;
        SampleRec."Sent to Lab":=true;
        SampleRec.Modify();
        Message('Sample sent to lab successfully');
    end;
    procedure SubmitResults(var SampleRecHeader: Record "Sample Test Header")
    var
        SampleRecTest: Record "Sample Test Lines";
        SampleRec: Record "Sample Test";
        SampleAnalysis: Record "Sample Analysis And Reporting";
        UserSetup: Record "User Setup";
    begin
        SampleRec.Reset();
        SampleRec.SetRange("Test No.", SampleRecHeader."Test No.");
        SampleRec.SetRange(Test, SampleRecHeader.TestForm);
        if SampleRec.find('-')then begin
            SampleRecTest.Reset();
            SampleRecTest.SetRange("Sample ID", SampleRecHeader."Sample Code");
            SampleRecTest.SetRange("Cannot be done", false);
            SampleRecTest.SetRange(Test, SampleRecHeader."Test to be conducted");
            if SampleRecTest.Find('-')then begin
                repeat case SampleRec.Test of SampleRec.Test::"Milk preservation test": begin
                        SampleRecTest.Results:='Rapid Test:  ' + SampleRec."Results Rapid test (mg/L)";
                        SampleRecTest.Specification:=SampleRec."Specifications";
                        SampleRecTest.Remarks:=format(SampleRec."Interpretation(Preserved)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Peroxide Conventional form": begin
                        SampleRecTest.Results:='RPotassium-iodide: ' + format(SampleRec."Results potassium iodide");
                        SampleRecTest.Specification:=SampleRec."Specifications";
                        SampleRecTest.Remarks:=format(SampleRec."Interpretation(Preserved)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Phosphatase test": begin
                        SampleRecTest.Results:='Color Indication:  ' + SampleRec."Color Indication";
                        SampleRecTest.Specification:=SampleRec."Specifications";
                        SampleRecTest.Remarks:=format(SampleRec."Interpretation(Pasteurized)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Butter fat": begin
                        SampleRecTest.Results:='Butter Fat Content:  ' + format(SampleRec."Butter Fat content (%)");
                        SampleRecTest.Specification:=format(SampleRec."Specification (%)") + '%';
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Mycobacterium spp": begin
                        SampleRecTest.Results:='Alcohol Test:  ' + format(SampleRec."Alcohol Test Results");
                        SampleRecTest.Specification:='Alcohol Test: ' + format(SampleRec."Alcohol Test Specifications2");
                        SampleRecTest.Results:='Resazurin Test:  ' + format(SampleRec."Resazurin test results");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Resazurin Test": begin
                        SampleRecTest.Results:='Resazurin Test:  ' + format(SampleRec."Resazurin test results");
                        SampleRecTest.Specification:='Resazurin Test:  ' + SampleRec."Resazurin Test Specifications";
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Antibiotic residue": begin
                        SampleRecTest.Results:='Sulfonamide:  ' + format(SampleRec.Sulfonamide) + 'Beta-Lactam: ' + Format(SampleRec."Beta-Lactam") + 'Tetracycline: ' + Format(SampleRec.Tetracycline);
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::Volume: begin
                        SampleRecTest.Results:='Flow Time in seconds:  ' + format(SampleRec."Flow time in seconds");
                        SampleRecTest.Specification:=format(SampleRec.Specifications);
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::Density: begin
                        SampleRecTest.Results:=format(SampleRec."Results in g/ml") + 'g/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specifications g/ml") + 'g/ml';
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Brix test": begin
                        SampleRecTest.Results:=format(SampleRec."Brix content (g/ml)") + 'g/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specifications g/ml") + 'g/ml';
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::Organoleptic: begin
                        SampleRecTest.Results:='Colour: ' + SampleRec.Colour + 'Odour and Taints: ' + SampleRec."Odour and Taints ";
                        SampleRecTest.Specification:=format(SampleRec.Specifications);
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Free fatty acid": begin
                        SampleRecTest.Results:=SampleRec.Results;
                        SampleRecTest.Specification:=SampleRec.Specifications;
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Acidity test A": begin
                        SampleRecTest.Results:=format(SampleRec."Titer (ml)");
                        SampleRecTest.Specification:=SampleRec.Specifications;
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Acidity  test B": begin
                        SampleRecTest.Results:='pH: ' + format(SampleRec."Titer (ml)") + 'Temp: ' + Format(SampleRec."Specification (%)");
                        SampleRecTest.Specification:=format(SampleRec."Specifications");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Moisture determination": begin
                        SampleRecTest.Results:=format(SampleRec."Moisture Content((W3-W4)/W2");
                        SampleRecTest.Specification:=format(SampleRec."Specification (%w/w)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Moisture analyzer form": begin
                        SampleRecTest.Results:=format(SampleRec."Moisture content (%w/w)");
                        SampleRecTest.Specification:=format(SampleRec."Specification (%w/w)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::Coliforms: begin
                        SampleRecTest.Results:=format(SampleRec."Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d") + 'cfu/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specification (CFU/ml)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Staph.aureaus": begin
                        SampleRecTest.Results:=format(SampleRec."Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d") + 'cfu/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specification (CFU/ml)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"E.coli test": begin
                        SampleRecTest.Results:=format(SampleRec."Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d") + 'cfu/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specification (CFU/ml)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Total plate count": begin
                        SampleRecTest.Results:=format(SampleRec."Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d") + 'cfu/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specification (CFU/ml)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Yeast and molds": begin
                        SampleRecTest.Results:=format(SampleRec."Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d") + 'cfu/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specification (CFU/ml)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Moulds Count": begin
                        SampleRecTest.Results:=format(SampleRec."Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d") + 'cfu/ml';
                        SampleRecTest.Specification:=format(SampleRec."Specification (CFU/ml)");
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    SampleRec.Test::"Aflatoxin M1 form", SampleRec.Test::"Freezing point  test": begin
                        SampleRecTest.Results:=SampleRec.Results;
                        SampleRecTest.Specification:=SampleRec.Specifications;
                        SampleRecTest.Remarks:=format(SampleRec."Remarks(PassFail)");
                        SampleRecTest.Modify();
                    end;
                    else
                    begin
                        SampleRecTest.Results:=SampleRec.Results;
                        SampleRecTest.Specification:=SampleRec.Specifications;
                        SampleRecTest.Remarks:=SampleRec.Remarks;
                        SampleRecTest.Modify();
                    end;
                    end;
                    SampleRecTest."Submission DateTime":=CreateDateTime(Today, Time);
                    SampleRecTest.Modify();
                until SampleRecTest.Next() = 0;
                SampleAnalysis.Reset();
                SampleAnalysis.SetRange("Sample ID", SampleRecHeader."Sample Code");
                if SampleAnalysis.FindFirst()then begin
                    //  SampleAnalysis."Testing officer No." := SampleRecHeader."Done By No.";
                    // SampleAnalysis.Validate("Testing officer No.");
                    SampleAnalysis."Testing date":=SampleRecHeader.Date;
                    SampleAnalysis."Results date":=Today;
                    SampleAnalysis.Remarks:=SampleRecHeader.Remarks;
                    SampleAnalysis.Modify();
                end;
            end;
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId);
            if UserSetup.FindFirst()then begin
                SampleRecHeader."Done By No.":=UserSetup."Employee No.";
                SampleRecHeader."Checked By No.":=UserSetup."Employee No.";
                SampleRecHeader.Validate("Checked By No.");
                SampleRecHeader.Validate("Done By No.");
            end;
            SampleRecHeader.Submitted:=true;
            SampleRecHeader.Modify();
            Message('You have submitted the test results successfully');
        end;
    end;
    procedure SendScheduleNotice(Schedule: Record "Lab Annual Testing Schedule")
    var
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        Email: Codeunit Email;
        // SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of[Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: List of[Text];
        Attachment: Text;
        ErrorMsg: Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt"></b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that there is a lab testing activity:  <Strong> %1 </Strong>-<Strong> between %2 and %3 </Strong> that you have are part of.';
        NoOfRecipients: Integer;
        ScheduleAlloc: Record "Testing Resorce Allocation";
        ScheduleResources: Record "Testing Employee Allocation";
        Employee: Record Employee;
        CompanyInfo: Record "Company Information";
    begin
        ScheduleAlloc.Reset();
        ScheduleAlloc.SetRange("Annual Schedule", Schedule.Code);
        if ScheduleAlloc.find('-')then begin
            Message(ScheduleAlloc.AllocationNo);
            ScheduleResources.Reset();
            ScheduleResources.SetRange("Allocation No", ScheduleAlloc.AllocationNo);
            if ScheduleResources.Find('-')then repeat Message(ScheduleResources."Employee name");
                    //REPEAT
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("E-Mail");
                    SenderName:=CompanyInfo.Name;
                    SenderAddress:=CompanyInfo."E-Mail";
                    Employee.Reset;
                    Employee.SetRange("No.", ScheduleResources."Employee No");
                    if Employee.FindFirst()then Receipient.Add(Employee."Company E-Mail");
                    Subject:='Laboratory testing Schedule Notification';
                    TimeNow:=Format(Time);
                    SMTP.Create(Receipient, Subject, '', true);
                    SMTP.AppendToBody(StrSubstNo(NewBody, Schedule.Code, Schedule."Proposed Start Date", Schedule."Proposed End Date"));
                    NoOfRecipients:=RecipientCC.Count;
                    if NoOfRecipients > 0 then //eddies SMTP.AddCC(RecipientCC);
                        Email.Send(SMTP);
                until ScheduleResources.Next() = 0;
            Message('Employees notified successfully');
        end;
    end;
    procedure SendScheduleNotice2(var ScheduleAlloc: Record "Lab Annual Testing Schedule")
    var
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        Email: Codeunit Email;
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of[Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: List of[Text];
        Attachment: Text;
        ErrorMsg: Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that there is a lab testing activity:  <Strong> %2 </Strong>-<Strong> starting from %3 to %4  </Strong> that you are part of.';
        NoOfRecipients: Integer;
        ScheduleResources: Record "Testing Employee Allocation";
        Employee: Record Employee;
        CompanyInfo: Record "Company Information";
        Schedule: record "Lab Annual Testing Schedule";
    begin
        ScheduleResources.Reset();
        ScheduleResources.SetRange("Allocation No", ScheduleAlloc.Code);
        if ScheduleResources.Find('-')then repeat //REPEAT
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName:=CompanyInfo.Name;
                SenderAddress:=CompanyInfo."E-Mail";
                Employee.Reset;
                Employee.SetRange("No.", ScheduleResources."Employee No");
                if Employee.FindFirst()then Receipient.Add(Employee."Company E-Mail");
                Subject:='Laboratory testing Schedule Notification';
                TimeNow:=Format(Time);
                SMTP.Create(Receipient, Subject, '', true);
                SMTP.AppendToBody(StrSubstNo(NewBody, Employee.Name, ScheduleAlloc.Code, ScheduleAlloc."Proposed Start Date", ScheduleAlloc."Proposed End Date"));
                NoOfRecipients:=RecipientCC.Count;
                if NoOfRecipients > 0 then // SMTP.AddCC(RecipientCC);
                    Email.Send(SMTP);
            until ScheduleResources.Next() = 0;
        ScheduleAlloc."Resource Allocated":=true;
        ScheduleAlloc.Scheduled:=true;
        ScheduleAlloc.Modify();
        Message('Employees notified successfully');
    end;
    procedure SampleDisposal(var SampleDisposal: Record "Sample Disposal")
    var
        Alloc: record "Testing Resorce Allocation";
        SampleReception: Record "Sample Reception Header";
        SampleAnalysis: Record "Sample Analysis And Reporting";
        Schedule: Record "Lab Annual Testing Schedule";
    begin
        SampleReception.Reset();
        SampleReception.SetRange("Entry No.", SampleDisposal."Sample Reception No.");
        if SampleReception.FindFirst()then begin
            SampleReception.Archived:=true;
            SampleReception.Modify();
            SampleAnalysis.Reset();
            SampleAnalysis.SetRange("Sample Reception No", SampleDisposal."Sample Reception No.");
            if SampleAnalysis.FindFirst()then begin
                SampleAnalysis.Archived:=true;
                SampleAnalysis.Modify();
            end;
            Schedule.Reset();
            Schedule.SetRange(Code, SampleReception."Schedule No.");
            if Schedule.FindFirst()then begin
                Schedule.Archive:=true;
                Schedule.Modify();
            end;
            Alloc.Reset();
            Alloc.SetRange("Annual Schedule", SampleReception."Schedule No.");
            if Alloc.FindFirst()then begin
                Alloc.Archived:=true;
                Alloc.Modify();
            end;
        end;
        SampleDisposal.Disposed:=true;
        SampleDisposal.Modify();
    end;
    procedure SetControlAppearance(var SampleRecHeader: Record "Sample Test Header")
    begin
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Phosphatase test" then SampleRecHeader.Phosphatase:=true
        else
            SampleRecHeader.Phosphatase:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Milk preservation test" then SampleRecHeader.MilkPreservation:=true
        else
            SampleRecHeader.MilkPreservation:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Butter fat" then SampleRecHeader.Butterfat:=true
        else
            SampleRecHeader.Butterfat:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Mycobacterium spp" then SampleRecHeader.PreliminaryTest:=true
        else
            SampleRecHeader.PreliminaryTest:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Antibiotic residue" then SampleRecHeader.AntibioticResidue:=true
        else
            SampleRecHeader.AntibioticResidue:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Density then SampleRecHeader.Density:=true
        else
            SampleRecHeader.Density:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Brix test" then SampleRecHeader.Brix:=true
        else
            SampleRecHeader.Brix:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Organoleptic then SampleRecHeader.Organoleptic:=true
        else
            SampleRecHeader.Organoleptic:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Free fatty acid" then SampleRecHeader.FreeFatty:=true
        else
            SampleRecHeader.FreeFatty:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Acidity test A" then SampleRecHeader.AcidityA:=true
        else
            SampleRecHeader.AcidityA:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Acidity  test B" then SampleRecHeader.AcidityB:=true
        else
            SampleRecHeader.AcidityB:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moisture determination" then SampleRecHeader.Moisture:=true
        else
            SampleRecHeader.Moisture:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Coliforms then SampleRecHeader.Coliform:=true
        else
            SampleRecHeader.Coliform:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Staph.aureaus" then SampleRecHeader.StaphAurea:=true
        else
            SampleRecHeader.StaphAurea:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"E.coli test" then SampleRecHeader.Ecoli:=true
        else
            SampleRecHeader.Ecoli:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Total plate count" then SampleRecHeader.TotalViable:=true
        else
            SampleRecHeader.TotalViable:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Yeast and molds" then SampleRecHeader.YeastMould:=true
        else
            SampleRecHeader.YeastMould:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::General)then SampleRecHeader.Others:=true
        else
            SampleRecHeader.Others:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Peroxide Conventional form")then SampleRecHeader.Conventional:=true
        else
            SampleRecHeader.Conventional:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Resazurin Test")then SampleRecHeader.Resazurin:=true
        else
            SampleRecHeader.Resazurin:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Salmonella Spp")then SampleRecHeader.Salmonella:=true
        else
            SampleRecHeader.Salmonella:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moisture analyzer form")then SampleRecHeader.MoistureAnalyzer:=true
        else
            SampleRecHeader.MoistureAnalyzer:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moulds Count")then SampleRecHeader.Moulds:=true
        else
            SampleRecHeader.Moulds:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Aflatoxin M1 form")then SampleRecHeader.Aflatoxin:=true
        else
            SampleRecHeader.Aflatoxin:=false;
        SampleRecHeader.Modify();
    end;
    procedure SetControlAppearance2(SampleRecHeader: Record "Sample Test Header")
    begin
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Phosphatase test" then SampleRecHeader.Phosphatase:=true
        else
            SampleRecHeader.Phosphatase:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Milk preservation test" then SampleRecHeader.MilkPreservation:=true
        else
            SampleRecHeader.MilkPreservation:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Butter fat" then SampleRecHeader.Butterfat:=true
        else
            SampleRecHeader.Butterfat:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Mycobacterium spp" then SampleRecHeader.PreliminaryTest:=true
        else
            SampleRecHeader.PreliminaryTest:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Antibiotic residue" then SampleRecHeader.AntibioticResidue:=true
        else
            SampleRecHeader.AntibioticResidue:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Density then SampleRecHeader.Density:=true
        else
            SampleRecHeader.Density:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Brix test" then SampleRecHeader.Brix:=true
        else
            SampleRecHeader.Brix:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Organoleptic then SampleRecHeader.Organoleptic:=true
        else
            SampleRecHeader.Organoleptic:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Free fatty acid" then SampleRecHeader.FreeFatty:=true
        else
            SampleRecHeader.FreeFatty:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Acidity test A" then SampleRecHeader.AcidityA:=true
        else
            SampleRecHeader.AcidityB:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Acidity  test B" then SampleRecHeader.AcidityB:=true
        else
            SampleRecHeader.AcidityB:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moisture determination" then SampleRecHeader.Moisture:=true
        else
            SampleRecHeader.Moisture:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Coliforms then SampleRecHeader.Coliform:=true
        else
            SampleRecHeader.Coliform:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Staph.aureaus" then SampleRecHeader.StaphAurea:=true
        else
            SampleRecHeader.StaphAurea:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"E.coli test" then SampleRecHeader.Ecoli:=true
        else
            SampleRecHeader.Ecoli:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Total plate count" then SampleRecHeader.TotalViable:=true
        else
            SampleRecHeader.TotalViable:=false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Yeast and molds" then SampleRecHeader.YeastMould:=true
        else
            SampleRecHeader.YeastMould:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::General)then SampleRecHeader.Others:=true
        else
            SampleRecHeader.Others:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Peroxide Conventional form")then SampleRecHeader.Conventional:=true
        else
            SampleRecHeader.Conventional:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Resazurin Test")then SampleRecHeader.Resazurin:=true
        else
            SampleRecHeader.Resazurin:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moisture analyzer form")then SampleRecHeader.MoistureAnalyzer:=true
        else
            SampleRecHeader.MoistureAnalyzer:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moulds Count")then SampleRecHeader.Moulds:=true
        else
            SampleRecHeader.Moulds:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Aflatoxin M1 form")then SampleRecHeader.Aflatoxin:=true
        else
            SampleRecHeader.Aflatoxin:=false;
        if(SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Freezing point  test")then SampleRecHeader."Freezing Point":=true
        else
            SampleRecHeader."Freezing Point":=false;
        SampleRecHeader.Modify();
    end;
}

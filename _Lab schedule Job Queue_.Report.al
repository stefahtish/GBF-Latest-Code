report 50398 "Lab schedule Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Schedule; "Lab Annual Testing Schedule")
        {
            trigger OnAfterGetRecord()
            var
                LabSetup: Record "Lab Setup";
                Schedule2: Record "Lab Annual Testing Schedule";
                DateDue: Date;
                SMTP: Codeunit "Email Message";
                Email: Codeunit Email;
                SenderName: Text;
                SenderAddress: Text;
                Receipient: List of [Text];
                Subject: Text;
                FileName: Text;
                TimeNow: Text;
                CompanyInfo: Record "Company Information";
                RecipientCC: List of [Text];
                RecipientBCC: List of [Text];
                RecipientMail: Text[80];
                NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt"><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your the schedule<Strong> %1 </Strong>is starting on <Strong> %2</Strong>.Please allocate resources for this.<br> Thank you. <br><br> Kind Regards, <br><br>';
                NewBody2: Label '<p style="font-family:Verdana,Arial;font-size:10pt"><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that the next date for schedule<Strong> %1 </Strong>is <Strong> %2</Strong>.Please plan for the same.<br> Thank you. <br><br> Kind Regards, <br><br>';
            begin
                LabSetup.Get;
                LabSetup.TestField("Schedule notification email");
                LabSetup.TestField("Schedule Notification Time");
                DateDue := calcdate(LabSetup."Schedule Notification Time", Today);
                Schedule.Reset;
                Schedule.SetFilter("Proposed Start Date", '=%1', DateDue);
                if Schedule.Find('-') then
                    repeat
                        Clear(Receipient);
                        RecipientMail := LabSetup."Schedule notification email";
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyInfo.Name;
                        Receipient.Add(RecipientMail);
                        Subject := ('Schedule due for allocation:' + '  ' + Schedule.code);
                        TimeNow := Format(Time);
                        SMTP.Create(Receipient, Subject, '', true);
                        SMTP.AppendToBody(StrSubstNo(NewBody, Schedule.Code, Schedule."Proposed Start Date"));
                        Email.Send(SMTP);
                    UNTIL Schedule.NEXT = 0;
                if Schedule."Next Notification Date" = 0D then begin
                    Schedule2.SetRange(Code, Schedule.Code);
                    if Schedule2.FindFirst() then begin
                        if Schedule2.Frequency = Schedule2.Frequency::Weekly then Schedule2."Next Notification Date" := CalcDate('7D', "Proposed Start Date");
                        if Schedule2.Frequency = Schedule2.Frequency::Monthly then Schedule2."Next Notification Date" := CalcDate('1M', "Proposed Start Date");
                        if Schedule2.Frequency = Schedule2.Frequency::SemiAnnualy then Schedule2."Next Notification Date" := CalcDate('6M', "Proposed Start Date");
                        if Schedule2.Frequency = Schedule2.Frequency::Quarterly then Schedule2."Next Notification Date" := CalcDate('1Q', "Proposed Start Date");
                        Schedule2.Modify();
                    end;
                end;
                if Schedule."Next Notification Date" = Today then begin
                    //Notify on next workplan
                    Clear(Receipient);
                    RecipientMail := LabSetup."Schedule notification email";
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    SenderAddress := CompanyInfo."E-Mail";
                    SenderName := CompanyInfo.Name;
                    Receipient.Add(RecipientMail);
                    Subject := ('Schedule due for allocation:' + '  ' + Schedule.code);
                    TimeNow := Format(Time);
                    SMTP.Create(Receipient, Subject, '', true);
                    SMTP.AppendtoBody(StrSubstNo(NewBody2, Schedule.Code, Schedule."Next Notification Date"));
                    email.Send(SMTP);
                    //Change next notification date
                    Schedule2.SetRange(Code, Schedule.Code);
                    if Schedule2.FindFirst() then begin
                        if Schedule2.Frequency = Schedule2.Frequency::Weekly then Schedule2."Next Notification Date" := CalcDate('7D', Schedule."Next Notification Date");
                        if Schedule2.Frequency = Schedule2.Frequency::Monthly then Schedule2."Next Notification Date" := CalcDate('1M', Schedule."Next Notification Date");
                        if Schedule2.Frequency = Schedule2.Frequency::SemiAnnualy then Schedule2."Next Notification Date" := CalcDate('6M', Schedule."Next Notification Date");
                        if Schedule2.Frequency = Schedule2.Frequency::Quarterly then Schedule2."Next Notification Date" := CalcDate('1Q', Schedule."Next Notification Date");
                        Schedule2.Modify();
                    end
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
}

codeunit 50108 "Workflow Responses"
{
    trigger OnRun()
    begin
    end;
    var HRMgnt: Codeunit "HR Management";
    Committment: Codeunit Committment;
    Emailmessage: Codeunit "Email Message";
    //SMTPSetup: Record "SMTP Mail Setup";
    SenderName: Text;
    Email: Codeunit email;
    SenderAddress: Text;
    Receipient: List of[Text];
    Subject: Text;
    procedure ReleaseLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset;
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst then begin
            LeaveRec.Status:=LeaveRec.Status::Released;
            LeaveRec.Modify(true);
            //Recall
            HRMgnt.LeaveRecall(LeaveRec."No.");
        end;
    end;
    procedure ReopenLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset;
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst then begin
            LeaveRec.Status:=LeaveRecall.Status::Open;
            LeaveRec.Modify(true)end;
    end;
    procedure ReleaseLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin
        Leave.Reset;
        Leave.SetRange("Application No", LeaveReq."Application No");
        if Leave.FindFirst then begin
            Leave.Status:=Leave.Status::Released;
            Leave.Modify(true);
            HRMgnt.LeaveApplication(Leave."Application No");
            HRMgnt.NotifyLeaveReliever(Leave."Application No");
        end;
    end;
    procedure ReleaseSample(var SampleReq: Record "Sample Analysis And Reporting")
    var
        SampleAnalysis: Record "Sample Analysis And Reporting";
        usersetup: Record "User Setup";
    begin
        SampleAnalysis.Reset;
        SampleAnalysis.SetRange("Analysis No.", SampleReq."Analysis No.");
        if SampleAnalysis.FindFirst then begin
            usersetup.SetRange("User ID", UserId);
            if usersetup.FindFirst()then SampleAnalysis."Verified By":=usersetup."Employee No.";
            SampleAnalysis.Validate("Verified By");
            SampleAnalysis.Status:=SampleAnalysis.Status::Released;
            SampleAnalysis."Result authorization date":=Today;
            SampleAnalysis."Approval datetime":=CreateDateTime(Today, Time);
            SampleAnalysis."Result verification date":=Today;
            SampleAnalysis."Submit results":=true;
            SampleAnalysis.Modify(true);
        end;
    end;
    procedure ReleaseAssetTransfer(var AssetTrans: Record "Asset Allocation and Transfer")
    var
        AssetTransfer: Record "Asset Allocation and Transfer";
    begin
        AssetTransfer.Reset;
        AssetTransfer.SetRange("No.", AssetTrans."No.");
        if AssetTransfer.FindFirst then begin
            AssetTransfer.Status:=AssetTransfer.Status::Released;
            AssetTransfer.Modify(true);
        end;
    end;
    procedure ReleaseEmployeeTransfer(var EmployeeTransfer: Record "Employee Transfers")
    var
        EmpTrans: Record "Employee Transfers";
    begin
        EmpTrans.Reset;
        EmpTrans.SetRange("Transfer No", EmployeeTransfer."Transfer No");
        if EmpTrans.FindFirst then begin
            EmpTrans.Status:=EmpTrans.Status::Released;
            EmpTrans.Modify(true);
        end;
    end;
    //Tender committee
    procedure ReleaseTenderCommittee(var TenderCommittee: Record "Tender Committees")
    var
        TenderComm: Record "Tender Committees";
        ProcMgmt: Codeunit "Procurement Management";
        PurchPaybles: Record "Purchases & Payables Setup";
    begin
        TenderComm.Reset;
        TenderComm.SetRange("Appointment No", TenderCommittee."Appointment No");
        if TenderComm.FindFirst then begin
            TenderComm.Status:=TenderComm.Status::Released;
            TenderComm.Modify(true);
        end;
        // PurchPaybles.get();
        // if PurchPaybles."Notify Committee Members" then
        ProcMgmt.NotifyCommitteeMembers(TenderComm."Appointment No");
    end;
    procedure ReopenTenderCommittee(var TenderCommittee: Record "Tender Committees")
    var
        TenderComm: Record "Tender Committees";
    begin
        TenderComm.Reset;
        TenderComm.SetRange("Appointment No", TenderCommittee."Appointment No");
        if TenderComm.FindFirst then begin
            TenderComm.Status:=TenderComm.Status::Open;
            TenderComm.Modify(true);
        end;
    end;
    //Procurement Request Change
    procedure ReleaseProcChangeRequest(var ProcRequest: Record "Procurement Change Request")
    var
        proqReq: Record "Procurement Change Request";
        proqReqLines: Record "Proc. Lines Change Request";
        ProcurementRequest: Record "Procurement Request";
        ProcurementLines: Record "Procurement Request Lines";
    begin
        proqReq.Reset;
        proqReq.SetRange(Number, ProcRequest.Number);
        if proqReq.FindFirst then begin
            proqReq.Status:=proqReq.Status::Approved;
            proqReq.Modify(true);
            ProcurementRequest.Reset;
            ProcurementRequest.SetRange("No.", ProcRequest."No.");
            if ProcurementRequest.FindFirst()then begin
                ProcurementRequest.TransferFields(proqReq);
                ProcurementRequest.Modify;
            end;
            proqReqLines.Reset();
            proqReqLines.SetRange(Number, ProcRequest.Number);
            if proqReqLines.FindFirst()then repeat proqReqLines.CalcFields(Specification2);
                    ProcurementLines.Reset();
                    ProcurementLines.SetRange("Requisition No", proqReqLines."Requisition No");
                    ProcurementLines.SetRange("Line No", proqReqLines."Line No");
                    if ProcurementLines.FindFirst()then begin
                        ProcurementLines.TransferFields(proqReqLines);
                        ProcurementLines.Modify;
                    end;
                until proqReqLines.Next() = 0;
            Message('Change Made Successfully');
        end;
    end;
    procedure ReopenProcChangeRequest(var ProcRequest: Record "Procurement Change Request")
    var
        proqReq: Record "Procurement Change Request";
    begin
        proqReq.Reset;
        proqReq.SetRange(Number, ProcRequest.Number);
        if proqReq.FindFirst then begin
            proqReq.Status:=proqReq.Status::New;
            proqReq.Modify(true);
        end;
    end;
    //Contract Change START
    procedure ReleaseContChange(var ContChange: Record "Contract Change Header")
    var
        ContChangeComm: Record "Contract Change Header";
        LastLineNo: Integer;
        ContChangeEnt: Record "Contract Change Entries";
        ConttractChangeEnt: Record "Contract Change Entries";
        ProjectHeader: Record "Project Header";
    begin
        ContChangeComm.Reset;
        ContChangeComm.SetRange(ContChangeComm."No.", ContChange."No.");
        if ContChangeComm.FindFirst then begin
            ContChangeComm.Status:=ContChangeComm.Status::Approved;
            ContChangeComm.Modify(true);
            if ContChange."Change Type" = ContChange."Change Type"::Extension then begin
                if ContChangeEnt.FindLast()then LastLineNo:=ContChangeEnt."Line No.";
                ConttractChangeEnt.Init();
                ConttractChangeEnt."Line No.":=LastLineNo + 1000;
                ConttractChangeEnt."Change Type":=ContChange."Change Type";
                ConttractChangeEnt."Date-Time Created":=CurrentDateTime;
                ConttractChangeEnt.Description:='Contract Extension_' + 'to_' + Format(ContChange."New Contract End Date");
                ConttractChangeEnt.Active:=false;
                ConttractChangeEnt."Change No.":=ContChange."No.";
                ConttractChangeEnt."Contract No.":=ContChange."Contract No.";
                ConttractChangeEnt.Insert();
                if ProjectHeader.Get(ContChange."Contract No.")then begin
                    ProjectHeader."Estimated End Date":=ContChange."New Contract End Date";
                    ProjectHeader.Modify();
                end;
            end;
            if ContChange."Change Type" = ContChange."Change Type"::Termination then begin
                if ProjectHeader.Get(ContChange."Contract No.")then begin
                    ProjectHeader.Stage:=ProjectHeader.Stage::Termination;
                    ProjectHeader.Modify();
                end;
            end;
            if ContChange."Change Type" = ContChange."Change Type"::Suspension then begin
                if ProjectHeader.Get(ContChange."Contract No.")then begin
                    ProjectHeader.Stage:=ProjectHeader.Stage::Suspension;
                    ProjectHeader.Modify();
                end;
            end;
        end;
    end;
    procedure ReopenContChange(var ContChange: Record "Contract Change Header")
    var
        ContChangeComm: Record "Contract Change Header";
    begin
        ContChangeComm.Reset;
        ContChangeComm.SetRange("No.", ContChange."No.");
        if ContChangeComm.FindFirst then begin
            ContChangeComm.Status:=ContChangeComm.Status::Open;
            ContChangeComm.Modify(true);
        end;
    end;
    //Contract Change END
    //Proc methods
    procedure ReleaseProcMethod(var ProcMethod: Record "Procurement Request")
    var
        ProcReq: Record "Procurement Request";
    begin
        ProcReq.Reset;
        ProcReq.SetRange("No.", ProcMethod."No.");
        if ProcReq.FindFirst then begin
            ProcReq.Status:=ProcReq.Status::Approved;
            ProcReq.Modify(true);
        end;
    end;
    procedure ReopenProcMethod(var ProcMethod: Record "Procurement Request")
    var
        ProcReq: Record "Procurement Request";
    begin
        ProcReq.Reset;
        ProcReq.SetRange("No.", ProcMethod."No.");
        if ProcReq.FindFirst then begin
            ProcReq.Status:=ProcReq.Status::New;
            ProcReq.Modify(true);
        end;
    end;
    procedure ReopenLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code)then begin
            LeaveAdjRec.Status:=LeaveAdjRec.Status::Open;
            LeaveAdjRec.Modify;
        end;
    end;
    procedure ReopenLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin
        Leave.Reset;
        Leave.SetRange("Application No", LeaveReq."Application No");
        if Leave.FindFirst then begin
            Leave.Status:=Leave.Status::Open;
            Leave.Modify(true);
        end;
    end;
    procedure ReopenAssetTransfer(var AssetTrans: Record "Asset Allocation and Transfer")
    var
        AssetTransfer: Record "Asset Allocation and Transfer";
    begin
        AssetTransfer.Reset;
        AssetTransfer.SetRange("No.", AssetTrans."No.");
        if AssetTransfer.FindFirst then begin
            AssetTransfer.Status:=AssetTransfer.Status::Open;
            AssetTransfer.Modify(true);
        end;
    end;
    procedure ReopenEmployeeTransfer(var EmployeeTransfer: Record "Employee Transfers")
    var
        EmpTrans: Record "Employee Transfers";
    begin
        EmpTrans.Reset;
        EmpTrans.SetRange("Transfer No", EmployeeTransfer."Transfer No");
        if EmpTrans.FindFirst then begin
            EmpTrans.Status:=EmpTrans.Status::New;
            EmpTrans.Modify(true);
        end;
    end;
    procedure ReopenSample(var SampleReq: Record "Sample Analysis And Reporting")
    var
        Sample: Record "Sample Analysis And Reporting";
    begin
        Sample.Reset;
        Sample.SetRange("Analysis No.", SampleReq."Analysis No.");
        if Sample.FindFirst then begin
            Sample.Status:=Sample.Status::Open;
            Sample.Modify(true);
        end;
    end;
    procedure ReleaseTrainingRequest(var TrainingReq: Record "Training Request")
    var
        Training: Record "Training Request";
        ErrorMsg: Text;
    begin
        Training.Reset;
        Training.SetRange("Request No.", TrainingReq."Request No.");
        if Training.FindFirst then begin
            HRMgnt.CheckTrainingCostExceeded(Training."Request No.", Training."Training Need");
            Committment.TrainingRequestCommittment(Training, ErrorMsg);
            if ErrorMsg <> '' then Error(ErrorMsg);
            Training.Status:=Training.Status::Released;
            Training.Modify(true);
        end;
    end;
    procedure ReopenTrainingRequest(var TrainingReq: Record "Training Request")
    var
        Training: Record "Training Request";
    begin
        Training.Reset;
        Training.SetRange("Request No.", TrainingReq."Request No.");
        if Training.FindFirst then begin
            Training.Status:=Training.Status::Open;
            Training.Modify(true)end;
    end;
    procedure ReleaseEmployeeAppraisalRequest(var Appraisal: Record "Employee Appraisal")
    var
        EmployeeApp: Record "Employee Appraisal";
    begin
        EmployeeApp.Reset;
        EmployeeApp.SetRange("Appraisal No", Appraisal."Appraisal No");
        if EmployeeApp.FindFirst then begin
            /*if (EmployeeApp.Type = EmployeeApp.Type::"Mid-Year") and (EmployeeApp.Status <> EmployeeApp.Status::"Mid-Year Approved") then
                EmployeeApp.Status := EmployeeApp.Status::"Mid-Year Approved";

            if (EmployeeApp.Type = EmployeeApp.Type::"Mid-Year") and (EmployeeApp.Status = EmployeeApp.Status::"Mid-Year Approved") then
                HRMgnt.SendToFinalYearAppraisal(EmployeeApp);
            Commit;

            if (EmployeeApp.Type <> EmployeeApp.Type::"Mid-Year") and (EmployeeApp.Status <> EmployeeApp.Status::"Mid-Year Approved") then
                EmployeeApp.Status := EmployeeApp.Status::Released;*/
            EmployeeApp.Status:=EmployeeApp.Status::Released;
            EmployeeApp."Appraisal Status":=EmployeeApp."Appraisal Status"::Review;
            EmployeeApp.Modify(true);
        end;
    end;
    procedure ReopenEmployeeAppraisalRequest(var Appraisal: Record "Employee Appraisal")
    var
        EmployeeApp: Record "Employee Appraisal";
    begin
        EmployeeApp.Reset;
        EmployeeApp.SetRange("Appraisal No", Appraisal."Appraisal No");
        if EmployeeApp.FindFirst then begin
            EmployeeApp.Status:=EmployeeApp.Status::Open;
            EmployeeApp."Appraisal Status":=EmployeeApp."Appraisal Status"::Setting;
            EmployeeApp.Modify(true);
        end;
    end;
    procedure ReleaseLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    var
        Entitlement: Record Employee;
    begin
    end;
    procedure ReopenLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    var
        Entitlement: Record Employee;
    begin
    end;
    procedure ReleaseTransportReq(var Transport: Record "Travel Requests")
    var
        TransportReq: Record "Travel Requests";
    begin
        TransportReq.Reset;
        TransportReq.SetRange("Request No.", Transport."Request No.");
        if TransportReq.FindFirst then begin
            TransportReq.Status:=TransportReq.Status::Released;
            TransportReq.Modify(true);
        end;
    end;
    procedure ReopenTransportReq(var Transport: Record "Travel Requests")
    var
        TransportReq: Record "Travel Requests";
    begin
        TransportReq.Reset;
        TransportReq.SetRange("Request No.", Transport."Request No.");
        if TransportReq.FindFirst then begin
            TransportReq.Status:=TransportReq.Status::Open;
            TransportReq.Modify(true)end;
    end;
    procedure ReleaseRecruitment(var RecruitmentReq: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        Recruitment.Reset;
        Recruitment.SetRange("No.", RecruitmentReq."No.");
        if Recruitment.FindFirst then begin
            RecruitmentReq.Status:=RecruitmentReq.Status::Released;
            RecruitmentReq.Modify(true);
        end;
    /*
        RecruitmentReq.RESET;
        RecruitmentReq.SETRANGE("No.",Recruitment."No.");
          IF RecruitmentReq.FINDFIRST THEN BEGIN
            RecruitmentReq.Status:=RecruitmentReq.Status::Released;
            RecruitmentReq.MODIFY(TRUE);
            END;
        */
    end;
    procedure ReleaseProspectiveSuppliers(var ProspectiveSupp: Record "Prospective Suppliers")
    var
        ProspectiveSupplier: Record "Prospective Suppliers";
    begin
        ProspectiveSupplier.Reset;
        ProspectiveSupplier.SetRange("No.", ProspectiveSupp."No.");
        if ProspectiveSupplier.FindFirst then begin
            ProspectiveSupp.Status:=ProspectiveSupp.Status::Released;
            ProspectiveSupp.Modify(true);
        end;
    end;
    procedure ReopenRecruitment(var RecruitmentReq: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        RecruitmentReq.Reset;
        RecruitmentReq.SetRange("No.", Recruitment."No.");
        if RecruitmentReq.FindFirst then begin
            RecruitmentReq.Status:=RecruitmentReq.Status::Open;
            RecruitmentReq.Modify(true)end;
    end;
    procedure ReopenProspectiveSupp(var ProspectSupplier: Record "Prospective Suppliers")
    var
        Supplier: Record "Prospective Suppliers";
    begin
        ProspectSupplier.Reset;
        ProspectSupplier.SetRange("No.", Supplier."No.");
        if ProspectSupplier.FindFirst then begin
            ProspectSupplier.Status:=ProspectSupplier.Status::Open;
            ProspectSupplier."Vendor Created":=false;
            ProspectSupplier.Modify(true)end;
    end;
    procedure ReleasePayrollChange(var Payroll: Record "Payroll Change Header")
    var
        PayrollChange: Record "Payroll Change Header";
    begin
        PayrollChange.Reset;
        PayrollChange.SetRange(No, Payroll.No);
        if PayrollChange.FindFirst then begin
            PayrollChange.Status:=PayrollChange.Status::Approved;
            PayrollChange.Modify(true);
        end;
    end;
    procedure ReopenPayrollChange(var Payroll: Record "Payroll Change Header")
    var
        PayrollChange: Record "Payroll Change Header";
    begin
        PayrollChange.Reset;
        PayrollChange.SetRange(No, Payroll.No);
        if PayrollChange.FindFirst then begin
            PayrollChange.Status:=PayrollChange.Status::Open;
            PayrollChange.Modify(true);
        end;
    end;
    procedure ReleasePayrollRequest(var PayrollReq: Record "Payroll Requests")
    var
        PayrollRequest: Record "Payroll Requests";
    begin
        PayrollRequest.Reset;
        PayrollRequest.SetRange("No.", PayrollReq."No.");
        if PayrollRequest.FindFirst then begin
            PayrollRequest.Status:=PayrollRequest.Status::Approved;
            PayrollRequest.Modify(true);
        end;
    end;
    procedure ReopenPayrollRequest(var PayrollReq: Record "Payroll Requests")
    var
        PayrollRequest: Record "Payroll Requests";
    begin
        PayrollRequest.Reset;
        PayrollRequest.SetRange("No.", PayrollReq."No.");
        if PayrollRequest.FindFirst then begin
            PayrollRequest.Status:=PayrollRequest.Status::Open;
            PayrollRequest.Modify(true);
        end;
    end;
    procedure ReleaseLoanApplication(var LoanApp: Record "Loan Application")
    var
        LoanApplication: Record "Loan Application";
    begin
        LoanApplication.Reset;
        LoanApplication.SetRange("Loan No", LoanApp."Loan No");
        if LoanApplication.FindFirst then begin
            LoanApplication."Loan Status":=LoanApplication."Loan Status"::Approved;
            LoanApplication.Modify(true);
        end;
    end;
    procedure ReopenLoanApplication(var LoanApp: Record "Loan Application")
    var
        LoanApplication: Record "Loan Application";
    begin
        LoanApplication.Reset;
        LoanApplication.SetRange("Loan No", LoanApp."Loan No");
        if LoanApplication.FindFirst then begin
            LoanApplication."Loan Status":=LoanApplication."Loan Status"::Application;
            LoanApplication.Modify(true);
        end;
    end;
    procedure ReleaseEmpActingPromotion(var EmpActingProm: Record "Employee Acting Position")
    var
        EmpActingPromRec: Record "Employee Acting Position";
        Employee: Record Employee;
    begin
        EmpActingPromRec.Reset;
        EmpActingPromRec.SetRange(No, EmpActingProm.No);
        if EmpActingPromRec.FindFirst then begin
            case EmpActingPromRec."Promotion Type" of EmpActingPromRec."Promotion Type"::"Acting Position": begin
                Employee.Reset;
                Employee.SetRange("No.", EmpActingPromRec."Employee No.");
                if Employee.Find('-')then begin
                    EmpActingPromRec.TestField("End Date");
                    if Employee."End Date" > Today then Error('This Employee is already on an acting Capacity');
                    Employee."Acting No":=EmpActingPromRec.No;
                    Employee."Acting Position":=EmpActingPromRec.Position;
                    Employee."Acting Description":=EmpActingPromRec."Job Description";
                    Employee."Relieved Employee":=EmpActingPromRec."Relieved Employee";
                    Employee."Relieved Name":=EmpActingPromRec."Relieved Name";
                    Employee."Start Date":=EmpActingPromRec."Start Date";
                    Employee."End Date":=EmpActingPromRec."End Date";
                    Employee."Reason for Acting":=EmpActingPromRec.Reason;
                    Employee.Modify;
                end;
            end;
            EmpActingPromRec."Promotion Type"::Promotion: begin
                Employee.Reset;
                Employee.SetRange("No.", EmpActingPromRec."Employee No.");
                if Employee.Find('-')then begin
                    Employee."Job Title":=EmpActingPromRec."Job Description";
                    Employee."Job Position":=EmpActingPromRec."Desired Position";
                    Employee.Modify;
                end;
            // EmpActingPromRec.Promoted := true;
            // EmpActingPromRec.Modify;
            end;
            end;
            EmpActingPromRec.Status:=EmpActingPromRec.Status::Approved;
            EmpActingPromRec.Modify(true);
        end;
    end;
    procedure ReopenEmpActingPromotion(var EmpActingProm: Record "Employee Acting Position")
    var
        EmpActingPromRec: Record "Employee Acting Position";
        Employee: Record Employee;
    begin
        EmpActingPromRec.Reset;
        EmpActingPromRec.SetRange(No, EmpActingProm.No);
        if EmpActingPromRec.FindFirst then begin
            EmpActingPromRec.Status:=EmpActingPromRec.Status::New;
            EmpActingPromRec.Modify(true);
        end;
    end;
    procedure ReleaseBudget(var BudgetRec: Record "Budget Approval Header")
    var
        Budget: Record "Budget Approval Header";
        BudgetApprovalLines: Record "Budget Approval Lines";
        GLBudgetEntry: Record "G/L Budget Entry";
        ProposedBudgetHeader: Record "Proposed Budget Header";
        LastGLBudgetEntry: Integer;
    begin
        Budget.Reset;
        Budget.SetRange("Document No.", BudgetRec."Document No.");
        if Budget.FindFirst then begin
            BudgetApprovalLines.Reset;
            BudgetApprovalLines.SetRange("Document No.", Budget."Document No.");
            if BudgetApprovalLines.Find('-')then repeat GLBudgetEntry.Init;
                    GLBudgetEntry.TransferFields(BudgetApprovalLines);
                    GLBudgetEntry."Entry No.":=GLBudgetEntry.GetNextEntryNo;
                    if Budget."Budget Option" = Budget."Budget Option"::Budgeting then GLBudgetEntry."Budget Status":=GLBudgetEntry."Budget Status"::Open
                    else
                        GLBudgetEntry."Budget Status":=GLBudgetEntry."Budget Status"::Approved;
                    GLBudgetEntry.Insert(true);
                    BudgetApprovalLines.Proposed:=true;
                    BudgetApprovalLines.Posted:=true;
                    BudgetApprovalLines."Posted By":=UserId;
                    BudgetApprovalLines."Date-Time Posted":=CreateDateTime(Today, Time);
                    BudgetApprovalLines."Budget Status":=BudgetApprovalLines."Budget Status"::Approved;
                    BudgetApprovalLines.Modify;
                until BudgetApprovalLines.Next = 0;
            Budget.Status:=Budget.Status::Approved;
            Budget.Modify;
        end;
    /*
        Budget.RESET;
        Budget.SETRANGE("Document No.",BudgetRec."Document No.");
        IF Budget.FINDFIRST THEN
          BEGIN
            BudgetApprovalLines.RESET;
            BudgetApprovalLines.SETRANGE("Document No.",Budget."Document No.");
            IF BudgetApprovalLines.FIND('-') THEN
              REPEAT
                GLBudgetEntry.INIT;
                GLBudgetEntry.TRANSFERFIELDS(BudgetApprovalLines);
                GLBudgetEntry."Entry No.":=GLBudgetEntry.GetNextEntryNo;
                GLBudgetEntry."Budget Status":=GLBudgetEntry."Budget Status"::Open;
                GLBudgetEntry.INSERT(TRUE);
        
                //Modify lines
                BudgetApprovalLines.Posted:=TRUE;
                BudgetApprovalLines."Posted By":=USERID;
                BudgetApprovalLines."Date-Time Posted":=CURRENTDATETIME;
                BudgetApprovalLines.MODIFY;
              UNTIL BudgetApprovalLines.NEXT=0;
        
            Budget.Status:=Budget.Status::Approved;
            Budget.MODIFY;
          END;
        */
    /*
                    //Inserts the lines to the G_L Budget Entry
        //            GLBudgetEntry.RESET;
        //            GLBudgetEntry.FINDLAST;
        //            LastGLBudgetEntry:=GLBudgetEntry."Entry No.";
        //              GLBudgetEntry.INIT;
        //              GLBudgetEntry.TRANSFERFIELDS(BudgetApprovalLines);
        //              GLBudgetEntry."Entry No.":=LastGLBudgetEntry+1;
        //              GLBudgetEntry.INSERT;
                      //End Added by SpongeBob
        */
    end;
    procedure ReopenBudget(var BudgetRec: Record "Budget Approval Header")
    var
        Budget: Record "Budget Approval Header";
    begin
        Budget.Reset;
        Budget.SetRange("Document No.", BudgetRec."Document No.");
        if Budget.FindFirst then begin
            //Transfer Lines to main budget
            Budget.Status:=Budget.Status::Open;
            Budget.Modify;
        end;
    end;
    procedure ReleaseProposedBudget(var ProposedBudget: Record "G/L Budget Name")
    var
        Budget: Record "G/L Budget Name";
        BudgetApprovalLines: Record "Budget Approval Lines";
        GLBudgetEntry: Record "G/L Budget Entry";
        ProposedBudgetHeader: Record "Proposed Budget Header";
    begin
        Budget.Reset;
        Budget.SetRange("Document No.", ProposedBudget."Document No.");
        if Budget.FindFirst then begin
            GLBudgetEntry.Reset;
            GLBudgetEntry.SetRange("Budget Name", Budget.Name);
            if GLBudgetEntry.Find('-')then repeat GLBudgetEntry."Budget Status":=GLBudgetEntry."Budget Status"::Approved;
                    GLBudgetEntry.Modify;
                until GLBudgetEntry.Next = 0;
            Budget."Budget Status":=Budget."Budget Status"::Approved;
            Budget.Modify;
        end;
    end;
    procedure ReopenProposedBudget(var ProposedBudget: Record "G/L Budget Name")
    var
        Budget: Record "G/L Budget Name";
        BudgetApprovalLines: Record "Budget Approval Lines";
        GLBudgetEntry: Record "G/L Budget Entry";
        ProposedBudgetHeader: Record "Proposed Budget Header";
    begin
        Budget.Reset;
        Budget.SetRange("Document No.", ProposedBudget."Document No.");
        if Budget.FindFirst then begin
            Budget."Budget Status":=Budget."Budget Status"::Open;
            Budget.Modify;
        end;
    end;
    procedure ReleaseBankRec(BankAccRec: Record "Bank Acc. Reconciliation")
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.Reset;
        BankAccReconciliation.SetRange("Document No.", BankAccRec."Document No.");
        if BankAccReconciliation.FindFirst then begin
            BankAccReconciliation."Approval Status":=BankAccReconciliation."Approval Status"::Approved;
            BankAccReconciliation.Modify;
        end;
    end;
    procedure ReopenBankRec(BankAccRec: Record "Bank Acc. Reconciliation")
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.Reset;
        BankAccReconciliation.SetRange("Document No.", BankAccRec."Document No.");
        if BankAccReconciliation.FindFirst then begin
            BankAccReconciliation."Approval Status":=BankAccReconciliation."Approval Status"::Open;
            BankAccReconciliation.Modify;
        end;
    end;
    procedure ReleaseLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code)then begin
            LeaveAdjRec.Status:=LeaveAdjRec.Status::Released;
            LeaveAdjRec.Modify;
        end;
    end;
    procedure ReleaseReq(Req: Record "Internal Request Header")
    var
        ReqRec: Record "Internal Request Header";
    begin
        if ReqRec.Get(Req."No.")then begin
            ReqRec."Status":=ReqRec."Status"::Released;
            ReqRec.Modify();
        end;
    end;
    procedure ReopenReq(Req: Record "Internal Request Header")
    var
        ReqRec: Record "Internal Request Header";
    begin
        if ReqRec.Get(Req."No.")then begin
            ReqRec."Status":=ReqRec."Status"::Open;
            ReqRec.Modify();
        end;
    end;
    //Tender Evaluation
    procedure ReleaseTenderEval(var TenderEvaluation: Record "Tender Evaluation Header")
    var
        TenderEval: Record "Tender Evaluation Header";
    begin
        TenderEval.Reset;
        TenderEval.SetRange("Quote No", TenderEvaluation."Quote No");
        if TenderEval.FindFirst then begin
            TenderEval.Status:=TenderEval.Status::Approved;
            TenderEval.Modify(true);
        end;
    end;
    procedure ReopenTenderEval(var TenderEvaluation: Record "Tender Evaluation Header")
    var
        TenderEval: Record "Tender Evaluation Header";
    begin
        TenderEval.Reset;
        TenderEval.SetRange("Quote No", TenderEvaluation."Quote No");
        if TenderEval.FindFirst then begin
            TenderEval.Status:=TenderEval.Status::New;
            TenderEval.Modify(true);
        end;
    end;
    procedure ReleaseSupplierEval(var SupplierEvaluation: Record "Supplier Evaluation Header")
    var
        SupplierEval: Record "Supplier Evaluation Header";
    begin
        SupplierEval.Reset;
        SupplierEval.SetRange("Quote No", SupplierEvaluation."Quote No");
        if SupplierEval.FindFirst then begin
            SupplierEval.Status:=SupplierEval.Status::Approved;
            SupplierEval.Modify(true);
        end;
    end;
    procedure ReopenSupplierEval(var SupplierEvaluation: Record "Supplier Evaluation Header")
    var
        SupplierEval: Record "Supplier Evaluation Header";
    begin
        SupplierEval.Reset;
        SupplierEval.SetRange("Quote No", SupplierEvaluation."Quote No");
        if SupplierEval.FindFirst then begin
            SupplierEval.Status:=SupplierEval.Status::New;
            SupplierEval.Modify(true);
        end;
    end;
    //FA Disposal
    procedure ReleaseFADisposal(var FADisposal: Record "FA Disposal")
    var
        FADisposalRec: Record "FA Disposal";
        FADispLines: Record "FA Disposal Line";
        FA: Record "Fixed Asset";
    begin
        if FADisposalRec.get(FADisposal."No.")then begin
            FADisposalRec.Status:=FADisposalRec.Status::Approved;
            FADisposalRec.Modify(true);
            //Approve Lines
            FADispLines.reset;
            FADispLines.SetRange("Document No.", FADisposalRec."No.");
            if FADispLines.Find('-')then begin
                repeat FA.Get(FADispLines."FA No.");
                    FA."Marked For Disposal":=true;
                    FA.Modify();
                until FADispLines.Next() = 0;
            end;
        end;
    end;
    procedure ReopenFADisposal(var FADisposal: Record "FA Disposal")
    var
        FADisposalRec: Record "FA Disposal";
    begin
        if FADisposalRec.get(FADisposal."No.")then begin
            FADisposalRec.Status:=FADisposalRec.Status::Open;
            FADisposalRec.Modify(true);
        end;
    end;
    //Quote Evaluation
    procedure ReleaseQuoteEval(var QuoteEvaluation: Record "Quote Evaluation Header")
    var
        QuoteEval: Record "Quote Evaluation Header";
    begin
        QuoteEval.Reset;
        QuoteEval.SetRange("Quote No", QuoteEvaluation."Quote No");
        if QuoteEval.FindFirst then begin
            QuoteEval.Status:=QuoteEval.Status::Approved;
            QuoteEval.Modify(true);
        end;
    end;
    procedure ReopenQuoteEval(var QuoteEvaluation: Record "Quote Evaluation Header")
    var
        QuoteEval: Record "Quote Evaluation Header";
    begin
        QuoteEval.Reset;
        QuoteEval.SetRange("Quote No", QuoteEvaluation."Quote No");
        if QuoteEval.FindFirst then begin
            QuoteEval.Status:=QuoteEval.Status::New;
            QuoteEval.Modify(true);
        end;
    end;
    //Audit
    procedure ReleaseAudit(var Audit: Record "Audit Header")
    var
        Auditheader: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
    begin
        Auditheader.Reset;
        Auditheader.SetRange("No.", Audit."No.");
        if Auditheader.FindFirst then begin
            Auditheader.Status:=Auditheader.Status::Released;
            Auditheader.Modify(true);
            AuditMgt.CreateDepartmentRegister(Auditheader);
        end;
    end;
    procedure ReopenAudit(var Audit: Record "Audit Header")
    var
        Auditheader: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
    begin
        Auditheader.Reset;
        Auditheader.SetRange("No.", Audit."No.");
        if Auditheader.FindFirst then begin
            Auditheader.Status:=Auditheader.Status::Open;
            //AuditMgt.MailRiskSurvey(Audit);
            Auditheader.Modify(true);
        end;
    end;
    //ResearchActivity
    procedure ReleaseResearchActivity(var Research: Record "Research Activity Plan")
    var
        ResearchActivity: Record "Research Activity Plan";
    begin
        ResearchActivity.Reset;
        ResearchActivity.SetRange(code, Research.Code);
        if ResearchActivity.FindFirst then begin
            ResearchActivity.Status:=ResearchActivity.Status::Released;
            ResearchActivity.Submitted:=true;
            ResearchActivity.Modify(true);
        end;
    end;
    procedure ReopenResearchActivity(var Research: Record "Research Activity Plan")
    var
        ResearchActivity: Record "Research Activity Plan";
    begin
        ResearchActivity.Reset;
        ResearchActivity.SetRange(code, Research.Code);
        if ResearchActivity.FindFirst then begin
            ResearchActivity.Status:=ResearchActivity.Status::Open;
            ResearchActivity.Submitted:=false;
            ResearchActivity.Modify(true);
        end;
    end;
    //PartnershipActivity
    procedure ReleasePartnershipActivity(VAR PActivity: Record "Partnerships Activity Plan")
    var
        PartnershipActivity: Record "Partnerships Activity Plan";
    begin
        PartnershipActivity.Reset;
        PartnershipActivity.SetRange(code, PActivity.Code);
        if PartnershipActivity.FindFirst then begin
            PartnershipActivity.Status:=PartnershipActivity.Status::Released;
            PartnershipActivity.Submitted:=true;
            PartnershipActivity.Modify(true);
        end;
    end;
    procedure ReopenPartnershipActivity(VAR PActivity: Record "Partnerships Activity Plan")
    var
        PartnershipActivity: Record "Partnerships Activity Plan";
    begin
        PartnershipActivity.Reset;
        PartnershipActivity.SetRange(code, PActivity.Code);
        if PartnershipActivity.FindFirst then begin
            PartnershipActivity.Status:=PartnershipActivity.Status::Open;
            PartnershipActivity.Submitted:=false;
            PartnershipActivity.Modify(true);
        end;
    end;
    //ResearchSurvey Workplan
    procedure ReleaseResearchSurvey(VAR SActivity: Record "Research and survey Workplan")
    var
        SurveyActivity: Record "Research and survey Workplan";
    begin
        SurveyActivity.Reset;
        SurveyActivity.SetRange(code, SActivity.Code);
        if SurveyActivity.FindFirst then begin
            SurveyActivity.Status:=SurveyActivity.Status::Released;
            SurveyActivity.Submitted:=true;
            SurveyActivity.Modify(true);
        end;
    end;
    procedure ReopenResearchSurvey(VAR SActivity: Record "Research and survey Workplan")
    var
        SurveyActivity: Record "Research and survey Workplan";
    begin
        SurveyActivity.Reset;
        SurveyActivity.SetRange(code, SActivity.Code);
        if SurveyActivity.FindFirst then begin
            SurveyActivity.Status:=SurveyActivity.Status::Open;
            SurveyActivity.Submitted:=false;
            SurveyActivity.Modify(true);
        end;
    end;
    //Item Journal
    procedure ReleaseItemJournal(VAR ItemJnl: record "Item Journal Batch")
    var
        ItemJournal: record "Item Journal Batch";
        ItemJournalLine: record "Item Journal Line";
    begin
        ItemJournal.Reset;
        ItemJournal.SetRange("Document No.", ItemJnl."Document No.");
        if ItemJournal.FindFirst then begin
            ItemJournal.Status:=ItemJournal.Status::Released;
            ItemJournal.Modify(true);
            ItemJournalLine.Reset;
            ItemJournalLine.SetRange("Journal Template Name", ItemJnl."Journal Template Name");
            ItemJournalLine.SetRange("Journal Batch Name", ItemJnl.Name);
            ItemJournalLine.SetFilter(Status, '=%1', ItemJournalLine.Status::Open);
            if ItemJournalLine.Find('-')then repeat ItemJournalLine.Status:=ItemJournalLine.Status::Released;
                    ItemJournalLine.Modify(true);
                until ItemJournalLine.Next() = 0;
        end;
    end;
    procedure ReopenItemJournal(VAR ItemJnl: record "Item Journal Batch")
    var
        ItemJournal: record "Item Journal Batch";
    begin
        ItemJournal.Reset;
        ItemJournal.SetRange("Document No.", ItemJnl."Document No.");
        if ItemJournal.FindFirst then begin
            ItemJournal.Status:=ItemJnl.Status::Open;
            ItemJournal.Modify(true);
        end;
    end;
    //Item Journal Line
    procedure ReleaseItemJournalLine(VAR ItemJnlLine: record "Item Journal Line")
    var
        ItemJournal: record "Item Journal Line";
    begin
        ItemJournal.Reset;
        ItemJournal.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
        ItemJournal.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        ItemJournal.SetRange("Line No.", ItemJnlLine."Line No.");
        if ItemJournal.FindFirst then begin
            ItemJournal.Status:=ItemJournal.Status::Released;
            ItemJournal.Modify(true);
        end;
    end;
    procedure ReopenItemJournalLine(VAR ItemJnlLine: record "Item Journal Line")
    var
        ItemJournal: record "Item Journal Line";
    begin
        ItemJournal.Reset;
        ItemJournal.SetRange("Document No.", ItemJnlLine."Document No.");
        if ItemJournal.FindFirst then begin
            ItemJournal.Status:=ItemJnlLine.Status::Open;
            ItemJournal.Modify(true);
        end;
    end;
    //LabSchedule
    procedure ReleaseLabSchedule(VAR LabSchedule: record "Lab Annual Testing Schedule")
    var
        LabSchedule2: record "Lab Annual Testing Schedule";
    begin
        LabSchedule2.Reset;
        LabSchedule2.SetRange(Code, LabSchedule.Code);
        if LabSchedule2.FindFirst then begin
            LabSchedule2.Status:=LabSchedule2.Status::Released;
            LabSchedule2.Modify(true);
        end;
    end;
    procedure ReopenLabSchedule(VAR LabSchedule: record "Lab Annual Testing Schedule")
    var
        LabSchedule2: record "Lab Annual Testing Schedule";
    begin
        LabSchedule2.Reset;
        LabSchedule2.SetRange(Code, LabSchedule.Code);
        if LabSchedule2.FindFirst then begin
            LabSchedule2.Status:=LabSchedule2.Status::Open;
            LabSchedule2.Modify(true);
        end;
    end;
    //Asset Disposal
    procedure ReleaseAssetDisposal(VAR AssetDisposal: record "AnnualDisposal Header")
    var
        AssetDisposal2: record "AnnualDisposal Header";
        AssetDisposalLines: Record "Annual Asset Disposal Lines";
        FA: Record "Fixed Asset";
    begin
        AssetDisposal2.Reset;
        AssetDisposal2.SetRange("No.", AssetDisposal."No.");
        if AssetDisposal2.FindFirst then begin
            AssetDisposal2.Status:=AssetDisposal2.Status::Approved;
            AssetDisposalLines.Reset();
            AssetDisposalLines.SetRange("No.", AssetDisposal."No.");
            if AssetDisposalLines.Find('-')then repeat FA.SetRange("No.", AssetDisposalLines."FA No.");
                    if FA.FindFirst()then begin
                        FA."Marked For Disposal":=true;
                        FA.Modify;
                    end;
                until AssetDisposalLines.Next() = 0;
            AssetDisposal2.Modify(true);
        end;
    end;
    procedure ReopenAssetDisposal(VAR AssetDisposal: record "AnnualDisposal Header")
    var
        AssetDisposal2: record "AnnualDisposal Header";
    begin
        AssetDisposal2.Reset;
        AssetDisposal2.SetRange("No.", AssetDisposal."No.");
        if AssetDisposal2.FindFirst then begin
            AssetDisposal2.Status:=AssetDisposal2.Status::Open;
            AssetDisposal2.Modify(true);
        end;
    end;
    procedure ReleaseLicenseRegistration(VAR LicenseRegistration: record "Licensing dairy Enterprise")
    var
        LicenseRegistration2: record "Licensing dairy Enterprise";
        Paymgmt: Codeunit "Payments Management";
    begin
        LicenseRegistration2.Reset;
        LicenseRegistration2.SetRange("Application No", LicenseRegistration."Application No");
        if LicenseRegistration2.FindFirst then begin
            LicenseRegistration2."Approval Status":=LicenseRegistration2."Approval Status"::Approved;
            // LicenseRegistration2.Submitted := true;
            LicenseRegistration2.Modify();
        // Paymgmt.CreateCustomer(LicenseRegistration2."Application no");
        end;
    end;
    procedure ReopenLicenseRegistration(VAR LicenseRegistration: record "Licensing dairy Enterprise")
    var
        LicenseRegistration2: record "Licensing dairy Enterprise";
    begin
        LicenseRegistration2.Reset;
        LicenseRegistration2.SetRange("Application No", LicenseRegistration."Application No");
        if LicenseRegistration2.FindFirst then begin
            LicenseRegistration2."Approval Status":=LicenseRegistration2."Approval Status"::Open;
            LicenseRegistration2.Submitted:=false;
            LicenseRegistration2.Modify();
        end;
    end;
    procedure ReleaseLicenseApplication(VAR LicenseApplication: record "License Applications")
    var
        LicenseApplication2: record "License Applications";
        PmtMgmt: Codeunit "Payments Management";
    begin
        LicenseApplication2.Reset;
        LicenseApplication2.SetRange("No.", LicenseApplication."No.");
        if LicenseApplication2.FindFirst then begin
            LicenseApplication2."Approval Status":=LicenseApplication2."Approval Status"::Approved;
            LicenseApplication2.Status:=LicenseApplication2.Status::"Pending inspection";
            LicenseApplication2.Modify(true);
            if LicenseApplication2."Customer No." = '' then PmtMgmt.CreateCustomer(LicenseApplication."No.");
        end;
    end;
    procedure ReopenLicenseApplication(VAR LicenseApplication: record "License Applications")
    var
        LicenseApplication2: record "License Applications";
    begin
        LicenseApplication2.Reset;
        LicenseApplication2.SetRange("No.", LicenseApplication."No.");
        if LicenseApplication2.FindFirst then begin
            LicenseApplication2."Approval Status":=LicenseApplication2."Approval Status"::Open;
            LicenseApplication2.Status:=LicenseApplication2.Status::Open;
            LicenseApplication2.Submitted:=false;
            LicenseApplication2.Modify(true);
        end;
    end;
    procedure ReleaseICTWorkplan(VAR ICTWorkplan: record "ICT Workplan")
    var
        ICTWorkplan2: record "ICT Workplan";
    begin
        ICTWorkplan2.Reset;
        ICTWorkplan2.SetRange("No.", ICTWorkplan."No.");
        if ICTWorkplan2.FindFirst then begin
            ICTWorkplan2.Status:=ICTWorkplan.Status::Approved;
            ICTWorkplan2.Modify(true);
        end;
    end;
    procedure ReopenICTWorkplan(VAR ICTWorkplan: record "ICT Workplan")
    var
        ICTWorkplan2: record "ICT Workplan";
    begin
        ICTWorkplan2.Reset;
        ICTWorkplan2.SetRange("No.", ICTWorkplan."No.");
        if ICTWorkplan2.FindFirst then begin
            ICTWorkplan2.Status:=ICTWorkplan2.Status::Open;
            ICTWorkplan2.Modify(true);
        end;
    end;
    //UserIncidences
    procedure ReleaseUserIncidences(VAR UserIncidences: record "User Support Incident")
    var
        UserIncidences2: record "User Support Incident";
    begin
        UserIncidences2.Reset;
        UserIncidences2.SetRange("Incident Reference", UserIncidences."Incident Reference");
        if UserIncidences2.FindFirst then begin
            UserIncidences2."Approval Status":=UserIncidences."Approval Status"::Approved;
            UserIncidences2.Modify(true);
        end;
    end;
    procedure ReopenUserIncidences(VAR UserIncidences: record "User Support Incident")
    var
        UserIncidences2: record "User Support Incident";
    begin
        UserIncidences2.Reset;
        UserIncidences2.SetRange("Incident Reference", UserIncidences."Incident Reference");
        if UserIncidences2.FindFirst then begin
            UserIncidences2."Approval Status":=UserIncidences."Approval Status"::Open;
            UserIncidences2.Modify(true);
        end;
    end;
    //RiskHeader
    procedure ReleaseRiskHeader(VAR RiskHeader: record "Risk Header")
    var
        RiskHeader2: record "Risk Header";
    begin
        RiskHeader2.Reset;
        RiskHeader2.SetRange("No.", RiskHeader."No.");
        if RiskHeader2.FindFirst then begin
            RiskHeader2."Status":=RiskHeader2."Status"::Released;
            RiskHeader2.Modify(true);
        end;
    end;
    procedure ReopenRiskHeader(VAR RiskHeader: record "Risk Header")
    var
        RiskHeader2: record "Risk Header";
    begin
        RiskHeader2.Reset;
        RiskHeader2.SetRange("No.", RiskHeader."No.");
        if RiskHeader2.FindFirst then begin
            RiskHeader2."Status":=RiskHeader2."Status"::New;
            RiskHeader2.Modify(true);
        end;
    end;
    //TransportIncident
    procedure ReleaseTransportIncident(VAR TransportIncident: record "Transport Incident")
    var
        TransportIncident2: record "Transport Incident";
    begin
        TransportIncident2.Reset;
        TransportIncident2.SetRange("Incident Reference", TransportIncident."Incident Reference");
        if TransportIncident2.FindFirst then begin
            TransportIncident2."Status":=TransportIncident2."Status"::Approved;
            TransportIncident2.Modify(true);
        end;
    end;
    procedure ReopenTransportIncident(VAR TransportIncident: record "Transport Incident")
    var
        TransportIncident2: record "Transport Incident";
    begin
        TransportIncident2.Reset;
        TransportIncident2.SetRange("Incident Reference", TransportIncident."Incident Reference");
        if TransportIncident2.FindFirst then begin
            TransportIncident2."Status":=TransportIncident2."Status"::Open;
            TransportIncident2.Modify(true);
        end;
    end;
    //DriverLogging
    procedure ReleaseDriverLogging(VAR DriverLogging: record "Driver Logging")
    var
        DriverLogging2: record "Driver Logging";
    begin
        DriverLogging2.Reset;
        DriverLogging2.SetRange("Log No.", DriverLogging."Log No.");
        if DriverLogging2.FindFirst then begin
            DriverLogging2."Status":=DriverLogging2."Status"::Approved;
            DriverLogging2.Modify(true);
        end;
    end;
    procedure ReopenDriverLogging(VAR DriverLogging: record "Driver Logging")
    var
        DriverLogging2: record "Driver Logging";
    begin
        DriverLogging2.Reset;
        DriverLogging2.SetRange("Log No.", DriverLogging."Log No.");
        if DriverLogging2.FindFirst then begin
            DriverLogging2."Status":=DriverLogging2."Status"::Open;
            DriverLogging2.Modify(true);
        end;
    end;
    //WorkProgramme
    procedure ReleaseWorkProgramme(VAR WorkProgramme: record "Activity Work Programme")
    var
        WorkProgramme2: record "Activity Work Programme";
        WPLines: Record "Activity Work Programme Lines";
        Space: Label '  ';
        Employee: Record Employee;
        CompanyInfo: Record "Company Information";
        Msg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that we have activity workprogramme %2 in which you are a participant has been approved. The activity start date is from %3 to %4. You may apply for imprest. </br><br><br><br>Kind regards,<br><br><Strong>%5<Strong></p>';
    begin
        WorkProgramme2.Reset;
        WorkProgramme2.SetRange("No.", WorkProgramme."No.");
        if WorkProgramme2.FindFirst then begin
            WorkProgramme2."Status":=WorkProgramme2."Status"::Approved;
            WorkProgramme2.Modify(true);
            WPLines.Reset();
            WPLines.SetRange("No.", WorkProgramme."No.");
            WPLines.setrange(Type, WPLines.Type::Participants);
            if WPLines.Find('-')then repeat Clear(Receipient);
                    Employee.Reset;
                    if Employee.Get(WPLines."Employee No.")then begin
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        CompanyInfo.TestField("E-Mail");
                        SenderAddress:=CompanyInfo."E-Mail";
                        SenderName:=CompanyInfo.Name;
                        Receipient.Add(Employee."E-Mail");
                        Subject:='Approval of activity workprogramme';
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(Msg, Employee."First Name", WorkProgramme."No.", WorkProgramme."Activity Start Date", WorkProgramme."Activity End Date", CompanyInfo.Name));
                        Email.Send(Emailmessage)end;
                until WPLines.Next() = 0;
        end;
    end;
    procedure ReopenWorkProgramme(VAR WorkProgramme: record "Activity Work Programme")
    var
        WorkProgramme2: record "Activity Work Programme";
    begin
        WorkProgramme2.Reset;
        WorkProgramme2.SetRange("No.", WorkProgramme."No.");
        if WorkProgramme2.FindFirst then begin
            WorkProgramme2."Status":=WorkProgramme2."Status"::Open;
            WorkProgramme2.Modify(true);
        end;
    end;
    //ProjectManagement
    procedure ReleaseProjectManagement(VAR ProjectMan: record Projectman)
    var
        Projectman2: record "ProjectMan";
    begin
        Projectman2.Reset;
        Projectman2.SetRange("Project No.", ProjectMan."Project No.");
        if projectman2.FindFirst then begin
            Projectman2."Project approval Status":=ProjectMan2."Project Approval Status"::Approved;
            ProjectMan2.Modify(true);
        end;
    end;
    procedure ReopenProjectManagement(VAR ProjectMan: record "ProjectMan")
    var
        Projectman2: record "ProjectMan";
    begin
        Projectman2.Reset;
        Projectman2.SetRange("Project No.", ProjectMan."Project No.");
        if projectman2.FindFirst then begin
            Projectman2."Project approval Status":=ProjectMan2."Project Approval Status"::Open;
            ProjectMan2.Modify(true);
        end;
    end;
    //Contract Management
    procedure ReleaseContractManagement(VAR ContractMan: record "Project Header")
    var
        Contractman2: record "Project Header";
        DcoRelease: Codeunit "Document Release";
    begin
        Contractman2.Reset;
        Contractman2.SetRange("No.", ContractMan."No.");
        if Contractman2.FindFirst then begin
            if Contractman2.Type = Contractman2.Type::Extension then begin
                Contractman2."Extension Status":=Contractman2."Extension Status"::Approved;
                Contractman2.Status:=Contractman2.Status::"Extended Contracts";
                Contractman2.Modify();
            end
            else //suspension
                If Contractman2."Type" = Contractman2."Type"::Suspension then begin
                    Contractman2."Suspension Status":=Contractman2."Suspension Status"::Approved;
                    Contractman2.Status:=Contractman2.Status::"Suspended";
                    Contractman2.Modify();
                end
                else
                begin
                    Contractman2."Status":=ContractMan2."Status"::Approved;
                    Contractman2.Modify(true);
                end;
            DcoRelease.SendContractEmail(ContractMan);
        end;
    end;
    procedure ReopenContractManagement(VAR ContractMan: record "Project Header")
    var
        Contractman2: record "Project Header";
    begin
        Contractman2.Reset;
        Contractman2.SetRange("No.", ContractMan."No.");
        if Contractman2.FindFirst then begin
            Contractman2."Status":=ContractMan2."Status"::Open;
            Contractman2.Modify(true);
        end;
    end;
    //Project Management Status Update
    procedure ReleaseProjectManagementStatus(VAR ProjectMan: record "Projectman")
    var
        Projectman2: record "ProjectMan";
    begin
        Projectman2.Reset;
        Projectman2.SetRange("Project No.", ProjectMan."Project No.");
        if Projectman2.FindFirst then begin
            Projectman2."Project Status":=ProjectMan2."Project Status"::"Work in Progress";
            projectman2.Modify(true);
        end;
    end;
    procedure ReopenProjectManagementStatus(VAR ProjectMan: record "Projectman")
    var
        Projectman2: record "ProjectMan";
    begin
        Projectman2.Reset;
        Projectman2.SetRange("Project No.", ProjectMan."Project No.");
        if Projectman2.FindFirst then begin
            Projectman2."Project Status":=ProjectMan2."Project Status"::"open";
            projectman2.Modify(true);
        end;
    end;
}

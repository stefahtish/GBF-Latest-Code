codeunit 50136 "Document Release"
{
    trigger OnRun()
    begin
    end;
    var Text000: Label 'This document can only be released when the approval process is complete.';
    Text001: Label 'This document has been rejected, you cannot approved it';
    Text002: Label 'The approval process must be cancelled or completed to reopen this document.';
    Text003: Label 'The approval process must be canceled or completed to reopen this document.';
    procedure EmployeeTransferRelease(var EmployeeTransfer: Record "Employee Transfers")
    var
    begin
        if EmployeeTransfer.Status = EmployeeTransfer.Status::Released then exit;
        EmployeeTransfer.Status:=EmployeeTransfer.Status::Released;
        EmployeeTransfer.Modify();
    end;
    procedure EmployeeTransferReopen(var EmployeeTransfer: Record "Employee Transfers")
    var
    begin
        if EmployeeTransfer.Status = EmployeeTransfer.Status::New then exit;
        EmployeeTransfer.Status:=EmployeeTransfer.Status::New;
        EmployeeTransfer.Modify();
    end;
    procedure RequisitionRelease(var Requisition: record "Internal Request Header")
    var
        myInt: Integer;
    begin
        Requisition.Status:=Requisition.Status::Released;
        Requisition.Modify();
    end;
    procedure RequisitionReopen(var Requisition: record "Internal Request Header")
    begin
        if Requisition.Status = Requisition.Status::Open then exit;
        Requisition.Status:=Requisition.Status::Open;
        Requisition.Modify(true);
    end;
    procedure SampleRelease(var Sample: Record "Sample Analysis And Reporting")
    var
    begin
        if Sample.Status = Sample.Status::Released then exit;
        Sample.Status:=Sample.Status::Released;
        Sample.Modify();
    end;
    procedure SampleReopen(var Sample: Record "Sample Analysis And Reporting")
    var
    begin
        if Sample.Status = Sample.Status::open then exit;
        Sample.Status:=Sample.Status::Open;
        Sample.Modify();
    end;
    //TargetSetupHeader
    procedure TargetSetupHeaderRelease(var TargetSetup: Record "Target Setup Header")
    var
    begin
        TargetSetup."Target Status":=TargetSetup."Target Status"::Approved;
        TargetSetup.Modify(true);
    end;
    procedure TargetSetupHeaderReopen(var TargetSetup: Record "Target Setup Header")
    var
        TargetSetup1: Record "Target Setup Header";
    begin
        TargetSetup1.Reset;
        TargetSetup1.SetRange("Target No", TargetSetup."Target No");
        if TargetSetup1.FindFirst()then begin
            TargetSetup1."Target Status":=TargetSetup1."Target Status"::Setting;
            TargetSetup1.Modify(true);
        end;
    end;
    procedure AssetTransferRelease(var AssetTrans: Record "Asset Allocation and Transfer")
    var
    begin
        if AssetTrans.Status = AssetTrans.Status::Released then exit;
        AssetTrans.Status:=AssetTrans.Status::Released;
        AssetTrans.Modify();
    end;
    procedure AssetTransferReopen(var AssetTrans: Record "Asset Allocation and Transfer")
    var
    begin
        if AssetTrans.Status = AssetTrans.Status::open then exit;
        AssetTrans.Status:=AssetTrans.Status::Open;
        AssetTrans.Modify();
    end;
    procedure SendContractEmail(ContractHeader: Record "Project Header")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Contract: Record "Project Header";
        Subject: Label 'Contract Approval';
        ExtensionNewBody: Label 'Dear %1, <br>This is To notify you that extension for Contract No. %1 has been approved. <br><br>Kind Regards, <br><br><Strong>BPIT Contract Committee</Strong>.  ';
        SuspensionNewBody: Label 'Dear %1, <br>This is To notify you that suspension for Contract No. %1 has been approved. <br><br>Kind Regards, <br><br><Strong>BPIT Contract Committee</Strong>.  ';
        NewBody: Label 'Dear %1, <br>This is To Notify you that Contract No. %1 has been approved. <br><br>Kind Regards, <br><br><Strong>BPIT Contract Committee</Strong>.  ';
    begin
        Contract.Reset();
        Contract.SetRange("No.", ContractHeader."No.");
        If Contract.FindFirst()then begin
            If ContractHeader."Company E-mail" <> '' then begin
                If ContractHeader.Type = ContractHeader.Type::Extension then begin
                    EmailMessage.Create(ContractHeader."Company E-mail", Subject, StrSubstNo(ExtensionNewBody, ContractHeader."Supplier Name", ContractHeader."No."), true);
                end
                else if ContractHeader.Type = ContractHeader.Type::Suspension then begin
                        EmailMessage.Create(ContractHeader."Company E-mail", Subject, StrSubstNo(SuspensionNewBody, ContractHeader."Supplier Name", ContractHeader."No."), true);
                    end
                    else
                    begin
                        EmailMessage.Create(ContractHeader."Company E-mail", Subject, StrSubstNo(NewBody, ContractHeader."Supplier Name", ContractHeader."No."), true);
                    end;
                Email.Send(EmailMessage);
            end;
            Message('Supplier Notified Successfully');
        end;
    end;
    procedure PayrollApprovalRelease(var PayrollApproval: record "Payroll Approval")
    var
        TransferToJournal: Report "Transfer to Journal";
        PaymentsMgt: Codeunit "Payments Management";
        PayrollApprovalRec: record "Payroll Approval";
    begin
        PayrollApprovalRec.Reset();
        PayrollApprovalRec.SetRange("No.", PayrollApproval."No.");
        if PayrollApprovalRec.FindFirst()then begin
            PayrollApprovalRec.Status:=PayrollApprovalRec.Status::Approved;
            PayrollApprovalRec.Modify();
        end;
    end;
    procedure PayrollApprovalReopen(var PayrollApproval: record "Payroll Approval")
    var
        PayrollApprovalRec: Record "Payroll Approval";
    begin
        PayrollApprovalRec.Reset();
        PayrollApprovalRec.SetRange("No.", PayrollApproval."No.");
        if PayrollApprovalRec.FindFirst()then begin
            PayrollApprovalRec.Status:=PayrollApprovalRec.Status::Open;
            PayrollApprovalRec.Modify();
        end;
    end;
    //Target Setup Header
    procedure AppraisalInitiation(var TargetSetupHeader: Record "Target Setup Header")
    var
        EmployeeApprisal: Record "Employee Appraisal";
        Noseries: Code[20];
        CoreSetup: Record "Core Values/Competences setup";
        AppraisalCompetence: Record "Appraisal Competences";
    begin
        EmployeeApprisal.Init;
        EmployeeApprisal.TransferFields(TargetSetupHeader);
        EmployeeApprisal."Appraisal No":=' ';
        EmployeeApprisal.Insert(true);
        // TargetSetupHeader.Modify;
        if EmployeeApprisal.Manager = true then begin
            CoreSetup.Reset();
            CoreSetup.SetFilter(Type, '%1|%2', CoreSetup.Type::"Managerial Core Values/Competence", CoreSetup.Type::"Core Values/Competence");
            if CoreSetup.FindSet()then repeat AppraisalCompetence.Init();
                    AppraisalCompetence."Appraisal No.":=EmployeeApprisal."Appraisal No";
                    AppraisalCompetence."SNo.":=CoreSetup."SNo.";
                    AppraisalCompetence.Description:=CoreSetup.Description;
                    AppraisalCompetence."Max Score":=CoreSetup."Max Weight";
                    AppraisalCompetence."Core Value/Competence":=CoreSetup.Type;
                    AppraisalCompetence.Insert();
                until CoreSetup.Next() = 0;
        end
        else
        begin
            CoreSetup.Reset();
            CoreSetup.SetRange(Type, CoreSetup.Type::"Core Values/Competence");
            if CoreSetup.FindSet()then repeat AppraisalCompetence.Init();
                    AppraisalCompetence."Appraisal No.":=EmployeeApprisal."Appraisal No";
                    AppraisalCompetence."SNo.":=CoreSetup."SNo.";
                    AppraisalCompetence.Description:=CoreSetup.Description;
                    AppraisalCompetence."Max Score":=CoreSetup."Max Weight";
                    AppraisalCompetence."Core Value/Competence":=CoreSetup.Type;
                    AppraisalCompetence.Insert();
                until CoreSetup.Next() = 0;
        end;
    end;
}

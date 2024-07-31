codeunit 50127 "Release Requisition"
{
    TableNo = "Internal Request Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        OnBeforeReleaseRequisition(Rec);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        //SendApprovedEmail("No.");
        OnAfterReleaseRequisition(Rec);
    end;
    var Text001: Label 'There is nothing to release for Payment %1.';
    Text002: Label 'This document can only be released when the approval process is complete.';
    Text003: Label 'The approval process must be canceled or completed to reopen this document.';
    Text004: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
    Text005: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
    CompInfo: Record "Company Information";
    ///SMTPSetup: Record "SMTP Mail Setup";
    UserSetup: Record "User Setup";
    ApprovalMail: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Purchase Requisition No.%2 has been approved.</p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly attend to it.</p><p style="font-family:Verdana,Arial;font-size:9pt";font color="#cbefe5">This is a system generated message, do not reply.</p><p><b>%3</b></p>';
    procedure Reopen(var Requisition: Record "Internal Request Header")
    var
        Committment: Codeunit Committment;
    begin
        OnBeforeReopenRequisition(Requisition);
        if Requisition.Status = Requisition.Status::Open then exit;
        Requisition.Status:=Requisition.Status::Open;
        Requisition.Modify(true);
        Commit;
        Committment.ReversePurchReqCommittment(Requisition);
        OnAfterReopenRequisition(Requisition);
    end;
    procedure PerformManualRelease(var Requisition: Record "Internal Request Header")
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // IF ApprovalsMgmt.IsRequisitionsApprovalsWorkflowEnabled(Requisition) AND (Requisition.Status = Requisition.Status::Open) THEN
        //  ERROR(Text002);
        CODEUNIT.Run(CODEUNIT::"Release Requisition", Requisition);
    end;
    procedure PerformManualReopen(var Requisition: Record "Internal Request Header")
    begin
        // IF Requisition.Status = Requisition.Status::"Pending Approval" THEN
        //  ERROR(Text003);
        Reopen(Requisition);
    end;
    procedure sendSupplyChainNotifications(var Requisition: Record "Internal Request Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        CompanyInfo: Record "Company Information";
        FileManagement: Codeunit "File Management";
        Employee: Record Employee;
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of[text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of[text];
        Attachment: Text;
        ErrorMsg: Text;
        Body: Label 'Dear All, <br><br> This is to notify you that a %1 Requisition <Strong>%2</Strong> has been fully approved for your action.<br><br>Please find attached the requisition report to see the details.<br><br> Kind Regards, <br><br> <Strong>%3</Strong> ';
        Instr: InStream;
        EmailSignText: Text;
        EmailSignBigText: BigText;
        TempBlobNew: Codeunit "Temp Blob";
        StoreRequest: Report "Store Request";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailScenario: Enum "Email Scenario";
        FilePath: Text;
        Requisitions: Record "Internal Request Header";
    begin
        PurchSetup.Get();
        if PurchSetup."Send Requisition Notifications" then begin
            Clear(StoreRequest);
            CompanyInfo.get;
            CompanyInfo.CalcFields(Picture);
            Clear(Receipient);
            PurchSetup.TestField("Procurement Email");
            CompanyInfo.Get;
            CompanyInfo.TestField(Name);
            CompanyInfo.TestField("E-Mail");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Receipient.Add(PurchSetup."Procurement Email");
            Subject:=StrSubstNo('Approval for Requisition %1', Requisition."No.");
            EmailMessage.Create(Receipient, Subject, StrSubstNo((Body), Requisition."Document Type", Requisition."No.", SenderName), true);
            Clear(Instr);
            FileName:='Requisition ' + Requisition."No." + '.pdf';
            FilePath:=PurchSetup."REquisition File Path" + '\' + FileName;
            Requisitions.Reset();
            Requisitions.SetRange("No.", Requisition."No.");
            Requisitions.SetRange("Document Type", Requisition."Document Type");
            StoreRequest.SetTableView(Requisitions);
            //EDDIE 
            // if not Exists(FilePath) then
            //     StoreRequest.SaveAsPdf(FilePath);
            // FileManagement.BLOBImportFromServerFile(TempBlobNew, FilePath);
            TempBlobNew.CreateInStream(Instr);
            EmailMessage.AddAttachment(FileName, 'PDF', Instr);
            Email.Send(EmailMessage, EmailScenario::Default);
        end;
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReleaseRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterReleaseRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;
    procedure SendApprovedEmail(ReqNo: Code[20])
    var
        //SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "Email Message";
        Filename: Text[100];
        Selectedfilter: Date;
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Text001: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Purchase Requisition No.%2 has been approved.</p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly attend to it.</p><p style="font-family:Verdana,Arial;font-size:9pt";font-color="blue">This is a system generated message, do not reply.</p><p><b>%3</b></p>';
    begin
    // SMTPSetup.GET();
    // CompInfo.GET();
    //
    // UserSetup.RESET;
    // UserSetup.SETRANGE(UserSetup."Req Email Notification",TRUE);
    // IF UserSetup.FIND('-') THEN
    //  BEGIN
    //    REPEAT
    //      IF UserSetup."E-Mail"<>'' THEN
    //      SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",UserSetup."E-Mail",'Approved Purchase Requisition','',TRUE);
    //      SMTPMail.AppendBody(STRSUBSTNO(ApprovalMail,UserSetup."User ID",ReqNo,CompInfo.Name));
    //      SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
    //      SMTPMail.AppendBody('<br><br>');
    //      SMTPMail.AddAttachment(Filename,Attachment);
    //      SMTPMail.Send;
    //    UNTIL UserSetup.NEXT=0;
    //  END;
    end;
}

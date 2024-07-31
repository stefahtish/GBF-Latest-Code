codeunit 50144 "Email Notification Manager"
{
    var PaymentsRec: Record Payments;
    EmployeeRec: Record Employee;
    CashManagementSetup: Record "Cash Management Setups";
    NVInStream: InStream;
    Recipient: List of[Text];
    SenderName: Text;
    OutStr: OutStream;
    InStr: InStream;
    Email: Codeunit email;
    InSReadChar: Text[1];
    Body: Text;
    CharNo: Text[4];
    SMTP: Codeunit "Email Message";
    //STMPSetup: Record "SMTP Mail Setup";
    AssignMatrix: Record "Assignment Matrix-X";
    HrSetup: Record "Human Resources Setup";
    //For Customer Receipt
    procedure RunReminders(NotificationRecord: Variant; UpdateRec: Boolean; Resent: Boolean; AccountNo: Code[20])
    var
        RecRef: RecordRef;
        Window: Dialog;
        EmailBody: Text;
        FileName: Text[250];
        Customers: Record Customer;
    begin
        RecRef.GetTable(NotificationRecord);
        case RecRef.Number of Database::Payments: begin
            RecRef.SetTable(PaymentsRec);
            CashManagementSetup.Get();
            if(CashManagementSetup."Customer Email Subject" = '')then exit;
            if not Customers.Get(AccountNo)then exit;
            if not CheckValidEmail(Customers."E-Mail")then exit;
            if CheckValidEmail(Customers."E-Mail") and not(Customers."E-Mail" = '')then Recipient.Add(Customers."E-Mail");
            Clear(OutStr);
            Clear(InStr);
            EmailBody:='Dear ' + Customers.Name + ',<br><br>' + CashManagementSetup."Customer Email Body" + '<br><br>Regards,<br>' + UserId;
            //eddie STMPSetup.Get();
            FileName:=Customers.Name + ' - ' + 'Payment Receipt #' + Format(PaymentsRec."No.") + '.pdf';
            SMTP.Create(Recipient, CashManagementSetup."Customer Email Subject", EmailBody, true);
            SetEmailingReport(RecRef.Number, FileName);
            if Email.Send(SMTP) and UpdateRec then begin
                Message('Email has been sent to, ' + Customers.Name);
            end;
        end;
        end;
    end;
    //Vendor Email Receipt
    procedure RunVReminders(NotificationRecord: Variant; UpdateRec: Boolean; Resent: Boolean; AccountNo: Code[20])
    var
        RecRef: RecordRef;
        Window: Dialog;
        EmailBody: Text;
        FileName: Text[250];
        Vendor: Record Vendor;
    begin
        RecRef.GetTable(NotificationRecord);
        case RecRef.Number of Database::Payments: begin
            RecRef.SetTable(PaymentsRec);
            CashManagementSetup.Get();
            if(CashManagementSetup."Vendor Email Subject" = '')then exit;
            if not Vendor.Get(AccountNo)then exit;
            if not CheckValidEmail(Vendor."E-Mail")then exit;
            if CheckValidEmail(Vendor."E-Mail") and not(Vendor."E-Mail" = '')then Recipient.Add(Vendor."E-Mail");
            Clear(OutStr);
            Clear(InStr);
            EmailBody:='Dear ' + Vendor.Name + ',<br><br>' + CashManagementSetup."Vendor Email Body" + '<br><br>Regards,<br>' + UserId;
            //eddie STMPSetup.Get();
            FileName:=Vendor.Name + ' - ' + 'Payment Receipt #' + Format(PaymentsRec."No.") + '.pdf';
            SMTP.Create(Recipient, CashManagementSetup."Vendor Email Subject", EmailBody, true);
            SetEmailingReport(RecRef.Number, FileName);
            if Email.Send(SMTP) and UpdateRec then begin
                Message('Email has been sent to, ' + Vendor.Name);
            end;
        end;
        end;
    end;
    //Common for Customer and Vendor
    local procedure SetEmailingReport(RecID: Integer; FileName: Text)
    var
        LocalRecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Test: Text;
        dd: Codeunit "Stream Management";
        GetFilter: Text;
        LocalPayments: Record Payments;
    begin
        case RecID of Database::Payments: begin
            Clear(TempBlob);
            LocalPayments.Reset();
            LocalPayments.SetFilter("No.", '%1', PaymentsRec."No.");
            if LocalPayments.FindFirst()then begin
                LocalRecRef.GetTable(LocalPayments);
                TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                Report.SaveAs(Report::"Receipt Custom", '', ReportFormat::Pdf, OutStr, LocalRecRef);
                TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
            //eddie SMTP.AddAttachment(InStr, FileName,'');
            end;
        end;
        end;
    end;
    //For Payslip
    procedure RunPayslip(NotificationVariant: Variant; UpdateRec: Boolean; Resent: Boolean; PayPeriod: Date)
    var
        RecRef: RecordRef;
        Window: Dialog;
        EmailBody: Text;
        FileName: Text[250];
        Subject: Text;
    begin
        RecRef.GetTable(NotificationVariant);
        case RecRef.Number of Database::Employee: begin
            RecRef.SetTable(EmployeeRec);
            HrSetup.Get();
            if(HrSetup."General Payslip Message" = '')then Error('General Payslip Message field on HR Setup is empty!');
            EmployeeRec.TestField("Company E-Mail");
            if not CheckValidEmail(EmployeeRec."Company E-Mail")then exit;
            if CheckValidEmail(EmployeeRec."Company E-Mail") and not(EmployeeRec."Company E-Mail" = '')then Recipient.Add(EmployeeRec."Company E-Mail");
            Clear(OutStr);
            Clear(InStr);
            Subject:='Payslip for Period - ' + Format(PayPeriod);
            EmailBody:='Dear ' + EmployeeRec."First Name" + ',<br><br>' + HrSetup."General Payslip Message";
            //STMPSetup.Get();
            FileName:=EmployeeRec."First Name" + ' - ' + 'Payslip for Period #' + Format(PayPeriod) + '.pdf';
            SMTP.Create(Recipient, Subject, EmailBody, true);
            SetEmailingReport2(RecRef.Number, FileName, PayPeriod);
            Email.Send(SMTP);
        end;
        end;
    end;
    local procedure SetEmailingReport2(RecID: Integer; FileName: Text; PayPeriod: Date)
    var
        LocalRecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Test: Text;
        GetFilter: Text;
        LocalEmployee: Record Employee;
    begin
        case RecID of Database::Employee: begin
            Clear(TempBlob);
            LocalEmployee.Reset();
            LocalEmployee.SetFilter("No.", '%1', EmployeeRec."No.");
            LocalEmployee.SetRange("Pay Period Filter", PayPeriod);
            LocalEmployee.SetFilter(Status, '%1', EmployeeRec.Status::Active);
            if LocalEmployee.FindFirst()then begin
                LocalRecRef.GetTable(LocalEmployee);
                TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                Report.SaveAs(Report::"New Payslipx", '', ReportFormat::Pdf, OutStr, LocalRecRef);
                TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
            //eddie mark SMTP.AddAttachmentStream(InStr, FileName);
            end;
        end;
        end;
    end;
    //Common Settings
    local procedure CheckValidEmail(RecipientsMail: Text): Boolean var
        TmpRecipients: Text;
        ValidEmail: Boolean;
    begin
        ValidEmail:=false;
        if RecipientsMail = '' then exit(false);
        TmpRecipients:=DelChr(RecipientsMail, '<>', ';');
        while StrPos(TmpRecipients, ';') > 1 do begin
            if ValidateEmail(CopyStr(TmpRecipients, 1, StrPos(TmpRecipients, ';') - 1))then ValidEmail:=true;
            TmpRecipients:=CopyStr(TmpRecipients, StrPos(TmpRecipients, ';') + 1);
        end;
        if ValidEmail then exit(ValidEmail);
        ValidEmail:=ValidateEmail(TmpRecipients);
        exit(ValidEmail);
    end;
    local procedure ValidateEmail(EmailAddress: Text): Boolean var
        Valid: Boolean;
        i: Integer;
        NoOfAtSigns: Integer;
    begin
        NoOfAtSigns:=0;
        Valid:=false;
        if EmailAddress = '' then exit(Valid);
        EmailAddress:=DelChr(EmailAddress, '<>');
        if(EmailAddress[1] = '@') or (EmailAddress[StrLen(EmailAddress)] = '@')then exit(false);
        for i:=1 to StrLen(EmailAddress)do begin
            if EmailAddress[i] = '@' then NoOfAtSigns:=NoOfAtSigns + 1
            else if EmailAddress[i] = ' ' then exit(Valid);
        end;
        if not(NoOfAtSigns = 1)then exit(Valid);
        exit(true);
    end;
}

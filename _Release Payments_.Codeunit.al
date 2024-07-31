codeunit 50105 "Release Payments"
{
    TableNo = Payments;

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        OnBeforeReleasePayments(Rec);
        Rec.Status:=Rec.Status::Released;
        //Committment.ImprestCommittment(Rec);
        // IF ("Payment Type" = "Payment Type"::"Staff Claim") and ("Claim Type" <> "Claim Type"::"Mileage Claim") THEN begin
        IF(Rec."Payment Type" = Rec."Payment Type"::"Staff Claim")THEN begin
            PmtLines.Reset();
            PmtLines.SetRange(No, Rec."No.");
            // PmtLines.SetRange("Activity Work Programme", '<>%1', ' ');
            // if PmtLines.find('-') then begin
            //     repeat
            //         Wprogram := PmtLines."Activity Work Programme";
            //         Amt += PmtLines.Amount;
            //     until PmtLines.next = 0;
            // end;
            WpLines.Reset();
            WpLines.SetRange("Employee No.", Rec."Staff No.");
            WpLines.SetRange("No.", Wprogram);
            if WpLines.FindFirst()then begin
                WpLines."Mileage claimed":=true;
                WpLines."Remaining Mileage":=WpLines."Estimated Mileage Amount" - Amt;
                WpLines.Modify();
            end;
        end;
        Rec.Modify(true);
        OnAfterReleasePayments(Rec);
    end;
    var Text001: Label 'There is nothing to release for Payment %1.';
    Text002: Label 'This document can only be released when the approval process is complete.';
    Text003: Label 'The approval process must be canceled or completed to reopen this document.';
    Text004: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
    Text005: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
    Committment: Codeunit Committment;
    UserSetup: Record "User Setup";
    SMTP: Codeunit "Email Message";
    WpLines: record "Activity Work Programme Lines";
    Amt: Decimal;
    Wprogram: code[20];
    PmtLines: Record "Payment Lines";
    Recipient: list of[text];
    SenderAddress: Text;
    EmailBody: Label '<p style="font-family:Corbel,Corbel;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Corbel,Corbel;font-size:10pt"> This is to inform your %2 No. %3 has been approved. </br><br>Kindly proceed to Confirm Receipt of Funds in the system. <br><br> Thank you.<br><br>Kind regards,<br><br><Strong>%4<Strong></p>';
    CompanyInfo: Record "Company Information";
    CashSetup: Record "Cash Management Setups";
    SenderName: Text;
    Subject: text;
    procedure Reopen(var Payments: Record Payments)
    begin
        OnBeforeReopenPayments(Payments);
        if Payments.Status = Payments.Status::Open then exit;
        Payments.Status:=Payments.Status::Open;
        Payments.Modify(true);
        OnAfterReopenPayments(Payments);
    end;
    procedure PerformManualRelease(var Payments: Record Payments)
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Payments", Payments);
    end;
    procedure PerformManualReopen(var Payments: Record Payments)
    begin
        if Payments.Status = Payments.Status::"Pending Approval" then Error(Text003);
        Reopen(Payments);
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReleasePayments(var Payments: Record Payments)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterReleasePayments(var Payments: Record Payments)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenPayments(var Payments: Record Payments)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenPayments(var Payments: Record Payments)
    begin
    end;
}

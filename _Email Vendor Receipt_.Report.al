report 50209 "Email Vendor Receipt"
{
    Caption = 'Email Receipt';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.");

            trigger OnAfterGetRecord()
            var
                Receipts: Record Payments;
                ReceiptLine: Record "Payment Lines";
                CashSetup: Record "Cash Management Setups";
                Text001: Label 'Kindly ensure that the Vendor Email Body and Vendor Email Subject for Receipt are not blank in Cash Management Setup.';
                NotificationConfirm: Label 'Do you want to send the Receipt to Vendor';
                Emailmanager: Codeunit "Email Notification Manager";
            begin
                if not Receipts.Get(ReceiptNo) then exit;
                ReceiptLine.Reset();
                ReceiptLine.SetFilter(No, '%1', Receipts."No.");
                ReceiptLine.SetFilter("Account No", '%1', Vendor."No.");
                // if ReceiptLine.FindFirst() then begin
                //     CashSetup.Get();
                //     // if (CashSetup."Vendor Email Body" <> '') and (CashSetup."Vendor Email Subject" <> '') then begin
                //     if Confirm(NotificationConfirm) then
                //         Emailmanager.RunVReminders(Receipts, true, true, Vendor."No.");
                // end else
                //     Error(Text001);
            end;
            // end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field(ReceiptNo; ReceiptNo)
                    {
                        Caption = 'Receipt No.';
                        ApplicationArea = All;
                        TableRelation = Payments."No.";
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if Vendor.GetFilter("No.") = '' then Error('Vendor No. field is required!');
        if ReceiptNo = '' then Error('Receipt No. field is required');
    end;

    var
        ReceiptNo: Code[20];
}

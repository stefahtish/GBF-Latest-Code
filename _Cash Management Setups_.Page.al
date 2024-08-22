page 50106 "Cash Management Setups"
{
    PageType = Card;
    SourceTable = "Cash Management Setups";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Payment Voucher Template"; Rec."Payment Voucher Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Voucher Template field';
                }
                field("Imprest Journal Template"; Rec."Imprest Journal Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Journal Template field';
                }
                field("Imprest Surrender Template"; Rec."Imprest Surrender Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Surrender Template field';
                }
                field("Petty Cash Journal Template"; Rec."Petty Cash Journal Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Petty Cash Journal Template field';
                }
                field("Petty Cash Surrender Template"; Rec."Petty Cash Surrender Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Petty Cash Surrender Template field';
                }
                field("Receipt Template"; Rec."Receipt Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Template field';
                }
                field("Staff Claim Template"; Rec."Staff Claim Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Claim Template field';
                }
                field("Bank Transfer Template"; Rec."Bank Transfer Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Transfer Template field';
                }
                field("Post VAT"; Rec."Post VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post VAT field';
                }
                field("Rounding Type"; Rec."Rounding Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rounding Type field';
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rounding Precision field';
                }
                field("Imprest Limit"; Rec."Imprest Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Limit field';
                }
                field("Travel Limit Date"; Rec."Travel Limit Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Travel Limit Date field.';
                }
                field("Imprest Due Date"; Rec."Imprest Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Due Date field';
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Budget field';
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Budget Start Date field';
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Budget End Date field';
                }
                field("Imprest Posting Group"; Rec."Imprest Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Posting Group field';
                }
                field("General Bus. Posting Group"; Rec."General Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Bus. Posting Group field';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
                }
                field("Projects G/L Account"; Rec."Projects G/L Account")
                {
                    ToolTip = 'Specifies the value of the Projects G/L Account field.';
                    ApplicationArea = All;
                }
                field("Check for Committment"; Rec."Check for Committment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Check for Committment field';
                }
                field("Petty Cash Max"; Rec."Petty Cash Max")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Petty Cash Max field';
                }
                field("Max Imprests Unsurrendered"; Rec."Max Imprests Unsurrendered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Imprests Unsurrendered field';
                }
                field("Max Open Documents"; Rec."Max Open Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Open Documents field';
                }
                field("EFT Path"; Rec."EFT Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT Path field';
                }
                field("Forex Path"; Rec."Forex Path")
                {
                    ApplicationArea = All;
                }
                field("EFT Path User"; Rec."EFT Path User")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("EFT Path User Password"; Rec."EFT Path User Password")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Bank"; Rec."Default Bank")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Bank field.';
                }
                field("POP Code"; Rec."POP Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the POP Code field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    Caption = 'Default Pay Mode';
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Default Currency Code"; Rec."Default Currency Code")
                {
                    ToolTip = 'Specifies the value of the Default Currency Code field.';
                    ApplicationArea = All;
                }
                field("Payment Files Archive Path"; Rec."Payment Files Archive Path")
                {
                    ApplicationArea = All;
                }
                field("Tax Files Path"; Rec."Tax Files Path")
                {
                    ApplicationArea = All;
                }
                field("Append Sign To Documents"; Rec."Append Sign To Documents")
                {
                    Caption = 'Append Signatures on Documents';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Append Signatures on Documents field';
                }
                field("Loan Journal Template"; Rec."Loan Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Loan Journal Template field';
                }
                field("Loan Batch Template"; Rec."Loan Batch Template")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Loan Batch Template field';
                }
                field("Payment Description1"; Rec."Payment Description1")
                {
                    ToolTip = 'Specifies the value of the Payment Description1 field.';
                    ApplicationArea = All;
                }
                field("Payment Description2"; Rec."Payment Description2")
                {
                    ToolTip = 'Specifies the value of the Payment Description2 field.';
                    ApplicationArea = All;
                }
                field("Payment Description3"; Rec."Payment Description3")
                {
                    ToolTip = 'Specifies the value of the Payment Description3 field.';
                    ApplicationArea = All;
                }
                field("Payment Description4"; Rec."Payment Description4")
                {
                    ToolTip = 'Specifies the value of the Payment Description4 field.';
                    ApplicationArea = All;
                }
                field("Debit Narrative"; Rec."Debit Narrative")
                {
                    ToolTip = 'Specifies the value of the Debit Narrative field.';
                    ApplicationArea = All;
                }
                field("Credit Narrative"; Rec."Credit Narrative")
                {
                    ToolTip = 'Specifies the value of the Credit Narrative field.';
                    ApplicationArea = All;
                }
                field("Purpose Pay"; Rec."Purpose Pay")
                {
                    ToolTip = 'Specifies the value of the Purpose Pay field.';
                    ApplicationArea = All;
                }
                field("Claim Overspend Code"; Rec."Claim Overspend Code")
                {
                    ToolTip = 'Specifies the value of the Claim Overspend Code field.';
                }
            }
            group(Numbering)
            {
                field("PV Nos"; Rec."PV Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PV Nos field';
                }
                field("Petty Cash Nos"; Rec."Petty Cash Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Petty Cash Nos field';
                }
                field("Petty Cash Surrender Nos"; Rec."Petty Cash Surrender Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Petty Cash Surrender Nos field';
                }
                field("Imprest Nos"; Rec."Imprest Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Nos field';
                }
                field("Imprest Surrender Nos"; Rec."Imprest Surrender Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Surrender Nos field';
                }
                field("Receipt Nos"; Rec."Receipt Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Nos field';
                }
                field("Donor Workflows Nos"; Rec."Donor Workflows Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Donor Workflows Nos field';
                }
                field("Tax Payment Nos"; Rec."Tax Payment Nos")
                {
                    ApplicationArea = All;
                }
                field("PV Request Nos"; Rec."PV Request Nos")
                {
                    ToolTip = 'Specifies the value of the PV Request Nos field.';
                    ApplicationArea = All;
                }
                field("Item Journal Nos"; Rec."Item Journal Nos")
                {
                    ToolTip = 'Specifies the value of the Item Journal Nos field.';
                    ApplicationArea = All;
                }
                field("Tag Nos"; Rec."Tag Nos")
                {
                    ToolTip = 'Specifies the value of the Tag Nos field.';
                    ApplicationArea = All;
                }
                field("Approvals Delegation Nos."; Rec."Approvals Delegation Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approvals Delegation Nos. field';
                }
                field("Staff Claim Nos"; Rec."Staff Claim Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Claim Nos field';
                }
                field("Bank Transfer Nos"; Rec."Bank Transfer Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Transfer Nos field';
                }
                field("Profile Delegation Nos"; Rec."Profile Delegation Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Profile Delegation Nos field';
                }
                field("Apportionment Nos"; Rec."Apportionment Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Apportionment Nos field';
                }
                field("Input Tax Nos"; Rec."Input Tax Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Input Tax Nos field';
                }
                field("Service Charge Nos"; Rec."Service Charge Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Charge Nos field';
                }
                field("Service Charge Surrender Nos"; Rec."Service Charge Surrender Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Charge Surrender Nos field';
                }
                field("Service Charge Claim Nos"; Rec."Service Charge Claim Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Charge Claim Nos field';
                }
                field("Budget Approval Nos"; Rec."Budget Approval Nos")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Budget Approval Nos field';
                }
                field("Proposed Budget Approval Nos"; Rec."Proposed Budget Approval Nos")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Proposed Budget Approval Nos field';
                }
                field("Departmemtal Budget Nos"; Rec."Departmemtal Budget Nos")
                {
                    ApplicationArea = basic, suite;
                }
                field("FA Disposal Nos"; Rec."FA Disposal Nos")
                {
                    ToolTip = 'Specifies the value of the FA Disposal Nos field';
                    ApplicationArea = All;
                }
                field("Bank Reconciliation Nos"; Rec."Bank Reconciliation Nos")
                {
                    ApplicationArea = All;
                }
                field("EFT File Gen Nos"; Rec."EFT File Gen Nos")
                {
                    ToolTip = 'Specifies the value of the EFT File Gen Nos field.';
                    ApplicationArea = All;
                }
                field("Bill Number Nos"; Rec."Bill Number Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill Number Nos field.';
                }
                field("Travel Request Nos"; Rec."Travel Request Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Travel Request Nos field.';
                }
                field("Welfare Nos"; Rec."Welfare Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Welfare Nos field.';
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serial No field.';
                }
                field("EFT Serial No"; Rec."EFT Serial No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT Serial No field.';
                }
            }
            group(Accounts)
            {
                Caption = 'Accounts';

                field("Approtionment Account"; Rec."Approtionment Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approtionment Account field';
                }
                field("Apportion Template"; Rec."Apportion Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Apportion Template field';
                }
                field("Apportion Batch"; Rec."Apportion Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Apportion Batch field';
                }
                field("EFT Payee Reference Nos"; Rec."EFT Payee Reference Nos")
                {
                    ApplicationArea = All;
                }
            }
            group("Communication")
            {
                field("Finance Email"; Rec."Finance Email")
                {
                    ApplicationArea = All;
                }
            }
            group(Receipt)
            {
                Caption = 'Receipt';

                field("Customer Email subject"; Rec."Customer Email subject")
                {
                    ApplicationArea = All;
                }
                field("Customer Email Body"; Rec."Customer Email Body")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Vendor Email Subject"; Rec."Vendor Email Subject")
                {
                    ApplicationArea = All;
                }
                field("Vendor Email Body"; Rec."Vendor Email Body")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}

page 51266 "Finance Management Cues"
{
    Caption = 'Finance Management Cues';
    PageType = CardPart;
    SourceTable = "Finance Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Receivables")
            {
                field(Customers; Rec.Customers)
                {
                    ApplicationArea = All;
                }
                field("Sales Invoices"; Rec."Sales Invoices")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Invoice List";
                }
                field("Posted Sales Invoices"; Rec."Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Posted Sales Invoices";
                }
            }
            cuegroup(Payables)
            {
                field(Vendors; Rec.Vendors)
                {
                    ApplicationArea = All;
                }
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                }
                field("Purchase Invoices"; Rec."Purchase Invoices")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Invoices";
                }
                field("Posted Purchase Invoices"; Rec."Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Posted Purchase Invoices";
                }
            }
            cuegroup("Fixed Assets")
            {
                field("Fixed Assets List"; Rec."Fixed Assets")
                {
                    ApplicationArea = All;
                }
            }
            cuegroup(InventoryList)
            {
                Caption = 'Inventory';

                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Cash Management")
            {
                field("Bank Accounts"; Rec."Bank Accounts")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Balances"; Rec."Bank Account Balances")
                {
                }
            }
            cuegroup(Payments)
            {
                field(Receipts; Rec.Receipts)
                {
                    ApplicationArea = All;
                    DrillDownPageId = Receipts;
                }
                field("Posted Receipts"; Rec."Posted Receipts")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Posted Receipts";
                }
                field("Payment Voucher"; Rec."Payment Voucher")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Payment Vouchers";
                }
                field("Pending Payment Vouchers"; Rec."Pending Payment Vouchers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Payment Vouchers";
                }
                field("Posted Payment Voucher"; Rec."Posted Payment Voucher")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Approved Payment Vouchers1";
                }
                field("Petty cash"; Rec."Petty cash")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Petty Cash List";
                }
                field("Pending Petty Cash"; Rec."Pending Petty Cash")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Petty Cash List";
                }
                field("Posted petty cash"; Rec."Posted petty cash")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Posted Petty cash";
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Approval Request Entries";
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID Filter", UserId);
        if not Rec.Get('') then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

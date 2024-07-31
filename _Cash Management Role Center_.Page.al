page 50223 "Cash Management Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part("General Management Cues"; "General Management Cues2")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Approval Cues"; "Approval Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(sections)
        {
            group(Setups)
            {
                action(CashSetup)
                {
                    Caption = 'Cash Management Setup';
                    Image = Setup;
                    RunObject = page "Cash Management Setups";
                }
                action("Imprest Types")
                {
                    RunObject = page "Imprest Types";
                }
                action("Payment Types")
                {
                    Caption = 'Payments & Petty Cash Types';
                    RunObject = page "Payment Types";
                }
                action("Receipt Types")
                {
                    RunObject = page "Receipt Types";
                }
                action("Advance Types")
                {
                    RunObject = page "Advance Types";
                }
                action("Claim Types")
                {
                    RunObject = page "Claim Types";
                }
                action("Expense Codes")
                {
                    RunObject = page "Expense Codes";
                }
                action("Destination Codes")
                {
                    RunObject = page "Destination Code";
                }
                action("User Posting Template")
                {
                    RunObject = page "User Posting Template";
                }
                action("Banker Cheque Register")
                {
                    RunObject = page "Banks Cheque Register";
                }
                action("Cash Office User Template")
                {
                    RunObject = page "Cash Office User Template";
                }
            }
            group("Self Service")
            {
                action("Imprests ")
                {
                    RunObject = Page Imprests;
                }
                action("Imprest Surrenders ")
                {
                    RunObject = Page "Imprest Surrenders";
                }
                action("Staff Claim List ")
                {
                    RunObject = Page "Staff Claim List";
                }
                action("Purchase Request List ")
                {
                    RunObject = Page "Purchase Request List";
                }
                action("Store Request List ")
                {
                    RunObject = Page "Store Request List";
                }
                // action("Leave Applications List")
                // {
                //     RunObject = Page "Leave Application List";
                // }
                action("Transport Request")
                {
                    RunObject = Page "Trip Listing";
                }
                action("Training Requests List ")
                {
                    RunObject = Page "Training Request List";
                }
                action("Budget Approval List")
                {
                    RunObject = Page "Budget Approval List";
                }
            }
            group(Lists)
            {
                action("Bank Accounts")
                {
                    RunObject = Page "Bank Account List";
                }
                action("Payment Reconciliation Journals")
                {
                    RunObject = Page "Pmt. Reconciliation Journals";
                }
                action("Bank Acc. Reconciliation List")
                {
                    RunObject = Page "Bank Acc. Reconciliation List";
                }
                action("Posted Payment Reconciliations")
                {
                    RunObject = Page "Posted Payment Reconciliations";
                }
            }
            group(Archive)
            {
                action("Bank Account Ledger Entries")
                {
                    RunObject = Page "Bank Account Ledger Entries";
                }
                action("Check Ledger Entries")
                {
                    RunObject = Page "Check Ledger Entries";
                }
            }
            group("Inter Bank Transfers")
            {
                action("InterBank Transfer List")
                {
                    RunObject = Page "InterBank Transfer List";
                }
                action("Approved InterBank Transfer")
                {
                    RunObject = Page "Approved InterBank Transfer";
                }
            }
            group("Inter Bank Transfers Archive")
            {
                action("Posted InterBank Transfers")
                {
                    RunObject = Page "Posted InterBank Transfer";
                }
            }
            group("Finance Transaction List")
            {
                group("Open Documents")
                {
                    action("Request for Payment Form")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Payment Form Requests";
                        RunPageLink = Status = filter(Open);
                        Visible = false;
                    }
                    action("Payment Voucher")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Payment Vouchers";
                    }
                    action(Receipts)
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page Receipts;
                    }
                    action("Petty Cash List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Petty Cash List";
                    }
                    action("Petty Cash Surrender")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Petty Cash Surrenders";
                    }
                    action("Staff Claim")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Staff Claim List";
                    }
                    action("Interbank Transfers")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "InterBank Transfer List";
                    }
                    action("Mpesa Entries")
                    {
                        RunObject = page "Mpesa Entries";
                    }
                    action("Bank Entries")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Coop Bank Entries";
                    }
                    action("Open Imprests")
                    {
                        Caption = 'Imprest';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Imprests-General";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Open Imprest Surrenders")
                    {
                        Caption = 'Imprest Surrenders';
                        ApplicationArea = Basic, suite;
                        RunObject = page "Imprest Surrenders-General";
                        RunPageLink = Status = filter(Open);
                    }
                }
                group("Documents Pending Approval")
                {
                    action("Pending Payment Vouchers")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Pending Payment Vouchers1";
                    }
                    action("Pending Imprests")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Pending Imprests";
                    }
                    action("Pending Imprest Surrenders")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Pending Imprest Surrenders";
                    }
                    action("Pending Staff Claim")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Pending Staff Claim List";
                    }
                    action("Pending Petty Cash")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Pending Petty Cash List";
                    }
                    action("Pending Petty Cash Surrenders ")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Pending Petty Cash Surrenders";
                    }
                    action("Pending InterBank Transfers")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Pending InterBank Transfer";
                    }
                }
                group("Document Approved List")
                {
                    action("Approved Payment Vouchers")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Approved Payment Vouchers1";
                    }
                    action("Request for Payment Form sent to finance")
                    {
                        ApplicationArea = basic, suite;
                        Visible = false;
                        RunObject = page "Payment Form Requests";
                        RunPageLink = Status = filter(Released), "PV Created" = const(false);
                    }
                    action("Approved Petty Cash List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Approved Petty Cash";
                    }
                    action("Approved Petty Cash Surrender")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Approved Petty Cash Surrenders";
                    }
                    action("Budget Approved List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Budget Approved List";
                    }
                    action("Approved Imprests ")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Approved Imprests";
                    }
                    action("Approved Imprest Surrenders ")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Approved Imprest Surrenders";
                    }
                    action("Approved Staff Claim ")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Staff Claim List-General";
                    }
                    action("Purchase Request Approved ")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Purchase Request Approved";
                    }
                    action("Imprest Deductions ")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Imprest Deduction";
                    }
                    action("Approved InterBank Transfers")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Approved InterBank Transfer";
                    }
                }
                group("Posted Document List")
                {
                    action("Posted PVs")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Posted Payment Vouchers1";
                    }
                    action("Archived Payment Request Forms")
                    {
                        ApplicationArea = basic, suite;
                        Visible = false;
                        RunObject = page "Payment Form Requests";
                        RunPageLink = Status = filter(Released), "PV Created" = const(true);
                    }
                    action("Posted Receipts")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Posted Receipts";
                    }
                    action("Posted Petty Cash")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Posted Petty cash";
                    }
                    action("Posted Petty Cash Surrenders")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = Page "Posted Petty Cash Surrenders";
                    }
                    action("Posted Credit Memos1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Credit Memos';
                        RunObject = page "Posted Purchase Credit Memos";
                    }
                    action("Posted Purchase Invoices12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Invoices';
                        RunObject = page "Posted Purchase Invoices";
                    }
                    action("Posted Purchase Receipts")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Posted Purchase Receipts';
                        RunObject = page "Posted Purchase Receipts";
                    }
                    action("Posted Return Shipments")
                    {
                        ApplicationArea = PurchReturnOrder;
                        Caption = 'Posted Purchase Return Shipments';
                        RunObject = page "Posted Return Shipments";
                    }
                    action("Posted Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Invoices';
                        RunObject = page "Posted Sales Invoices";
                    }
                    action("Posted Sales Shipments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Shipments';
                        RunObject = page "Posted Sales Shipments";
                    }
                    action("Posted Credit Memos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Credit Memos';
                        RunObject = page "Posted Sales Credit Memos";
                    }
                    action("Posted Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'Posted Return Receipts';
                        RunObject = page "Posted Return Receipts";
                    }
                    action("Posted Imprest Surrenders")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Posted Imprest Surrenders";
                    }
                    action("Posted Imprests")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Posted Imprests";
                    }
                    action("Posted Staff Claims")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Posted Staff Claim";
                    }
                    action("Posted interbank transfers2")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Posted InterBank Transfer";
                    }
                }
                group("Bank Payments")
                {
                    action("Bank Payment List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "Bank Payment List";
                    }
                }
            }
        }
        area(reporting)
        {
        }
    }
}

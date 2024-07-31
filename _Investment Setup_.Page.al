page 50743 "Investment Setup"
{
    SourceTable = "Investment Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Money Market Nos"; Rec."Money Market Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Bond Nos"; Rec."Bond Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Property Nos"; Rec."Property Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Equity Nos"; Rec."Equity Nos")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Mortgages/Loans"; Rec."Mortgages/Loans")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Fund"; Rec."Fund/Pool Nos")
                {
                    Caption = 'Funds';
                    ApplicationArea = Basic, suite;
                }
                field("Unit Trust Nos"; Rec."Unit Trust Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Unit Trust Member Nos"; Rec."Unit Trust Member Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Forex Exchaage"; Rec."Forex Exchange Nos")
                {
                    ApplicationArea = Basic, suite;
                    Caption = 'Forex Exchange';
                }
                field("Broker Nos"; Rec."Broker Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Year Days"; Rec."Year Days")
                {
                    ApplicationArea = Basic, suite;
                }
                field("6months Days"; Rec."6months Days")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Warning Period"; Rec."Warning Period")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Market Mortgage Interest Rate"; Rec."Market Mortgage Interest Rate")
                {
                    ApplicationArea = Basic, suite;
                    Caption = 'Market Mortgage Interest Rate %';
                    Editable = false;
                    Visible = false;
                }
                field("Government Mortgage Rate"; Rec."Government Mortgage Rate")
                {
                    ApplicationArea = Basic, suite;
                    Caption = 'Government Mortgage Rate %';
                    Editable = false;
                    Visible = false;
                }
                field("Calendar Days"; Rec."Calendar Days")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Withholding Tax Percentage"; Rec."Withholding Tax Percentage")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Management Fee Receivables AC"; Rec."Management Fee Receivables AC")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Management Fee Income AC"; Rec."Management Fee Income AC")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Witholding Tax%-Fixed Deposits"; Rec."Witholding Tax%-Fixed Deposits")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Other Commission Percentage"; Rec."Other Commission Percentage")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Receipt Nos"; Rec."Receipt Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Requisition No.s"; Rec."Requisition No.s")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Posted Receipts No"; Rec."Posted Receipts No")
                {
                    ApplicationArea = Basic, suite;
                }
                field("PV Nos"; Rec."PV Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Institutions No."; Rec."Institutions No.")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Registrer Nos."; Rec."Registrer Nos.")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Disposal Nos"; Rec."Disposal Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Dividend Nos"; Rec."Dividend Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Expected Interest No"; Rec."Expected Interest No")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Portfolio Trans Nos."; Rec."Portfolio Trans Nos.")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Property Lease Nos"; Rec."Property Lease Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Lease Nos"; Rec."Lease Nos")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Equity Action Nos."; Rec."Equity Action Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Rights Declaration Nos."; Rec."Rights Declaration Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Sale Rights Order Nos."; Rec."Sale Rights Order Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Sale Rights Nos."; Rec."Sale Rights Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Purchase Rights Order Nos."; Rec."Purchase Rights Order Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Purchase Rights Nos."; Rec."Purchase Rights Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Execise Rights Nos."; Rec."Execise Rights Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Right Refund Nos."; Rec."Right Refund Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Billing Nos."; Rec."Billing Nos.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Maintainace No."; Rec."Maintainace No.")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Room Booking"; Rec."Room Booking")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Complains No."; Rec."Complains No.")
                {
                    Visible = false;
                    ApplicationArea = Basic, suite;
                }
                field("Fund Req Nos."; Rec."Fund Req Nos.")
                {
                    ApplicationArea = all;
                }
                field("Bid App Nos."; Rec."Bid App Nos.")
                {
                }
            }
            group(Journals)
            {
                Caption = 'Journals';

                field("General Journal"; Rec."General Journal")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Batch Name"; Rec."Batch Name")
                {
                    ApplicationArea = Basic, suite;
                }
            }
            group(Periods)
            {
                Caption = 'Periods';

                field("Equity Settlement Period"; Rec."Equity Settlement Period")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Money Market Settlement Period"; Rec."Money Market Settlement Period")
                {
                    ApplicationArea = Basic, suite;
                    Visible = false;
                }
                field("Bond Settlement Period"; Rec."Bond Settlement Period")
                {
                    ApplicationArea = Basic, suite;
                }
            }
            group(Folder)
            {
                field("Investment Folder"; Rec."Investment Folder")
                {
                    ApplicationArea = Basic, suite;
                }
                field(Director; Rec.Director)
                {
                    ApplicationArea = Basic, suite;
                }
                field("Current Company"; Rec."Current Company")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Post to Inter Company"; Rec."Post to Inter Company")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Report Ref No."; Rec."Report Ref No.")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Finance Email"; Rec."Finance Email")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Investment Email"; Rec."Investment Email")
                {
                    ApplicationArea = Basic, suite;
                }
                field("Send to External"; Rec."Send to External")
                {
                    ApplicationArea = Basic, suite;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}

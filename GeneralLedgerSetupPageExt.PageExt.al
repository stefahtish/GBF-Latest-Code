pageextension 50106 GeneralLedgerSetupPageExt extends "General Ledger Setup"
{
    layout
    {
        addafter(Application)
        {
            group(Budgeting)
            {
                field("Current Budget"; Rec."Current Budget")
                {
                    ApplicationArea = All;
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = All;
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = All;
                }
                field("Use Dimensions For Budget"; Rec."Use Dimensions For Budget")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

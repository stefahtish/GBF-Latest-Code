pageextension 50112 GeneralJournalPageExt extends "General Journal"
{
    layout
    {
        addafter("Amount (LCY)")
        {
            field("ReasonCode"; Rec."Reason Code")
            {
                Caption = 'General Expense Code';
                ApplicationArea = All;
            }
        }
        modify("Reason Code")
        {
            Caption = 'General Expense Code';
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }

        modify("External Document No.")
        {
            Visible = true;
        }
        modify(Applied)
        {
            Visible = true;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = true;
        }
        modify("Applies-to ID")
        {
            Visible = true;
        }
        addafter(Description)
        {
            // field("General Expense Code"; "General Expense Code")
            // {
            // }
        }
        addlast(Control1)
        {
            // field("Investment Code"; "Investment Code")
            // {
            // }
            // field("Investment Transcation Type"; "Investment Transcation Type")
            // {
            // }
            // field("Asset Type"; "Asset Type")
            // {
            // }
        }
    }
}

pageextension 50155 GLAccountListExt extends "G/L Account List"
{
    layout
    {
        addlast(Control1)
        {
            field("Account Subcategory Descript."; Rec."Account Subcategory Descript.")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}

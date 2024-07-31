pageextension 50150 "GLBudgetNames TableExt" extends "G/L Budget Names"
{
    layout
    {
        addafter(Blocked)
        {
            field("Current Year"; Rec."Current Year")
            {
                ApplicationArea = All;
            }
        }
    }
}

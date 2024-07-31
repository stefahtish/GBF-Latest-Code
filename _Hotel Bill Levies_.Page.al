page 50668 "Hotel Bill Levies"
{
    PageType = List;
    SourceTable = "Bill Levies";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill Code"; Rec."Bill Code")
                {
                }
                field("Levy Code"; Rec."Levy Code")
                {
                }
                field("Levy Description"; Rec."Levy Description")
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
                field("Percentage Amount"; Rec."Percentage Amount")
                {
                }
            }
        }
    }
    actions
    {
    }
}

page 50499 "Bank Branches"
{
    PageType = List;
    SourceTable = "Bank Branches";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Branch Code"; Rec."Branch Code")
                {
                }
                field("Branch Name"; Rec."Branch Name")
                {
                }
            }
        }
    }
    actions
    {
    }
}

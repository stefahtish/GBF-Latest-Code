page 50492 "Houses List"
{
    PageType = ListPart;
    SourceTable = "House Units";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("House No"; Rec."House No")
                {
                }
                field("Allocated Employee"; Rec."Allocated Employee")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Occupation Date"; Rec."Occupation Date")
                {
                }
                field("Vacation Date"; Rec."Vacation Date")
                {
                }
                field("Quaters Code"; Rec."Quaters Code")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}

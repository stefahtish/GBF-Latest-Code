page 51456 "External Committee"
{
    PageType = ListPart;
    SourceTable = "External Committee";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

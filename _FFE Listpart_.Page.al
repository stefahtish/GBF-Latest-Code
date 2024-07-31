page 51246 "FFE Listpart"
{
    PageType = ListPart;
    SourceTable = "Fixed Asset";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Bookable; Rec.Bookable)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}

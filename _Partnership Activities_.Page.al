page 51054 "Partnership Activities"
{
    PageType = ListPart;
    SourceTable = "Partnerships Activity Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Patnership line type"; Rec."Patnership line type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Activity';
                    ApplicationArea = Basic, Suite;
                }
                field("Date Held"; Rec."Date Held")
                {
                }
                field(County; Rec.County)
                {
                }
                field("County Name"; Rec."County Name")
                {
                    Editable = false;
                }
                field(Venue; Rec.Venue)
                {
                }
                field(Outcome; Rec.Outcome)
                {
                }
            }
        }
    }
    actions
    {
    }
}

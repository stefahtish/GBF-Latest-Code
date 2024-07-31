page 51404 "Accomplishments"
{
    PageType = ListPart;
    Caption = 'Accomplishments Since Last Report';
    SourceTable = "Accomplishments";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Accomplishments; Rec.Accomplishments)
                {
                    ToolTip = 'Specifies the value of the Accomplishments field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

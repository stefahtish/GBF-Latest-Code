page 51403 "Upcoming NextStep"
{
    PageType = ListPart;
    Caption = 'Upcoming Next/Steps';
    SourceTable = NextSteps;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Next steps"; Rec."Next steps")
                {
                    ToolTip = 'Specifies the value of the Next steps field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

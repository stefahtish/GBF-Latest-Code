page 51399 "Schedule"
{
    PageType = ListPart;
    Caption = 'Project Schedule';
    SourceTable = ProjSchedule;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Current Status (%)"; Rec."Current Status")
                {
                    ToolTip = 'Specifies the value of the Current Status field.';
                    ApplicationArea = All;
                }
                field("Previous Status (%)"; Rec."Previous Status")
                {
                    ToolTip = 'Specifies the value of the Previous Status field.';
                    ApplicationArea = All;
                }
                field("Schedule Perfomance (%)"; Rec."Schedule Perfomance")
                {
                    ToolTip = 'Specifies the value of the Schedule Perfomance field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

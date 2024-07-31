page 50475 "Interview Panel Members"
{
    PageType = List;
    SourceTable = "Interview Panel Members";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Panel Member Code"; Rec."Panel Member Code")
                {
                    ToolTip = 'Specifies the value of the Panel Member Code field';
                    ApplicationArea = All;
                }
                field("Panel Member Name"; Rec."Panel Member Name")
                {
                    ToolTip = 'Specifies the value of the Panel Member Name field';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

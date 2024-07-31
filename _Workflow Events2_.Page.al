page 51148 "Workflow Events2"
{
    ApplicationArea = All;
    Caption = 'Workflow Events';
    PageType = List;
    SourceTable = "Workflow Event";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field';
                    ApplicationArea = All;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ToolTip = 'Specifies the value of the Function Name field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the When field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

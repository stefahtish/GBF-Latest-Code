page 51328 "ICT Workplan List"
{
    Caption = 'ICT Workplan List';
    PageType = List;
    SourceTable = "ICT Workplan";
    CardPageId = "ICT Workplan Header";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                // field("Activity Code"; Rec."Activity Code")
                // {
                //     ToolTip = 'Specifies the value of the Activity Code field';
                //     ApplicationArea = All;
                // }
                // field("Activity Description"; Rec."Activity Description")
                // {
                //     ToolTip = 'Specifies the value of the Activity Description field';
                //     ApplicationArea = All;
                // }
            }
        }
    }
}

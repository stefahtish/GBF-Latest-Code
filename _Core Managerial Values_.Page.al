page 51430 "Core Managerial Values"
{
    Caption = 'Core Managerial Values';
    PageType = List;
    SourceTable = "Managerial Values";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Core Managerial Values"; Rec."Core Managerial Values")
                {
                    ToolTip = 'Specifies the value of the Core Managerial Values field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

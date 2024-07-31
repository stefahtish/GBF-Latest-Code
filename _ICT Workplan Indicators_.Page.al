page 51334 "ICT Workplan Indicators"
{
    CardPageId = "Workplan indicator card";
    Caption = 'Workplan Indicators';
    PageType = ListPart;
    SourceTable = "ICT Workplan Indicators2";
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
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Perfomance Indicator Code"; Rec."Perfomance Indicator Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

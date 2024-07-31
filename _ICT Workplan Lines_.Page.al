page 51327 "ICT Workplan Lines"
{
    Caption = 'ICT Workplan Lines';
    PageType = ListPart;
    SourceTable = "ICT WorkPlan Lines2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reporting Indicator"; Rec."Reporting Indicator")
                {
                    ToolTip = 'Specifies the value of the Reporting Indicator field';
                    ApplicationArea = All;
                }
                field("Means of Verification"; Rec."Means of Verification")
                {
                    ToolTip = 'Specifies the value of the Means of Verification field';
                    ApplicationArea = All;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = All;
                }
                field("Sub Activity"; Rec."Sub Activity")
                {
                    ToolTip = 'Specifies the value of the Sub Activity field';
                    ApplicationArea = All;
                }
                field("Time Plan"; Rec."Time Plan")
                {
                    ToolTip = 'Specifies the value of the Time Plan field';
                    ApplicationArea = All;
                }
                field("Estimated Budget"; Rec."Estimated Budget")
                {
                    ToolTip = 'Specifies the value of the Estimated Budget field';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Perfomance Indicator Code"; Rec."Perfomance Indicator Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Time Frame"; Rec."Time Frame")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}

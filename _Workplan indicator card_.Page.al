page 51335 "Workplan indicator card"
{
    Caption = 'Workplan indicator card';
    PageType = Card;
    SourceTable = "ICT Workplan Indicators2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                    visible = false;
                }
                field("Perfomance Indicator Code"; Rec."Perfomance Indicator Code")
                {
                    ToolTip = 'Specifies the value of the Pefomance Indicator Code field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
            }
            part("ICT Workplan Lines"; "ICT Workplan Lines")
            {
                SubPageLink = "No." = field("No."), "Perfomance Indicator Code" = field("Perfomance Indicator Code");
                ApplicationArea = All;
            }
        }
    }
}

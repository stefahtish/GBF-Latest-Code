page 50727 "Board Committee Card"
{
    Caption = 'Board Committee Card';
    PageType = List;
    SourceTable = "Board Committees";
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
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                    ApplicationArea = All;
                }
                field("End date"; Rec."End date")
                {
                    ToolTip = 'Specifies the value of the End date field';
                    ApplicationArea = All;
                }
            }
            part("BOD Committee Members"; "BOD Committee Members")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }
}

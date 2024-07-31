page 50987 "Sample Disposal Lines"
{
    AutoSplitKey = true;
    Caption = 'Sample Disposal Lines';
    PageType = ListPart;
    SourceTable = "Sample Disposal Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("No."; Rec."No.")
                {
                    visible = false;
                    ApplicationArea = All;
                }
                field("Sample Name"; Rec."Sample Name")
                {
                    ApplicationArea = All;
                }
                field("Sample Code"; Rec."Sample Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

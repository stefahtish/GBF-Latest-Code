page 50986 "Sample Disposal List"
{
    Caption = 'Sample Disposal List';
    PageType = List;
    CardPageId = "Sample Disposal Card";
    SourceTable = "Sample Disposal";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sample Reception No."; Rec."Sample Reception No.")
                {
                    ApplicationArea = All;
                }
                field("Disposal Date"; Rec."Disposal Date")
                {
                    ApplicationArea = All;
                }
                field("Disposal Time"; Rec."Disposal Time")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

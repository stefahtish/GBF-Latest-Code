page 51329 "Activity Workplan List"
{
    Caption = 'Activity Workplan List';
    PageType = List;
    CardPageId = "Activity Work Program";
    SourceTable = "Activity Work Programme";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Workplan No."; Rec."Workplan No.")
                {
                }
                field("Activity Start Date"; Rec."Activity Start Date")
                {
                }
                field("Activity End Date"; Rec."Activity End Date")
                {
                }
            }
        }
    }
}

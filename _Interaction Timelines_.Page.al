page 50725 "Interaction Timelines"
{
    Caption = 'Interaction Timelines';
    PageType = List;
    SourceTable = "Interaction Timelines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Interaction Type"; Rec."Interaction Type")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Timeline; Rec.Timeline)
                {
                }
                field("First Notification"; Rec."First Notification")
                {
                }
                field("Subsequent Notifications"; Rec."Subsequent Notifications")
                {
                }
            }
        }
    }
}

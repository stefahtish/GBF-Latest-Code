page 51120 TimeFrames
{
    Caption = 'TimeFrames';
    PageType = List;
    SourceTable = "Time Frames";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Time Frame"; Rec."Time Frame")
                {
                    ApplicationArea = All;
                }
                field("Plan Name"; Rec."Plan Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

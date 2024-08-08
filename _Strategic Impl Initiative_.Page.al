page 50614 "Strategic Impl Initiative"
{
    Caption = 'Performance Indicators';
    PageType = List;
    SourceTable = "Strategic Imp Initiatives";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("SNo."; Rec."SNo.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Objective"; Rec.Initiatives)
                {
                    ApplicationArea = All;
                }
                field("Mark Out of Score"; Rec."Mark Out of Score")
                {
                    ToolTip = 'Specifies the value of the Mark Out of Score field.';
                    ApplicationArea = All;
                }
                field(Timelines; Rec.Timelines)
                {
                    ToolTip = 'Specifies the value of the Timelines field.';
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

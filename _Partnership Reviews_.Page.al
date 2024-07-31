page 51098 "Partnership Reviews"
{
    Caption = 'Partnership Reviews';
    PageType = List;
    SourceTable = "Partnership Reviews";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field';
                    ApplicationArea = All;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ToolTip = 'Specifies the value of the Recommendation field';
                    ApplicationArea = All;
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    ToolTip = 'Specifies the value of the Reviewed By field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

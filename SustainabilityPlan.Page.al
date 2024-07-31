page 51377 SustainabilityPlan
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SustainabilityPlan;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(SustainabiliyCode; Rec.SustainabiliyCode)
                {
                    ToolTip = 'Specifies the value of the SustainabiliyCode field.';
                    ApplicationArea = All;
                }
                field(BContent; Rec.Content)
                {
                    ToolTip = 'Specifies the value of the Content field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                //ApplicationArea = All;
                trigger OnAction()
                begin
                end;
            }
        }
    }
    var myInt: Integer;
}

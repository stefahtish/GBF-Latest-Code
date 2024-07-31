page 51375 "Evaluation Plan"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ProjectEvaluationPlan;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(EvaluationCode; Rec.EvaluationCode)
                {
                    ToolTip = 'Specifies the value of the EvaluationCode field.';
                    ApplicationArea = All;
                }
                field(SContent; Rec.Content)
                {
                    ToolTip = 'Specifies the value of the Content field.';
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
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
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }
    var myInt: Integer;
}

page 51372 "Statement of Purpose"
{
    PageType = listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Statement Of Purpose";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(PurposeCode; Rec.PurposeCode)
                {
                    ToolTip = 'Specifies the value of the PurposeCode field.';
                    ApplicationArea = All;
                }
                field(PContent; Rec.Content)
                {
                    ToolTip = 'Specifies the value of the Content field.';
                    ApplicationArea = All;
                }
                field(Goal; Rec.Goal)
                {
                    ToolTip = 'Specifies the value of the Goal field.';
                    ApplicationArea = All;
                }
                field(Outcome; Rec.Outcome)
                {
                    ToolTip = 'Specifies the value of the Outcome field.';
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

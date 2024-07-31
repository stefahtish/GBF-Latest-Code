page 51373 "Product Design"
{
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Projet Design";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(DesignCode; Rec.DesignCode)
                {
                    ToolTip = 'Specifies the value of the DesignCode field.';
                    ApplicationArea = All;
                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Activity field.';
                    ApplicationArea = All;
                }
                field(Goal; Rec.Goal)
                {
                    ToolTip = 'Specifies the value of the Goal field.';
                    ApplicationArea = All;
                }
                field(SContent; Rec.Content)
                {
                    ToolTip = 'Specifies the value of the Content field.';
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

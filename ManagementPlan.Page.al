page 51374 ManagementPlan
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ProjectManagementPlan;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Abstractcode; Rec.Abstractcode)
                {
                    ToolTip = 'Specifies the value of the Abstractcode field.';
                    ApplicationArea = All;
                }
                field(SContent; Rec.Content)
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
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }
    var myInt: Integer;
}

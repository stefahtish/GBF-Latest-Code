page 51370 AbstractListPart
{
    PageType = listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ProjectAbstract;

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
                field(sContent; Rec.Content)
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
                visible = false;

                trigger OnAction()
                begin
                end;
            }
        }
    }
    var myInt: Integer;
}

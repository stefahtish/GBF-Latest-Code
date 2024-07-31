page 51378 Dissemination
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ProjectDisseminationPlan;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(DisseminationCode; Rec.DisseminationCode)
                {
                    ToolTip = 'Specifies the value of the DisseminationCode field.';
                    ApplicationArea = All;
                }
                field("Mode of Dissemination"; Rec."Mode of Dissemination")
                {
                    ToolTip = 'Specifies the value of the Mode of Dissemination field.';
                    ApplicationArea = All;
                }
                field(SContent; Rec.Content)
                {
                    ToolTip = 'Specifies the value of the Content field.';
                    ApplicationArea = All;
                }
                field("Mode of Marketing"; Rec."Mode of Marketing")
                {
                    ToolTip = 'Specifies the value of the Mode of Marketing field.';
                    ApplicationArea = All;
                }
                field("Target Group"; Rec."Target Group")
                {
                    ToolTip = 'Specifies the value of the Target Group field.';
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

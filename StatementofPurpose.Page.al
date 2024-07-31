page 51371 StatementofPurpose
{
    PageType = Listpart;
    Caption = 'Statement of Purpose';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ProjetStatement of Need";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(NeedCode; Rec.NeedCode)
                {
                    ToolTip = 'Specifies the value of the NeedCode field.';
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

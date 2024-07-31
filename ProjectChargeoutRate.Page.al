page 51381 ProjectChargeoutRate
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Project Charge-Out Rate";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Charge Code"; Rec."Charge Code")
                {
                    ToolTip = 'Specifies the value of the Charge Code field.';
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                    ApplicationArea = All;
                }
                field(Cadre; Rec.Cadre)
                {
                    ToolTip = 'Specifies the value of the Cadre field.';
                    ApplicationArea = All;
                }
                field("Low Rate"; Rec."Low Rate")
                {
                    ToolTip = 'Specifies the value of the Low Rate field.';
                    ApplicationArea = All;
                }
                field("High Rate"; Rec."High Rate")
                {
                    ToolTip = 'Specifies the value of the High Rate field.';
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

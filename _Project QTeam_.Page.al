page 51376 "Project QTeam"
{
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ProjectTeamQualification;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Team Member Name"; Rec."Team Member Name")
                {
                    ToolTip = 'Specifies the value of the Team Member Name field.';
                    ApplicationArea = All;
                }
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field.';
                    ApplicationArea = All;
                }
                field(Experience; Rec.Experience)
                {
                    ToolTip = 'Specifies the value of the Experience field.';
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

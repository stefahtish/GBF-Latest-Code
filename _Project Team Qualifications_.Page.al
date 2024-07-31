page 51392 "Project Team Qualifications"
{
    PageType = ListPart;
    Caption = 'Project Team Qualifications';
    SourceTable = ProjectTeamQualification;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Emp No."; Rec."Emp No.")
                {
                    ToolTip = 'Specifies the value of the Team Member No. field.';
                    ApplicationArea = All;
                }
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
}

page 51397 "Upcoming Milestones"
{
    PageType = ListPart;
    Caption = 'Key Upcoming Milestones';
    SourceTable = "Project Tasks Mgmt";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Deliverable Number"; Rec."Deliverable Number")
                {
                    ToolTip = 'Specifies the value of the Deliverable Number field.';
                    ApplicationArea = All;
                }
                field(ProjectDeliverable; Rec.ProjectDeliverable)
                {
                    ToolTip = 'Specifies the value of the Deliverable field.';
                    ApplicationArea = All;
                    Caption = 'Upcoming Milestone';
                }
                field(ProjectTaskStartDate; Rec.ProjectTaskStartDate)
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(ProjectTaskDuration; Rec.ProjectTaskDuration)
                {
                    ToolTip = 'Specifies the value of the Task Duration field.';
                    ApplicationArea = All;
                    caption = 'Duration';
                }
                field(ProjectTaskEndDate; Rec.ProjectTaskEndDate)
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field("MileStone Actual Cost"; Rec."MileStone Actual Cost")
                {
                    Enabled = Rec."Milestone Closed";
                    ToolTip = 'Specifies the value of the MileStone Actual Cost field.';
                    ApplicationArea = All;
                    Editable = not Rec."Sales Invoice Generated";
                }
                field("Milestone Closed"; Rec."Milestone Closed")
                {
                    caption = 'Close Milestone';
                    ToolTip = 'Specifies the value of the Milestone Closed field.';
                    ApplicationArea = All;
                }
                field("Sales Invoice Generated"; Rec."Sales Invoice Generated")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Sales Invoice Generated field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

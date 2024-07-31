page 51345 "Project Deliverable"
{
    PageType = ListPart;
    Caption = 'Project Task Management';
    SourceTable = "Project Tasks Mgmt";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ProjectDeliverable; Rec.ProjectDeliverable)
                {
                    ToolTip = 'Specifies the value of the ProjectDeliverable field.';
                    ApplicationArea = All;
                    Caption = 'Project Deliverable';
                }
                field(projectTask; Rec.projectTask)
                {
                    ToolTip = 'Specifies the value of the projectTask field.';
                    ApplicationArea = All;
                    Caption = 'Task';
                }
                field(ProjectStepNumber; Rec.ProjectStepNumber)
                {
                    ToolTip = 'Specifies the value of the ProjectStepNumber field.';
                    ApplicationArea = All;
                    Caption = 'Project Step Number';
                }
                field(ProjectTaskStartDate; Rec.ProjectTaskStartDate)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskStartDate field.';
                    ApplicationArea = All;
                    Caption = 'Task Start Date';
                }
                field(ProjectTaskDuration; Rec.ProjectTaskDuration)
                {
                    ToolTip = 'Specifies the value of the Task Duration field.';
                    ApplicationArea = All;
                    Caption = 'Task Duration';
                }
                field(ProjectTaskEndDate; Rec.ProjectTaskEndDate)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskEndDate field.';
                    ApplicationArea = All;
                    Caption = 'Task End Date';
                }
                field(ProjectTaskAssignedUserID; Rec.ProjectTaskAssignedUserID)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskAssignedUserID field.';
                    ApplicationArea = All;
                }
                field(ProjectTaskAssignedUser; Rec.ProjectTaskAssignedUser)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskAssignedUser field.';
                    ApplicationArea = All;
                }
                field(ProjectTaskStatus; Rec.ProjectTaskStatus)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskStatus field.';
                    ApplicationArea = All;
                    style = favorable;
                }
                field(ProjectTaskReassignement; Rec.ProjectTaskReassignement)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskReassignement field.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        If Rec.projectTaskReassignement = Rec.projectTaskReassignement::YES then begin
                            TaskReassignments := True;
                        end
                        else begin
                            TaskReassignments := False;
                        end;
                        // currpage.Update();
                    end;
                }
                field(ProjectTaskReassignedUSERID; Rec.ProjectTaskReassignedUSERID)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskReassignedUSERID field.';
                    ApplicationArea = All;
                }
                field(ProjectTaskReassignedTo; Rec.ProjectTaskReassignedTo)
                {
                    ToolTip = 'Specifies the value of the ProjectTaskReassignedTo field.';
                    ApplicationArea = All;
                    Visible = TaskReassignments;
                }
                field(ProjectEstimatedCostPerTask; Rec.ProjectEstimatedCostPerTask)
                {
                    ToolTip = 'Specifies the value of the ProjectEstimatedCostPerTask field.';
                    ApplicationArea = All;
                }
                field(ProjectActualCostPerTask; Rec.ProjectActualCostPerTask)
                {
                    ToolTip = 'Specifies the value of the ProjectActualCostPerTask field.';
                    ApplicationArea = All;
                    // trigger onvalidate()
                    // begin
                    //     //currpage.Update();
                    // end;
                }
            }
        }
    }
    var
        TaskReassignments: boolean;
}

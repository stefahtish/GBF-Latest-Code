table 50667 "Project Tasks Mgmt"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Deliverable Number"; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; ProjectDeliverable; Text[100])
        {
            DataClassification = ToBeClassified;
            caption = 'Deliverable';
        }
        field(3; projectTask; Text[100])
        {
            DataClassification = ToBeClassified;
            caption = 'Task';
        }
        field(4; ProjectStepNumber; Integer)
        {
            DataClassification = ToBeClassified;
            caption = 'Step Number';
        }
        field(5; ProjectTaskStartDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                // if "Project Start Date" < Today then
                //     Error('You cannot enter a date Later than today');
                "ProjectTaskEndDate":=CalcDate("ProjecttaskDuration", "ProjectTaskStartDate");
            end;
        }
        field(25; ProjectTaskDuration; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Duration';

            trigger OnValidate()
            begin
                VALIDATE("ProjecttaskStartDate");
            end;
        }
        field(6; ProjectTaskEndDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(7; ProjectTaskAssignedUser; Text[100])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("ProjectManagementImplCommittee"."Full Name" where("ID Number"=field(ProjectTaskAssignedUserID)));
            Caption = 'Task Assigned User';
        }
        field(77; ProjectTaskAssignedUserID; CODE[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = ProjectManagementImplCommittee;
            Caption = 'Task Assigned User Id';

            trigger Onvalidate()
            var
            //myInt: Integer;
            begin
                Calcfields(ProjectTaskAssignedUser)end;
        }
        field(8; ProjectEstimatedCostPerTask; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Estimated Cost Per Task';
        }
        field(9; ProjectActualCostPerTask; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual Cost Per Task';
        }
        field(10; ProjectTaskStatus; option)
        {
            OptionCaption = 'Open, Work in Progress, Work in Progress (Overdue), Closed';
            OptionMembers = open, "Work In Progress", "Work in Progress(Overdue)", Closed;
            Caption = 'Task Status';
        }
        field(11; ProjectTaskReassignement; option)
        {
            //DataClassification = ToBeClassified;
            OptionMembers = NO, YES;
            OptionCaption = 'NO,YES';
            Caption = 'Task Reassignement';
        //Trigger onvalidate()
        // begin
        //     case "ProjectTaskReassignement" of
        //         ProjectTaskReassignement::NO:
        //             ProjectTaskReassignedTo  = 
        //         ProjectTaskReassignement::YES:
        //     end;
        // end;
        }
        field(12; ProjectTaskReassignedTo; CODE[50])
        {
            // DataClassification = ToBeClassified;
            // Tablerelation = ProjectManagementImplCommittee."ID number" where("project no." = field("project no."));
            Caption = 'Task Reassigned To';
            FieldClass = FlowField;
            CalcFormula = lookup("ProjectManagementImplCommittee"."Full Name" where("ID Number"=field(ProjectTaskReAssignedUserID)));
        }
        field(122; ProjectTaskReassignedUSERID; CODE[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = ProjectManagementImplCommittee;
            Caption = 'Task ReassignedTO User ID';

            trigger Onvalidate()
            var
            //myInt: Integer;
            begin
                Calcfields(ProjectTaskReassignedTo)end;
        }
        // field(10; "Task Budget"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         Project.Reset;
        //         Project.SetRange("No.", "Project No");
        //         if Project.FindFirst then begin
        //             TaskBudget := "Task Budget";
        //             ProjectTasks.Reset;
        //             ProjectTasks.SetRange("Project No", "Project No");
        //             ProjectTasks.SetFilter("Task No", '<>%1', "Task No");
        //             if ProjectTasks.FindFirst then
        //                 repeat
        //                     TaskBudget += ProjectTasks."Task Budget";
        //                 until ProjectTasks.Next = 0;
        //             if Project."Project Budget" < TaskBudget then
        //                 Error('You have exceeded project %1 budget by %2', "Project No", TaskBudget - Project."Project Budget");
        //         end;
        //     end;
        // }
        field(123; "MileStone Actual Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Projects: Record ProjectIdentification;
            begin
                Projects.Reset();
                Projects.SetRange("Project No.", "Project No.");
                If Projects.FindFirst()then if "MileStone Actual Cost" > Projects."Project Estimated Cost" then Error('Milestone %1 Actual cost Should not be greater than Project %2 Estimated Cost', ProjectDeliverable, "Project No.");
            end;
        }
        field(124; "Milestone Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(125; "Sales Invoice Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Deliverable Number", "Project No.")
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
    var Project: Record "Project Header";
    ProjectTasks: Record "Project Tasks";
    TaskBudget: Decimal;
    ContractSetup: Record "Purchases & Payables Setup";
    NoSeriesManagement: Codeunit NoSeriesManagement;
}

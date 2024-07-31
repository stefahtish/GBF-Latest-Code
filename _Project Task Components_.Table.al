table 50663 "Project Task Components"
{
    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Header";
        }
        field(2; "Task No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Tasks"."Task No" WHERE("Project No"=FIELD("Project No"));
        }
        field(3; Component; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Component Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TaskBudget:="Component Budget";
                ProjectTasks.Reset;
                ProjectTasks.SetRange("Project No", "Project No");
                ProjectTasks.SetRange("Task No", "Task No");
                if ProjectTasks.FindFirst then begin
                    ProjectTaskComponents.Reset;
                    ProjectTaskComponents.SetRange("Project No", "Project No");
                    ProjectTaskComponents.SetRange("Task No", "Task No");
                    if ProjectTaskComponents.FindFirst then repeat if ProjectTaskComponents.Component <> Component then TaskBudget+=ProjectTaskComponents."Component Budget";
                        until ProjectTaskComponents.Next = 0;
                    if ProjectTasks."Task Budget" < TaskBudget then Error(BudgetError, "Task No", "Project No", TaskBudget - ProjectTasks."Task Budget");
                end;
            end;
        }
        field(5; "Progress Level"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Progress := "Progress Level";
                ProjectTaskComponents.Reset;
                ProjectTaskComponents.SetRange("Project No", "Project No");
                ProjectTaskComponents.SetRange("Task No", "Task No");
                if ProjectTaskComponents.FindFirst then repeat //if ProjectTaskComponents.Component <> Component then
                        Progress+=ProjectTaskComponents."Progress Level";
                    until ProjectTaskComponents.Next = 0;
                if Progress > 100 then Error(ProgressError, "Task No", "Project No", Progress);
            end;
        }
    }
    keys
    {
        key(Key1; "Project No", "Task No", Component)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var ProjectTasks: Record "Project Tasks";
    ProjectTaskComponents: Record "Project Task Components";
    TaskBudget: Decimal;
    Progress: Decimal;
    ProgressError: Label 'Accumulative progress level for task %1 of project %2 has exceeded 100% by %3';
    BudgetError: Label 'You have exceeded task %1 of project %2 budget by %3';
}

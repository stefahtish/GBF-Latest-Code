table 50662 "Project Tasks"
{
    Caption = 'Contract Tasks';
    DrillDownPageID = "Project Tasks";
    LookupPageID = "Project Tasks";

    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Header";
            Caption = 'Contract No.';
        }
        field(2; "Task No"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Task No" <> xRec."Task No" then begin
                    NoSeriesManagement.TestManual(ContractSetup."Task Nos");
                    "No. Series":='';
                end;
            end;
        }
        field(3; Descriprion; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(4; "Responsible Person"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Team"."Full Name" WHERE("Project No"=FIELD("Project No"));

            trigger onValidate()
            var
                Teams: Record "Project Team";
            begin
                Teams.Reset();
                Teams.SetRange("Project No", "Responsible Person");
                If Teams.FindFirst()then "Responsible Person Name":=Teams."Full Name";
                CalcFields("Progress Level %");
            end;
        }
        field(5; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(6; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Email, "Phone Call", "Field Visit", Training, Meeting, "Report Preparation", "Report Presentation", Other;
        // ObsoleteState = Removed;
        }
        field(7; Importance; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Low, Moderate, High;
        // ObsoleteState = Removed;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Started, Suspended, Finished, "Pending Approval", Approved, Rejected;

            trigger OnValidate()
            begin
                if Status = Status::Started then begin
                    Project.Get("Project No");
                    Project.TestField("Estimated Start Date");
                    if Project."Actual Start Date" = 0D then begin
                        Project."Actual Start Date":=Today;
                        Project.Modify;
                    end;
                end;
            end;
        }
        field(9; "Progress Level %"; Decimal)
        {
            CalcFormula = Sum("Project Task Components"."Progress Level" WHERE("Project No"=FIELD("Project No"), "Task No"=FIELD("Task No")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(10; "Task Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Project.Reset;
                Project.SetRange("No.", "Project No");
                if Project.FindFirst then begin
                    TaskBudget:="Task Budget";
                    ProjectTasks.Reset;
                    ProjectTasks.SetRange("Project No", "Project No");
                    ProjectTasks.SetFilter("Task No", '<>%1', "Task No");
                    if ProjectTasks.FindFirst then repeat TaskBudget+=ProjectTasks."Task Budget";
                        until ProjectTasks.Next = 0;
                    if Project."Project Budget" < TaskBudget then Error('You have exceeded project %1 budget by %2', "Project No", TaskBudget - Project."Project Budget");
                end;
            end;
        }
        field(11; "Estimated Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Estimated End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Actual Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Actual End date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; No; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17; "Responsible Person Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Project No", "Task No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        Contractsetup.Get;
        if "Task No" = '' then begin
            ContractSetup.TESTFIELD("Task Nos");
            NoSeriesManagement.InitSeries(ContractSetup."Task Nos", xRec."No. Series", 0D, "Task No", "No. Series");
        end;
        "User ID":=UserId;
    end;
    var Project: Record "Project Header";
    ProjectTasks: Record "Project Tasks";
    TaskBudget: Decimal;
    ContractSetup: Record "Purchases & Payables Setup";
    NoSeriesManagement: Codeunit NoSeriesManagement;
}

table 50669 ProjectManagementGLAccounts
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project GL Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            Tablerelation = "G/L Account"."No.";

            Trigger onvalidate()
            var
                GlRecord: record "G/L Account";
                GlBudgetEntry: Record "G/L Budget Entry";
                GlRecords1: Record "Dimension Code Buffer";
            begin
                GlRecord.get("Project GL Account");
                "G/l Name":=GlRecord.Name;
                "G/L Budgeted cost":=GlRecord."Budgeted Amount";
            end;
        }
        field(3; "G/L Name"; Text[50])
        {
            TableRelation = "G/L Account".Name;
        }
        field(4; "G/L Actual Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "G/L Budgeted Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Project No."; Code[50])
        {
            DataClassification = tobeclassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Project No.")
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
}

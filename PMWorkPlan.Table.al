table 50687 PMWorkPlan
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        //Autoincrement = true;
        }
        field(2; "Phase"; text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Responsible Person Code"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            Trigger onValidate()
            var
                ProjTeam: record Employee;
            Begin
                ProjTeam.Get("Responsible Person Code");
                //ProjTeam.SetFilter("Project No.", "Project No.");
                //ProjTeam.SetRange("Emp No.", "Responsible Person");
                "Responsible Person":=ProjTeam."First Name" + ' ' + ProjTeam."Middle Name" + '' + ProjTeam."Last name";
            End;
        }
        field(3; "Responsible Person"; Text[50])
        {
            DataClassification = ToBeClassified;
        // TableRelation = ProjectTeamQualification."Emp no.";
        }
        field(4; "Timeline in Days"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ProjectIdentification: Record ProjectIdentification;
            begin
                ProjectIdentification.Reset();
                ProjectIdentification.SetRange("Project No.", "Project No.");
                if ProjectIdentification.FindFirst()then "Collection Date":=CalcDate("Timeline in Days", ProjectIdentification."Project Start Date");
            end;
        }
        field(5; "Deliverable"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Project No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "WPNO."; CODE[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "WPNO1"; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(72; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(73; "Collection Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74; "Notification Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(75; "Invoice Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; wpno1, "Project No.")
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

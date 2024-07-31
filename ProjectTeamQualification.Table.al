table 50680 ProjectTeamQualification
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project No."; Code[50])
        {
            NotBlank = false;
        }
        field(21; "Emp No."; Code[50])
        {
            NotBlank = false;
            Caption = 'Team Member No.';
            TableRelation = employee."No.";

            TRIGGER ONVALIDATE()
            VAR
                TeamMember: Record Employee;
            begin
                TeamMember.get("Emp No.");
                "Team Member Name":=TeamMember."First Name" + '' + Teammember."Middle name" + ' ' + TeamMember."last name";
            end;
        }
        field(7; "Team Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        //Tablerelation = Employee.Name;
        //TableRelation = ProjectManagementImplCommittee."Full Name";
        }
        field(8; "Qualification"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Experience"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Emp No.", "project no.")
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

table 50722 "ApplicantSkills"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Skill Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(pk; "applicant No.", "Skill Code")
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

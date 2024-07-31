table 50676 "Projet Design"
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
        field(3; DesignCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Content; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Activity; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Goal; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Statement of Purpose".Goal;
        }
        field(6; Outcome; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; MyField)
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

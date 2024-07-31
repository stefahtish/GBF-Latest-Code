table 50675 "Statement Of Purpose"
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
        field(3; PurposeCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Content; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Goal; Text[100])
        {
            DataClassification = ToBeClassified;
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

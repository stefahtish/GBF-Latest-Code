table 50686 "Project Inception"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Background/Context"; text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Objective"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Data Collection"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sampling"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Limitations"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Logistics/Support"; Text[1000])
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

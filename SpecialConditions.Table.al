table 50670 SpecialConditions
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project no"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Special Conditions"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No."; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Special Condition Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Project no", "no.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Special Condition Code")
        {
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

table 50672 GeneralConditionsSetup
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        // field(2; "Project no"; code[50])
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(3; "General Conditions"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No."; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "General Condition Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "no.", "General Condition Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "General Condition Code", "General Conditions")
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

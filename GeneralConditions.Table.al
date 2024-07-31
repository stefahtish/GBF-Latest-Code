table 50671 GeneralConditions
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
        field(3; "General Conditions"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No."; integer)
        {
            DataClassification = ToBeClassified;
            autoincrement = true;
        }
        field(5; "General Condition Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = GeneralConditionsSetup."General Condition Code";

            trigger OnValidate()
            var
                GenCon: Record GeneralConditionsSetup;
            begin
                GenCon.Reset();
                GenCon.SetRange("General Condition Code", "General Condition Code");
                If GenCon.FindFirst()then "General Conditions":=GenCon."General Conditions";
            end;
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
        fieldgroup(DropDown; "General Conditions", "General Condition Code")
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

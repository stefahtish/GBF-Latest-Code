table 50684 "Project Charge-Out Rate"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Charge Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Position; Text[30])
        {
            DataClassification = ToBeClassified;
        // Tablerelation = Employee."Job Position";
        }
        field(6; Cadre; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Low Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "High Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; MyField, "Charge Code")
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

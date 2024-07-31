table 50137 "Procurement Committees"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Members; Integer)
        {
            CalcFormula = Count("Commitee Member" WHERE(Commitee=FIELD(Code)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(4; Permanent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

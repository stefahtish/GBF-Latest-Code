table 50393 "Deduction Balances"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[70])
        {
            CalcFormula = Lookup(DeductionsX.Description WHERE(Code=FIELD("Deduction Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Employee No", "Deduction Code", Date)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

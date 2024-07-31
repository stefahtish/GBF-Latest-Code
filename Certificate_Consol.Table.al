table 50533 Certificate_Consol
{
    fields
    {
        field(1; "Schedule No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Activity; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Delivarable; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Payment; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Contract No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = , "In Progress", Accepted, "Not Due", Due;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Total Amount"; Decimal)
        {
            CalcFormula = Sum(Certificate_Consol.Amount);
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Contract No.", "Schedule No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

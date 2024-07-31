table 50535 Cert_Delivarable
{
    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Delivarable; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Conract No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Accepted, "Not Due", Due;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Total Amount Paid"; Decimal)
        {
            CalcFormula = Sum(Cert_Delivarable.Amount WHERE(Paid=CONST(true), "Conract No."=FIELD("Conract No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Conract No.", "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

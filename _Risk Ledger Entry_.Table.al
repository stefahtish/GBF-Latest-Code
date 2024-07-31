table 50510 "Risk Ledger Entry"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Mitigation Status"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Mitigation KRI(s)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

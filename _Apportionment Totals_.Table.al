table 50160 "Apportionment Totals"
{
    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "G/L Account No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(4; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Apportion Lines".Amount WHERE("No."=FIELD("No."), "G/L Account No."=FIELD("G/L Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

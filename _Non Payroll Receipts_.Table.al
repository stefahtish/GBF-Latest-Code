table 50376 "Non Payroll Receipts"
{
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Application"."Loan No";
        }
        field(2; "Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Received From"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Reference No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Loan No", "Receipt Date")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

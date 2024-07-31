table 50406 "Loan Repayment-Payroll"
{
    fields
    {
        field(1; "Loan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Application"."Loan No";
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No. of Periods"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Customer No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(6; "Repayment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Loan No.", "Start Date")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

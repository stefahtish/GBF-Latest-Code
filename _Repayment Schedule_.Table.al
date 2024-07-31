table 50367 "Repayment Schedule"
{
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Application"."Loan No";
        }
        field(2; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(3; "Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Amount"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;
        }
        field(5; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Loan Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Monthly Repayment"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;
        }
        field(8; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Monthly Interest"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;
        }
        field(10; "Principal Repayment"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;
        }
        field(11; "Instalment No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Remaining Debt"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;
        }
        field(13; "Payroll Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan Deduction Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX.Code;
        }
        field(16; "Loan Interest Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX.Code;
        }
        field(17; "Customer Code"; code[50])
        {
        }
        field(18; "Loan Customer Type"; option)
        {
            OptionMembers = "Staff", "External Customer";
        }
        field(19; "Partially Paid"; Boolean)
        {
        }
        field(20; "Next Invoice Date"; date)
        {
        }
        field(21; "Last Interest Date"; date)
        {
        }
    }
    keys
    {
        key(Key1; "Loan No", "Employee No", "Repayment Date")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

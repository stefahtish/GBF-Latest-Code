table 50328 "Employee Insurance"
{
    Caption = 'Employee Insurance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Insurance Company"; Code[50])
        {
            Caption = 'Insurance Company';
            DataClassification = ToBeClassified;
        }
        field(3; "Policy No"; Code[50])
        {
            Caption = 'Policy No';
            DataClassification = ToBeClassified;
        }
        field(4; "Deduction code"; Code[50])
        {
            Caption = 'Deduction code';
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
    }
    keys
    {
        key(PK; "Employee No.", "Insurance Company", "Policy No")
        {
            Clustered = true;
        }
    }
}

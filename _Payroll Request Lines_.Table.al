table 50380 "Payroll Request Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Previous Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "New Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Change; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Employee No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

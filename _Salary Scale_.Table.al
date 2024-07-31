table 50371 "Salary Scale"
{
    fields
    {
        field(1; Scale; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Minimum Pointer"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Maximum Pointer"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Leave Entitlement"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Responsibility Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Commuter Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "In Patient Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Out Patient Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Per Diem"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Location; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Max Imprest"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Scale)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

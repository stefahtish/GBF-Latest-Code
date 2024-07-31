table 50269 "Employee House Details"
{
    fields
    {
        field(1; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "House No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Dedcution; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "House No.", "Start Date", Dedcution)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

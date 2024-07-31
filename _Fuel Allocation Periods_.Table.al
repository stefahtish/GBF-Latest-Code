table 50348 "Fuel Allocation Periods"
{
    Caption = 'Fuel Allocation Periods';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Period)
        {
            Clustered = true;
        }
    }
}

table 50647 "Strategic Period"
{
    Caption = 'Period';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Plan Name"; Code[20])
        {
            Caption = 'Plan Name';
            DataClassification = ToBeClassified;
        }
        field(2; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Strategic, Audit;
        }
    }
    keys
    {
        key(PK; "Plan Name")
        {
            Clustered = true;
        }
    }
}

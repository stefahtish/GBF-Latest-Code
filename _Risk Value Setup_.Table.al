table 50511 "Risk Value Setup"
{
    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Risk Impact,Risk Appetite';
            OptionMembers = " ", "Risk Impact", "Risk Appetite";
        }
        field(2; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Type, Value)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

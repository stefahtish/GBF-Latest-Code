table 50291 "Housing Issue Setup"
{
    fields
    {
        field(1; Criteria; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Marital Status,Children,Service Years';
            OptionMembers = "Marital Status", Children, "Service Years";
        }
        field(2; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ", Single, Married, Separated, Divorced, "Widow(er)", Other;
        }
        field(3; Points; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Spouse; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Criteria, "Marital Status")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

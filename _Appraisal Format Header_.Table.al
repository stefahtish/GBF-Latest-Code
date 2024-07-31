table 50243 "Appraisal Format Header"
{
    fields
    {
        field(1; Header; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Priority; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Header)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

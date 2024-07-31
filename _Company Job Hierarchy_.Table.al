table 50743 "Company Job Hierarchy"
{
    Caption = 'Company Job Hierarchy';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Hierarchy Level"; Text[30])
        {
            Caption = 'Hierarchy Level';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Hierarchy Level")
        {
            Clustered = true;
        }
    }
}

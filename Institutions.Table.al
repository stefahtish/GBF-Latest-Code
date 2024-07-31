table 50370 Institutions
{
    DrillDownPageID = Institutionsz;
    LookupPageID = Institutionsz;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Address; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Email; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

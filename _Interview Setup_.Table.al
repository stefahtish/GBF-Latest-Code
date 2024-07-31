table 50282 "Interview Setup"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Oral,Practical';
            OptionMembers = " ", Oral, Practical;
        }
        field(4; "Oral Interview"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Oral Interview (Board)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Classroom Interview"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Practical; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Pass Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
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

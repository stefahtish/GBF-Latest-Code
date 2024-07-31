table 50285 "Practical Interview"
{
    fields
    {
        field(1; "Applicant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Need Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interview Setup";
        }
        field(3; "Panel Member"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interview Panel Members";
        }
        field(4; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Test Parameter"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Test Parameters".Code;
        }
        field(7; "Test Parameter2"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Test Parameters".Description;
        }
    }
    keys
    {
        key(Key1; "Applicant No", "Panel Member", "Test Parameter")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

table 50250 "Recruitment Stages"
{
    DrillDownPageID = "Recruitment Stages";
    LookupPageID = "Recruitment Stages";

    fields
    {
        field(1; "Recruitement Stage"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Failed Response Templates"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interaction Template".Code;
        }
        field(4; "Passed Response Templates"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interaction Template".Code;
        }
        field(5; Interview; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Application; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Recruitement Stage")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

table 50147 "Approval Stages1"
{
    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group";
        }
        field(2; "Approval Stage"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Approval Stage Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Minimum Approvers"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Workflow User Group Code", "Approval Stage")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

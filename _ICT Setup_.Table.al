table 50295 "ICT Setup"
{
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Incidence Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Registry E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Screenshot Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Security E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Escalation E-mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Communication Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Communication E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Registry BCC"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Workplan Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Activity Workplan Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

table 50486 "Client Interactions Docs"
{
    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Client Interaction"; Code[20])
        {
            TableRelation = "Client Interaction Header";
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Document Link"; Text[200])
        {
        }
        field(6; "Language Code (Default)"; Code[10])
        {
        }
        field(7; Attachment; Option)
        {
            OptionMembers = No, Yes;
        }
        field(8; "Litigation Code"; Code[10])
        {
        }
        field(9; "Doc Code"; Code[20])
        {
        }
        field(10; Date; Date)
        {
        }
        field(11; "Approval Stage"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Approval Stages1"."Approval Stage";
        }
        field(12; "Workflow User Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group";
        }
        field(14; "Clearance Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Principal,Beneficiary,Third Party';
            OptionMembers = Principal, Beneficiary, "Third Party";
        }
        field(15; Provided; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Client Interaction", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

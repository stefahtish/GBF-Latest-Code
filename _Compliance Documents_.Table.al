table 50611 "Compliance Documents"
{
    Caption = 'Required Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Process; Option)
        {
            Caption = 'Process';
            DataClassification = ToBeClassified;
            OptionMembers = "", Registration, "Regulatory Permit Application";
            OptionCaption = ' ,Registration,Regulatory Permit Application';
        }
        field(2; "Registration Type"; Option)
        {
            Caption = 'Registration Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Individual, "Registered Entity";
            OptionCaption = ' ,Individual,Registered Entity';
        }
        field(3; Document; Text[100])
        {
            Caption = 'Document';
            DataClassification = ToBeClassified;
        }
        field(4; "License Category"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "License and Permit Category"."License/Permit Category";
        }
    }
    keys
    {
        key(PK; Process, "Registration Type", Document)
        {
            Clustered = true;
        }
    }
}

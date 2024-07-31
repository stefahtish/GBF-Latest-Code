table 50483 "SMS Logging Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Email/SMS Logging Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Client Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Member,Sponsor';
            OptionMembers = " ", Member, Sponsor;
        }
        field(4; "Client No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Client Phone Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "SMS Error Message"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

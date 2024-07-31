table 50297 "ICT Escalations"
{
    Caption = 'ICT Escalations';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Escalator No."; Code[20])
        {
            Caption = 'Escalator No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Escalation Option"; Option)
        {
            Caption = 'Escalation Option';
            OptionMembers = " ", Internal, External;
            OptionCaption = ' ,Internal,External';
            DataClassification = ToBeClassified;
        }
        field(4; "Escalator Name"; Text[100])
        {
            Caption = 'Escalator Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Escalator User ID"; Code[100])
        {
            Caption = 'Escalator User ID';
            DataClassification = ToBeClassified;
        }
        field(6; "Escalation date"; Date)
        {
            Caption = 'Escalation date';
            DataClassification = ToBeClassified;
        }
        field(7; "Escalation Time"; Time)
        {
            Caption = 'Escalation Time';
            DataClassification = ToBeClassified;
        }
        field(8; "Resolution time"; Time)
        {
            Caption = 'Resolution time';
            DataClassification = ToBeClassified;
        }
        field(9; "Resolution Date"; Date)
        {
            Caption = 'Resolution Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Escalation Email"; Text[100])
        {
            Caption = 'Escalation Email';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Escalator No.", "Escalation Email")
        {
            Clustered = true;
        }
    }
}

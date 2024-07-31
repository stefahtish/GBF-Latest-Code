table 50474 "Interaction Escalations"
{
    fields
    {
        field(1; "Interaction Code"; Code[30])
        {
        }
        field(2; User; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(3; DateTime; DateTime)
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(5; "Resolution Status"; Option)
        {
            OptionCaption = 'Outstanding,Skipped,Escalated,Completed';
            OptionMembers = Outstanding, Skipped, Escalated, Completed;
        }
        field(6; "Resolution Time"; Date)
        {
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Level No.';
        }
        field(8; "Escalation Employee No."; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Escalation Employee Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Notes; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "First Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Second Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Third Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Escalation Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Escalation Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "", Internal, External;
            OptionCaption = ' ,Internal,External';
        }
        field(16; "Last Notification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "No of Escalations"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Interaction Code", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

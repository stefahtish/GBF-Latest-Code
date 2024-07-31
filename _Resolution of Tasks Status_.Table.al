table 50467 "Resolution of Tasks Status"
{
    fields
    {
        field(1; "Interaction Header No."; Code[20])
        {
            TableRelation = "Client Interaction Header"."Interact Code";
        }
        field(2; "Interation Reso. Code"; Code[20])
        {
            TableRelation = "Interaction Resolution"."Cause No.";
        }
        field(3; "Step No."; Integer)
        {
        }
        field(4; "Resolution Description"; Text[250])
        {
        }
        field(5; "Resolution Status"; Option)
        {
            OptionCaption = 'Outstanding,Skipped,Completed';
            OptionMembers = Outstanding, Skipped, Completed;
        }
        field(6; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Assigned User From"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Assigned Date From"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Assigned User To"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Assigned Date To"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Action Taken"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Action Status"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Header Status"; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Logged,Assigned,Escalated,Awaiting 3rd Party,Closed,Registry,Awaiting Assignment,EFT Created,EFT Processed,Payment Initiated,PV Created,EFT Posted,PV Posted';
            OptionMembers = Logged, Assigned, Escalated, "Awaiting 3rd Party", Closed, Registry, "Awaiting Assignment", "EFT Created", "EFT Processed", "Payment Initiated", "PV Created", "EFT Posted", "PV Posted";
        }
        field(14; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Membership Exit,Risk Based Benefit';
            OptionMembers = " ", "Membership Exit", "Risk Based Benefit";
        }
    }
    keys
    {
        key(Key1; "Interaction Header No.", "Interation Reso. Code", "Step No.")
        {
            Clustered = true;
        }
    }
}

table 50287 "Leave Periods"
{
    DrillDownPageID = "Leave Period";
    LookupPageID = "Leave Period";

    fields
    {
        field(1; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Type";
        }
        field(6; "Employment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Partime,Casual,Contract,Trustee,Attachee,Intern';
            OptionMembers = Permanent, Partime, Casual, Contract, Trustee, Attachee, Intern;
        }
        // field(6; "Employment Type"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee,Attachee,Intern';
        //     OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee,Attachee,Intern;
        // }
        field(7; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Leave Period", "Employment Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

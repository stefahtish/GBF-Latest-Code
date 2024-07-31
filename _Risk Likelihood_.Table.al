table 50501 "Risk Likelihood"
{
    DrillDownPageID = "Risk Likelihood";
    LookupPageID = "Risk Likelihood";

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Likelihood Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Probability; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Frequency (General)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Probably Never Happen,Not Expected,Might Happen,Probably Recur,Recur Frequently';
            OptionMembers = " ", "Probably Never Happen", "Not Expected", "Might Happen", "Probably Recur", "Recur Frequently";
        }
        field(6; "Frequency (Timeframe)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Not Expected,Expected Annually,Expected Monthly,Expected,Expected Daily';
            OptionMembers = " ", "Not Expected", "Expected Annually", "Expected Monthly", Expected, "Expected Daily";
        }
        field(7; "Probability Start Range"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Likelihood Score")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Likelihood Score")
        {
        }
    }
}

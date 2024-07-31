table 50236 "Appraisal Periods"
{
    DrillDownPageId = "Appraisal Periods";
    LookupPageId = "Appraisal Periods";

    fields
    {
        field(1; Period; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Appraisal Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        //TableRelation = "Appraisal Type".Code;
        }
        field(6; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ", "Mid-Year", "Final Year";
        }
        field(8; "Appraisal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
            OptionMembers = " ", Q1, Q2, Q3, Q4;
        }
        field(9; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Period)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Period, Description, "Start Date", "End Date")
        {
        }
    }
}

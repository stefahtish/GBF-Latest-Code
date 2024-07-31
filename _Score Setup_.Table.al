table 50252 "Score Setup"
{
    fields
    {
        field(1; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs";

            trigger OnValidate()
            var
                RecNeeds: Record "Recruitment Needs";
            begin
                if "Job Description" <> '' then "Job Description":='';
                if RecNeeds.Get("Job ID")then "Job Description":=RecNeeds.Description;
            end;
        }
        field(2; "Job Description"; Text[250])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(3; "Pass Mark"; Decimal)
        {
            MinValue = 1;
            MaxValue = 100;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

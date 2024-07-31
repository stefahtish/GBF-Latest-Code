table 50208 "Positions Supervised"
{
    fields
    {
        field(1; "Job ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Company Job"."Job ID";
        }
        field(2; "Position Supervised"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Company Job"."Job ID";

            trigger OnValidate()
            begin
                if Jobs.Get("Job ID")then begin
                    if "Position Supervised" = "Job ID" then Error('You cannot Supervise the same position you are in');
                end;
                Jobs.SetRange("Job ID", "Position Supervised");
                if Jobs.Find('-')then Description:=Jobs."Job Description";
            end;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job ID", "Position Supervised")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Jobs: Record "Company Job";
}

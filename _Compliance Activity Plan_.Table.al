table 50561 "Compliance Activity Plan"
{
    fields
    {
        field(1; "Activity Type";enum "Compliance Activity Types")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Description of activity"; Code[2048])
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
        field(5; Country; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(6; County; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", County);
                if cty.FindFirst()then "County Name":=cty.County;
            end;
        }
        field(7; Subcounty; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub-County"."Sub-County Code";
        }
        field(8; Venue; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "County Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            clustered = true;
        }
    }
}

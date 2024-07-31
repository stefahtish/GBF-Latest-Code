table 50630 "Research-Survey Activity Plan"
{
    fields
    {
        field(1; "Export Activity Type";enum "Export promotion Types")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Description of activity"; Code[2048])
        {
            Editable = false;
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

            trigger OnValidate()
            var
                subc: Record "Sub-County";
            begin
                if subc.Get(Subcounty)then "Sub-County Name":=subc.Name;
            end;
        }
        field(8; Venue; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Support Activity Type";enum "Stakeholder support Types")
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Research type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Support, Export, Dairystds;
            OptionCaption = 'Support, Export, Dairy Standards';
        }
        field(12; "County Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Sub-County Name"; Code[50])
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

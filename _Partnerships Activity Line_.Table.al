table 50629 "Partnerships Activity Line"
{
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Patnership line type"; Option)
        {
            OptionMembers = Objectives, Patners, Activities, Recommendations, Funding;
            OptionCaption = 'Objectives,Patners,Activities,Recommendations,Funding';
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Outcome; Text[2000])
        {
            Caption = 'Output';
            DataClassification = ToBeClassified;
        }
        field(6; "Quantification of outcome"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Roles; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date Held"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "County"; code[20])
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
        field(10; "County Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Venue; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Budgetary Plan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code, "Patnership line type", "Line No.")
        {
            clustered = true;
        }
    }
}

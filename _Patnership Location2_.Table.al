table 50637 "Patnership Location2"
{
    Caption = 'Patnership Location';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Country Code"; Code[20])
        {
            Caption = 'County Code';
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                Counties: Record CountyNew;
            begin
                Counties.Reset();
                Counties.SetRange("County Code", "Country Code");
                if Counties.FindFirst()then County:=Counties.County;
            end;
        }
        field(3; Country; Text[100])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(4; "County Code"; Code[20])
        {
            Caption = 'County Code';
            DataClassification = ToBeClassified;
        }
        field(5; County; Text[100])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(6; "Sub County Code"; Code[20])
        {
            Caption = 'Sub County Code';
            DataClassification = ToBeClassified;
        }
        field(7; "Sub County"; Text[100])
        {
            Caption = 'Sub County';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code, "Country Code")
        {
            Clustered = true;
        }
    }
}

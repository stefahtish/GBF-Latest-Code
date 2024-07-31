table 50307 "Company Job Experience"
{
    Caption = 'Company Job Experience';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; Industry; Code[50])
        {
            Caption = 'Industry';
            DataClassification = ToBeClassified;
            TableRelation = "Company Job Industry".Code;

            trigger OnValidate()
            begin
                if CompanyJobIndustry.Get(Industry)then "Industry Name":=CompanyJobIndustry.Description;
            end;
        }
        field(4; "Industry Name"; Text[2000])
        {
            Caption = 'Industry Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Hierarchy Level";Enum "Hierarchy Level")
        {
            Caption = 'Hierarchy Level';
            DataClassification = ToBeClassified;
        }
        field(6; "No. of Years"; Decimal)
        {
            Caption = 'No. of Years';
            DataClassification = ToBeClassified;
        }
        field(7; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Job ID", "Line No")
        {
            Clustered = true;
        }
    }
    var CompanyJobIndustry: Record "Company Job Industry";
}

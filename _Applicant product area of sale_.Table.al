table 50613 "Applicant product area of sale"
{
    Caption = 'Applicant product area of sale';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Applicant No"; Code[50])
        {
            Caption = 'Applicant No';
            DataClassification = ToBeClassified;
        }
        field(2; Outlet; Code[50])
        {
            Caption = 'Name of Premise';
            DataClassification = ToBeClassified;
        }
        field(3; Product; Text[100])
        {
            Caption = 'Product';
            DataClassification = ToBeClassified;
        }
        field(4; "Area of sale"; Code[50])
        {
            Caption = 'Area of sale';
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", "Area of Sale");
                if cty.FindFirst()then "Area of Sale Name":=cty.County;
            end;
        }
        field(5; "Area of sale name"; Text[100])
        {
            Caption = 'Area of sale name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Applicant No", Outlet, Product, "Area of sale")
        {
            Clustered = true;
        }
    }
}

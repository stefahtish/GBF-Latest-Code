table 50545 "Customer Branches"
{
    Caption = 'Customer Branches';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(2; Branch; Code[50])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
        }
        field(3; "Category of outlets"; Text[100])
        {
            Caption = 'Category of Premise';
            DataClassification = ToBeClassified;
            TableRelation = "Means of Handling Setup" where("Means of Handling"=filter(Premise));
        }
        field(4; "Contact person"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Telephone No"; Code[100])
        {
            DataClassification = ToBeClassified;
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
            TableRelation = "Sub-County"."Sub-County Code" where("County Code"=field(County));

            trigger OnValidate()
            var
                subc: Record "Sub-County";
            begin
                subc.SetRange("Sub-County Code", Subcounty);
                if subc.find('-')then begin
                    "Sub-County Name":=subc.Name;
                    Station:=subc.Station;
                end;
            end;
        }
        field(8; "County Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sub-County Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Station; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Salutation;Enum Salutations)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Applicant No"; Code[20])
        {
        }
    }
    keys
    {
        key(PK; "Customer No.", Branch)
        {
            Clustered = true;
        }
    }
}

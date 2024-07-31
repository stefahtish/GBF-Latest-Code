table 50610 "Applicants Products per outlet"
{
    Caption = 'License Applicants Products';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application no"; Code[20])
        {
            Caption = 'Application no';
            DataClassification = ToBeClassified;
        }
        field(2; Product; Code[100])
        {
            Caption = 'Product';
            DataClassification = ToBeClassified;
            TableRelation = "Dairy Produce Setup";
        }
        field(3; Outlet; Text[100])
        {
            Caption = 'Name of Premise';
            DataClassification = ToBeClassified;
        }
        field(4; "Quantity handled"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unit of measure"; Text[50])
        {
            ObsoleteState = removed;
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(6; "Sell to whom"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sale to whom Setup";
        }
        field(7; "Area of Sale"; Code[50])
        {
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
        field(8; "Area of Sale Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unit of measure2"; Code[50])
        {
            caption = 'Unit of measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
    }
    keys
    {
        key(PK; "Application no", Outlet, Product)
        {
            Clustered = true;
        }
    }
}

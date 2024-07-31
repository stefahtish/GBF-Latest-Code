table 50186 "Prequalified Supplier Categ"
{
    Caption = 'Prequalified Supplier Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Vendor; Code[20])
        {
            Caption = 'Vendor';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Prop: Record "Prospective Suppliers";
            begin
                "Supplier Name":='';
                if Prop.Get(Vendor)then "Supplier Name":=Prop.Name;
            end;
        }
        field(2; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";

            trigger OnValidate()
            var
                Categ: Record "Supplier Category";
            begin
                if Categ.Get("Category Code")then Category:=Categ.Description;
            end;
        }
        field(3; Category; Text[500])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
        }
        field(4; "Supplier Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Vendor, "Category Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Vendor, "Category Code", "Supplier Name")
        {
        }
    }
}

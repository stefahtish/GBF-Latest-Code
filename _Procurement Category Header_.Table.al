table 50145 "Procurement Category Header"
{
    fields
    {
        field(1; "Fiscal Year"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(2; Category; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";

            trigger OnValidate()
            begin
                if CategoryRec.Get(Category)then begin
                    "Category Name":=CategoryRec.Description;
                end;
            end;
        }
        field(3; "Category Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Fiscal Year", Category)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var CategoryRec: Record "Supplier Category";
}

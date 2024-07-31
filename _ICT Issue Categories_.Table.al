table 50491 "ICT Issue Categories"
{
    Caption = 'ICT Issue Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Category; Code[10])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
        }
        field(2; "Category Description"; Text[200])
        {
            Caption = 'Category Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Category)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Category, "Category Description")
        {
        }
    }
}

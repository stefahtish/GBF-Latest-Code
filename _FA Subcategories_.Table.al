table 50185 "FA Subcategories"
{
    Caption = 'FA Subcategories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Class; Code[20])
        {
            Caption = 'Class';
            DataClassification = ToBeClassified;
        }
        field(2; Subclass; Text[20])
        {
            Caption = 'Subclass';
            DataClassification = ToBeClassified;
        }
        field(3; Subcategory; Text[20])
        {
            Caption = 'Subcategory';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Class, Subclass, Subcategory)
        {
            Clustered = true;
        }
    }
}

tableextension 50139 FASubclassTableExt extends "FA Subclass"
{
    fields
    {
        field(5000; "No of Depreciation Years"; Decimal)
        {
            Caption = 'No of Depreciation Years';
            DataClassification = ToBeClassified;
        }
        field(5001; "Has subcategories"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5002; Computer; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

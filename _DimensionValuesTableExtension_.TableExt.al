tableextension 50167 "DimensionValuesTableExtension" extends "Dimension Value"
{
    fields
    {
        field(100; HQ; Boolean)
        {
            Caption = 'HQ';
            DataClassification = ToBeClassified;
        }
        field(101; Lab; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(102; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60015; "Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

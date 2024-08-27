tableextension 50167 "DimensionValuesTableExtension" extends "Dimension Value"
{
    fields
    {
        field(50100; HQ; Boolean)
        {
            Caption = 'HQ';
            DataClassification = ToBeClassified;
        }
        field(50101; Lab; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

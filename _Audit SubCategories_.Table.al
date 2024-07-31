table 50529 "Audit SubCategories"
{
    Caption = 'Audit Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Category; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Code; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Category, Code)
        {
            Clustered = true;
        }
    }
}

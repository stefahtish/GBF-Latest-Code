table 50619 "Laboratory Products"
{
    Caption = 'Laboratory Product Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Product; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Category; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; SubCategory; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Lab Section"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Lab section to test"));
        }
        field(5; Description; Text[300])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Product)
        {
            Clustered = true;
        }
    }
}

table 50407 "House Allowances"
{
    Caption = 'House Allowances';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job group"; Code[20])
        {
            Caption = 'Job group';
            DataClassification = ToBeClassified;
        }
        field(2; Pointer; Code[20])
        {
            Caption = 'Pointer';
            DataClassification = ToBeClassified;
        }
        field(3; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Branch; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(1));
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Job group", Pointer, Code, Branch)
        {
            Clustered = true;
        }
    }
}

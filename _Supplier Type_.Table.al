table 50183 "Supplier Type"
{
    Caption = 'Supplier Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Type; Code[500])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Type)
        {
            Clustered = true;
        }
    }
}

table 50591 "Target Clients"
{
    Caption = 'Target Clients';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Client; Code[200])
        {
            Caption = 'Client';
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No", Client)
        {
            Clustered = true;
        }
    }
}

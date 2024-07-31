table 50101 "Temp Bank Recon"
{
    fields
    {
        field(1; "Document No"; Code[20])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Bank No."; Code[20])
        {
        }
        field(6; Opened; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Document No")
        {
        }
    }
    fieldgroups
    {
    }
}

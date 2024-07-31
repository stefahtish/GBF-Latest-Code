table 50112 CITI
{
    fields
    {
        field(1; DocumentNo; Code[20])
        {
        }
        field(2; "Customer No"; Code[20])
        {
        }
        field(3; "Party Cnt"; Code[20])
        {
        }
        field(4; "Co_Ins Account"; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; DocumentNo, "Co_Ins Account")
        {
        }
    }
    fieldgroups
    {
    }
}

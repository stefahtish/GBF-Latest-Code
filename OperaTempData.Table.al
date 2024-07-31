table 50103 OperaTempData
{
    fields
    {
        field(1; "Account No"; Code[10])
        {
        }
        field(2; TransactionDate; Date)
        {
        }
        field(3; OperaCode; Code[10])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Description; Text[120])
        {
        }
    }
    keys
    {
        key(Key1; "Account No")
        {
        }
    }
    fieldgroups
    {
    }
}

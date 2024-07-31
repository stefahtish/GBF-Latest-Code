table 50100 ProductionPure
{
    fields
    {
        field(1; DocumentNo; Code[20])
        {
        }
        field(2; InsuranceRef; Code[20])
        {
        }
        field(3; DocumentDate; Text[30])
        {
        }
        field(4; TransactionDate; Text[30])
        {
        }
        field(5; PremiumTotal; Text[30])
        {
        }
        field(6; CurrencyCode; Code[10])
        {
        }
        field(7; InsuranceHldAcc; Code[20])
        {
        }
        field(8; InsuranceHldName; Text[100])
        {
        }
        field(9; AgencyAcc; Code[20])
        {
        }
        field(10; Agency; Text[100])
        {
        }
        field(11; BranchID; Code[10])
        {
        }
        field(12; ProductCode; Code[10])
        {
        }
        field(13; PostingDate; DateTime)
        {
        }
        field(14; Amount; Decimal)
        {
        }
        field(15; AccNo; Code[10])
        {
        }
        field(16; Posted; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; DocumentNo)
        {
        }
    }
    fieldgroups
    {
    }
}

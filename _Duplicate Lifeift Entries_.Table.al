table 50110 "Duplicate Lifeift Entries"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Document No"; Code[20])
        {
        }
        field(3; "Transaction No"; Integer)
        {
        }
        field(4; "Posting Date"; Date)
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Policy No"; Code[20])
        {
        }
        field(7; Narration; Text[250])
        {
        }
        field(8; "GL Account No"; Code[20])
        {
        }
        field(9; "Journal Batch"; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "Entry No")
        {
        }
    }
    fieldgroups
    {
    }
}

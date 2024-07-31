table 50109 "Repush Receipts to Lifefit"
{
    fields
    {
        field(1; "Receipt No"; Code[20])
        {
        }
        field(2; Policy; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Media Ref"; Code[100])
        {
        }
        field(5; Repushed; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Receipt No")
        {
        }
    }
    fieldgroups
    {
    }
}

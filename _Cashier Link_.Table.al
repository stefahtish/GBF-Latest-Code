table 50464 "Cashier Link"
{
    fields
    {
        field(1; UserID; Code[20])
        {
            NotBlank = true;
            TableRelation = user;
        }
        field(2; "Bank Account No"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(3; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code"=CONST('BRANCHES'));
        }
    }
    keys
    {
        key(Key1; UserID)
        {
        }
    }
    fieldgroups
    {
    }
}

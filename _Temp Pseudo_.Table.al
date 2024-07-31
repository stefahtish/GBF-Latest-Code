table 50105 "Temp Pseudo"
{
    fields
    {
        field(1; "Line No"; Integer)
        {
        }
        field(2; Pseudo; Code[100])
        {
        }
        field(3; Amount; Code[50])
        {
        }
        field(4; Posted; Boolean)
        {
        }
        field(5; "Trans No"; Code[50])
        {
        }
        field(6; "Policy No"; Code[50])
        {
        }
        field(7; AccProd; Code[50])
        {
        }
        field(8; "Source Schema"; Code[50])
        {
        }
        field(9; Product; Code[50])
        {
        }
        field(10; Branch; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "Line No")
        {
        }
    }
    fieldgroups
    {
    }
}

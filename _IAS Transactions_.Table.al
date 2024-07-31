table 50104 "IAS Transactions"
{
    fields
    {
        field(1; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(2; DocumentNo; Code[20])
        {
        }
        field(3; "Account Type"; Text[30])
        {
        }
        field(4; AccountNo; Code[20])
        {
        }
        field(5; AccountName; Text[100])
        {
        }
        field(6; Description; Text[100])
        {
        }
        field(7; GlobalDim1; Code[20])
        {
        }
        field(8; GlobalDim2; Code[20])
        {
        }
        field(9; GlobalDim3; Code[20])
        {
        }
        field(10; Amount; Text[30])
        {
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; PolicyRef; Code[20])
        {
        }
        field(13; PostingDate; Text[30])
        {
        }
        field(14; ExternalDocNo; Code[50])
        {
        }
        field(15; BatchName; Code[20])
        {
        }
        field(16; "Bal.Acc No"; Code[20])
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

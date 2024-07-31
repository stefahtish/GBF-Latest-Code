table 50191 "MPESA Integration Setup"
{
    fields
    {
        field(1; "Primary key"; Code[10])
        {
        }
        field(2; "Integration Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Default Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(4; "Operations & Manitenance A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Default Dim1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(6; "Default Dim2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(7; "Default Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(8; "Default Type"; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code WHERE(Type=FILTER(Receipt));
        }
        field(9; "Default Description"; Text[100])
        {
        }
    }
    keys
    {
        key(Key1; "Primary key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

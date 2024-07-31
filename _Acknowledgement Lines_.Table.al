table 50180 "Acknowledgement Lines"
{
    Caption = 'Acknowledgement Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[10])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Quantity Ordered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Quantity Received"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Order No")
        {
            Clustered = true;
        }
    }
}

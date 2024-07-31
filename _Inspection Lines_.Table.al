table 50142 "Inspection Lines"
{
    fields
    {
        field(1; "Inspection No"; Code[20])
        {
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
        field(7; "Inspection Decision"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Accept, Reject;
        }
        field(8; "Reasons for Rejection"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Return Reasons"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason";
        }
        field(10; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Remarks; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Inspection No", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

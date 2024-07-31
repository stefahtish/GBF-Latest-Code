table 50134 "Supplier Monitoring"
{
    fields
    {
        field(1; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type"=CONST(Order));

            trigger OnValidate()
            begin
                if PO.Get(PO."Document Type"::Order, "Purchase Order No.")then begin
                    "Vendor Name":=PO."Pay-to Name";
                end;
            end;
        }
        field(2; "Brief Description of Work done"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Agreed Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Actual Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Agreed Completion date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Actual Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Completed Within Schedule"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Reasons for Late completion"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Quality of Work"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "User ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Vendor Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Purchase Order No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var PO: Record "Purchase Header";
}

tableextension 50127 SalesShipmentHdrExt extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Lease No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Billing No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Property No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9409; "Customer Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(9550; "Requested Evacuation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9551; "PurchHeader No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9552; "Rent Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9553; TPS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9554; "Property Unit"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9555; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}

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
        field(50003; "Customer Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(50004; "Requested Evacuation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "PurchHeader No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Rent Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; TPS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Property Unit"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}

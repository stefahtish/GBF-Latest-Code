table 50179 "Acknowledgement Header"
{
    Caption = 'Acknowledgement Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type"=CONST(Order), Status=CONST(Released));

            trigger OnValidate()
            begin
            // PurchLines.Reset;
            // PurchLines.SetRange(PurchLines."Document Type", PurchLines."Document Type"::Order);
            // PurchLines.SetRange(PurchLines."Document No.", "Order No");
            // if PurchLines.Find('-') then begin
            //     repeat
            //         InspectLines.Init;
            //         InspectLines."Inspection No" := "Inspection No";
            //         InspectLines."Line No" := PurchLines."Line No.";
            //         InspectLines.Description := PurchLines."Description 2";
            //         InspectLines."Unit of Measure" := PurchLines."Unit of Measure";
            //         InspectLines."Quantity Ordered" := PurchLines.Quantity;
            //         InspectLines."Item No" := PurchLines."No.";
            //         if not InspectLines.Get(InspectLines."Inspection No", InspectLines."Line No") then
            //             InspectLines.Insert else
            //             InspectLines.Modify;
            //     until PurchLines.Next = 0;
            // end;
            // if PO.Get(PO."Document Type"::Order, "Order No") then
            //     "Supplier Name" := PO."Buy-from Vendor Name";
            end;
        }
        field(3; "Amount Invoiced"; Decimal)
        {
            CalcFormula = Sum("Purch. Inv. Line".Amount WHERE("Document No."=FIELD("Order No")));
            FieldClass = FlowField;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Supplier Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Open, Released;
        }
        field(8; Amount; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Amount WHERE("Document Type"=CONST(Order), "Document No."=FIELD("Order No")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(9; Acknowledged; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Order Inspection Nos");
        if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."Acknowledgement Nos", xRec."No. Series", 0D, "No.", "No. Series");
    // "Document Date" := today;
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    PurchLines: Record "Purchase Line";
    InspectLines: Record "Inspection Lines";
    PO: Record "Purchase Header";
    PurchInvHeader: Record "Purch. Inv. Header";
}

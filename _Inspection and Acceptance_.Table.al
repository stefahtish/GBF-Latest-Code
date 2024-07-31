table 50442 "Inspection and Acceptance"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            Caption = 'Tender No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                User:=UserId;
                PurchSetup.Get;
                if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."Order Inspection Nos");
            end;
        }
        field(3; Title; Text[250])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; User; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Vendor Invoice No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Order Date"; Date)
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
        if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."Order Inspection Nos", xRec."No. Series", 0D, "No.", "No. Series");
        "Document Date":=today;
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Commett: Record "Commitee Member";
    ProspectRec: Record "Prospective Suppliers";
    Vendors: Record Vendor;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
    end;
}

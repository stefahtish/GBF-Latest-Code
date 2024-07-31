table 50429 "Document required"
{
    fields
    {
        field(1; "Quote No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";
            Caption = 'RFP/EOI/Quote/Tender No.';
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Mandatory; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Document Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Document Setup"."Code";

            trigger OnValidate()
            var
                ProcDocs: Record "Procurement Document Setup";
            begin
                if ProcDocs.Get("Document Code")then "Document Name":=ProcDocs.Description;
            end;
        }
        field(6; Checked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "RFQ No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Supplier No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Vendor No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Quote No", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var DimMgt: Codeunit DimensionManagement;
    VATAmount: Decimal;
    AmountToPost: Decimal;
    GLSetup: Record "General Ledger Setup";
    Vendor: Record Vendor;
    ProcurementPlan: Record "Procurement Plan";
    PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    VATSetup: Record "VAT Posting Setup";
    GLAcc: Record "G/L Account";
    ItemRec: Record Item;
    CurrencyRec: Record Currency;
    CurrencyExchangeRate: Record "Currency Exchange Rate";
    Direction: Text[30];
}

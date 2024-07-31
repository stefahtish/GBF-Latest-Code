table 50133 "Supplier Category"
{
    fields
    {
        field(1; "Category Code"; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Category Code" <> xRec."Category Code" then begin
                    PurchSetup.get;
                    PurchSetup.TestField("Supplier Category Nos");
                    NoSeries.TestManual(PurchSetup."Supplier Category Nos");
                    "No. Series":='';
                end;
            end;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor Posting Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(4; "Gen. Bus. Posting Group"; Code[50])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
            /*IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                  IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                    VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");*/
            end;
        }
        field(5; "VAT Bus. Posting Group"; Code[50])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }
        field(6; "No. Prequalified"; Integer)
        {
            CalcFormula = Count("Prequalified Suppliers" WHERE(Category=FIELD("Category Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Year Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
        field(8; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Supplier, LPO;
        }
        field(9; "No. Series"; code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Category Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Category Code" = '' then begin
            PurchSetup.get;
            PurchSetup.TestField("Supplier Category Nos");
            NoSeries.InitSeries(PurchSetup."Supplier Category Nos", xRec."No. Series", 0D, "Category Code", "No. Series");
        end;
    end;
    var NoSeries: Codeunit NoSeriesManagement;
    PurchSetup: Record "Purchases & Payables Setup";
}

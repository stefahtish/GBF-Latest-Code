table 50184 "Supplier Sub Category2"
{
    fields
    {
        field(1; "Category Code"; Code[50])
        {
            DataClassification = ToBeClassified;
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
        field(6; "No. Requisitions"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Supplier Subcategory"=field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Code; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Category Code", Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    end;
    var NoSeries: Codeunit NoSeriesManagement;
    PurchSetup: Record "Purchases & Payables Setup";
}

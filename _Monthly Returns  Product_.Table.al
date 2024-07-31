table 50600 "Monthly Returns  Product"
{
    Caption = 'Monthly Returns  Product';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ApplicationNo; Code[20])
        {
            Caption = 'ApplicationNo';
            DataClassification = ToBeClassified;
        }
        field(2; Product; Text[100])
        {
            Caption = 'Product';
            DataClassification = ToBeClassified;
            TableRelation = "Dairy Produce Setup";
        }
        field(3; "Unit of Measure"; Code[50])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(6; "SubProduct"; Text[100])
        {
            Caption = 'Product';
            DataClassification = ToBeClassified;
            TableRelation = "Dairy Produce Setup" where(Heading=field(Product));
        }
        field(7; "Others Description"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(8; HasSubheadings; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Dairy Produce Setup" where(Heading=field(Product)));
        }
    }
    keys
    {
        key(PK; ApplicationNo, "Line No.")
        {
            Clustered = true;
            SumIndexFields = Quantity;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        GetNextLineNo();
    end;
    procedure GetNextLineNo()
    var
        ProdRec: Record "Monthly Returns  Product";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo:=0;
        ProdRec.Reset;
        ProdRec.SetRange(ApplicationNo, ApplicationNo);
        if ProdRec.FindLast then "Line No.":=ProdRec."Line No." + 1
        else
            "Line No.":=1;
    end;
}

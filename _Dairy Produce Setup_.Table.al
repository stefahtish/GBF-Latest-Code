table 50580 "Dairy Produce Setup"
{
    Caption = 'Compliance Dairy Produce Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Dairy Produce"; Code[100])
        {
            Caption = 'Dairy Produce';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Code[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit of measure"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(5; Type; Option)
        {
            OptionMembers = "", Heading, SubHeading;
            OptionCaption = ' ,Heading,SubHeading';
        }
        field(6; Heading; Code[100])
        {
            TableRelation = "Dairy Produce Setup" where(Type=filter(Heading));
            DataClassification = ToBeClassified;
        }
        field(7; HasSubheadings; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Dairy Produce Setup" where(Heading=field("Dairy Produce")));
        }
        field(8; Others; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Dairy Produce", Heading)
        {
            Clustered = true;
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
        ProductRec: Record "Dairy Produce Setup";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo:=0;
        if ProductRec.FindLast then "Line No.":=ProductRec."Line No." + 1
        else
            "Line No.":=1;
    end;
}

table 50652 "Perfomance Targets Lines"
{
    Caption = 'Perfomance Targets Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; TimeFrame; Code[20])
        {
            Caption = 'TimeFrame';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Annual  Target"; Decimal)
        {
            Caption = 'Annual  Target';
            DataClassification = ToBeClassified;
        }
        field(6; "Q1 Target"; Decimal)
        {
            Caption = 'Q1 Target';
            DataClassification = ToBeClassified;
        }
        field(7; "Q2 Target"; Decimal)
        {
            Caption = 'Q2 Target';
            DataClassification = ToBeClassified;
        }
        field(8; "Q3 Target"; Decimal)
        {
            Caption = 'Q3 Target';
            DataClassification = ToBeClassified;
        }
        field(9; "Q4 Target"; Decimal)
        {
            Caption = 'Q4 Target';
            DataClassification = ToBeClassified;
        }
        field(10; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Date of Completion"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.", TimeFrame)
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
    procedure GetNextLineNo(): Integer var
        TargetLine: Record "Perfomance Targets Lines";
    begin
        TargetLine.RESET;
        TargetLine.SETRANGE("Document No.", "Document No.");
        IF TargetLine.FINDLAST THEN EXIT(TargetLine."Line No." + 1)
        ELSE
            EXIT(1);
    end;
}

table 50604 "Applicant Penalty Logs"
{
    Caption = 'Applicant Penalty Logs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Cess Compounded"; Decimal)
        {
            Caption = 'Cess Compounded';
            DataClassification = ToBeClassified;
        }
        field(4; "Cess Penalty"; Decimal)
        {
            Caption = 'Cess Penalty';
            DataClassification = ToBeClassified;
        }
        field(5; "Levy Compounded"; Decimal)
        {
            Caption = 'Levy Compounded';
            DataClassification = ToBeClassified;
        }
        field(6; "Levy Penalty"; Decimal)
        {
            Caption = 'Levy Penalty';
            DataClassification = ToBeClassified;
        }
        field(7; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = ToBeClassified;
        }
        field(8; "Update Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Month; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Entry No.")
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
        LogRec: Record "Applicant Penalty Logs";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo:=0;
        LogRec.Reset;
        LogRec.SetRange("Document No.", "Document No.");
        if LogRec.FindLast then "Entry No.":=LogRec."Entry No." + 1
        else
            "Entry No.":=1;
    end;
}

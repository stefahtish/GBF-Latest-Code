table 50599 "Monthly Returns intake"
{
    Caption = 'Monthly Returns intake';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            TableRelation = "Monthly Return Intake Setup2";
        }
        field(3; Units; Text[50])
        {
            Caption = 'Units';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure" where(Products=const(True));
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("Unit Cost per litre");
            end;
        }
        field(5; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "", Heading, SubHeading;
            OptionCaption = ' ,Heading,SubHeading';
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Cost(Ksh.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Source; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unit Cost per litre"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Cost(Ksh.)":="Unit Cost per litre" * Quantity;
            end;
        }
        field(10; Others; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Application No", "Line No.")
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
        IntakeRec: Record "Monthly Returns intake";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo:=0;
        IntakeRec.Reset;
        IntakeRec.SetRange("Application No", "Application No");
        if IntakeRec.FindLast then "Line No.":=IntakeRec."Line No." + 1
        else
            "Line No.":=1;
    end;
}

table 50605 "Monthly Return Intake Setup2"
{
    Caption = 'Monthly Return Intake Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            OptionMembers = "", Heading, SubHeading;
            OptionCaption = ' ,Heading,SubHeading';
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; units; Text[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(6; Others; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Description, "Line No.")
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
        IntakeRec: Record "Monthly Return Intake Setup2";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo:=0;
        IntakeRec.Reset;
        if IntakeRec.FindLast then "Line No.":=IntakeRec."Line No." + 1
        else
            "Line No.":=1;
    end;
}

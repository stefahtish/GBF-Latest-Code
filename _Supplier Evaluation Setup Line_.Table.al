table 50436 "Supplier Evaluation Setup Line"
{
    Caption = 'Supplier Evaluation Setup Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Blob)
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(4; "Maximum Score"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                lvRec: Record "Supplier Evaluation Setup Line";
                TotalPer: Decimal;
            begin
                Clear(TotalPer);
                lvRec.Reset();
                lvRec.SetRange(Code, Code);
                if lvRec.FindSet()then repeat TotalPer:=TotalPer + lvRec."Maximum Score";
                    until lvRec.Next() = 0;
                if(TotalPer + "Maximum Score") > 100 then Error('The sum of maximum scores cannot be greater than 100 for this setup');
            end;
        }
        field(5; "Score Type"; Option)
        {
            OptionMembers = " ", "Yes/No", "Criteria";
            OptionCaption = ' ,Yes/No,Criteria';
        }
        field(6; Passmark; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                lvRec: Record "Supplier Evaluation Setup Line";
            begin
                lvRec.Reset();
                lvRec.SetRange(Code, Code);
                lvRec.SetRange("Line No.", "Line No.");
                if lvRec.FindSet()then begin
                    if Passmark > lvRec."Maximum Score" then Error('Passmark cannot be greater than the maximum score');
                end;
            end;
        }
        field(7; "Criteria Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Score Criteria";enum "Supplier Evaluation Score Types")
        {
        }
    }
    keys
    {
        key(PK; Code, "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description, "Maximum Score")
        {
        }
    }
    trigger OnInsert()
    var
        SetupRec: Record "Supplier Evaluation SetUp";
    begin
        if SetupRec.Get(Code)then begin
            "Score Criteria":=SetupRec."Score Criteria";
        end;
    end;
}

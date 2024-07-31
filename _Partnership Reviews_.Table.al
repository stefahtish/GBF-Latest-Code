table 50638 "Partnership Reviews"
{
    Caption = 'Partnership Reviews';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[30])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; Frequency; Option)
        {
            Caption = 'Frequency';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Quarterly,Annually';
            OptionMembers = "", Quarterly, Annually;
        }
        field(5; Recommendation; Text[2048])
        {
            Caption = 'Recommendation';
            DataClassification = ToBeClassified;
        }
        field(6; "Reviewed By"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code, "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "Line No." = 0 then "Line No.":=GetNextLineNo();
    end;
    local procedure GetNextLineNo(): Integer var
        Review: Record "Partnership Reviews";
    begin
        Review.RESET;
        Review.SETRANGE(Code, Code);
        IF Review.FINDLAST THEN EXIT(Review."Line No." + 1)
        ELSE
            EXIT(1);
    end;
}

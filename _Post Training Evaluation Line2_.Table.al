table 50711 "Post Training Evaluation Line2"
{
    Caption = 'Post Training Evaluation Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Skills; Text[2048])
        {
            Caption = 'Skills';
            DataClassification = ToBeClassified;
        }
        field(4; Ratings; Decimal)
        {
            Caption = 'Ratings';
            DataClassification = ToBeClassified;
        }
        field(5; "Knowledge Explanation"; Text[2048])
        {
            Caption = 'Knowledge Explanation';
            DataClassification = ToBeClassified;
        }
        field(6; Recommendations; Text[2048])
        {
            Caption = 'Recommendations';
            DataClassification = ToBeClassified;
        }
        field(7; "Improvement Explanation"; Text[2048])
        {
            Caption = 'Improvement Explanation';
            DataClassification = ToBeClassified;
        }
        field(8; "Employee Affected Skills"; Text[2048])
        {
            Caption = 'Employee Affected Skills';
            DataClassification = ToBeClassified;
        }
        field(9; "Training Recommendation"; Text[2048])
        {
            Caption = 'Training Recommendation';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Line No.":=GetNextLineNo();
    end;
    procedure GetNextLineNo(): Integer var
        TrainingLines: Record "Post Training Evaluation Lines";
    begin
        TrainingLines.RESET;
        TrainingLines.SETRANGE("No.", "No.");
        IF TrainingLines.FINDLAST THEN EXIT(TrainingLines."Line No." + 1)
        ELSE
            EXIT(1);
    end;
}

table 50345 "Appraisal Decision"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Person"; Option)
        {
            OptionMembers = HOD, MD;
            OptionCaption = 'HOD,MD';
        }
        field(4; "Appraisee Performance"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Merit Recommendation"; Option)
        {
            OptionCaption = 'Recommended,Not Recommended';
            OptionMembers = Recommended, "Not Recommended";
        }
        field(6; "Training Action"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Job Rotation"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Transfer"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "MD Decision"; Text[1000])
        {
            Caption = 'Managing Directors Decision';
        }
    }
    keys
    {
        key(Key1; "Appraisal No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}

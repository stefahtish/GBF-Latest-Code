table 50726 "Interview Entries"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Oral,Practical';
            OptionMembers = " ", Oral, Practical;
        }
        field(5; "Oral Interview"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Oral Interview (Board)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Classroom Interview"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Practical; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Score; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
            DataClassification = ToBeClassified;
        }
        field(11; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Need Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Interviewer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Pass Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Application No.", "Line No.")
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

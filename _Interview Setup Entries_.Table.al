table 50725 "Interview Setup Entries"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(Oral))"Interview Setup".Code where(Type=const(Oral))
            ELSE IF(Type=CONST(Practical))"Interview Setup".Code where(Type=const(Practical));

            trigger OnValidate()
            var
                InterviewSetup: Record "Interview Setup";
            begin
                if InterviewSetup.Get(Code)then begin
                    Description:=InterviewSetup.Description;
                    "Oral Interview":=InterviewSetup."Oral Interview";
                    "Oral Interview (Board)":=InterviewSetup."Oral Interview (Board)";
                    "Classroom Interview":=InterviewSetup."Classroom Interview";
                    Practical:=InterviewSetup.Practical;
                    "Pass Mark":=InterviewSetup."Pass Mark";
                end;
            end;
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
        field(10; "Pass Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
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

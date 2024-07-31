table 50678 ProjectEvaluationPlan
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project No."; Code[50])
        {
            NotBlank = false;
        }
        field(3; EvaluationCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Content; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unit of Measure"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Score; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; MyField)
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

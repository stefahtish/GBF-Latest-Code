table 50343 "Appraisal Trainings"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Training Areas"; Text[1000])
        {
        }
        field(4; "Training Solutions"; Text[1000])
        {
        }
        field(5; "Action Taken By"; TEXT[100])
        {
        }
        field(6; "Action Type"; Option)
        {
            OptionMembers = Training, "Non Training";
            OptionCaption = 'Training,Non Training';
        }
        field(7; "Action Location"; Text[50])
        {
        }
        field(8; "Job Rotation"; Boolean)
        {
        }
        field(9; Coaching; Boolean)
        {
        }
        field(10; Counselling; Boolean)
        {
        }
        field(11; Transfer; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Appraisal No", "Line No")
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

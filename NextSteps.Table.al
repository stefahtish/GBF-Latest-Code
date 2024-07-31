table 50693 NextSteps
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project No."; Code[50])
        {
        }
        field(2; "Line"; Integer)
        {
            autoincrement = true;
        }
        field(3; "Next steps"; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "Project No.", line)
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

table 50695 KeyIssuesCurrent
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
        field(3; "Current Key Issues"; Text[50])
        {
            caption = 'Key Issues Currently Affecting The System';
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

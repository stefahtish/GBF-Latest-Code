table 50682 ProjectSetupType
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "No."; Code[50])
        {
            NotBlank = false;
        }
        field(3; "Project Type"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Description"; code[40])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Project Type")
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

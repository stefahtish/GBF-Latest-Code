table 50728 "Contract Change Entries"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date-Time Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Change Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Extension, Termination, Suspension;
        }
        field(7; "Change No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Contract No."; Code[20])
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

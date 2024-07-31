table 50339 "Knowledge Required"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[10])
        {
        }
        field(3; Description; Text[2048])
        {
        }
        field(4; "No. of Contacts"; Integer)
        {
        }
        field(5; "Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Header, Objective;
            OptionCaption = ' ,Header,Objective';
        }
        field(6; "Knowledge Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Code, "Line No")
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

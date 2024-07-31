table 50326 "Key Job responsibilities New"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[80])
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "No. of Contacts"; Integer)
        {
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

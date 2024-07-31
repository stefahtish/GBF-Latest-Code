table 50738 "Account Restrictions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Userid; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Gl Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; Userid, "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    // Add changes to field groups here
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

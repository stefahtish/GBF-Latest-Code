table 50713 "Surrender Docs Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Mandatory; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document Name")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        IntRecord();
    end;
    procedure IntRecord()
    var
        ISDocs: Record "Surrender Docs Setup";
    begin
        if not("Primary Key" = 0)then exit;
        ISDocs.Reset();
        ISDocs.SetCurrentKey("Primary Key");
        if ISDocs.FindLast()then "Primary Key":=ISDocs."Primary Key" + 1000
        else
            "Primary Key":=1000;
    end;
}

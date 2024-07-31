table 50623 "License Notes Setup"
{
    Caption = 'License Notes Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; Note; Text[1000])
        {
            Caption = 'Note';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Primary Key", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
        Lic: Record "License Notes Setup";
    begin
        if Lic.FindLast()then "Line No.":=Lic."Line No." + 1
        else
            "Line No.":=1;
    end;
}

table 50441 "Vendor Evaluation Setup Line"
{
    Caption = 'Vendor Evaluation Setup Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Blob)
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(4; "Maximum Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Score Type"; Option)
        {
            OptionMembers = " ", "Yes/No", "Criteria";
            OptionCaption = ' ,Yes/No,Criteria';
        }
        field(6; HeaderCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Headercode, Code, "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description, "Maximum Score")
        {
        }
    }
}

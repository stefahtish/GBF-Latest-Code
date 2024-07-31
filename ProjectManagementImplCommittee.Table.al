table 50666 ProjectManagementImplCommittee
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Full Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Contact; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone Number';
            ExtendedDatatype = PhoneNo;
        // eddie trigger OnValidate()
        // var
        //  eddie    Char: DotNet Char;
        //     i: Integer;
        // begin
        //     for i := 1 to StrLen("contact") do
        //         if Char.IsLetter("contact"[i]) then
        //             FieldError("contact", PhoneNoCannotContainLettersErr);
        // end;
        }
        field(4; "Email Address"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(5; "Project No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "ID Number"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Institution/Organization Name"; text[60])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Project No.", "ID Number") //full name
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "id number", "Full Name")
        {
        }
    }
    var myInt: Integer;
    PhoneNoCannotContainLettersErr: label 'Phone Number can not contain A letter';
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

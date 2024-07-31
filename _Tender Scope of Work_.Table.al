table 50437 "Tender Scope of Work"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tender No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Scope Type"; Option)
        {
            Caption = 'Scope Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Scope Item,Main Heading,Main Heading End,Sub-Heading,Sub-Heading End';
            OptionMembers = "Scope Parameter", "Objective Heading", "Objective Heading End", "Sub-Heading", "Sub-Heading End";
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; Indentation; Integer)
        {
            Caption = 'Indentation';
            DataClassification = ToBeClassified;
        }
        field(6; Indent; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Scope, Specifications, Addendum;
        }
    }
    keys
    {
        key(PK; "Tender No.", "Line No.")
        {
            Clustered = true;
        }
    }
}

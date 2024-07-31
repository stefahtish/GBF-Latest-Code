table 50607 "Issued Applicant License"
{
    Caption = 'Issued Applicant Licenses';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            Caption = 'Applicant No.';
            DataClassification = ToBeClassified;
        }
        field(2; "License/Permit"; Option)
        {
            Caption = 'License/Permit';
            OptionMembers = License, Permit;
            DataClassification = ToBeClassified;
        }
        field(3; Category; Code[100])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "License No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Permit No.';
        }
        field(6; "Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Outlet; Code[100])
        {
            Caption = 'Name of Premise';
            DataClassification = ToBeClassified;
        }
        field(8; "Expiry date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Applicant No.", "License/Permit", "License No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Applicant No.", Outlet, "License No.")
        {
        }
    }
}

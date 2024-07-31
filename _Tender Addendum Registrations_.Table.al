table 50448 "Tender Addendum Registrations"
{
    Caption = 'Tender Addendum Registrations';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tender No."; Code[20])
        {
            Caption = 'Tender No.';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request" where("Process Type"=const(Tender), "Tender Type"=const(Open));
        }
        field(2; "Prospect No."; Code[20])
        {
            Caption = 'Prospect No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Name of the Firm"; Text[100])
        {
            Caption = 'Name of the Firm';
            DataClassification = ToBeClassified;
        }
        field(4; "Postal Address"; Code[100])
        {
            Caption = 'Postal Address';
            DataClassification = ToBeClassified;
        }
        field(5; "Telephone Contacts"; Code[20])
        {
            Caption = 'Telephone Contacts';
            DataClassification = ToBeClassified;
        }
        field(6; "Company Email"; Text[100])
        {
            Caption = 'Company Email';
            DataClassification = ToBeClassified;
        }
        field(7; "Contact Person"; Text[100])
        {
            Caption = 'Contact Person';
            DataClassification = ToBeClassified;
        }
        field(8; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Tender No.", "Prospect No.", "Line No.")
        {
            Clustered = true;
        }
    }
}

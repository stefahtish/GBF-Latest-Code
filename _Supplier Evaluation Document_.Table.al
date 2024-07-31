table 50435 "Supplier Evaluation Document"
{
    Caption = 'Supplier Evaluation Document';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Quote No."; Code[50])
        {
            Caption = 'Quote No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Code"; Code[50])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Name"; Text[250])
        {
            Caption = 'Document Name';
            DataClassification = ToBeClassified;
        }
        field(4; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            DataClassification = ToBeClassified;
        }
        field(5; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = ToBeClassified;
        }
        field(6; "Supplier Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Tender No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Remarks; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Stage; Option)
        {
            OptionMembers = , " ", Preliminary, Technical, Prices, Archived, Opening;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Quote No.", "Document Code")
        {
            Clustered = true;
        }
    }
}

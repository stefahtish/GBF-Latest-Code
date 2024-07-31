table 50449 "Supplier Document Links"
{
    Caption = 'Prospective Supplier Document Links';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Process Type"; Option)
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI, "FA Disposal Quote";
        }
        field(3; Link; Text[2048])
        {
            Caption = 'URL';
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(4; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Record ID"; RecordId)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Tender No"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "No.", "Tender No", LineNo)
        {
            Clustered = true;
        }
    }
}

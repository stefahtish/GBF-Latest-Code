table 50447 "Procurement Document Links"
{
    Caption = 'Procurement Document Links';
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
            Caption = 'Link';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Record ID"; RecordId)
        {
            DataClassification = ToBeClassified;
        }
        field(6; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Process Type", Link)
        {
            Clustered = true;
        }
    }
}

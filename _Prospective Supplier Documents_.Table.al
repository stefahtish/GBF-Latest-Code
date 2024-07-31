table 50445 "Prospective Supplier Documents"
{
    Caption = 'Prospective Supplier Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Prospect No."; Code[20])
        {
            Caption = 'Prospect No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Code"; Code[50])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Document Setup".Code where("Mandatory on Registration"=const(true));

            trigger OnValidate()
            var
                Docs: Record "Procurement Document Setup";
            begin
                Docs.Reset();
                Docs.SetRange(Code, "Document Code");
                if Docs.FindFirst()then Description:=Docs.Description;
            end;
        }
        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Process Type"; Option)
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI, "FA Disposal Quote";
        }
        field(5; Link; Text[2048])
        {
            Caption = 'Link';
            DataClassification = ToBeClassified;
        }
        field(6; "Record ID"; RecordId)
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
        key(PK; "Prospect No.", "Document Code")
        {
            Clustered = true;
        }
    }
}

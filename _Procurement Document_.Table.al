table 50164 "Procurement Document"
{
    Caption = 'Procurement Document-Per Method';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI;
        }
        field(2; "Document Code"; Code[1000])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Document Setup".Code;

            trigger OnValidate()
            var
                Docs: Record "Procurement Document Setup";
            begin
                Docs.Reset();
                Docs.SetRange(Code, "Document Code");
                if Docs.FindFirst()then Description:=Docs.Description;
            end;
        }
        field(3; Description; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            DataClassification = ToBeClassified;
        }
        field(7; "RFQ No."; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Supplier No."; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Vendor No."; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(10; URL; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Type, "Document Code", "Line No.")
        {
            Clustered = true;
        }
    }
}

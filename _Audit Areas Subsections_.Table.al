table 50527 "Audit Areas Subsections"
{
    Caption = 'Audit Areas Subsections';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Audit plan area"; Text[100])
        {
            Caption = 'Area';
            DataClassification = ToBeClassified;
        }
        field(3; Subsection; Text[100])
        {
            Caption = 'Subsection';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Audit plan area", Subsection)
        {
            Clustered = true;
        }
    }
}

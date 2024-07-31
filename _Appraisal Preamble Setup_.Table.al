table 50412 "Appraisal Preamble Setup"
{
    Caption = 'Appraisal Preamble Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SNo."; Integer)
        {
            Caption = 'SNo.';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "SNo.")
        {
            Clustered = true;
        }
    }
}

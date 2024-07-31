table 50526 "Audit Areas"
{
    Caption = 'Audit Areas';
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
    }
    keys
    {
        key(PK; "No.", "Audit plan area")
        {
            Clustered = true;
        }
    }
}

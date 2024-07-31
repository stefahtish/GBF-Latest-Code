table 50609 "Sample Disposal Lines"
{
    Caption = 'Sample Disposal Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Sample Name"; Text[100])
        {
            Caption = 'Sample Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Sample Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
}

table 50582 "Reasons For Confiscation Setup"
{
    Caption = 'Reasons For Confiscation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}

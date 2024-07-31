table 50569 "Sample Analysis Line"
{
    Caption = 'Test conducted to sample';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Analysis No."; Code[20])
        {
            Caption = 'Analysis No.';
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Targeted tests"));
        }
        field(3; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Analysis No.", Code)
        {
            Clustered = true;
        }
    }
}

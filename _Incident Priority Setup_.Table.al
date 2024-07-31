table 50525 "Incident Priority Setup"
{
    Caption = 'Incident Priority Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[500])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Priority; Option)
        {
            Caption = 'Priority';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Low, Medium, High;
            OptionCaption = ' ,Low,Medium,High';
        }
        field(4; "Mitigation Plan"; Text[1000])
        {
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

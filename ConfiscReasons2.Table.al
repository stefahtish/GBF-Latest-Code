table 50586 ConfiscReasons2
{
    Caption = 'ConfiscReasons';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Code[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code, Description)
        {
            Clustered = true;
        }
    }
}

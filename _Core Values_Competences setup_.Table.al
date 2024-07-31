table 50303 "Core Values/Competences setup"
{
    Caption = 'Core Values/Competences setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SNo."; Integer)
        {
            Caption = 'SNo.';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Max Weight"; Decimal)
        {
            Caption = 'Max Weight';
            DataClassification = ToBeClassified;
        }
        field(4; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Managerial Core Values/Competence", "Core Values/Competence";
        }
        field(5; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "SNo.", Type)
        {
            Clustered = true;
        }
    }
}

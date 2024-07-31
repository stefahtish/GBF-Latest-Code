table 50201 "Vehicle CC Setup"
{
    Caption = 'Vehicle CC Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; From; Decimal)
        {
            Caption = 'From';
            DataClassification = ToBeClassified;
        }
        field(2; To; Decimal)
        {
            Caption = 'To';
            DataClassification = ToBeClassified;
        }
        field(3; "Rate per Kilometer"; Decimal)
        {
            Caption = 'Rate per Kilometer';
            DataClassification = ToBeClassified;
        }
        field(4; Code; Text[100])
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
    fieldgroups
    {
        fieldgroup(DropDown; Code, "Rate per Kilometer")
        {
        }
    }
}

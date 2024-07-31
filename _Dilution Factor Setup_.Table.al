table 50594 "Dilution Factor Setup"
{
    Caption = 'Dilution Factor Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Number; Decimal)
        {
            Caption = 'Number';
            DataClassification = ToBeClassified;
        }
        field(3; Exponential; Decimal)
        {
            Caption = 'Exponential';
            DataClassification = ToBeClassified;
        }
        field(4; "Type"; Option)
        {
            OptionMembers = Dilution, Specifications;
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

table 50554 "Forex Dealers"
{
    Caption = 'Forex Dealers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Bank; Code[20])
        {
            Caption = 'Bank';
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            var
                Banks: record Banks;
            begin
                if Banks.get(Bank)then "Bank Swift Code":=Banks."Swift Code";
            end;
        }
        field(4; "Maturity Period"; DateFormula)
        {
            Caption = 'Maturity Period';
            DataClassification = ToBeClassified;
        }
        field(5; "Bank Swift Code"; Code[20])
        {
            Caption = 'Bank Swift Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}

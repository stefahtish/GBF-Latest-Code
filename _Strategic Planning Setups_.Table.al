table 50653 "Strategic Planning Setups"
{
    Caption = 'Strategic Planning Setups';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Perfomance Contract Nos"; Code[20])
        {
            Caption = 'Perfomance Contract Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Perfomance Actuals Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}

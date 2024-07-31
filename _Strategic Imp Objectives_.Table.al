table 50312 "Strategic Imp Objectives"
{
    Caption = 'Strategic Implementation Objectives';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Max Score"; Decimal)
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

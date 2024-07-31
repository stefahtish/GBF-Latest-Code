table 50579 "Sample Condition Options"
{
    Caption = 'Sample Condition Options';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Condition; Code[100])
        {
            Caption = 'Condition';
            DataClassification = ToBeClassified;
        }
        field(2; Option; Code[100])
        {
            Caption = 'Option';
            DataClassification = ToBeClassified;
        }
        field(3; "Batch Number needed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Expiry date needed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Explanation Needed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Has Manufacturing Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Condition, Option)
        {
            Clustered = true;
        }
    }
}

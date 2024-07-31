table 50581 "Type of Vehicle Setup"
{
    Caption = 'Type of Vehicle Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Descriptiom; Code[100])
        {
            Caption = 'Descriptiom';
            DataClassification = ToBeClassified;
        }
        field(3; Vehicle; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "MotorCycle"; Boolean)
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

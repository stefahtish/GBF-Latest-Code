table 50411 "Rating Scale"
{
    Caption = 'Rating Scale';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Achievement Performance Target"; Text[100])
        {
            Caption = 'Achievement of Performance Targets';
            DataClassification = ToBeClassified;
        }
        field(2; "Rating Scale Description"; Text[50])
        {
            Caption = 'Rating Scale Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Rating Scale Range"; Text[50])
        {
            Caption = 'Rating Scale Range';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Achievement Performance Target", "Rating Scale Description")
        {
            Clustered = true;
        }
    }
}

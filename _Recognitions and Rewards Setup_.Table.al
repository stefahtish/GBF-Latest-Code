table 50718 "Recognitions and Rewards Setup"
{
    Caption = 'Recognitions and Rewards Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Category;Enum "Recognition & Rewards Category")
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Appraisal No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Reward Type"; Option)
        {
            OptionMembers = " ", Monetary, "Non_Monetary";
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

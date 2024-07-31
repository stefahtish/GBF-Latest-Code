table 50556 "Interaction Timelines"
{
    Caption = 'Interaction Deadlines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Interaction Type";Enum "CRM Interaction Types")
        {
            Caption = 'Interaction Type';
            DataClassification = ToBeClassified;
        }
        field(2; Timeline; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "First Notification"; DateFormula)
        {
            Caption = 'First Notification';
            DataClassification = ToBeClassified;
        }
        field(4; "Second Notification"; DateFormula)
        {
            Caption = 'Second Notification';
            DataClassification = ToBeClassified;
        }
        field(5; "Subsequent Notifications"; DateFormula)
        {
            Caption = 'Subsequent Notifications';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Interaction Type")
        {
            Clustered = true;
        }
    }
}

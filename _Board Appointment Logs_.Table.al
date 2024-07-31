table 50408 "Board Appointment Logs"
{
    Caption = 'Board Appointment Logs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(3; Tenure; DateFormula)
        {
            Caption = 'Tenure';
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Appointment Date"; Date)
        {
            Caption = 'Appointment Date';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code, "Start Date")
        {
            Clustered = true;
        }
    }
}

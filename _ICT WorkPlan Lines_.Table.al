table 50194 "ICT WorkPlan Lines"
{
    Caption = 'ICT WorkPlan Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Reporting Indicator"; Text[500])
        {
            Caption = 'Reporting Indicator';
            DataClassification = ToBeClassified;
        }
        field(4; "Means of Verification"; Text[500])
        {
            Caption = 'Means of Verification';
            DataClassification = ToBeClassified;
        }
        field(5; "Sub Activity"; Text[500])
        {
            Caption = 'Sub Activity';
            DataClassification = ToBeClassified;
        }
        field(6; "Time Frame"; Code[20])
        {
            Caption = 'Time Frame';
            DataClassification = ToBeClassified;
        }
        field(7; "Time Plan"; Code[20])
        {
            Caption = 'Time Plan';
            DataClassification = ToBeClassified;
        }
        field(8; "Estimated Budget"; Decimal)
        {
            Caption = 'Estimated Budget';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Time Frame", "Line No.")
        {
            Clustered = true;
        }
    }
}

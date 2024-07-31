table 50333 "Applicant Hobbies2"
{
    Caption = 'Applicant Hobbies';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Hobbies; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Line No")
        {
            Clustered = true;
        }
    }
}

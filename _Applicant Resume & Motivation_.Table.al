table 50346 "Applicant Resume & Motivation"
{
    Caption = 'Applicant Resume and Motivation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Applicant No"; Code[20])
        {
            Caption = 'Applicant No';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Resume, Motivation;
            DataClassification = ToBeClassified;
        }
        field(4; Resume; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(5; Motivation; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
    }
    keys
    {
        key(PK; "Applicant No", "Line No")
        {
            Clustered = true;
        }
    }
}

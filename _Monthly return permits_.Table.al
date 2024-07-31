table 50615 "Monthly return permits"
{
    Caption = 'Monthly return permits';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Applicant No"; Code[20])
        {
            Caption = 'Applicant No';
            DataClassification = ToBeClassified;
        }
        field(3; "Permit No."; Text[50])
        {
            Caption = 'Permit No.';
            DataClassification = ToBeClassified;
            TableRelation = "Issued Applicant License"."License No." where("Applicant No."=field("Applicant No"));

            trigger OnValidate()
            var
                Licenses: Record "Issued Applicant License";
            begin
                Licenses.Reset();
                Licenses.SetRange("License No.", "Permit No.");
                if Licenses.FindFirst()then Outlet:=Licenses.Outlet;
            end;
        }
        field(4; Outlet; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Applicant No", "Permit No.")
        {
            Clustered = true;
        }
    }
}

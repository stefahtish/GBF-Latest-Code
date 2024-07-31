table 50320 "Applicant Prof Membership"
{
    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Applicant No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Professional Body"; Code[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Professional Memberships";

            trigger OnValidate()
            var
                profmemb: record "Professional Memberships";
            begin
                if profmemb.Get("Professional Body")then Description:=profmemb.Description;
            end;
        }
        field(3; MembershipNo; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Need Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Description; Code[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Applicant No.", "Need Code", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

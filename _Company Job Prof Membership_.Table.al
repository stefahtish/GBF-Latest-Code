table 50319 "Company Job Prof Membership"
{
    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; Name; Code[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Professional Memberships";

            trigger OnValidate()
            var
                ProfMemb: Record "Professional Memberships";
            begin
                if ProfMemb.Get(Name)then Description:=ProfMemb.Description;
            end;
        }
        field(4; Description; Code[500])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job ID", Name, "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

table 50475 "Claim Assignment Movement"
{
    fields
    {
        field(1; "Case Handler"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Case No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Datetime Received"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Datetime Cleared"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Case Receipt Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Assigned,Escalated';
            OptionMembers = Assigned, Escalated;
        }
        field(6; "Case Clearance Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Closed,Escalated';
            OptionMembers = Closed, Escalated;
        }
    }
    keys
    {
        key(Key1; "Case Handler", "Case No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

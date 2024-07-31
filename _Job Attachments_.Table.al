table 50278 "Job Attachments"
{
    fields
    {
        field(1; "Job ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Attachment; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Attachments;

            trigger OnValidate()
            begin
                if Attachments.Get(Attachment)then Description:=Attachments.Description;
            end;
        }
        field(3; Description; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job ID", Attachment)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Attachments: Record Attachments;
}

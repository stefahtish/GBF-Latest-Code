table 50279 Attachments
{
    DrillDownPageID = "Attachments Setup";
    LookupPageID = "Attachments Setup";

    fields
    {
        field(1; Attachment; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Attachment)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

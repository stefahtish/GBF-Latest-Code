page 50526 "Job Attachments"
{
    PageType = ListPart;
    SourceTable = "Job Attachments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Attachment; Rec.Attachment)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Job ID"; Rec."Job ID")
                {
                    Caption = 'Application No.';
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
    }
}

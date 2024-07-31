page 50527 "Attachments Setup"
{
    PageType = List;
    SourceTable = Attachments;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Attachment; Rec.Attachment)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
    actions
    {
    }
}

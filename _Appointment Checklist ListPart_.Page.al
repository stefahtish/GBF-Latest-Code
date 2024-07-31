page 50423 "Appointment Checklist ListPart"
{
    PageType = ListPart;
    SourceTable = "Appointment Checklist";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Signed; Rec.Signed)
                {
                }
            }
        }
    }
    actions
    {
    }
}

page 50439 "Base Calender Changes New"
{
    PageType = List;
    SourceTable = "Base Calender Change Custom";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    Visible = false;
                }
                field("Recurring System"; Rec."Recurring System")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Day; Rec.Day)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Nonworking; Rec.Nonworking)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(RecordLinks; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }
    actions
    {
    }
}

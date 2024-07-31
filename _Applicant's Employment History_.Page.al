page 50494 "Applicant's Employment History"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Applicants Employment History";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To"; Rec."To")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Application No"; Rec."Application No")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
    }
}

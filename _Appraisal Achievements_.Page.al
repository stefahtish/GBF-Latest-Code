page 51301 "Appraisal Achievements"
{
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                }
                field(Person; Rec.Person)
                {
                    Visible = false;
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ShowCaption = false;
                    Visible = true;
                }
            }
        }
    }
    actions
    {
    }
}

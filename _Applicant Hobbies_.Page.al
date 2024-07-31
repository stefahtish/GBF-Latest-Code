page 50479 "Applicant Hobbies"
{
    AutoSplitKey = true;
    PageType = Listpart;
    SourceTable = "Applicant Hobbies2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Hobbies; Rec.Hobbies)
                {
                }
                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field("Line No"; Rec."Line No")
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

page 50532 "Oral Interview (Board)"
{
    PageType = ListPart;
    SourceTable = "Oral Interview (Board)";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Applicant No"; Rec."Applicant No")
                {
                    Visible = false;
                }
                field("Need Code"; Rec."Need Code")
                {
                    Visible = false;
                }
                field("Panel Member"; Rec."Panel Member")
                {
                }
                field("Test Parameter"; Rec."Test Parameter")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }
    actions
    {
    }
}

page 50543 "Classroom Interview"
{
    PageType = ListPart;
    SourceTable = "Classroom Interview";
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
                }
                field("Panel Member"; Rec."Panel Member")
                {
                }
                field("Test Parameters"; Rec."Test Parameters")
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

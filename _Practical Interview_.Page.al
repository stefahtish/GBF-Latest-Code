page 50533 "Practical Interview"
{
    PageType = ListPart;
    SourceTable = "Practical Interview";
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
                field("Test Parameter"; Rec."Test Parameter2")
                {
                    Caption = 'Test Parameter';
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

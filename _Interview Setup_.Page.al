page 50541 "Interview Setup"
{
    PageType = List;
    SourceTable = "Interview Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Oral Interview"; Rec."Oral Interview")
                {
                }
                field("Oral Interview (Board)"; Rec."Oral Interview (Board)")
                {
                }
                field("Classroom Interview"; Rec."Classroom Interview")
                {
                }
                field(Practical; Rec.Practical)
                {
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
    }
}

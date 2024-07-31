page 50474 "Recruitment Stages"
{
    PageType = List;
    SourceTable = "Recruitment Stages";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Recruitement Stage"; Rec."Recruitement Stage")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Application; Rec.Application)
                {
                }
                field(Interview; Rec.Interview)
                {
                }
            }
        }
    }
    actions
    {
    }
}

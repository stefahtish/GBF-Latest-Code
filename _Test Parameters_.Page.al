page 50476 "Test Parameters"
{
    PageType = List;
    SourceTable = "Test Parameters";
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
                field("Pass Mark"; Rec."Pass Mark")
                {
                }
                field("Max Marks"; Rec."Max Marks")
                {
                }
            }
        }
    }
    actions
    {
    }
}

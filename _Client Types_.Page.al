page 50875 "Client Types"
{
    PageType = List;
    SourceTable = "Client Types";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                }
                field(Company; Rec.Company)
                {
                }
            }
        }
    }
    actions
    {
    }
}

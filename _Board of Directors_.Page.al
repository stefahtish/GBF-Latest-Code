page 50440 "Board of Directors"
{
    CardPageID = "Board of Director";
    PageType = List;
    SourceTable = "Board of Director";
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
                field(SurName; Rec.SurName)
                {
                }
                field("Other Names"; Rec."Other Names")
                {
                }
                field("Phone No"; Rec."Phone No")
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
            }
        }
    }
    actions
    {
    }
}

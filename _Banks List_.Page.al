page 50665 "Banks List"
{
    PageType = List;
    SourceTable = Banks;
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
                field(Name; Rec.Name)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(City; Rec.City)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
            }
        }
    }
    actions
    {
    }
}

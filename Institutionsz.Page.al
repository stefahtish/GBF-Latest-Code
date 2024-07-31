page 50640 Institutionsz
{
    PageType = List;
    SourceTable = Institutions;
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
                field(Email; Rec.Email)
                {
                }
            }
        }
    }
    actions
    {
    }
}

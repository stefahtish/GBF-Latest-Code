page 50498 Banks
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
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Branches)
            {
                Image = Warehouse;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Bank Branches";
                RunPageLink = "Bank Code" = field(Code);
            }
        }
    }
}

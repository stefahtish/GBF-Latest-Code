pageextension 50133 CountryExtension extends "Countries/Regions"
{
    layout
    {
        addafter(Name)
        {
            field(Local; Rec.Local)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action(Counties)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "County List";
                RunPageLink = Country = field(Code);
                ApplicationArea = All;
            }
        }
    }
}

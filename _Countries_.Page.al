page 51159 "Countries"
{
    Caption = 'Country List';
    PageType = List;
    SourceTable = "Country/Region";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Local; Rec.Local)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Counties)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "County List";
                RunPageLink = Country = field(Code);
            }
        }
    }
}

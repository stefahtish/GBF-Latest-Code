page 51122 "Criteria Categories"
{
    Caption = 'Criteria Categories';
    PageType = List;
    SourceTable = "Criteria Category";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Perfomance SubCriteria")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Perfomance SubCriteria List";
                RunPageLink = "Criteria Code" = field(Code);
            }
        }
    }
}

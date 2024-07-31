page 51242 "Audit categories"
{
    Caption = 'Audit categories';
    PageType = List;
    SourceTable = "Audit Categories";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Subcategories")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Audit subcategories";
                RunPageLink = Category = field(Category);
            }
        }
    }
}

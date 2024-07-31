page 51101 "Product subcategories"
{
    Caption = 'Product subcategories';
    PageType = List;
    SourceTable = "Product SubCategories";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SubCategory; Rec.SubCategory)
                {
                    ToolTip = 'Specifies the value of the SubCategory field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

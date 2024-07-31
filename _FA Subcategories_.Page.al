page 50217 "FA Subcategories"
{
    Caption = 'FA Subcategories';
    PageType = List;
    SourceTable = "FA Subcategories";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Subcategory; Rec.Subcategory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

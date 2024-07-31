page 51102 Products
{
    Caption = 'Products';
    PageType = List;
    SourceTable = "Laboratory Products";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Product; Rec.Product)
                {
                    ToolTip = 'Specifies the value of the Product field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the SubCategory field';
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field';
                    ApplicationArea = All;
                }
                // field("Lab Section"; "Lab Section")
                // {
                // }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Possible Tests")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Possible Tests";
                RunPageLink = Product = field(Product);
            }
        }
    }
}

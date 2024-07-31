page 50869 "Supplier Responses"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Prosp Tender Lines Card";
    SourceTable = "Prospective Tender Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Response No"; Rec."Response No")
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    ApplicationArea = All;
                }
            }
            systempart(Control53; Links)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
}

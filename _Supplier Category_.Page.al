page 50165 "Supplier Category"
{
    Caption = 'Supply Codes';
    PageType = List;
    SourceTable = "Supplier Category";
    SourceTableView = WHERE(Type = FILTER(Supplier));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    Caption = 'Code';
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. Prequalified"; Rec."No. Prequalified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Year Filter"; Rec."Year Filter")
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
            action("Supply SubCodes")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Supplier SubCategories";
                RunPageLink = "Category Code" = field("Category Code");
            }
        }
    }
}

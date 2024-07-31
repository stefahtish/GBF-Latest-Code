page 50166 "LPO Category"
{
    PageType = List;
    SourceTable = "Supplier Category";
    SourceTableView = WHERE(Type = FILTER(LPO));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("No. Prequalified"; Rec."No. Prequalified")
                {
                }
                field("Year Filter"; Rec."Year Filter")
                {
                }
            }
        }
    }
    actions
    {
    }
}

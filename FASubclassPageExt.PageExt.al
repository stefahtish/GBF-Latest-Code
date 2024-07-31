pageextension 50144 FASubclassPageExt extends "FA Subclasses"
{
    layout
    {
        addafter("FA Class Code")
        {
            field("No of Depreciation Years"; Rec."No of Depreciation Years")
            {
                ApplicationArea = all;
            }
            field("Has subcategories"; Rec."Has subcategories")
            {
                Caption = 'Furniture';
                ApplicationArea = all;
            }
            field(Computer; Rec.Computer)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action(Subcategories)
            {
                Visible = Rec."Has subcategories";
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "FA Subcategories";
                RunPageLink = Class = field("FA Class Code"), Subclass = field(Code);
                ApplicationArea = All;
            }
        }
    }
}

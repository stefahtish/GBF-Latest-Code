page 50227 "FA Disposal Lines"
{
    Caption = 'FA Disposal Lines';
    PageType = ListPart;
    SourceTable = "FA Disposal Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Fixed Asset Register No."; Rec."Fixed Asset Register No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Acquisition Date"; Rec."Acquisition Date")
                {
                    ApplicationArea = All;
                }
                field(Condition; Rec.Condition)
                {
                    ApplicationArea = All;
                }
                field("Original Purchase Value"; Rec."Original Purchase Value")
                {
                    ApplicationArea = All;
                }
                field("Estimated Current Value"; Rec."Estimated Current Value")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Bids; Rec.Bids)
                {
                    ApplicationArea = All;
                    Caption = 'Submitted Bids';
                }
                field("Highest Bid"; Rec."Highest Bid")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
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
            action("View Bids")
            {
                Image = CalculateDiscount;
                RunObject = page "FA Disposal Quote Bids";
                RunPageLink = "FA Disposal Doc No." = field("Document No."), No = field("FA No."), "Line No" = field("Line No."), "Bid Submitted" = const(true);
                ApplicationArea = All;
            }
        }
    }
}

page 51280 "Annual Asset  Disposal"
{
    Caption = 'Annual Asset  Disposal';
    PageType = ListPart;
    SourceTable = "Annual Asset Disposal Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                }
                field("FA Name"; Rec."FA Name")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Acquisition Date"; Rec."Acquisition Date")
                {
                    Caption = 'Date of purchase';
                }
                field("Original Purchase Value"; Rec."Original Purchase Value")
                {
                    Caption = 'Purchase Price';
                }
                field("Estimated Current Value"; Rec."Estimated Current Value")
                {
                }
                field("Reasons for disposal"; Rec."Reasons for disposal")
                {
                    Caption = 'Justification for disposal';
                    ApplicationArea = All;
                }
                field("Item Life span"; Rec."Item Life span")
                {
                }
                field("Disposal Method Code"; Rec."Disposal Method Code")
                {
                }
                field("Disposal Method"; Rec."Disposal Method")
                {
                    Enabled = false;
                }
                field("Cost of managing disposal"; Rec."Cost of managing disposal")
                {
                }
                field("Disposal Initiation"; Rec."Disposal Initiation")
                {
                }
                field("Bid Documents Prepared"; Rec."Bid Documents Prepared")
                {
                }
                field("Invitation To Tender"; Rec."Invitation To Tender")
                {
                }
                field("Bid Opening"; Rec."Bid Opening")
                {
                }
                field("Accounting officer Award"; Rec."Accounting officer Award")
                {
                }
                field("Notification of Award"; Rec."Notification of Award")
                {
                }
                field("Contract Signed"; Rec."Contract Signed")
                {
                }
                field("Disposal Completed"; Rec."Disposal Completed")
                {
                }
                field("Notice to PPRA"; Rec."Notice to PPRA")
                {
                }
            }
        }
    }
}

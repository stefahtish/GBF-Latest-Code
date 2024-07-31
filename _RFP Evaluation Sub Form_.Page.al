page 50809 "RFP Evaluation Sub Form"
{
    PageType = ListPart;
    SourceTable = "RFP Evaluation Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No"; Rec."Vendor No")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = false;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Visible = false;
                }
                field(Suggested; Rec.Suggested)
                {
                    Editable = false;
                }
                field(Awarded; Rec.Awarded)
                {
                    Caption = 'Award';
                }
                field("Quote No"; Rec."Quote No")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }
    actions
    {
    }
}

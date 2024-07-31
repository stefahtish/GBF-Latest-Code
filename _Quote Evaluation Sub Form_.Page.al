page 50765 "Quote Evaluation Sub Form"
{
    PageType = ListPart;
    SourceTable = "Quote Evaluation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No"; Rec."Vendor No")
                {
                    // Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    Editable = false;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Editable = false;
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
                field(Comments; Rec.Comments)
                {
                }
                field("Quote No"; Rec."Quote No")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
    }
}

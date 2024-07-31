page 50784 "EOI Evaluation Sub Form"
{
    PageType = ListPart;
    SourceTable = "EOI Evaluation Line";
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
                field("Quote No"; Rec."Quote No")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                    Visible = false;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    Visible = false;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Visible = false;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Visible = false;
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
            }
        }
    }
    actions
    {
    }
}

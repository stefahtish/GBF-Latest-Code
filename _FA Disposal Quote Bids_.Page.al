page 50237 "FA Disposal Quote Bids"
{
    Caption = 'FA Disposal Quote Bids';
    PageType = List;
    SourceTable = "Procurement Request Lines";
    InsertAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field(Suggested; Rec.Suggested)
                {
                    Editable = false;
                }
                field(Awarded; Rec.Awarded)
                {
                }
            }
        }
    }
}

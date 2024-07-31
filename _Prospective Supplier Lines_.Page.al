page 50826 "Prospective Supplier Lines"
{
    Caption = 'Prospective Supplier Lines';
    PageType = ListPart;
    SourceTable = "Prospective Supplier Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Response No"; Rec."Response No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Type; Rec.Type)
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
                field(Specifications; Rec.Specifications)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Visible = PriceView;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Visible = PriceView;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        ProspectiveRec: Record "Prospective Suppliers";
        PriceView: Boolean;

    local procedure GetHeader()
    begin
        if ProspectiveRec.get(Rec."Response No") then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader();
        if ProspectiveRec."Supplier Status" = ProspectiveRec."Supplier Status"::New then
            PriceView := false
        else
            PriceView := true;
    end;
}

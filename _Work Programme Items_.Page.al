page 51331 "Work Programme Items"
{
    Caption = 'Items';
    PageType = ListPart;
    SourceTable = "Activity Work Programme Lines";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ApplicationArea = All;
                    Enabled = CheckIFapproved;
                    Editable = CheckIFapproved;
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ToolTip = 'Specifies the value of the Procurement Method field';
                    ApplicationArea = All;
                    Enabled = Rec."Purchase Type" = Rec."Purchase Type"::"Procurement Process";
                    Editable = CheckIFapproved;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Items;
    end;

    trigger OnAfterGetRecord()
    begin
        CheckStatus();
    end;

    local procedure CheckStatus()
    var
        ActivityWorkplan: Record "Activity Work Programme";
    begin
        If ActivityWorkplan.Get(Rec."No.") then
            if ActivityWorkplan.Status = ActivityWorkplan.status::Approved then
                CheckIFapproved := true
            else
                CheckIFapproved := false;
    END;

    Var
        CheckIFapproved: boolean;
}

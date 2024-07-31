page 50186 "Request for Quote & Order"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Internal Request Line";
    SourceTableView = WHERE("Header Status" = FILTER(Released), "RFQ Created" = CONST(false), "Document Type" = FILTER(Purchase), "Cleared For Rfq" = CONST(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
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
                field(Specifications; Rec.Specification2)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                field(Selected; Rec.Selected)
                {
                    Caption = 'Select';
                }
                field("Selected By"; Rec."Selected By")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(MakeQuote)
            {
                Caption = 'Make GPR From Selected';
                Image = CreatePutAway;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to create a GPR document from selected entries', false) = true then begin
                        ProcMgt.CreateRFQFromSelected;
                    end;
                end;
            }
        }
    }
    var
        ProcMgt: Codeunit "Procurement Management";
}

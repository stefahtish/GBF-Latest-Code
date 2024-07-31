page 50200 "Prosp Tender Lines Card"
{
    Caption = 'Prospective Tender Responses Card';
    PageType = Card;
    SourceTable = "Prospective Tender Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Response No"; Rec."Response No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part("Document Attachment Factbox"; "Prospective Supp ListPart")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Response No"), "Tender No" = field("Tender No.");
            }
            systempart(Links; Links)
            {
                Caption = 'Attachments';
            }
        }
    }
    actions
    {
        area(processing)
        {
            // action(Evaluate)
            // {
            //     Caption = 'Send for Evaluation';
            //     Image = SendConfirmation;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     begin
            //         if Confirm('Are you sure?', false) then
            //             ProcMgt.SendProspectiveSupplierForEval(Rec);
            //         CurrPage.Close();
            //     end;
            // }
        }
    }
    var
        ProcMgt: Codeunit "Procurement Management";
}

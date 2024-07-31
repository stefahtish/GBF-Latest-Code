page 50322 "Prospective Tender Card"
{
    Caption = 'Applications Card';
    PageType = Card;
    SourceTable = "Prospective Supplier Tender";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Caption = 'Tender/RFQ/RFP/EOI No';
                    ApplicationArea = All;
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(TenderOpeningDate; Rec.TenderOpeningDate)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(TenderClosingDate; Rec.TenderClosingDate)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
        area(FactBoxes)
        {
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

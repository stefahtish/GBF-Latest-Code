page 51145 "Licensing Requirements Card"
{
    Caption = 'Licensing Requirements Card';
    PageType = Card;
    SourceTable = "Licensing Required Documents";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Document; Rec.Document)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
        }
    }
    var
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
}

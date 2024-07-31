page 51144 "Licensing Required Documents"
{
    Caption = 'Required Documents';
    PageType = ListPart;
    CardPageId = "Licensing Requirements Card";
    SourceTable = "Licensing Required Documents";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Document; Rec.Document)
                {
                    ApplicationArea = All;
                }
                field(Attachments; Rec.Attachments)
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("UploadAttachments")
            {
                Caption = 'Attachments';

                action("Upload Document")
                {
                    Image = Attach;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
                action(Links)
                {
                    Image = Links;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecLinks: Record "Record Link";
                        DocLinks: page "Document Links";
                    begin
                        RecLinks.reset;
                        RecLinks.SetRange("Record ID", Rec.RecordId);
                        DocLinks.SetTableView(RecLinks);
                        DocLinks.Run();
                    end;
                }
            }
        }
    }
    var
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
}

pageextension 50122 PostedPurchaseInvoices extends "Posted Purchase Invoice"
{
    layout
    {
        modify("Vendor Invoice No.")
        {
            Visible = true;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        addafter("Vendor Invoice No.")
        {
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;
            }
            field("Delivery No."; Rec."Delivery No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addfirst(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
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
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    begin
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action("Preview Payments To S2B")
            {
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Caption = 'Preview Vendor Payments To S2B';

                trigger OnAction()
                var
                    GenerateS2B: report "Generate Vendor EFTFile";
                begin
                    Rec.Modify();
                    Commit();
                    Rec.SetRange("No.", Rec."No.");
                    GenerateS2B.SetTableView(Rec);
                    GenerateS2B.Run();
                end;
            }
        }
    }
    var //[RunOnClient]
        //eddie  DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        PurchHeader: Record "Purchase Header";
        Committment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
}

pageextension 50109 PurchaseInvoiceCardPageExt extends "Purchase Invoice"
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
        modify("Campaign No.")
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
        modify("Assigned User ID")
        {
            Visible = false;
        }
        addafter("Vendor Invoice No.")
        {
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Pin No"; Rec."Vendor Pin No")
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
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                UserSetUp: Record "User Setup";
            begin
                GLSetup.get;
                GLSetup.TestField("Allow Posting From");
                GLSetup.TestField("Allow Posting To");
                if (Rec."Posting Date" < GLSetup."Allow Posting From") then Error('Posting date should be within allowed ranges in GL setup');
                if (Rec."Posting Date" > GLSetup."Allow Posting To") then Error('Posting date should be within allowed ranges in GL setup');
                //Check on the user set up
                if UserSetUp.get(UserId) then begin
                    if UserSetUp."Allow Posting From" <> 0D then begin
                        if (Rec."Posting Date" > UserSetUp."Allow Posting To") then Error('Posting date should be within your allowed ranges in User setup');
                    end;
                    if UserSetUp."Allow Posting To" <> 0D then begin
                        if (Rec."Posting Date" > UserSetUp."Allow Posting To") then Error('Posting date should be within your allowed ranges in User setup');
                    end;
                end;
            end;
        }
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
                        //  FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
        }
    }
    var //[RunOnClient]
        //eddieDocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        PurchHeader: Record "Purchase Header";
        Committment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
}

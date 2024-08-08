pageextension 50108 PurchaseOrderCardPageExt extends "Purchase Order"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
        }

        modify("Buy-from Vendor No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                VendorRec: Record Vendor;
            begin
                VendorRec.Reset();
                VendorRec.SetFilter("Vendor Type", '%1', VendorRec."Vendor Type"::Vendor);
                if Page.RunModal(Page::"Vendor List", VendorRec) = Action::LookupOK then begin
                    Rec."Buy-from Vendor No." := VendorRec."No.";
                    Rec."Buy-from Vendor Name" := VendorRec.Name;
                    Rec."Buy-from Address" := VendorRec.Address;
                    Rec."Buy-from City" := VendorRec.City;
                    // Rec."Buy-from Contact" := VendorRec."Phone No.";
                    Rec."Buy-from Post Code" := VendorRec."Post Code";
                    Rec."Buy-from Country/Region Code" := VendorRec."Country/Region Code";
                    Rec."Buy-from County" := VendorRec.County;
                    Rec."Pay-to Vendor No." := VendorRec."No.";
                    Rec."Pay-to Name" := VendorRec.Name;
                    Rec."Pay-to Address" := VendorRec.Address;
                    Rec."Pay-to City" := VendorRec.City;
                    //   Rec."Pay-to Contact" := VendorRec."Phone No.";
                    Rec."Pay-to Post Code" := VendorRec."Post Code";
                    Rec."Pay-to County" := VendorRec.County;
                    Rec."Pay-to Country/Region Code" := VendorRec."Country/Region Code";
                    Rec."Vendor Posting Group" := VendorRec."Vendor Posting Group";
                    Rec."Gen. Bus. Posting Group" := VendorRec."Gen. Bus. Posting Group";
                    Rec."VAT Bus. Posting Group" := VendorRec."VAT Bus. Posting Group";
                end;
            end;
        }
        addlast(General)
        {
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;
            }
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
            }
            field("Procurement Method"; Rec."Procurement Method")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Tender/Quotation ref no"; Rec."Tender/Quotation ref no")
            {
                ApplicationArea = All;
            }
            field("Delivery No."; Rec."Delivery No.")
            {
                ApplicationArea = All;
            }
            field("Delivery Date"; Rec."Delivery Date")
            {
                ApplicationArea = All;
            }
            field(Acknowledged; Rec.Acknowledged)
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Sent for Inspection"; Rec."Sent for Inspection")
            {
                Enabled = false;
                ApplicationArea = All;
            }
        }
        addlast(factboxes)
        {
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
                PurchaseLine: Record "Purchase Line";
            begin
                Rec.TestField("Gen. Bus. Posting Group");
                Rec.TestField("VAT Bus. Posting Group");
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document No.", Rec."No.");
                If PurchaseLine.FindSet() then begin
                    PurchaseLine.TestField(Quantity);
                    PurchaseLine.TestField("Unit Cost");
                end;
            end;
        }
        addlast(processing)
        {
            action(Commit)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    //Committment.ReversePurchReqCommittment(Rec);
                end;
            }
            action("Send for Inspection")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = not Rec."Sent for Inspection";
                ApplicationArea = All;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField("Tender/Quotation ref no");
                    ProcManagement.SendOrderForInspection(Rec);
                end;
            }
            action("Send for Acknowledgement")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                // Visible = not "Sent for Inspection";
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ProcManagement.SendOrderForAcknowledgement(Rec);
                end;
            }
            action("Notify Asset admin")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ProcManagement.NotifyAssetsAdmin(Rec."No.");
                end;
            }
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
                        //    FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
        }
        addlast(Reporting)
        {
            action("Print LPO")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Commit();
                    PurchHeader.Reset();
                    PurchHeader.SetRange(PurchHeader."No.", Rec."No.");
                    if PurchHeader.FindFirst then Report.Run(Report::"Local Purchase Order", true, false, PurchHeader);
                    //Report.Run(Report::"Modified Purchases Order", true, false, PurchHeader);
                end;
            }
            action("Good Received Note")
            {
                ApplicationArea = All;
                Image = Report2;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                begin
                    PurchHeader.Reset();
                    PurchHeader.SetRange(PurchHeader."No.", Rec."No.");
                    if PurchHeader.FindFirst then Report.Run(Report::"Goods Received Note", true, false, PurchHeader);
                end;
            }
            action(Reports)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Caption = 'Inspection Report';
                Image = Report;

                trigger OnAction()
                begin
                    PurchaseHeaderRec.Reset();
                    PurchaseHeaderRec.SetFilter("No.", Rec."No.");
                    AcceptanceInspection.SetTableView(PurchaseHeaderRec);
                    AcceptanceInspection.Run();
                end;
            }
        }
    }
    var //[RunOnClient]
        //eddieDocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        ProcManagement: Codeunit "Procurement Management";
        FromFile: Text;
        PurchHeader: Record "Purchase Header";
        Committment: Codeunit Committment;
        SpecificationBigTxt: BigText;
        SpecificationTxt: Text;
        PurchaseHeaderRec: Record "Purchase Header";
        AcceptanceInspection: Report "Inspection & Acceptance Report";
}

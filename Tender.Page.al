page 50303 Tender
{
    Caption = 'Tender';
    PageType = Card;
    SourceTable = "Procurement Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Procurement type"; Rec."Procurement type")
                {
                    ApplicationArea = All;
                }
                field(TenderOpeningDate; Rec.TenderOpeningDate)
                {
                    ApplicationArea = All;
                }
                field(TenderClosingDate; Rec.TenderClosingDate)
                {
                    ApplicationArea = All;
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    ApplicationArea = All;
                }
            }
            part(TenderLines; "Tender Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Requisition No" = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Mandatory Requirements")
            {
                Promoted = true;
                ApplicationArea = all;
                RunObject = page "Tender Manadatory Requirements";
                RunPageLink = "Tender No" = field("No.");
            }
            action(Bidders)
            {
                Promoted = true;
                ApplicationArea = all;
                RunObject = page Bidders;
                RunPageLink = "Ref No." = field("No.");
            }
            group("Attachments")
            {
                action("Upload Tender Document")
                {
                    Visible = NewVisible;
                    Image = Attach;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                        // DocumentManagement.InsertProcurementLinks(Rec);
                    end;
                }
                action("Upload Tender Opening Document")
                {
                    Visible = Opening;
                    Image = Attach;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        //   FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action("Select Suppliers")
            {
                Visible = Opening;
                Caption = 'Select Suppliers';
                Image = SelectEntries;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Bidders Selection";
                RunPageLink = "Reference No." = FIELD("No.");

                trigger OnAction()
                begin
                    TestTheFields;
                end;
            }
            action("Send for opening")
            {
                Visible = NewVisible;
                ApplicationArea = all;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    OpeningCommitee: Record "Tender Committees";
                begin
                    OpeningCommitee.Reset();
                    OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Tender);
                    OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Opening);
                    OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                    OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                    if not OpeningCommitee.FindFirst() then Error('There is no approved opening tender committee for Tender %1', Rec."No.");
                    Rec.Status := Rec.Status::Opening;
                    Commit();
                    CurrPage.Close();
                end;
            }
            action(Links)
            {
                Image = SelectEntries;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "Procurement Documents Links";
                RunPageLink = "No." = FIELD("No."), "Process Type" = field("Process Type");
            }
            action("Print RFQ's")
            {
                Caption = 'Print Tender''s';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    TestTheFields;
                    SupplierSelect.Reset;
                    SupplierSelect.SetFilter(SupplierSelect."Reference No.", Rec."No.");
                    REPORT.Run(Report::Tender, true, false, SupplierSelect);
                end;
            }
            action("Terminate")
            {
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Rec.Terminated := true;
                    Rec.Status := Rec.Status::Terminated;
                    Rec."Termination Date" := Today;
                    Rec.Modify();
                    CurrPage.Close();
                end;
            }
            action("Suppliers under Evaluation")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                var
                    SupplierEval: Record "Supplier Evaluation Header";
                begin
                    TestTheFields;
                    SupplierEval.Reset;
                    SupplierEval.SetRange("Quote No", Rec."No.");
                    SupplierEvaluation.SetTableView(SupplierEval);
                    SupplierEvaluation.Run();
                end;
            }
            action("Prospective Suppliers")
            {
                Image = Print;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Prosp: Record "Prospective Supplier Tender";
                begin
                    TestTheFields;
                    Prosp.Reset;
                    Prosp.SetRange("Tender No.", Rec."No.");
                    Prospectives.SetTableView(Prosp);
                    Prospectives.Run();
                end;
            }
            action(Notify)
            {
                Visible = Opening;
                Caption = 'Notify Suppliers';
                Image = Email;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TestTheFields;
                    if Confirm('Are you sure you want to notify the selected suppliers via mail?', false) = true then
                        ProcurementManagement.NotifySuppliers(Rec."No.")
                    else
                        exit;
                end;
            }
            action("Send Suppliers for Evaluation")
            {
                Visible = Opening;
                Image = SelectEntries;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProcMgt: Codeunit "Procurement Management";
                    Prospectives: Record "Prospective Suppliers";
                    TendersApp: Record "Prospective Supplier Tender";
                    OpeningCommitee: Record "Tender Committees";
                begin
                    OpeningCommitee.Reset();
                    OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Tender);
                    OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                    OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                    OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                    if not OpeningCommitee.FindFirst() then Error('There is no approved evaluation tender committee for Tender %1', Rec."No.");
                    if Confirm('Are you sure you want to send this document for evaluation?', false) = true then begin
                        ProcMgt.SendProspectiveSuppliersForEvaluation(Rec."No.");
                    end;
                    CurrPage.Close();
                end;
            }
            action("Generate Quote Evaluation")
            {
                Visible = Opening;
                Caption = 'Generate Tender Evaluation';
                Image = CreatePutAway;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SupplierSelection: Record "Bidders Selection";
                    OpeningCommitee: Record "Tender Committees";
                begin
                    OpeningCommitee.Reset();
                    OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Tender);
                    OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                    OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                    OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                    if not OpeningCommitee.FindFirst() then Error('There is no approved evaluation tender committee for Tender %1', Rec."No.");
                    TestTheFields;
                    if Confirm('Are you sure you want to generate a Tender Evaluation?', false) = true then begin
                        SupplierSelection.Reset;
                        SupplierSelection.SetRange(SupplierSelection."Reference No.", Rec."No.");
                        //SupplierSelection.SetRange(SupplierSelection.Invited, true);
                        if SupplierSelection.Find('-') then begin
                            ProcurementManagement.CreaTenderEvaluation(Rec);
                        end;
                    end;
                    Commit;
                    CurrPage.Close;
                end;
            }
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
                    Visible = Rec."Submitted To Portal" = false;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = AddContacts;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Remove from Portal")
                {
                    Visible = Approved;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = RemoveContacts;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := false;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
        Rec."Tender Type" := Rec."Tender Type"::Open;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
        Rec."Tender Type" := Rec."Tender Type"::Open;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance;
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        SupplierSelect: Record "Supplier Selection";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Opening: Boolean;
        NewVisible: Boolean;
        Approved: Boolean;
        Prospectives: Report "Prospective Suppliers";
        SupplierEvaluation: Report "Suppliers Under Evaluation";

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
        Rec.TestField(Title);
    end;

    procedure SetControlAppearance()
    begin
        if (Rec.Status = Rec.Status::Opening) then
            Opening := true
        else
            Opening := false;
        if (Rec.Status = Rec.Status::New) then
            NewVisible := true
        else
            NewVisible := false;
        if (Rec.Status = Rec.Status::Approved) then
            Approved := true
        else
            Approved := false;
    end;
}

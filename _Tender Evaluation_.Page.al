page 50803 "Tender Evaluation"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Tender Evaluation Header";
    PromotedActionCategories = 'New,Process,Report,Approvals,Attachments';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Editable = false;

                field("Quote No"; Rec."Quote No")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Requisition No"; Rec."Requisition No")
                {
                }
                field("Tender Generated"; Rec."Tender Generated")
                {
                    Caption = 'LPO Generated';
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetControlApperance();
                    end;
                }
                group("Document Files")
                {
                    Caption = 'Document Files';

                    field(DocCount; DocCount)
                    {
                        Caption = 'Attached Documents';
                        Editable = false;
                    }
                }
            }
            part(Control7; "Tender Evaluation Sub Form")
            {
                //Editable = false;
                SubPageLink = "Quote No" = FIELD("Quote No");
            }
            part("Commitee Members"; "Committee Members")
            {
                SubPageLink = "Tender No." = field("Quote No"), "Committee Type" = field(Stage);
                Editable = not OpenApprovalEntriesExist;
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                Caption = 'Attachments';
            }
            systempart(Notes; Notes)
            {
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("Quote No");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Check)
            {
                Caption = 'Commit Entries';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    // Committment.CheckPurchQuoteCommittment(Rec);
                    // Committment.PurchQuoteCommittment(Rec, ErrorMsg);
                    // if ErrorMsg <> '' then
                    //     Error(ErrorMsg);
                end;
            }
            action("Order")
            {
                Caption = 'Create LPO';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                // Enabled = OpenApprovalEntriesExist;
                trigger OnAction()
                var
                    ExpectedDate: Date;
                    PurchSetup: Record "Purchases & Payables Setup";
                begin
                    if Confirm('Are you sure you want to create an LPO?', false) = true then begin
                        //create LPO after 14 days
                        PurchSetup.Get();
                        PurchSetup.TestField("LPO Creation Duration");
                        ExpectedDate := CalcDate(PurchSetup."LPO Creation Duration", Rec."Creation Date");
                        If ExpectedDate <= Today then begin
                            //ProcurementManagement.MakeOrderFromTender(Rec);
                            Commit;
                            QuoteLines.Reset;
                            QuoteLines.SetRange(QuoteLines."Quote No", Rec."Quote No");
                            QuoteLines.SetRange(QuoteLines.Awarded, true);
                            if QuoteLines.Find('-') then begin
                                QuoteLines.CalcSums(Quantity);
                                if QuoteLines.Quantity = 0 then Rec."Tender Generated" := true;
                            end;
                            CurrPage.Close();
                        end
                        else
                            Error('Purchase Order Can only be created after %1 days', PurchSetup."LPO Creation Duration");
                        ;
                    end
                    else
                        exit;
                end;
            }
            action("Tender Analysis")
            {
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SupplEvalHdr: Record "Prospective Tender Line";
                    ProcRequestLines: Record "Procurement Request Lines";
                    ProsTenderLine: Record "Prospective Tender Line";
                begin
                    if not Confirm('Are you sure you want to perform an analysis on this tender?', false) then
                        exit
                    else begin
                        SupplEvalHdr.Reset();
                        SupplEvalHdr.SetRange(SupplEvalHdr."Tender No.", Rec."Quote No");
                        SupplEvalHdr.SetRange("Amount Inclusive VAT", 0);
                        if SupplEvalHdr.FindFirst() then Error('All evaluators must submit their scores before analysis');
                        ProcRequestLines.Reset();
                        ProcRequestLines.SetRange("Requisition No", Rec."Quote No");
                        if ProcRequestLines.FindSet() then
                            repeat
                                ProsTenderLine.Reset();
                                ProsTenderLine.SetCurrentKey("Amount Inclusive VAT");
                                ProsTenderLine.SetRange(No, ProcRequestLines.No);
                                ProsTenderLine.SetRange("Tender No.", Rec."Quote No");
                                if ProsTenderLine.FindFirst() then begin
                                    ProsTenderLine.Awarded := true;
                                    ProsTenderLine.Suggested := true;
                                    ProsTenderLine.Modify();
                                end;
                            until ProcRequestLines.Next() = 0;
                        Message('Tender has been successfully awarded');
                    end;
                    /*CalcFields("Lowest Bid Price");
                        QuoteLines.Reset;
                        QuoteLines.SetRange(QuoteLines."Quote No", "Quote No");
                        QuoteLines.SetRange(Amount, "Lowest Bid Price");
                        if QuoteLines.FindFirst then begin
                            QuoteLines.Suggested := true;
                            QuoteLines.Modify;
                        end;

                        Commit;

                        Quote.Reset;
                        Quote.SetRange(Quote."Quote No", "Quote No");
                        if Quote.FindFirst then
                            REPORT.Run(51519815, true, false, Quote);*/
                end;
            }
            action("Submit")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    Rec.Status := Rec.Status::Approved;
                    Commit;
                    CurrPage.close;
                end;
            }
            // action("Send for Negotiation")
            // {
            //     Visible = Evaluation;
            //     Image = SendApprovalRequest;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     var
            //         OpeningCommitee: Record "Tender Committees";
            //     begin
            //         OpeningCommitee.Reset();
            //         OpeningCommitee.SetRange("Tender/Quotation No", "Quote No");
            //         OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Negotiation);
            //         OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
            //         if not OpeningCommitee.FindFirst() then
            //             Error('There is no approved negotiation tender committee for Tender %1', "Quote No");
            //         Stage := Stage::Negotiation;
            //         Commit;
            //         CurrPage.close;
            //     end;
            // }
            action("Send to Specialized Contract Committee")
            {
                Visible = Evaluation;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    OpeningCommitee: Record "Tender Committees";
                begin
                    OpeningCommitee.Reset();
                    OpeningCommitee.SetRange("Tender/Quotation No", Rec."Quote No");
                    OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Specialized);
                    OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                    if not OpeningCommitee.FindFirst() then Error('There is no approved specialized contract tender committee for Tender %1', Rec."Quote No");
                    Rec.Stage := Rec.Stage::Specialized;
                    Commit;
                    CurrPage.close;
                end;
            }
            action("Send for Approval")
            {
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if Approvalmgt.CheckTenderEvalWorkflowEnabled(Rec) then Approvalmgt.OnSendTenderEvalForApproval(Rec);
                    Commit;
                    CurrPage.Close;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = CanCancelApprovalForPayment;

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelTenderEvalApprovalRequest(rec);
                    CurrPage.Close();
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: page "Approval Entries";
                    Approvals: Record "Approval Entry";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Tender Evaluation Header");
                    Approvals.SetRange("Document No.", Rec."Quote No");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
        }
        area(Navigation)
        {
            action("Upload Document")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Upload documents for the record.';

                trigger OnAction()
                var
                begin
                    //   FromFile := DocumentManagement.UploadDocument(Rec."Quote No", CurrPage.Caption, Rec.RecordId);
                end;
            }
            action("Professional Opinion")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProfOpinion: Report "Professional Opinion";
                    Quote: Record "Procurement Request";
                begin
                    Commit;
                    Quote.Reset();
                    Quote.SetRange("No.", Rec."Quote No");
                    Report.Run(Report::"Professional Opinion", true, true, Quote);
                end;
            }
            action("Notify Shortlisted Suppliers")
            {
                ApplicationArea = All;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProcMan: Codeunit "Procurement Management";
                begin
                    if Confirm('Are you sure you want to notify award emails to suppliers via mail?', false) = true then begin
                        ProcMan.MailTenderQualified(Rec);
                    end
                    else
                        exit;
                end;
            }
        }
    }
    var
        Committment: Codeunit Committment;
        ProcurementManagement: Codeunit "Procurement Management";
        ErrorMsg: Text;
        Quote: Record "Tender Evaluation Header";
        QuoteLines: Record "Tender Evaluation Line";
        QuoteLines2: Record "Tender Evaluation Line";
        LeastAmount: Decimal;
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        DocCount: Integer;
        CompanyInfo: Record "Company Information";
        FilePath: Text;
        //eddie [RunOnClient]
        //DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Text002: Label 'File %1 uploaded successfully';
        OnlinePath: text;
        Evaluation: Boolean;

    trigger OnOpenPage()
    begin
        SetControlApperance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlApperance();
    end;

    local procedure SetControlApperance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Approved) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForPayment := App2.CanCancelApprovalForRecord(Rec.RecordId);
        if Rec.stage = Rec.stage::Evaluation then
            Evaluation := true
        else
            Evaluation := false;
        //Get Doc count
        //   DocCount := DocumentManagement.CountFiles(Rec."Quote No", CurrPage.Caption, '');
    end;
}

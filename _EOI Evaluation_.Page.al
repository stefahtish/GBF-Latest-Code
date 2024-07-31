page 50783 "EOI Evaluation"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "EOI Evaluation Header";
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
                field("EOI Generated"; Rec."EOI Generated")
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
                }
            }
            part(Control7; "EOI Evaluation Sub Form")
            {
                SubPageLink = "Quote No" = FIELD("Quote No");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Report)
            {
                action("EOI Analysis")
                {
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RecCount: Integer;
                        HalfRecord: Decimal;
                        LoopCounts: integer;
                        i: Integer;
                    begin
                        //
                        QuoteLines.Reset;
                        QuoteLines.SetRange(QuoteLines."Quote No", Rec."Quote No");
                        if QuoteLines.Find('-') then;
                        RecCount := QuoteLines.Count;
                        HalfRecord := RecCount / 2;
                        LoopCounts := Round(HalfRecord, 1);
                        i := 0;
                        QuoteLines.Reset;
                        QuoteLines.SetCurrentKey("Quote No", Amount);
                        QuoteLines.SetRange(QuoteLines."Quote No", Rec."Quote No");
                        QuoteLines.SetAscending(Amount, false);
                        if QuoteLines.Find('-') then begin
                            repeat
                                i += 1;
                                if i < LoopCounts then begin
                                    QuoteLines.Suggested := true;
                                    QuoteLines.Modify;
                                end
                                else begin
                                    QuoteLines.Suggested := false;
                                    QuoteLines.Modify;
                                end;
                            until QuoteLines.Next() = 0;
                        end;
                        Commit;
                        Quote.Reset;
                        Quote.SetRange(Quote."Quote No", Rec."Quote No");
                        if Quote.FindFirst then begin
                            EOIAnalysis.SetTableView(Quote);
                            EOIAnalysis.Run();
                        end;
                    end;
                }
            }
            group(Processing)
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to create an LPO?', false) = true then begin
                            ProcurementManagement.MakeOrderFromEOI(Rec);
                            Commit;
                            QuoteLines.Reset;
                            QuoteLines.SetRange(QuoteLines."Quote No", Rec."Quote No");
                            QuoteLines.SetRange(QuoteLines.Awarded, true);
                            if QuoteLines.Find('-') then begin
                                QuoteLines.CalcSums(Quantity);
                                if QuoteLines.Quantity = 0 then begin
                                    Rec."EOI Generated" := true;
                                end;
                            end;
                        end
                        else
                            exit;
                    end;
                }
                action("Send for Negotiation")
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
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::EOI);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Negotiation);
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved negotiation EOI committee for EOI %1', Rec."Quote No");
                        Rec.Stage := Rec.Stage::Negotiation;
                        Commit;
                        CurrPage.close;
                    end;
                }
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
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::EOI);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Specialized);
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved specialized contract EOI committee for EOI %1', Rec."Quote No");
                        Rec.Stage := Rec.Stage::Specialized;
                        Commit;
                        CurrPage.close;
                    end;
                }
            }
            group(Email)
            {
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
                            ProcMan.MailQualified(Rec);
                        end
                        else
                            exit;
                    end;
                }
                action("Send Regret Emails")
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
                        if Confirm('Are you sure you want to notify regret emails to suppliers via mail?', false) = true then begin
                            ProcMan.MailUnqualified(Rec);
                        end
                        else
                            exit;
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
            }
        }
    }
    var
        Committment: Codeunit Committment;
        ProcurementManagement: Codeunit "Procurement Management";
        ErrorMsg: Text;
        Quote: Record "EOI Evaluation Header";
        QuoteLines: Record "EOI Evaluation Line";
        QuoteLines2: Record "EOI Evaluation Line";
        LeastAmount: Decimal;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        DocCount: Integer;
        CompanyInfo: Record "Company Information";
        FilePath: Text;
        // [RunOnClient]
        //eddie DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Text002: Label 'File %1 uploaded successfully';
        OnlinePath: text;
        Evaluation: Boolean;
        EOIAnalysis: Report "EOI Analysis";

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
        //  DocCount := DocumentManagement.CountFiles(Rec."Quote No", CurrPage.Caption, '');
    end;
}

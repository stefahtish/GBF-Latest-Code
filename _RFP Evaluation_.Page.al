page 50808 "RFP Evaluation"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "RFP Evaluation Header";
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
                field("Tender Generated"; Rec."RFP Generated")
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
            part(Control7; "RFP Evaluation Sub Form")
            {
                SubPageLink = "Quote No" = FIELD("Quote No");
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

                trigger OnAction()
                var
                    RFPLines: Record "RFP Evaluation Line";
                    ProspectiveSuppliers: Record "Prospective Suppliers";
                    VendNo: Code[50];
                    RFPLines2: Record "RFP Evaluation Line";
                begin
                    if Confirm('Are you sure you want to create an LPO?', false) = true then begin
                        RFPLines.Reset();
                        RFPLines.SetRange("Quote No", Rec."Quote No");
                        RFPLines.SetRange(Suggested, true);
                        RFPLines.SetRange(Awarded, true);
                        //Get Vendor No.
                        if ProspectiveSuppliers.Get(RFPLines."Vendor No") then begin
                            if ProspectiveSuppliers."Vendor No" = '' then VendNo := ProspectiveSuppliers.CreateVendr(ProspectiveSuppliers);
                        end;
                        ProcurementManagement.MakeOrderFromRFP(Rec);
                        Commit;
                        //     QuoteLines.Reset;
                        //     QuoteLines.SetRange(QuoteLines."Quote No", "Quote No");
                        //     QuoteLines.SetRange(QuoteLines.Awarded, true);
                        //     if QuoteLines.Find('-') then begin
                        //         QuoteLines.CalcSums(Quantity);
                        //         if QuoteLines.Quantity = 0 then
                        //             "RFP Generated" := true;
                        //     end;
                    end
                    else
                        exit;
                end;
            }
            action("RFP Analysis")
            {
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // QuoteLines.Reset;
                    // QuoteLines.SetRange(QuoteLines."Quote No", "Quote No");
                    // if QuoteLines.Find('-') then begin
                    //     repeat
                    //         QuoteLines.CalcFields("Min Value");
                    //         if QuoteLines.Amount = QuoteLines."Min Value" then begin
                    //             QuoteLines.Suggested := true;
                    //         end else
                    //             QuoteLines.Suggested := false;
                    //     // QuoteLines.Modify;
                    //     until QuoteLines.Next = 0;
                    // end;
                    Commit;
                    Quote.Reset;
                    Quote.SetRange(Quote."Quote No", Rec."Quote No");
                    if Quote.FindFirst then begin
                        RFPReport.SetTableView(Quote);
                        RFPReport.Run();
                    end;
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
                    OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::RFP);
                    OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Negotiation);
                    OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                    if not OpeningCommitee.FindFirst() then Error('There is no approved negotiation RFP committee for RFP %1', Rec."Quote No");
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
                    if not OpeningCommitee.FindFirst() then Error('There is no approved specialized contract RFP committee for RFP %1', Rec."Quote No");
                    Rec.Stage := Rec.Stage::Specialized;
                    Commit;
                    CurrPage.close;
                end;
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
                            ProcMan.MailRFPQualified(Rec);
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
                            ProcMan.MailRFPUnqualified(Rec);
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
        Quote: Record "RFP Evaluation Header";
        QuoteLines: Record "RFP Evaluation Line";
        QuoteLines2: Record "RFP Evaluation Line";
        LeastAmount: Decimal;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        DocCount: Integer;
        CompanyInfo: Record "Company Information";
        FilePath: Text;
        //[RunOnClient]
        ///DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Text002: Label 'File %1 uploaded successfully';
        OnlinePath: text;
        Evaluation: Boolean;
        RFPReport: Report "RFP Analysis";

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
        // DocCount := DocumentManagement.CountFiles(Rec."Quote No", CurrPage.Caption, '');
    end;
}

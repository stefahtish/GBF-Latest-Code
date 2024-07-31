page 50764 "Quote Evaluation"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Quote Evaluation Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Quote No"; Rec."Quote No")
                {
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    Editable = false;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    Editable = false;
                }
                field("Quote Generated"; Rec."Quote Generated")
                {
                    Caption = 'LPO Generated';
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    Editable = true;
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    Editable = true;
                }
                // field("Submitted To Portal"; "Submitted To Portal")
                // {
                //     Enabled = false;
                // }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Award Comment"; Rec."Award Comment")
                {
                    MultiLine = true;
                }
                field("Legal Aspects"; Rec."Legal Aspects")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(Control7; "Quote Evaluation Sub Form")
            {
                SubPageLink = "Quote No" = field("Quote No");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Portal Controls")
            {
                visible = false;

                action("Submit To Portal")
                {
                    //Enabled = Status = Status::Approved;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = AddContacts;

                    trigger OnAction()
                    begin
                        Rec.TestField("Quotation Deadline");
                        Rec.TestField("Expected Closing Time");
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Remove from Portal")
                {
                    Enabled = Rec."Submitted To Portal";
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = RemoveContacts;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := false;
                            Rec.Modify();
                        end;
                    end;
                }
            }
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
                    Committment.CheckPurchQuoteCommittment(Rec);
                    Committment.PurchQuoteCommittment(Rec, ErrorMsg);
                    if ErrorMsg <> '' then Error(ErrorMsg);
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
                begin
                    if Confirm('Are you sure you want to create an LPO?', false) = true then begin
                        ProcurementManagement.MakeOrderFromQuote(Rec);
                        Commit;
                    end
                    else
                        exit;
                    CurrPage.Close();
                end;
            }
            action("Quotation Analysis")
            {
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    QuoteLines.Reset;
                    QuoteLines.SetRange(QuoteLines."Quote No", Rec."Quote No");
                    if QuoteLines.Find('-') then begin
                        repeat
                            QuoteLines.CalcFields("Min Value");
                            if QuoteLines.Amount = QuoteLines."Min Value" then begin
                                QuoteLines.Suggested := true;
                                QuoteLines.Modify;
                            end
                            else
                                QuoteLines.Suggested := false;
                            QuoteLines.Modify;
                        until QuoteLines.Next = 0;
                    end;
                    Commit;
                    Quote.Reset;
                    Quote.SetRange(Quote."Quote No", Rec."Quote No");
                    if Quote.FindFirst then begin
                        RFQAnalysis.SetTableView(Quote);
                        RFQAnalysis.Run();
                    end;
                    ;
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
                    OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Quotation);
                    OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Negotiation);
                    OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                    if not OpeningCommitee.FindFirst() then Error('There is no approved negotiation quotation committee for Quote %1', Rec."Quote No");
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
                    OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Quotation);
                    OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Specialized);
                    OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                    if not OpeningCommitee.FindFirst() then Error('There is no approved specialized contract quotation committee for Quote %1', Rec."Quote No");
                    Rec.Stage := Rec.Stage::Specialized;
                    Commit;
                    CurrPage.close;
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
                        ProcMan.MailRFQQualified(Rec);
                    end
                    else
                        exit;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlApperance();
    end;

    var
        Committment: Codeunit Committment;
        ProcurementManagement: Codeunit "Procurement Management";
        ErrorMsg: Text;
        Quote: Record "Quote Evaluation Header";
        QuoteLines: Record "Quote Evaluation";
        QuoteLines2: Record "Quote Evaluation";
        LeastAmount: Decimal;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        DocCount: Integer;
        CompanyInfo: Record "Company Information";
        FilePath: Text;
        // [RunOnClient]
        // DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Text002: Label 'File %1 uploaded successfully';
        OnlinePath: text;
        Evaluation: Boolean;
        RFQAnalysis: Report "RFQ Analysis";

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

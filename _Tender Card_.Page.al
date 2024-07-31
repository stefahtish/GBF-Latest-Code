page 50801 "Tender Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks,Links';
    SourceTable = "Procurement Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                    Editable = Rec.Status = Rec.Status::New;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    Editable = Rec.Status = Rec.Status::New;
                    ApplicationArea = all;
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = Rec.Status = Rec.Status::New;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = Rec.Status = Rec.Status::New;
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Category; Rec.Category)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Editable = Rec.Status = Rec.Status::New;
                    ApplicationArea = all;
                }
                field("Process Type"; Rec."Process Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    ApplicationArea = All;
                }
                field("Opening Venue"; Rec."Opening Venue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opening Venue field.';
                }
                field("Submission Method"; Rec."Submission Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submission Method field.';
                }
                field("Procurement Methods"; Rec."Procurement Methods")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Methods field.';
                }
                field("Eligible  bidders"; Rec."Eligible  bidders")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Eligible  bidders field.';

                    trigger OnValidate()
                    begin
                        If Rec."Eligible  bidders" = Rec."Eligible  bidders"::AGPO then
                            Isvisible := true
                        else
                            Isvisible := false;
                    end;
                }
                group("")
                {
                    Visible = Isvisible;

                    field(AGPO; Rec.AGPO)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the AGPO field.';
                    }
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Year field.';
                }
                group(New)
                {
                    ShowCaption = false;
                    Visible = NewVisible;

                    field("Quotation Deadline"; Rec."Quotation Deadline")
                    {
                        Editable = Rec.Status = Rec.Status::New;
                        ApplicationArea = all;
                    }
                    field("Expected Closing Time"; Rec."Expected Closing Time")
                    {
                        Editable = Rec.Status = Rec.Status::New;
                        ApplicationArea = all;
                    }
                }
                group(Opening)
                {
                    ShowCaption = false;
                    Visible = Opening;

                    field("Committee Submission Date"; Rec."Committee Submission Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Committee Submission Time"; Rec."Committee Submission Time")
                    {
                        ApplicationArea = all;
                    }
                }
                group(Termination)
                {
                    Visible = false;

                    field("Termination Date"; Rec."Termination Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Termination Code"; Rec."Termination Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Termination Reason"; Rec."Termination Reason")
                    {
                        ApplicationArea = all;
                        Enabled = false;
                    }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Tender Type"; Rec."Tender Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
            }
            part(Control13; "Procurement Documents Sub Form")
            {
                Editable = Rec.Status = Rec.Status::New;
                ApplicationArea = all;
                SubPageLink = "Quote No" = FIELD("No.");
            }
            part(Control12; "Procurement Request Lines")
            {
                Editable = Rec.Status = Rec.Status::New;
                ApplicationArea = all;
                SubPageLink = "Requisition No" = FIELD("No.");
            }
            part(Control7; "Tender Evaluation Sub Form")
            {
                //Editable = false;
                SubPageLink = "Quote No" = FIELD("No.");
            }
            part("Tender Scope of Work"; "Tender Scope of Work")
            {
                ApplicationArea = all;
                SubPageLink = "Tender No." = FIELD("No."), Type = const(Scope);
            }
            part("Tender Addendum"; "Tender Addendum")
            {
                ApplicationArea = all;
                SubPageLink = "Tender No." = FIELD("No."), Type = const(Addendum);
                visible = false;
            }
            part(Committee; "Opening Committee Members")
            {
                ApplicationArea = all;
                Visible = Opening;
                SubPageLink = "Tender No." = field("No.");
            }
            part(Addendum; "Addendum Registration")
            {
                Visible = false;
                ApplicationArea = all;
                SubPageLink = "Tender No." = field("No.");
            }
            group("Addendum1")
            {
                Caption = 'Addendum';

                field(Addendum2; Rec.Addendum)
                {
                    Caption = 'Addendum';
                    ToolTip = 'Specifies the value of the Addendum field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control53; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50415), "No." = FIELD("No."), "No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
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
                        //  FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
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
                        OnlinePortal: Codeunit "Online Portal Services";
                    begin
                        //  FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action("Select Suppliers")
            {
                Visible = Rec.Stage = Rec.Stage::Opening;
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
                Visible = (Rec."Submitted To Portal" = true) AND (Rec.Status = Rec.Status::New);
                ApplicationArea = all;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    OpeningCommitee: Record "Tender Committees";
                begin
                    if not Confirm('Are you sure you want to send this tender for opening?', false) then
                        exit
                    else begin
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Tender);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Opening);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved opening tender committee for Tender %1', Rec."No.");
                        Rec.Status := Rec.Status::Opening;
                        Rec.Stage := Rec.Stage::Opening;
                        Rec.Modify();
                        CurrPage.Close();
                    end;
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
                RunPageLink = "No." = FIELD("No.");
            }
            action(Suppliers)
            {
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Prospective Applicants Tenders";
                RunPageLink = "Tender No." = field("No.");
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
                Visible = Rec.Stage = Rec.Stage::Opening;
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
                    if Confirm('Are you sure you want to send this document for preliminary evaluation?', false) = true then begin
                        ProcMgt.SendProspectiveSuppliersForEvaluation(Rec."No.");
                        Rec.Stage := Rec.Stage::Periliminary;
                        Rec.Modify();
                    end;
                    //CurrPage.Close();
                end;
            }
            action("Generate Quote Evaluation")
            {
                Visible = (Rec.Stage = Rec.Stage::Periliminary) AND (Rec."Preliminary Analyzed" = true);
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
                        SupplierSelection.SetRange(SupplierSelection.Invited, true);
                        if SupplierSelection.Find('-') then begin
                            ProcurementManagement.CreaTenderEvaluation(Rec);
                        end;
                    end;
                    Rec.Stage := Rec.Stage::Technical;
                    Rec.Modify();
                end;
            }
            action("Analyze Preliminary")
            {
                ApplicationArea = All;
                Image = AnalysisView;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec.Stage = Rec.Stage::Periliminary) AND (Rec."Preliminary Analyzed" = false);

                trigger OnAction()
                var
                    EvalHeader: Record "Supplier Evaluation Header";
                    SupplEvalHeader: Record "Supplier Evaluation Header";
                    SupplEvalHeader2: Record "Supplier Evaluation Header";
                    ProspSupplier: Record "Bidders Selection";
                begin
                    if not Confirm('Are you sure you want to perform the preliminary analysis for this tender?', false) then
                        exit
                    else begin
                        SupplEvalHeader.Reset();
                        SupplEvalHeader.SetRange(Stage, SupplEvalHeader.Stage::Preliminary);
                        SupplEvalHeader.SetRange("Quote No", Rec."No.");
                        SupplEvalHeader.SetRange(Processed, false);
                        if SupplEvalHeader.FindFirst() then Error('All evaluators must submit preliminary results before proceeding');
                        ProspSupplier.Reset();
                        ProspSupplier.SetRange("Reference No.", Rec."No.");
                        if ProspSupplier.FindSet() then
                            repeat
                                EvalHeader.Reset();
                                EvalHeader.SetRange("Quote No", Rec."No.");
                                EvalHeader.SetRange(Stage, EvalHeader.Stage::Archived);
                                EvalHeader.SetRange("Supplier Code", ProspSupplier.Supplier);
                                if EvalHeader.FindFirst() then begin
                                    SupplEvalHeader2.Reset();
                                    SupplEvalHeader2.SetRange("Quote No", Rec."No.");
                                    SupplEvalHeader2.SetRange("Supplier Code", ProspSupplier.Supplier);
                                    if SupplEvalHeader2.FindSet() then
                                        repeat
                                            SupplEvalHeader2.Stage := SupplEvalHeader2.Stage::Archived;
                                            SupplEvalHeader2.Modify();
                                        until SupplEvalHeader2.Next() = 0;
                                    ProspSupplier."Passed Preliminary" := false;
                                    ProspSupplier.Modify();
                                end
                                else begin
                                    ProspSupplier."Passed Preliminary" := true;
                                    ProspSupplier.Modify();
                                end;
                            until ProspSupplier.Next() = 0;
                        Rec."Preliminary Analyzed" := true;
                        Rec.Modify();
                        Message('Tender has been successfully analyzed.');
                    end;
                end;
            }
            action("Analyze Technical")
            {
                Visible = Rec.Stage = Rec.Stage::Technical;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;

                trigger OnAction()
                var
                    SuppEvalHeader: Record "Supplier Evaluation Header";
                    SuppEvalHeader2: Record "Supplier Evaluation Header";
                    TenderCommittees: Record "Commitee Member";
                    CommitteeCount: Integer;
                    AverageMark: Decimal;
                    SupplierEvalScore: Record "Supplier Evaluation Score";
                    ProspectiveSupplier: Record "Prospective Tender Line";
                    TotalScore: Decimal;
                    PassMark: Decimal;
                    EvalSetup: Record "Supplier Evaluation SetUp";
                    TenderEvaluationLines: Record "Tender Evaluation Line";
                    ProspSuppliers: Record "Prospective Suppliers";
                    SuppName: Text;
                begin
                    if not Confirm('Are you sure you want to perform the technical analysis for this document?', false) then
                        exit
                    else begin
                        Clear(PassMark);
                        Clear(CommitteeCount);
                        EvalSetup.Reset();
                        EvalSetup.SetRange("Procurement Ref No.", Rec."No.");
                        if EvalSetup.FindFirst() then begin
                            EvalSetup.CalcFields("Total PassMark");
                            PassMark := EvalSetup."Total PassMark";
                        end;
                        SuppEvalHeader.Reset();
                        SuppEvalHeader.SetRange(Stage, SuppEvalHeader.Stage::Technical);
                        SuppEvalHeader.SetRange(Submitted, false);
                        SuppEvalHeader.SetRange("Quote No", Rec."No.");
                        if SuppEvalHeader.FindFirst() then Error('All evaluators must submit their scores before performing technical analysis.');
                        TenderCommittees.Reset();
                        TenderCommittees.SetRange("Tender No.", Rec."No.");
                        TenderCommittees.SetRange("Committee Type", TenderCommittees."Committee Type"::Evaluation);
                        CommitteeCount := TenderCommittees.Count();
                        ProspectiveSupplier.Reset();
                        ProspectiveSupplier.SetRange("Tender No.", Rec."No.");
                        if ProspectiveSupplier.FindSet() then
                            repeat
                                Clear(AverageMark);
                                Clear(TotalScore);
                                SupplierEvalScore.Reset();
                                SupplierEvalScore.SetRange("Tender No.", Rec."No.");
                                SupplierEvalScore.SetFilter("Supplier Code", '%1', ProspectiveSupplier."Response No");
                                if SupplierEvalScore.FindSet() then begin
                                    repeat
                                        SupplierEvalScore.CalcFields("Total Score");
                                        TotalScore := TotalScore + SupplierEvalScore."Total Score";
                                    until SupplierEvalScore.Next() = 0;
                                    AverageMark := TotalScore / CommitteeCount;
                                    Clear(SuppName);
                                    ProspSuppliers.Reset();
                                    ProspSuppliers.SetRange("No.", ProspectiveSupplier."Response No");
                                    if ProspSuppliers.FindFirst() then SuppName := ProspSuppliers.Name;
                                    if AverageMark >= PassMark then begin
                                        ProspectiveSupplier."Passed Technical" := true;
                                        ProspectiveSupplier."Average Mark" := AverageMark;
                                        ProspectiveSupplier.Modify();
                                        TenderEvaluationLines.Init();
                                        TenderEvaluationLines."Quote No" := Rec."No.";
                                        TenderEvaluationLines."Vendor No" := ProspectiveSupplier."Response No";
                                        TenderEvaluationLines."Vendor Name" := SuppName;
                                        TenderEvaluationLines.Description := ProspectiveSupplier.Description;
                                        TenderEvaluationLines.Validate("Shortcut Dimension 1 Code", ProspectiveSupplier."Shortcut Dimension 1 Code");
                                        TenderEvaluationLines.Validate("Shortcut Dimension 2 Code", ProspectiveSupplier."Shortcut Dimension 2 Code");
                                        TenderEvaluationLines.Validate(Quantity, ProspectiveSupplier.Quantity);
                                        TenderEvaluationLines.Validate(Amount, ProspectiveSupplier.Amount);
                                        TenderEvaluationLines.Validate("Unit Amount", ProspectiveSupplier."Unit Price");
                                        TenderEvaluationLines.Type := ProspectiveSupplier.Type;
                                        TenderEvaluationLines."No." := ProspectiveSupplier.No;
                                        TenderEvaluationLines."Unit of Measure" := ProspectiveSupplier."Unit of Measure";
                                        TenderEvaluationLines."Line No" := ProspectiveSupplier."Line No";
                                        TenderEvaluationLines."Procurement Plan Item" := ProspectiveSupplier."Procurement Plan Item";
                                        TenderEvaluationLines."Procurement Plan" := ProspectiveSupplier."Procurement Plan";
                                        TenderEvaluationLines.Insert();
                                    end
                                    else begin
                                        ProspectiveSupplier."Passed Technical" := false;
                                        ProspectiveSupplier."Average Mark" := AverageMark;
                                        ProspectiveSupplier.Modify();
                                    end;
                                end;
                            until ProspectiveSupplier.Next() = 0;
                        Rec.Stage := Rec.Stage::Financial;
                        Rec.Modify();
                        Message('Tender has been successfully analyzed');
                    end;
                end;
            }
            action("Financial Analysis")
            {
                Visible = (Rec.Stage = Rec.Stage::Financial) AND (Rec.Analyzed = false);
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;

                trigger OnAction()
                var
                    SupplEvalHdr: Record "Tender Evaluation Line";
                    ProcRequestLines: Record "Procurement Request Lines";
                    ProsTenderLine: Record "Tender Evaluation Line";
                begin
                    if not Confirm('Are you sure you want to perform financial analysis for this document?', false) then
                        exit
                    else begin
                        ProcRequestLines.Reset();
                        ProcRequestLines.SetRange("Requisition No", Rec."No.");
                        if ProcRequestLines.FindSet() then
                            repeat
                                ProsTenderLine.Reset();
                                ProsTenderLine.SetCurrentKey(Amount);
                                ProsTenderLine.SetRange("No.", ProcRequestLines.No);
                                ProsTenderLine.SetRange("Quote No", Rec."No.");
                                if ProsTenderLine.FindFirst() then begin
                                    ProsTenderLine.Awarded := true;
                                    ProsTenderLine.Suggested := true;
                                    ProsTenderLine.Modify();
                                end;
                            until ProcRequestLines.Next() = 0;
                        Rec.Analyzed := true;
                        Rec.Modify();
                        Message('Tender has been successfully Analyzed');
                    end;
                end;
            }
            group(Approvals)
            {
                action("Send for Approval")
                {
                    Visible = (Rec.Analyzed = true) AND (Rec.Status = Rec.Status::Opening);
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        if ApprovalManagement.CheckProcMethodWorkflowEnabled(Rec) then ApprovalManagement.OnSendProcMethodApprovalRequest(Rec);
                        Commit;
                        CurrPage.Close();
                    end;
                }
                action("Cancel Approval request")
                {
                    Caption = 'Cancel Approval Request';
                    Visible = Rec.Status = Rec.Status::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        ApprovalManagement.OnCancelProcMethodApprovalRequest(Rec);
                        CurrPage.Close();
                    end;
                }
                action(ViewApprovals)
                {
                    Caption = 'Approvals';
                    //Enabled = "Status" = "Status"::"Pending Approval";
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Approvalentries: Page "Approval Entries";
                        Approvals: Record "Approval Entry";
                    begin
                        Approvals.Reset();
                        Approvals.SetRange("Table ID", Database::"Procurement Request");
                        Approvals.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(Approvals);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action("Order")
            {
                Caption = 'Create LPO';
                Visible = (Rec.Stage = Rec.Stage::Financial) AND (Rec.Status = Rec.Status::Approved);
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ExpectedDate: Date;
                    PurchSetup: Record "Purchases & Payables Setup";
                begin
                    if not Confirm('Are you sure you want to create an LPO?', false) then
                        exit
                    else begin
                        PurchSetup.Get();
                        PurchSetup.TestField("LPO Creation Duration");
                        ExpectedDate := CalcDate(PurchSetup."LPO Creation Duration", Rec."Creation Date");
                        If ExpectedDate <= Today then begin
                            ProcurementManagement.MakeOrderFromTender(Rec);
                            CurrPage.Close();
                        end
                        else
                            Error('Purchase Order Can only be created after %1 days', PurchSetup."LPO Creation Duration");
                        Rec.Stage := Rec.Stage::Archived;
                        Rec.Modify();
                    end;
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
                        if Confirm('Are you sure you want to submit this tender to the portal?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec.Stage := Rec.Stage::Portal;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Remove from Portal")
                {
                    Visible = (Rec."Submitted To Portal" = true) AND (Rec.Status = Rec.Status::New);
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = RemoveContacts;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to remove this document from the portal?', false) then begin
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
        NewVisible := true;
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
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;
        Isvisible: Boolean;

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

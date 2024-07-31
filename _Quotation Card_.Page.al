page 50761 "Quotation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Portal Controls,Links';
    SourceTable = "Procurement Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                editable = not ApprovedEditable;

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                }
                field("Requisition No"; Rec."Requisition No")
                {
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Process Type"; Rec."Process Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Category; Rec.Category)
                {
                }
                field("Reference No."; Rec."Reference No.")
                {
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Control13; "Procurement Documents Sub Form")
            {
                ApplicationArea = all;
                SubPageLink = "Quote No" = FIELD("No.");
            }
            part(Control12; "Procurement Request Lines")
            {
                editable = not ApprovedEditable;
                SubPageLink = "Requisition No" = FIELD("No.");
            }
            part("Tender Evaluation Sub Form"; "Tender Evaluation Sub Form")
            {
                SubPageLink = "Quote No" = FIELD("No.");
            }
            Group(Introduction)
            {
                field(Introdcution; Rec.Introdcution)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
            Group(Recommendations)
            {
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
        }
        area(Factboxes)
        {
            systempart("Link"; Links)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::New;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if ApprovalManagement.CheckProcMethodWorkflowEnabled(Rec) then ApprovalManagement.OnSendProcMethodApprovalRequest(Rec);
                    Commit;
                end;
            }
            action("Cancel Approval request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = (Rec.Status = Rec.Status::"Pending Approval") OR ((Rec.Status = Rec.Status::Approved));
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelProcMethodApprovalRequest(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
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
        area(navigation)
        {
            group(Attachments)
            {
                action("Upload Quotation Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    //Visible = false;
                    trigger OnAction()
                    var
                    begin
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                        //DocumentManagement.InsertProcurementLinks(Rec);
                    end;
                }
                action(Attachments1)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                    Visible = false;

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
            group("Request for Quotation")
            {
                Caption = 'Request for Quotation';

                action("Select Suppliers")
                {
                    Caption = 'Select Suppliers to invite';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Supplier Selection";
                    visible = Rec.Status = Rec.Status::New;
                    RunPageLink = "Reference No." = FIELD("No."), "Supplier Category" = field(Category);

                    //RunPageLink = "Supplier Category" = field(Category);
                    trigger OnAction()
                    begin
                        //TestTheFields;
                    end;
                }
                action("Print RFQ's")
                {
                    Caption = 'Print RFQ''s';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestTheFields;
                        SupplierSelect.Reset;
                        SupplierSelect.SetFilter(SupplierSelect."Reference No.", Rec."No.");
                        RFQReport.SetTableView(SupplierSelect);
                        RFQReport.Run();
                    end;
                }
                action("Print RFQ Evaluation")
                {
                    Caption = 'Print RFQ Evaluation';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ProcReq: Record "Procurement Request";
                        lvEval: Report "RFQ Evaluation Report";
                    begin
                        Clear(lvEval);
                        ProcReq.Reset();
                        ProcReq.SetRange("No.", Rec."No.");
                        lvEval.SetTableView(ProcReq);
                        lvEval.Run();
                    end;
                }
                action("Print RFQ Evaluation4")
                {
                    Caption = 'Print RFQ Evaluation';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProcReq: Record "Procurement Request";
                        //  lvEval: Report "Test Report";
                        lvEval: Report "RFQ Report";
                    begin
                        Clear(lvEval);
                        ProcReq.Reset();
                        ProcReq.SetRange("No.", Rec."No.");
                        lvEval.SetTableView(ProcReq);
                        lvEval.Run();
                    end;
                }
                action("Print Opening Minutes")
                {
                    Caption = 'Print Opening Minutes';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProcReq: Record "Procurement Request";
                        lvEval: Report "Opening Minutes";
                    begin
                        Clear(lvEval);
                        ProcReq.Reset();
                        ProcReq.SetRange("No.", Rec."No.");
                        lvEval.SetTableView(ProcReq);
                        lvEval.Run();
                    end;
                }
                action(Links)
                {
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = Page "Procurement Documents Links";
                    RunPageLink = "No." = FIELD("No."), "Process Type" = field("Process Type");
                }
                action(Notify)
                {
                    Caption = 'Notify Suppliers';
                    Image = Email;
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
                    Caption = 'Send Suppliers for Evaluation';
                    Visible = false;
                    Image = ShowSelected;
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
                    //"Prospective Supplier Tender"."Prospect No." WHERE("Tender No." = field("Reference No."));
                    begin
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Quotation);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved Quotation evaluation committee for Tender %1', Rec."No.");
                        if Confirm('Are you sure?') then begin
                            ProcMgt.SendProspectiveSuppliersForEvaluationQuotation("Rec");
                        end;
                        CurrPage.Close();
                    end;
                }
                action("Send for opening")
                {
                    Caption = 'Send for opening';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    visible = ApprovedEditable;

                    trigger OnAction()
                    var
                        OpeningCommitee: Record "Tender Committees";
                        ProspSupplier: Record "Prospective Supplier Tender";
                        VendCount: Integer;
                        ProcMgt: Codeunit "Procurement Management";
                    begin
                        //TestField(Status, Status::Approved);
                        ProspSupplier.Reset();
                        ProspSupplier.SetRange("Tender No.", Rec."No.");
                        VendCount := ProspSupplier.Count();
                        if VendCount < 3 then begin
                            Error('The total number of supplier responses is below the minimum(3), %1 suppliers have submitted their responses', VendCount);
                        end;
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Quotation);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Opening);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved opening quotation committee for Quotation %1', Rec."No.");
                        if not Confirm('Are you sure?') then
                            exit
                        else begin
                            ProcMgt.SendProspectiveSuppliersForOpeningQuotation("Rec");
                            Rec.Status := Rec.Status::Opening;
                            Rec.Stage := Rec.Stage::Opening;
                            Commit();
                        end;
                        Message('Quote successfully sent for opening');
                        CurrPage.Close();
                    end;
                }
                action("Send To Preliminary")
                {
                    Caption = 'Send To Preliminary';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    visible = Rec.Stage = Rec.Stage::Opening;

                    trigger OnAction()
                    var
                        OpeningCommitee: Record "Tender Committees";
                        ProspSupplier: Record "Prospective Supplier Tender";
                        VendCount: Integer;
                        ProcMgt: Codeunit "Procurement Management";
                    begin
                        //TestField(Status, Status::Approved);
                        ProspSupplier.Reset();
                        ProspSupplier.SetRange("Tender No.", Rec."No.");
                        VendCount := ProspSupplier.Count();
                        if VendCount < 3 then Error('The total number of supplier responses is below the minimum(3), %1 suppliers have submitted their responses', VendCount);
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Quotation);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved Evaluation quotation committee for Quotation %1', Rec."No.");
                        if not Confirm('Are you sure?') then
                            exit
                        else begin
                            ProcMgt.SendProspectiveSuppliersForEvaluationQuotation("Rec");
                            //Status := Status::Opening;
                            Rec.Stage := Rec.Stage::Periliminary;
                            Commit();
                        end;
                        Message('Quote successfully sent to the preliminary stage');
                        CurrPage.Close();
                    end;
                }
                action("Select Suppliers for evaluation")
                {
                    Visible = false;
                    Caption = 'Select Suppliers for evaluation';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Bidders Selection";
                    RunPageLink = "Reference No." = FIELD("No.");
                }
                action("Generate Quote Evaluation")
                {
                    Caption = 'Generate Quote Evaluation';
                    Image = CreatePutAway;
                    Promoted = true;
                    Visible = (Rec.Stage = Rec.Stage::Technical) and Rec."Evaluation Generatated" = false;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Supplier Selection";
                        OpeningCommitee: Record "Tender Committees";
                    begin
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Quotation);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved quotation evaluation committee for quotation %1', Rec."No.");
                        TestTheFields;
                        if not Confirm('Are you sure you want to generate a quote Evaluation?') then
                            exit
                        else begin
                            //ProcurementManagement.CreateQuoteEvaluation("No.");
                            ProcurementManagement.SendProspectiveSuppliersForTechnicalEvaluationQuotation(Rec);
                            Rec."Evaluation Generatated" := true;
                            Rec.Modify();
                            CurrPage.Close;
                        end;
                    end;
                }
                //Evaluation...START
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
                        ProspSupplier: Record "Prospective Supplier Tender";
                        SupplEvalDocs: Record "Supplier Evaluation Document";
                        FailedCount: Integer;
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
                            ProspSupplier.SetRange(ProspSupplier."Tender No.", Rec."No.");
                            if ProspSupplier.FindSet() then
                                repeat
                                    Clear(FailedCount);
                                    SupplEvalHeader2.Reset();
                                    SupplEvalHeader2.SetRange(Stage, SupplEvalHeader2.Stage::Preliminary);
                                    SupplEvalHeader2.SetRange("Supplier Code", ProspSupplier."Prospect No.");
                                    SupplEvalHeader2.SetRange("Quote No", Rec."No.");
                                    if SupplEvalHeader2.FindSet() then
                                        repeat
                                            SupplEvalDocs.Reset();
                                            SupplEvalDocs.SetRange("Tender No.", Rec."No.");
                                            SupplEvalDocs.SetRange(Mandatory, true);
                                            SupplEvalDocs.SetRange(Submitted, false);
                                            SupplEvalDocs.SetRange("Supplier Code", ProspSupplier."Prospect No.");
                                            SupplEvalDocs.SetRange("Quote No.", SupplEvalHeader2."No.");
                                            if SupplEvalDocs.FindFirst() then FailedCount := FailedCount + 1;
                                        until SupplEvalHeader2.Next() = 0;
                                    if FailedCount = 0 then begin
                                        ProspSupplier."Passed Preliminary" := true;
                                        ProspSupplier.Modify();
                                    end;
                                until ProspSupplier.Next() = 0;
                            Rec.Stage := Rec.Stage::Technical;
                            Rec."Preliminary Analyzed" := true;
                            Rec.Modify();
                            Message('Tender has been successfully analyzed.');
                        end;
                    end;
                }
                action("Analyze Technical")
                {
                    Visible = (Rec.Stage = Rec.Stage::Technical) and Rec."Evaluation Generatated" = true;
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
                        //ProspectiveSupplier: Record "Prospective Tender Line";
                        ProspectiveSupplier: Record "Prospective Supplier Tender";
                        TotalScore: Decimal;
                        PassMark: Decimal;
                        EvalSetup: Record "Supplier Evaluation SetUp";
                        TenderEvaluationLines: Record "Tender Evaluation Line";
                        ProspSuppliers: Record "Prospective Suppliers";
                        SuppName: Text;
                        ProspLines: Record "Prospective Tender Line";
                        ScoreLines: Record "Supplier Evaluation Score Line";
                        Passed: Boolean;
                        EvaluationHeader: Record "Supplier Evaluation Header";
                    begin
                        if not Confirm('Are you sure you want to perform the technical analysis for this document?', false) then
                            exit
                        else begin
                            SuppEvalHeader.Reset();
                            SuppEvalHeader.SetRange(Stage, SuppEvalHeader.Stage::Technical);
                            SuppEvalHeader.SetRange(Submitted, false);
                            SuppEvalHeader.SetRange("Quote No", Rec."No.");
                            if SuppEvalHeader.FindFirst() then Error('All evaluators must submit their scores before performing technical analysis.');
                            Clear(PassMark);
                            Clear(CommitteeCount);
                            EvalSetup.Reset();
                            EvalSetup.SetRange("Procurement Ref No.", Rec."No.");
                            if EvalSetup.FindFirst() then begin
                                case EvalSetup."Score Criteria" of
                                    EvalSetup."Score Criteria"::Score:
                                        begin
                                            EvalSetup.CalcFields("Total PassMark");
                                            PassMark := EvalSetup."Total PassMark";
                                            TenderCommittees.Reset();
                                            TenderCommittees.SetRange("Tender No.", Rec."No.");
                                            TenderCommittees.SetRange("Committee Type", TenderCommittees."Committee Type"::Evaluation);
                                            CommitteeCount := TenderCommittees.Count();
                                            ProspectiveSupplier.Reset();
                                            ProspectiveSupplier.SetRange("Tender No.", Rec."No.");
                                            ProspectiveSupplier.SetFilter("Passed Preliminary", '%1', true);
                                            if ProspectiveSupplier.FindSet() then
                                                repeat
                                                    Clear(AverageMark);
                                                    Clear(TotalScore);
                                                    SupplierEvalScore.Reset();
                                                    SupplierEvalScore.SetRange("Tender No.", Rec."No.");
                                                    SupplierEvalScore.SetFilter("Supplier Code", '%1', ProspectiveSupplier."Prospect No.");
                                                    if SupplierEvalScore.FindSet() then begin
                                                        repeat
                                                            SupplierEvalScore.CalcFields("Total Score");
                                                            TotalScore := TotalScore + SupplierEvalScore."Total Score";
                                                        until SupplierEvalScore.Next() = 0;
                                                        AverageMark := TotalScore / CommitteeCount;
                                                        Clear(SuppName);
                                                        ProspSuppliers.Reset();
                                                        ProspSuppliers.SetRange("No.", ProspectiveSupplier."Prospect No.");
                                                        if ProspSuppliers.FindFirst() then SuppName := ProspSuppliers.Name;
                                                        if AverageMark >= PassMark then begin
                                                            ProspectiveSupplier."Passed Technical" := true;
                                                            ProspectiveSupplier."Average Mark" := AverageMark;
                                                            ProspectiveSupplier.Modify();
                                                            ProspLines.Reset();
                                                            ProspLines.SetRange("Response No", ProspectiveSupplier."Prospect No.");
                                                            ProspLines.SetRange("Tender No.", Rec."No.");
                                                            if ProspLines.FindFirst() then
                                                                repeat
                                                                    ProspLines.CalcFields(Specification2);
                                                                    TenderEvaluationLines.Init();
                                                                    TenderEvaluationLines."Quote No" := Rec."No.";
                                                                    TenderEvaluationLines."Vendor No" := ProspLines."Response No";
                                                                    TenderEvaluationLines."Vendor Name" := SuppName;
                                                                    TenderEvaluationLines.Description := ProspLines.Description;
                                                                    TenderEvaluationLines.Specification2 := ProspLines.Specification2;
                                                                    TenderEvaluationLines.Validate("Shortcut Dimension 1 Code", ProspectiveSupplier."Shortcut Dimension 1 Code");
                                                                    TenderEvaluationLines.Validate("Shortcut Dimension 2 Code", ProspectiveSupplier."Shortcut Dimension 2 Code");
                                                                    TenderEvaluationLines.Validate(Quantity, ProspLines.Quantity);
                                                                    TenderEvaluationLines.Validate(Amount, ProspLines.Amount);
                                                                    TenderEvaluationLines.Validate("Unit Amount", ProspLines."Unit Price");
                                                                    TenderEvaluationLines.Type := ProspLines.Type;
                                                                    TenderEvaluationLines."No." := ProspLines.No;
                                                                    TenderEvaluationLines."Unit of Measure" := ProspLines."Unit of Measure";
                                                                    TenderEvaluationLines."Line No" := ProspLines."Line No";
                                                                    TenderEvaluationLines."Procurement Plan Item" := ProspectiveSupplier."Procurement Plan Item";
                                                                    TenderEvaluationLines."Procurement Plan" := ProspLines."Procurement Plan";
                                                                    //Added to validate Amount each bidder responded
                                                                    TenderEvaluationLines."Unit Amount" := ProspLines."Unit Price";
                                                                    TenderEvaluationLines."Amount Inclusive VAT" := ProspLines.Amount;
                                                                    TenderEvaluationLines.Amount := ProspLines.Amount;
                                                                    TenderEvaluationLines.Insert();
                                                                until ProspLines.Next() = 0;
                                                        end
                                                        else begin
                                                            ProspectiveSupplier."Passed Technical" := false;
                                                            ProspectiveSupplier."Average Mark" := AverageMark;
                                                            ProspectiveSupplier.Modify();
                                                        end;
                                                    end;
                                                until ProspectiveSupplier.Next() = 0;
                                        end;
                                    EvalSetup."Score Criteria"::"Yes/No":
                                        begin
                                            ProspectiveSupplier.Reset();
                                            ProspectiveSupplier.SetRange("Tender No.", Rec."No.");
                                            ProspectiveSupplier.SetFilter("Passed Preliminary", '%1', true);
                                            if ProspectiveSupplier.FindSet() then
                                                repeat
                                                    Clear(Passed);
                                                    ScoreLines.Reset();
                                                    ScoreLines.SetRange("Supplier Code", ProspectiveSupplier."Prospect No.");
                                                    ScoreLines.SetRange(ScoreLines."Tender No.", Rec."No.");
                                                    ScoreLines.SetRange("Tender No.", Rec."No.");
                                                    ScoreLines.SetFilter("Y/N", '%1|%2', ScoreLines."Y/N"::" ", ScoreLines."Y/N"::No);
                                                    if ScoreLines.FindFirst() then
                                                        Passed := false
                                                    else
                                                        Passed := true;
                                                    Clear(SuppName);
                                                    ProspSuppliers.Reset();
                                                    ProspSuppliers.SetRange("No.", ProspectiveSupplier."Prospect No.");
                                                    if ProspSuppliers.FindFirst() then SuppName := ProspSuppliers.Name;
                                                    if Passed then begin
                                                        ProspectiveSupplier."Passed Technical" := true;
                                                        ProspectiveSupplier.Modify();
                                                        ProspLines.Reset();
                                                        ProspLines.SetRange("Response No", ProspectiveSupplier."Prospect No.");
                                                        ProspLines.SetRange("Tender No.", Rec."No.");
                                                        if ProspLines.FindFirst() then
                                                            repeat
                                                                TenderEvaluationLines.Init();
                                                                TenderEvaluationLines."Quote No" := Rec."No.";
                                                                TenderEvaluationLines."Vendor No" := ProspLines."Response No";
                                                                TenderEvaluationLines."Vendor Name" := SuppName;
                                                                TenderEvaluationLines.Description := ProspLines.Description;
                                                                TenderEvaluationLines.Validate("Shortcut Dimension 1 Code", ProspectiveSupplier."Shortcut Dimension 1 Code");
                                                                TenderEvaluationLines.Validate("Shortcut Dimension 2 Code", ProspectiveSupplier."Shortcut Dimension 2 Code");
                                                                TenderEvaluationLines.Validate(Quantity, ProspLines.Quantity);
                                                                TenderEvaluationLines.Validate(Amount, ProspLines.Amount);
                                                                TenderEvaluationLines.Validate("Unit Amount", ProspLines."Unit Price");
                                                                TenderEvaluationLines.Type := ProspLines.Type;
                                                                TenderEvaluationLines."No." := ProspLines.No;
                                                                TenderEvaluationLines."Unit of Measure" := ProspLines."Unit of Measure";
                                                                TenderEvaluationLines."Line No" := ProspLines."Line No";
                                                                TenderEvaluationLines."Procurement Plan Item" := ProspectiveSupplier."Procurement Plan Item";
                                                                TenderEvaluationLines."Procurement Plan" := ProspLines."Procurement Plan";
                                                                //Added to validate Amount each bidder responded
                                                                TenderEvaluationLines."Unit Amount" := ProspLines."Unit Price";
                                                                TenderEvaluationLines."Amount Inclusive VAT" := ProspLines.Amount;
                                                                TenderEvaluationLines.Amount := ProspLines.Amount;
                                                                TenderEvaluationLines.Insert();
                                                            until ProspLines.Next() = 0;
                                                    end
                                                    else begin
                                                        ProspectiveSupplier."Passed Technical" := false;
                                                        ProspectiveSupplier.Modify();
                                                    end;
                                                until ProspectiveSupplier.Next() = 0;
                                        end;
                                end;
                            end;
                            Rec.Stage := Rec.Stage::Financial;
                            Rec.Modify();
                            Message('Quotation has been successfully analyzed');
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
                        SupplTender: Record "Prospective Supplier Tender";
                        MaxAmout: Decimal;
                        MinAmount: Decimal;
                    begin
                        if not Confirm('Are you sure you want to perform financial analysis for this document?', false) then
                            exit
                        else begin
                            ProcRequestLines.Reset();
                            ProcRequestLines.SetRange("Requisition No", Rec."No.");
                            if ProcRequestLines.FindSet() then
                                repeat
                                    ProsTenderLine.Reset();
                                    ProsTenderLine.SetRange("No.", ProcRequestLines.No);
                                    ProsTenderLine.SetRange("Quote No", Rec."No.");
                                    ProsTenderLine.SetRange("Line No", ProcRequestLines."Line No");
                                    ProsTenderLine.SetCurrentKey(Amount);
                                    if ProsTenderLine.FindFirst() then begin
                                        ProsTenderLine.Awarded := true;
                                        ProsTenderLine.Suggested := true;
                                        ProsTenderLine.Modify();
                                        SupplTender.Reset();
                                        SupplTender.SetRange("Prospect No.", ProsTenderLine."Vendor No");
                                        SupplTender.SetRange("Tender No.", ProsTenderLine."Quote No");
                                        if SupplTender.FindFirst() then begin
                                            SupplTender."Passed Financial" := true;
                                            SupplTender.Modify();
                                        end;
                                    end;
                                until ProcRequestLines.Next() = 0;
                            Rec.Analyzed := true;
                            Rec.Modify();
                            Message('Tender has been successfully Analyzed');
                        end;
                    end;
                }
                //Evaluation...END
            }
            action("Order")
            {
                Caption = 'Create LPO';
                Visible = (Rec.Stage = Rec.Stage::Financial) AND (Rec.Analyzed = true);
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
                        ProcurementManagement.Emailnotification(Rec);
                        PurchSetup.Get();
                        PurchSetup.TestField("LPO Creation Duration");
                        ExpectedDate := CalcDate(PurchSetup."LPO Creation Duration", Rec."Creation Date");
                        If ExpectedDate <= Today then begin
                            ProcurementManagement.MakeOrderFromQuote(Rec);
                            Rec.Stage := Rec.Stage::Archived;
                            Rec.Modify();
                            CurrPage.Close();
                        end
                        else
                            Error('Purchase Order Can only be created after %1 days', PurchSetup."LPO Creation Duration");
                    end;
                end;
            }
            action("Change Request")
            {
                Image = Change;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Numb: Code[20];
                    ProcChnageReq: Record "Procurement Change Request";
                begin
                    Numb := RecChangeRequest(Rec);
                    ProcChnageReq.SetRange(Number, Numb);
                    RecChangeRequest(Rec);
                    PAGE.Run(Page::"Proc. Change Request Card", ProcChnageReq);
                end;
            }
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
                    Visible = ApprovedEditable;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = AddContacts;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec."Portal Submission Date" := Today;
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
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::RFQ;
        //Status := Status::Opening;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::RFQ;
        //Status := Status::Opening;
    end;

    trigger OnafterGetrecord()
    begin
        SetControlAppearance();
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        SupplierSelect: Record "Supplier Selection";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Opening: Boolean;
        NewVisible: Boolean;
        ApprovedEditable: Boolean;
        RFQReport: Report RFQ;
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
        Rec.TestField(Title);
        Rec.TestField("Quotation Deadline");
        Rec.TestField("Expected Closing Time");
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
            ApprovedEditable := true
        else
            ApprovedEditable := false;
    end;

    local procedure RecChangeRequest(ProcurementRequest: Record "Procurement Request"): Code[20]
    var
        NextNumber: Code[20];
        ProcChangeRequeest: Record "Procurement Change Request";
        PurchSet: Record "Purchases & Payables Setup";
        ProcLines: Record "Procurement Request Lines";
        ProcReqLines: Record "Proc. Lines Change Request";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        PurchSet.Get();
        PurchSet.TestField("Procurement Req. Change No.s");
        NextNumber := NoSeriesMgt.GetNextNo(PurchSet."Procurement Req. Change No.s", 0D, true);
        ProcChangeRequeest.Init;
        ProcChangeRequeest.TransferFields(ProcurementRequest);
        ProcChangeRequeest.Status := ProcChangeRequeest.Status::New;
        ProcChangeRequeest.Number := NextNumber;
        ProcChangeRequeest.Insert;
        ProcLines.Reset();
        ProcLines.SetRange("Requisition No", ProcurementRequest."No.");
        if ProcLines.FindFirst() then begin
            ProcReqLines.Init();
            repeat
                ProcLines.CalcFields(Specification2);
                ProcReqLines.TransferFields(ProcLines);
                ProcReqLines.Number := NextNumber;
                ProcReqLines.Insert;
            until ProcLines.Next() = 0;
        end;
        exit(NextNumber);
    end;
}

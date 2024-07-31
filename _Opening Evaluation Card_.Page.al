page 50989 "Opening Evaluation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks';
    SourceTable = "Supplier Evaluation Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'Tender No.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = all;
                }
                field(Submitted; Rec.Submitted)
                {
                    ApplicationArea = all;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = all;
                }
            }
            part("Supplier Evaluation Documents"; "Supplier Evaluation Documents")
            {
                //Visible = false;
                ApplicationArea = all;
                Caption = 'Supplier Preliminary Evaluation';
                SubPageLink = "Quote No." = field("No.");
                Editable = false;
            }
            part("Supplier Evaluation Scores"; "Supplier Evaluation Scores")
            {
                Visible = false;
                ApplicationArea = all;
                Caption = 'Supplier Technical Evaluation';
                SubPageLink = "Document No." = field("No.");
            }
            part(Control12; "Supplier Evaluation SubForm")
            {
                ApplicationArea = all;
                SubPageLink = "Quote No" = FIELD("No.");
                Visible = false;
            }
            part("Supplier responses"; "Supplier Responses")
            {
                ApplicationArea = all;
                SubPageLink = "Response No" = field("Supplier Code"), "Tender No." = field("Quote No");
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Caption = 'Submit';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec.Stage = Rec.Stage::Opening) AND (Rec.Status = Rec.Status::New);

                trigger OnAction()
                var
                    ProcMgmt: Codeunit "Procurement Management";
                    Text001: Label 'Supplier No. %1 has not been approved.';
                begin
                    if not Confirm('Are you sure you want to submit your response?', false) then
                        exit
                    else begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                end;
            }
            action(SubmitTechnical)
            {
                Caption = 'Submit Technical';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec.Stage = Rec.Stage::Technical) AND (Rec.Status = Rec.Status::New);

                trigger OnAction()
                var
                    ProcMgmt: Codeunit "Procurement Management";
                    Text001: Label 'Supplier No. %1 has not been approved.';
                    EvalsRec: Record "Supplier Evaluation Score Line";
                    SuppEvalScore: Record "Supplier Evaluation Score";
                begin
                    if not Confirm('Are you sure you want to submit this document?', false) then
                        exit
                    else begin
                        EvalsRec.Reset();
                        EvalsRec.SetRange("Document No.", Rec."No.");
                        EvalsRec.SetRange(Score, 0);
                        if EvalsRec.FindFirst() then Error('Please score before submitting for evaluation');
                        ProcMgmt.GetTechnicalEvaluationDecision(Rec);
                        SuppEvalScore.Reset();
                        SuppEvalScore.SetRange("Document No.", Rec."No.");
                        SuppEvalScore.SetRange("Supplier Code", Rec."Supplier Code");
                        SuppEvalScore.SetRange("Tender No.", Rec."Quote No");
                        if SuppEvalScore.FindFirst() then begin
                            SuppEvalScore.Submitted := true;
                            SuppEvalScore.Modify();
                        end;
                        Rec.Submitted := true;
                        Rec.Modify();
                    end;
                end;
            }
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec.Status in [Rec.Status::New] then Rec.Status := Rec.Status::Approved;
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Rejected then Rec.Status := Rec.Status::Rejected;
                end;
            }
            action("Apply Lines")
            {
                Caption = 'Apply Lines';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    SupEvaLine.Reset();
                    SupEvaLine.SetRange("Quote No", Rec."Quote No");
                    if SupEvaLine.Find('-') then begin
                        SupEvaLine.Delete();
                    end;
                    LineNo := 0;
                    ProSuppliers.Reset();
                    ProSuppliers.SetRange("Project Code", Rec."Quote No");
                    if ProSuppliers.Find('-') then
                        repeat
                            LineNo := LineNo + 1000;
                            SupEvaLine.Init();
                            SupEvaLine."Line No." := LineNo;
                            SupEvaLine."Quote No" := Rec."Quote No";
                            SupEvaLine.Supplier := ProSuppliers."No.";
                            SupEvaLine."Supplier Name" := ProSuppliers.Name;
                            SupEvaLine.Insert();
                        until ProSuppliers.Next = 0;
                    SupSetup.Reset();
                    SupSetup.SetFilter(Active, '%1', true);
                    if SupSetup.Find('-') then
                        repeat
                            if SupEvaLine.Get(Rec."Quote No") then SupEvaLine."Evaluation Type" := SupSetup.Code;
                            SupEvaLine."Evaluation Description" := SupSetup."Evalueation Description";
                            SupEvaLine."Max Score" := SupSetup."Maximum Score";
                            SupEvaLine.Modify(true);
                        Until SupSetup.Next = 0;
                end;
            }
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Enabled = NOT OpenApprovalEntriesExist;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if ApprovalMgt.CheckSupplierEvalWorkflowEnabled(Rec) then ApprovalMgt.OnSendSupplierEvalForApproval(rec);
                        CurrPage.Close()
                    end;
                }
                action("Cancel Approval Request")
                {
                    Visible = false;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApproval;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ApprovalMgt.OnCancelSupplierEvalApprovalRequest(rec);
                    end;
                }
                action("View Approvals")
                {
                    Visible = false;
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
                        Approvals.SetRange("Table ID", Database::"Supplier Evaluation Header");
                        Approvals.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(Approvals);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        SupEvaLine: Record "Supplier Evaluation Line";
        SupSetup: Record "Supplier Evaluation SetUp";
        ProcurementManagement: Codeunit "Procurement Management";
        SupplierSelect: Record "Supplier Selection";
        LineNo: Integer;
        ProSuppliers: Record "Prospective Suppliers";
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;
        ApprovalEntry: Record "Approval Entry";
        ShowCommentFactbox: Boolean;
        ShareholderVisible: Boolean;
        CanCancelApproval: Boolean;
        OpenApprovalEntriesExist: Boolean;
        Preliminary: Boolean;
        Technical: Boolean;

    local procedure TestTheFields()
    begin
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApproval := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if Rec.Stage = Rec.Stage::Preliminary then
            Preliminary := true
        else
            Preliminary := false;
        if Rec.Stage = Rec.Stage::Technical then
            Technical := true
        else
            Technical := false;
    end;
}

page 51286 "Vendor Evaluation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    caption = 'Supplier Performance Evaluation Card';
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks';
    SourceTable = "Supplier Evaluation Header";
    ApplicationArea = All;

    //SourceTableView = where(Type = const(Existing));
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field(Title; Rec.Title)
                {
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'Tender No.';
                    Visible = false;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(User; Rec.User)
                {
                    Editable = false;
                }
                field("Total Score"; TotalScoring)
                {
                    Editable = false;
                }
            }
            part("Supplier Evaluation Scores"; "Supplier Evaluation Scores")
            {
                Caption = 'Supplier Evaluation scores';
                SubPageLink = "Document No." = field("No.");
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
            group(Group)
            {
                Caption = 'Submit';

                action("Select Suppliers")
                {
                    Caption = 'Submit';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then Rec.Status := Rec.Status::Approved;
                        Message('successfully submitted');
                    end;
                }
                action("Reject")
                {
                    Caption = 'Reject Supplier Evaluation';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Rejected then Rec.Status := Rec.Status::New;
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
            }
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    Caption = 'Submit Scores';
                    Image = SendApprovalRequest;
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if ApprovalMgt.CheckSupplierEvalWorkflowEnabled(Rec) then ApprovalMgt.OnSendSupplierEvalForApproval(rec);
                        Message('Scores Submitted Successfully');
                        CurrPage.Close();
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApproval;
                    Image = CancelApprovalRequest;
                    Visible = false;
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
                    Caption = 'View Approvals';
                    Image = Approvals;
                    Visible = true;
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
            // action(Attachments)
            // {
            //     Caption = 'Upload attachment';
            //     ApplicationArea = all;
            //     Image = Attach;
            //     trigger OnAction()
            //     begin
            //         Clear(DocumentAttachment);
            //         RecRef.GETTABLE(Rec);
            //         DocumentAttachment.OpenForRecReference(RecRef);
            //         DocumentAttachment.RUNMODAL;
            //     end;
            // }
        }
    }
    trigger OnAfterGetRecord()
    begin
        TotalScoring := 0;
        SupScores.Reset();
        SupScores.SetRange("Document No.", Rec."No.");
        if SupScores.Find('-') then begin
            repeat
                SupScores.CalcFields("Total Score");
                TotalScoring := TotalScoring + SupScores."Total Score";
            until SupScores.Next() = 0;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Existing;
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
        RecRef: RecordRef;
        // DocumentAttachment: Page "Document Attachment Custom";
        TotalScoring: Decimal;
        SupScores: Record "Supplier Evaluation Score";

    local procedure TestTheFields()
    begin
    end;
    // local procedure SetControlAppearance()
    // var
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // begin
    //     if (Status = Status::Approved) or (Status = Status::Rejected) then
    //         OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(RecordId)
    //     else
    //         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    //     CanCancelApproval := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
    // end;
}

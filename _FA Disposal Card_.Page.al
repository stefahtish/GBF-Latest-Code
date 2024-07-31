page 50226 "FA Disposal Card"
{
    Caption = 'FA Disposal Card';
    PageType = Card;
    SourceTable = "FA Disposal";
    PromotedActionCategories = 'New,Process,Report,Approvals,View Bids,Sales Quote';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not OpenApprovalEntriesExist;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Created By Staff No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Enabled = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                group(Portal)
                {
                    ShowCaption = false;
                    Visible = PortalVisible;

                    field("Quotation Deadline"; Rec."Quotation Deadline")
                    {
                    }
                    field("Expected Closing Time"; Rec."Expected Closing Time")
                    {
                    }
                    field("Submitted To Portal"; Rec."Submitted To Portal")
                    {
                        Enabled = false;
                    }
                }
            }
            part("FA Disposal Lines"; "FA Disposal Lines")
            {
                editable = not OpenApprovalEntriesExist;
                SubPageLink = "Document No." = field("No.");
            }
            part("FA Disposal Form Lines"; "FA Disposal Form Lines")
            {
                Visible = PortalVisible;
                SubPageLink = "FA Disposal Doc No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            systempart(Attachements; Links)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = not OpenApprovalEntriesExist;
                ApplicationArea = All;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin
                    Rec.TestField(Comments);
                    if ApprovalMgt.CheckFADisposalWorkflowEnabled(Rec) then ApprovalMgt.OnSendFADisposalForApproval(rec);
                    CurrPage.Close();
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
                ApplicationArea = All;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelFADisposalApprovalRequest(Rec);
                    CurrPage.close;
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: page "Approval Entries";
                    Approvals: Record "Approval Entry";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"FA Disposal");
                    Approvals.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
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

                    trigger OnAction()
                    var
                    begin
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            group("Quote")
            {
                action(SalesQuote)
                {
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Image = NewSalesQuote;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ProcMgmt: Codeunit "Procurement Management";
                    begin
                        ProcMgmt.MakeSalesQuote(Rec);
                    end;
                }
            }
        }
        area(Reporting)
        {
            action("View Bids")
            {
                Promoted = true;
                PromotedOnly = true;
                Image = Report;
                PromotedIsBig = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    Commit();
                    FADisposal.Reset();
                    FADisposal.SetRange("No.", Rec."No.");
                    FADisposalEval.SetTableView(FADisposal);
                    FADisposalEval.Run();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        //EDDI[RunOnClient]
        //DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        FADisposal: Record "FA Disposal";
        PortalVisible: Boolean;
        FADisposalEval: Report "FA Disposal Quote Evaluation";

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Approved) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForPayment := App2.CanCancelApprovalForRecord(Rec.RecordId);
        if (Rec."Status" = Rec."Status"::Approved) then
            PortalVisible := true
        else
            PortalVisible := false;
    end;
}

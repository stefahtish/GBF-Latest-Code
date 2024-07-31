page 50870 "Proc. Change Request Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Portal Controls,Links';
    SourceTable = "Procurement Change Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
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
            part(Control12; "Proc. Lines Change Request")
            {
                editable = not ApprovedEditable;
                SubPageLink = Number = FIELD(Number);
            }
            Group(Introduction)
            {
                field(Introdcution; Rec.Introdcution)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
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
                    if ApprovalManagement.CheckProcReqRequestWorkflowEnabled(Rec) then ApprovalManagement.OnSendProcReqRequestApproval(Rec);
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
                    ApprovalManagement.OnCancelProcReqApproval(Rec);
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
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Process Type" := "Process Type"::RFQ;
        //Status := Status::Opening;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Process Type" := "Process Type"::RFQ;
        //Status := Status::Opening;
    end;

    trigger OnafterGetrecord()
    begin
        //SetControlAppearance();
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
}

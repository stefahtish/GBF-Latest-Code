page 50359 "Payment Form Request Gen"
{
    Caption = 'Request for payment form';
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Documents';
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Payment Request"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Request for payment")
            {
                showcaption = false;

                field("No."; Rec."No.")
                {
                    Editable = false;
                    APPLICATIONAREA = ALL;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Time Inserted"; Rec."Time Inserted")
                {
                    Caption = 'Time';
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ShowMandatory = true;
                    Caption = 'Supplier Name';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                    enabled = false;
                }
                field("Requested Payment"; Rec."Requested Payment")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                group(Vendor)
                {
                    Visible = VendorVisible;
                    ShowCaption = false;

                    field("Account No."; Rec."Account No.")
                    {
                        Caption = 'Vendor No.';
                    }
                    field("Account Name"; Rec."Account Name")
                    {
                        Caption = 'Description';
                    }
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Payment Request Amount"; Rec."Payment Request Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                Visible = ShowCommentFactbox;
            }
            systempart(Control21; Notes)
            {
            }
            systempart(Control20; MyNotes)
            {
            }
            systempart(Attachments; Links)
            {
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Action38)
            {
                Caption = 'Request for Payment Form';
                Image = "Order";

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send for approval';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField(Payee);
                        Rec.TestField("Requested Payment");
                        Rec.TestField("Document No.");
                        // PLines.Reset;
                        // PLines.SetRange(No, Rec."No.");
                        // if PLines.Find('-') then begin
                        //     repeat
                        //         if PLines."Account No" = '' then
                        //             Error('Account No. Field is Blank. Please Fill the Line No. %1 with amount %2.', PLines."Line No", PLines.Amount);
                        //     until PLines.Next = 0;
                        // end;
                        // if ErrorMsg <> '' then
                        //     Error(ErrorMsg);
                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendPaymentsForApproval(Rec);
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForPayment AND NOT DocPosted;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request? Please note this will uncommit previous committments regarding %1', false, Rec."No.") = true then begin
                            //Committment.ReversePVCommittment(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                            Commit;
                            Committment.CancelPaymentsCommitments(Rec);
                        end;
                        CurrPage.Close;
                    end;
                }
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
                        //    FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payment Request";
        Rec."Account Type" := Rec."Account Type"::Vendor;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payment Request";
        Rec."Account Type" := Rec."Account Type"::Vendor;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        [InDataSet]
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        Committment: Codeunit Committment;
        PaymentsPost: Codeunit "Payments Management";
        [InDataSet]
        DocPosted: Boolean;
        [InDataSet]
        ChequePayment: Boolean;
        [InDataSet]
        DocReleased: Boolean;
        EFTPayment: Boolean;
        PaymentRec: Record Payments;
        PLines: Record "Payment Lines";
        PayMethod: Record "Payment Method";
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        ImportPVLines: XMLport "Import PV Lines";
        CashManagementSetup: Record "Cash Management Setups";
        ErrorMsg: Text;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        RTGSPayment: Boolean;
        Apportionment: Codeunit Apportionment;
        //[RunOnClient]
        //eddieDocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        VendorVisible: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PaymentMethod: Record "Payment Method";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
        CanCancelApprovalForPayment := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then
            EFTPayment := true
        else
            EFTPayment := false;
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        // MESSAGE('%1,%2',DocPosted,OpenApprovalEntriesExist);
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::RTGS then
            RTGSPayment := true
        else
            RTGSPayment := false;
        if Rec."Requested Payment" = Rec."Requested Payment"::Invoice then
            VendorVisible := true
        else
            VendorVisible := false;
    end;
}

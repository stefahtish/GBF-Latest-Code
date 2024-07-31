page 50355 "Payment Form Request"
{
    Caption = 'Request for payment form';
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Documents,Approval';
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Payment Request"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Request for Payment")
            {
                Enabled = not DocReleased;

                field("No."; Rec."No.")
                {
                    Editable = false;
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
                field("Account Type"; Rec."Account Type")
                {
                    visible = false;
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
                // field("PV No."; "PV No.")
                // {
                //     Enabled = false;
                // }
                // field("PV Paid"; "PV Paid")
                // {
                //     Enabled = false;
                // }
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
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    visible = false;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetCurrentKey("Document No.");
                        ApprovalEntry.SetRange("Table ID", Database::Payments);
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.RunModal();
                    end;
                }
                action(Navigate)
                {
                    Caption = '&Navigate';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
                    Visible = DocPosted;

                    trigger OnAction()
                    begin
                        Rec.Navigate;
                    end;
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
                separator(Action30)
                {
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
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;

                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        PaymentRec.Reset;
                        PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                        if PaymentRec.FindFirst then begin
                            PLines.Reset;
                            PLines.SetRange(No, PaymentRec."No.");
                            if PLines.FindFirst then begin
                                if PLines."Account Type" <> PLines."Account Type"::Vendor then
                                    REPORT.Run(Report::"Payment Voucher", true, false, PaymentRec)
                                else
                                    REPORT.Run(Report::"Payment Voucher-Vendor", true, false, PaymentRec);
                            end;
                        end;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'Create Payment Voucher';
                Image = Post;

                action(Post)
                {
                    Caption = 'Create PV';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = DocReleased;

                    trigger OnAction()
                    begin
                        //Uncommented the code
                        if Rec."PV created" = true then // Error('PV is already created, PV No. %1', Rec."PV No.");
                            // PaymentsPost.CreatePaymentVoucher(Rec);
                            Commit;
                        CurrPage.Close();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

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

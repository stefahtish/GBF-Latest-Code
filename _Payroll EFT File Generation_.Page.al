page 50735 "Payroll EFT File Generation"
{
    Caption = 'Payment file Generation';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Post,Validate';
    SourceTable = Payments;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = NOT Rec."EFT File Generated";

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                field("EFT File Generated"; Rec."EFT File Generated")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the EFT File Generated field';
                    ApplicationArea = All;
                }
                field("EFT Reference"; Rec."EFT Reference")
                {
                    ToolTip = 'Specifies the value of the EFT Reference field';
                    ApplicationArea = All;
                }
                field("EFT Date"; Rec."EFT Date")
                {
                    ToolTip = 'Specifies the value of the EFT Date field';
                    ApplicationArea = All;
                }
            }
            part(Control5; "EFT File Gen Lines")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Generate)
            {
                Enabled = NOT Rec."EFT File Generated";
                Caption = 'Select Payments';
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Select Payments action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PayMgt.LookupETFDocs(Rec);
                    // PayMgt.ValidateEFTBanks(Rec);
                end;
            }
            action(PreviewGenTax)
            {
                Caption = 'Preview Batch Tax to S2B';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Preview := true;
                    Rec.Modify();
                    Commit();
                    PayMgt.GenerateTaxEFTs(Rec);
                end;
            }
            action(GenTax)
            {
                Caption = 'Batch Tax to S2B';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Batch Tax EFT to S2B action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Preview := false;
                    Rec.Modify();
                    Commit();
                    PayMgt.GenerateTaxEFTs(Rec); //"Generate EFT Multiple Tax"
                end;
            }
            action(PreviewGenEFT)
            {
                Caption = 'Preview Batch EFT/RTGS/BT to S2B';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Batch EFT/RTGS/BT to S2B action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Preview := true;
                    Rec.Modify();
                    Commit();
                    PayMgt.GenerateMultipleEFTs(Rec);
                end;
            }
            action(GenEFT)
            {
                Caption = 'Batch EFT/RTGS/BT to S2B';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Batch EFT/RTGS/BT to S2B action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Preview := false;
                    Rec.Modify();
                    Commit();
                    PayMgt.GenerateMultipleEFTs(Rec);
                end;
            }
            action(Post)
            {
                Enabled = not Rec.Posted;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PayMgt.PostMultipleEFTs(Rec);
                end;
            }
            separator(Separator13)
            {
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                Visible = (Rec.Status = Rec.Status::Open);
                ToolTip = 'Executes the Send A&pproval Request action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendPaymentsForApproval(Rec);
                    Commit;
                    CurrPage.Close;
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Visible = (CanCancelApprovalForPayment) AND (Rec.Status = Rec.Status::"Pending Approval");
                ToolTip = 'Executes the Cancel Approval Re&quest action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to cancel the approval request? Please note this will uncommit previous committments regarding %1', false, Rec."No.") = true then begin
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                        Commit;
                    end;
                    CurrPage.Close;
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ToolTip = 'Executes the Approvals action';
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.FilterGroup(2);
                    ApprovalEntry.SetCurrentKey("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval");
                    ApprovalEntry.SetRange("Table ID", Database::Payments);
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"EFT File Gen");
                    ApprovalEntry.FilterGroup(0);
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.Run;
                end;
            }
            action(Preview)
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Preview action';
                ApplicationArea = All;

                trigger OnAction()
                var
                    EFTReport: Report "EFT Report";
                    Payment: Record Payments;
                begin
                    Payment.Reset();
                    Payment.SetRange("No.", Rec."No.");
                    EFTReport.SetTableView(Payment);
                    EFTReport.Run();
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payroll EFT File Gen";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payroll EFT File Gen";
    end;

    trigger OnOpenPage();
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payroll EFT File Gen";
    end;

    var
        PayMgt: Codeunit "Payments Management";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        [InDataSet]
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
}

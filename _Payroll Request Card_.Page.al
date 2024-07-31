page 50653 "Payroll Request Card"
{
    PageType = Card;
    SourceTable = "Payroll Requests";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Applies; Rec.Applies)
                {
                    trigger OnValidate()
                    begin
                        case Rec.Applies of
                            Rec.Applies::All:
                                begin
                                    ShowAll := true;
                                    ShowGroup := false;
                                    ShowOne := false;
                                end;
                            Rec.Applies::Group:
                                begin
                                    ShowAll := false;
                                    ShowGroup := true;
                                    ShowOne := false;
                                    Message('%1', ShowGroup);
                                end;
                            Rec.Applies::Specific:
                                begin
                                    ShowAll := false;
                                    ShowGroup := false;
                                    ShowOne := true;
                                end;
                        end;
                    end;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field(Type; Rec.Type)
                {
                }
                group(Control19)
                {
                    ShowCaption = false;
                    Visible = ShowGroup;

                    field(Group; Rec.Group)
                    {
                        Visible = ShowGroup;
                    }
                }
                group(Control20)
                {
                    ShowCaption = false;
                    Visible = ShowOne;

                    field("Employee No."; Rec."Employee No.")
                    {
                        Visible = ShowOne;
                    }
                    field("Employee Name"; Rec."Employee Name")
                    {
                        Visible = ShowOne;
                    }
                    field("Special Condition"; Rec."Special Condition")
                    {
                        trigger OnValidate()
                        begin
                            if Rec."Special Condition" <> Rec."Special Condition"::" " then
                                NormalCondition := false
                            else
                                NormalCondition := true;
                        end;
                    }
                    field(Gratuity; Rec.Gratuity)
                    {
                    }
                    field(Locum; Rec.Locum)
                    {
                        trigger OnValidate()
                        begin
                            if Rec.Locum then
                                ShowLocum := true
                            else
                                ShowLocum := false;
                        end;
                    }
                    group(Control25)
                    {
                        ShowCaption = false;
                        Visible = ShowLocum;

                        field("Principal Employee Code"; Rec."Principal Employee Code")
                        {
                        }
                        field("Principal Employee Name"; Rec."Principal Employee Name")
                        {
                        }
                        field("Principal Employee Basic"; Rec."Principal Employee Basic")
                        {
                        }
                        field(Hours; Rec.Hours)
                        {
                        }
                    }
                }
                group(Control28)
                {
                    ShowCaption = false;
                    Visible = NormalCondition;

                    field("Code"; Rec.Code)
                    {
                    }
                    field("Code Descripton"; Rec."Code Descripton")
                    {
                    }
                    field(Formula; Rec.Formula)
                    {
                    }
                    field(Percentage; Rec.Percentage)
                    {
                    }
                    field(Units; Rec.Units)
                    {
                    }
                    field(Amount; Rec.Amount)
                    {
                    }
                }
                group("Short Explanation")
                {
                    field(Remarks; Rec.Remarks)
                    {
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                }
            }
            part(Control35; "Emp. Payment Req Lines")
            {
                SubPageLink = "Document No" = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /* if ApprovalsMngt.CheckPayrollRequestWorkflowEnabled(Rec) then
                            ApprovalsMngt.OnSendPayrollRequestforApproval(Rec); */
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = false;

                trigger OnAction()
                begin
                    //ApprovalsMngt.OnCancelPayrollRequestApproval(Rec);
                end;
            }
            action(Approval)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
            action(Calculate)
            {
                trigger OnAction()
                begin
                    // PayrollMgt.GetPureFormula("Employee No.",PayrollMgt.GetCurrentPay(),Formula);
                    Rec.UpdateChange;
                end;
            }
            action(Post)
            {
                trigger OnAction()
                begin
                    PayrollMgt.PostPayrollRequest(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        case Rec.Applies of
            Rec.Applies::All:
                begin
                    ShowAll := true;
                    ShowGroup := false;
                    ShowOne := false;
                end;
            Rec.Applies::Group:
                begin
                    ShowAll := true;
                    ShowGroup := true;
                    ShowOne := false;
                end;
            Rec.Applies::Specific:
                begin
                    ShowAll := false;
                    ShowGroup := false;
                    ShowOne := true;
                end;
        end;
        if Rec.Locum then ShowLocum := true;
        if Rec."Special Condition" <> Rec."Special Condition"::" " then
            NormalCondition := false
        else
            NormalCondition := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Calculation Method" := Rec."Calculation Method"::Formula;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Calculation Method" := Rec."Calculation Method"::Formula;
    end;

    trigger OnOpenPage()
    begin
        NormalCondition := true;
        ShowAll := false;
        ShowGroup := false;
        ShowOne := false;
    end;

    var
        ShowAll: Boolean;
        ShowGroup: Boolean;
        ShowOne: Boolean;
        PayrollMgt: Codeunit Payroll;
        ShowLocum: Boolean;
        NormalCondition: Boolean;
        ApprovalsMngt: Codeunit ApprovalMgtCuExtension;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request";
        ApprovalEntries: Page "Approval Entries";
}

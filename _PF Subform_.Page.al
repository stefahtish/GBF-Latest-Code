page 50357 "PF Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Payment Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    Caption = 'Payment Type';
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        SetPageView;
                        CurrPage.Update;
                    end;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    Caption = 'Imprest Number';
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    Visible = ImprestVisible;
                }
                field("Claim No."; Rec."Claim No.")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    Visible = ClaimVisible;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    ShowMandatory = true;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Visible = DocReleased;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field(Description; Rec.Description)
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("General Expense Code"; Rec."General Expense Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("VAT Exclusive"; Rec."VAT Exclusive")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("W/Tax Code"; Rec."W/Tax Code")
                {
                    Caption = 'W/Tax Code';
                    Editable = NOT CanEdit AND NOT IsStatusPending;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("W/T VAT Code"; Rec."W/T VAT Code")
                {
                    Caption = 'W/T VAT Code';
                    Editable = NOT CanEdit AND NOT IsStatusPending;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("W/Tax Amount"; Rec."W/Tax Amount")
                {
                    Caption = 'W/Tax Amount';
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("W/T VAT Amount"; Rec."W/T VAT Amount")
                {
                    Caption = 'W/T VAT Amount';
                    Visible = false;
                }
                field("Retention Amount"; Rec."Retention Amount")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Vatable Amount"; Rec."Vatable Amount")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    Visible = LevyVisible;
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    Visible = LevyVisible;
                }
                field("10% Not Wtheld"; Rec."10% Not Wtheld")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    Visible = LevyVisible;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Editable = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc Type")
                {
                    Editable = false;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                    ShowMandatory = true;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Levied Invoice H"; Rec."Levied Invoice H")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec."Levied Invoice H" = true then
                            LevyVisible := true
                        else
                            LevyVisible := false;
                    end;
                }
                field(AppliedDoc; AppliedDoc)
                {
                    Caption = 'Applied Doc No.';
                    Editable = false;
                }
                field("Sort Code"; Rec."Sort Code")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Our Account No."; Rec."Our Account No.")
                {
                    Editable = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Imprest Payment"; Rec."Imprest Payment")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
                field("Claim Payment"; Rec."Claim Payment")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Dimensions)
            {
                Enabled = false;
                Image = Dimensions;

                trigger OnAction()
                begin
                    Rec.ShowDimensions;
                    CurrPage.SaveRecord;
                end;
            }
            action("Apply Entries")
            {
                Caption = 'Apply Entries';
                Ellipsis = true;
                Image = ApplyEntries;
                ShortCutKey = 'Shift+F11';
                ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';
                Visible = NOT DocPosted;

                trigger OnAction()
                begin
                    PaymentMgt.ApplyEntry(Rec);
                end;
            }
            action("Suggent Payment Lines")
            {
                Image = Payment;
                Visible = false;

                trigger OnAction()
                begin
                    //PReport.GetNo(No);
                    //PReport.RUN;
                end;
            }
            action("Purch. Invoice")
            {
                Visible = false;

                trigger OnAction()
                var
                    PurchInv: Record "Purch. Inv. Header";
                begin
                    PurchInv.Reset;
                    PurchInv.SetRange("No.", Rec."Vendor Invoice");
                    REPORT.RunModal(Report::"Purchase - Invoice", true, true, PurchInv);
                end;
            }
            action("View Applied Entries")
            {
                Image = Approve;
                Visible = DocPosted;

                trigger OnAction()
                begin
                    PaymentMgt.ViewAppliedEntries(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Levied Invoice H" = true then
            LevyVisible := true
        else
            LevyVisible := false;
        AppliedDoc := Rec.GetAppliedDoc;
        SetPageView;
    end;

    trigger OnInit()
    begin
        ClaimVisible := false;
        ImprestVisible := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Levied Invoice H" = true then
            LevyVisible := true
        else
            LevyVisible := false;
        AppliedDoc := Rec.GetAppliedDoc;
        SetPageView;
    end;

    var
        PaymentMgt: Codeunit "Payments Management";
        ShortcutDimCode: array[8] of Code[20];
        LevyVisible: Boolean;
        AppliedDoc: Code[50];
        ClaimVisible: Boolean;
        ImprestVisible: Boolean;
        DocReleased: Boolean;
        Payments: Record Payments;
        CanEdit: Boolean;
        IsStatusPending: Boolean;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        AppliedVendorEntries: Page "Applied Vendor Entries-Custom";
        DocPosted: Boolean;

    local procedure SetPageView()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntry: Record "Approval Entry";
        DocStatus: Option Open,Released,"Pending Approval","Pending Prepayment",Canceled,Disapproved,Committed,Fulfilled;
    begin
        if Rec."Claim Payment" then ClaimVisible := true;
        if Rec."Imprest Payment" then ImprestVisible := true;
        if Payments.Get(Rec.No) then begin
            if Payments.Status = Payments.Status::Released then
                DocReleased := true
            else
                DocReleased := false;
            if Payments.Posted then
                DocPosted := true
            else
                DocPosted := false;
        end;
        if Payments.Get(Rec.No) then begin
            DocStatus := Payments.Status;
            case Payments.Status of
                Payments.Status::Released:
                    begin
                        CanEdit := true;
                        IsStatusPending := false;
                    end;
                Payments.Status::"Pending Approval":
                    begin
                        CanEdit := false;
                        IsStatusPending := true;
                    end
                else
                    CanEdit := false;
                    IsStatusPending := false;
            end;
        end;
    end;
}

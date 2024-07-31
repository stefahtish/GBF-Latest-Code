page 50148 "PV Subform"
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
                    // Editable = IsStatusPending;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Payment Type field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetPageView;
                        CurrPage.Update;
                    end;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Account Type field';
                    ApplicationArea = All;
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    Caption = 'Imprest Number';
                    Editable = IsStatusPending;
                    Visible = ImprestVisible;
                    ToolTip = 'Specifies the value of the Imprest Number field';
                    ApplicationArea = All;
                }
                field("Claim No."; Rec."Claim No.")
                {
                    Editable = false;
                    Visible = IsPension;
                    ToolTip = 'Specifies the value of the Claim No. field';
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Account No field';
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    visible = IsPension;
                    ApplicationArea = All;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    visible = IsPension;
                    ApplicationArea = All;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Visible = DocReleased;
                    ToolTip = 'Specifies the value of the Gen. Posting Type field';
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Account Name field';
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee field';
                }
                field(Description; Rec.Description)
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field';
                    ApplicationArea = All;
                }
                field("POP Code"; Rec."POP Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the POP Code field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    // Visible = DocReleased;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field("Pay Mode Type"; Rec."Pay Mode Type")
                {
                    //Visible = DocReleased;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Mode Type field';
                }
                field("System Amount"; Rec."System Amount")
                {
                    Visible = IsTax;
                    ApplicationArea = All;
                }
                field(KRAAmount; Rec.Amount)
                {
                    Caption = 'KRA Amount';
                    Visible = IsTax;
                    // Editable =CanEdit AND NOT IsStatusPending;
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = not IsTax;
                    // Editable =CanEdit AND NOT IsStatusPending;
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("VAT Exclusive"; Rec."VAT Exclusive")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the VAT Exclusive field';
                    ApplicationArea = All;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the VAT Code field';
                    ApplicationArea = All;
                }
                field("W/Tax Code"; Rec."W/Tax Code")
                {
                    Caption = 'W/Tax Code';
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the W/Tax Code field';
                    ApplicationArea = All;
                    // trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    // begin
                    //     CurrPage.Update();
                    // end;
                }
                field("W/T VAT Code"; Rec."W/T VAT Code")
                {
                    Caption = 'W/T VAT Code';
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the W/T VAT Code field';
                    ApplicationArea = All;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Retention Code field';
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the VAT Amount field';
                    ApplicationArea = All;
                }
                field("W/Tax Amount"; Rec."W/Tax Amount")
                {
                    Caption = 'W/Tax Amount';
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the W/Tax Amount field';
                    ApplicationArea = All;
                }
                field("W/T VAT Amount"; Rec."W/T VAT Amount")
                {
                    Caption = 'W/T VAT Amount';
                    ToolTip = 'Specifies the value of the W/T VAT Amount field';
                    ApplicationArea = All;
                }
                field("Retention Amount"; Rec."Retention Amount")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Retention Amount field';
                    ApplicationArea = All;
                }
                field("Vatable Amount"; Rec."Vatable Amount")
                {
                    Editable = IsStatusPending;
                    Visible = LevyVisible;
                    ToolTip = 'Specifies the value of the Vatable Amount field';
                    ApplicationArea = All;
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    Editable = IsStatusPending;
                    Visible = LevyVisible;
                    ToolTip = 'Specifies the value of the Other Charges field';
                    ApplicationArea = All;
                }
                field("10% Not Wtheld"; Rec."10% Not Wtheld")
                {
                    Editable = IsStatusPending;
                    Visible = LevyVisible;
                    ToolTip = 'Specifies the value of the 10% Not Wtheld field';
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Net Amount field';
                    ApplicationArea = All;
                }
                field("Payee Bank Code"; Rec."Payee Bank Code")
                {
                    //Visible = DocReleased;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee Bank Code field';
                }
                field("Payee Bank Branch Code"; Rec."Payee Bank Branch Code")
                {
                    //Visible = DocReleased;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee Bank Branch Code field';
                }
                field("Payee Bank Account No"; Rec."Payee Bank Account No")
                {
                    //Visible = DocReleased;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee Bank Account No field';
                }
                field("Payee Account Name"; Rec."Payee Account Name")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to ID field';
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field';
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field';
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Purpose field';
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount (LCY) field';
                    ApplicationArea = All;
                }
                // field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                // {
                //     Editable =CanEdit AND NOT IsStatusPending;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                //     ApplicationArea = All;
                // }
                // field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                // {
                //     Editable =CanEdit AND NOT IsStatusPending;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                //     ApplicationArea = All;
                // }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field';
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field';
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field';
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field';
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field';
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Levied Invoice H"; Rec."Levied Invoice H")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Levied Invoice H field';
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the Applied Doc No. field';
                    ApplicationArea = All;
                }
                field("Sort Code"; Rec."Sort Code")
                {
                    Visible = false;
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Sort Code field';
                    ApplicationArea = All;
                }
                field("Our Account No."; Rec."Our Account No.")
                {
                    Visible = false;
                    Editable = IsStatusPending;
                    ToolTip = 'Specifies the value of the Our Account No. field';
                    ApplicationArea = All;
                }
                field("Imprest Payment"; Rec."Imprest Payment")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Imprest Payment field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
                field("Claim Payment"; Rec."Claim Payment")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Claim Payment field';
                    ApplicationArea = All;

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
                ToolTip = 'Executes the Dimensions action';
                ApplicationArea = All;

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
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PaymentMgt.ApplyEntry(Rec, false);
                end;
            }
            action("Suggent Payment Lines")
            {
                Image = Payment;
                Visible = false;
                ToolTip = 'Executes the Suggent Payment Lines action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //PReport.GetNo(No);
                    //PReport.RUN;
                end;
            }
            action("Purch. Invoice")
            {
                Visible = false;
                ToolTip = 'Executes the Purch. Invoice action';
                ApplicationArea = All;

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
                ToolTip = 'Executes the View Applied Entries action';
                ApplicationArea = All;

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
        //SetPageView;
    end;

    var
        PaymentMgt: Codeunit "Payments Management";
        ShortcutDimCode: array[8] of Code[20];
        LevyVisible: Boolean;
        AppliedDoc: Code[50];
        ClaimVisible: Boolean;
        ImprestVisible: Boolean;
        DocReleased: Boolean;
        IsPension: Boolean;
        Payments: Record Payments;
        CanEdit: Boolean;
        IsStatusPending: Boolean;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        AppliedVendorEntries: Page "Applied Vendor Entries-Custom";
        DocPosted: Boolean;
        IsTax: Boolean;

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
            if Payments."PV Type" = Payments."PV Type"::Pension then
                IsPension := true
            else
                IsPension := false;
        end;
        if Payments.Get(Rec.No) then begin
            DocStatus := Payments.Status;
            case Payments.Status of
                Payments.Status::Released, Payments.Status::"Pending Approval", Payments.Status::Open:
                    begin
                        CanEdit := true;
                        IsStatusPending := true;
                    end
                else
                    CanEdit := false;
                    IsStatusPending := false;
            end;
            if Payments."Payment File" = Payments."Payment File"::Tax then
                IsTax := true
            else
                IsTax := false;
        end;
    end;
}

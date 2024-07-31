page 51137 "License and Permit Renewal"
{
    PageType = Card;
    SourceTable = "License Applications";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field("Renewal License No."; Rec."Renewal License No.")
                {
                    ApplicationArea = All;
                    Caption = 'Regulatory Permit No.';
                }
                field(Outlet; Rec.Outlet)
                {
                }
                field(Category; Rec.Category)
                {
                    Caption = 'Regulatory Permit';
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Enabled = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }
                field(Submitted; Rec.Submitted)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    Visible = false;
                }
            }
            group("Payment Details")
            {
                Visible = payment;

                // field("Invoice No."; "Invoice No.")
                // {
                // }
                // field(Amount; Amount)
                // {
                // }
                // field("Receipt No."; "Receipt No.")
                // {
                // }
                field("License fee Invoice No."; Rec."License fee Invoice No.")
                {
                    Caption = 'Permit fee Invoice No';
                }
                field("License fee Receipt No."; Rec."License fee Receipt No.")
                {
                    Caption = 'Permit fee Receipt No';
                }
                field("License fee"; Rec."License fee")
                {
                    Caption = 'Permit fee Amount';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Visible = not Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Paymgmt: codeunit "Payments Management";
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    Rec.TestField(Category);
                    //  Paymgmt.InvoiceLicenseRenewal("Applicant No.", "No.");
                    // if ApprovalsMgmt.CheckLicenseApplicationWorkflowEnabled(Rec) then
                    //     ApprovalsMgmt.OnSendLicenseApplicationForApproval(Rec);
                    currpage.close;
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = PendingApproval;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                begin
                    // ApprovalsMgmt.OnCancelLicenseApplicationApprovalRequest(Rec);
                    CurrPage.Close;
                end;
            }
            action("Invoice Annual fee")
            {
                Visible = Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                // PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Paymgmt: codeunit "Payments Management";
                begin
                    Rec.TestField(Category);
                    Paymgmt.InvoiceLicenseRenewal(Rec."Applicant No.", Rec."No.");
                    currpage.close;
                end;
            }
            action("Approve")
            {
                Visible = Rec.Submitted;
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                // PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Paymgmt: codeunit "Payments Management";
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Validate(Status);
                end;
            }
            action("Reject")
            {
                Visible = Rec.Submitted;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                // PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Paymgmt: codeunit "Payments Management";
                begin
                    Rec.Status := Rec.Status::Rejected;
                end;
            }
            action(Receipt)
            {
                Visible = Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                // PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CompMgmt: codeunit "MPESA Integration";
                begin
                    CompMgmt.PostPayments(Rec."No.");
                    currpage.close;
                end;
            }
        }
    }
    var
        payment: Boolean;
        License: Boolean;
        PendingApproval: Boolean;

    trigger OnAfterGetCurrRecord()
    var
    begin
        SetControlAppearance();
    end;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec.Status <> Rec.Status::Open then
            payment := true
        else
            payment := false;
        if Rec.Status = Rec.Status::Approved then
            License := true
        else
            License := false;
        if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then
            PendingApproval := true
        else
            PendingApproval := false;
    end;
}

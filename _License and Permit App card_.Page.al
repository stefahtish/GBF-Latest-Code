page 51134 "License and Permit App card"
{
    Caption = 'Permit Application card';
    PageType = Card;
    SourceTable = "License Applications";
    PromotedActionCategories = 'New,Process,Report,Approvals';
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
                field(Outlet; Rec.Outlet)
                {
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    Enabled = false;
                }
                group(Renewal)
                {
                    ShowCaption = false;
                    Visible = Renewal;

                    field("Renewal License No."; Rec."Renewal License No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Regulatory Permit No.';
                    }
                }
                field("Application Date"; Rec."Application Date")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    caption = 'Regulatory Permit';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    //Enabled = false;
                    ApplicationArea = All;
                }
                // field("Approval Status"; "Approval Status")
                // {
                //     //Enabled = false;
                //     ApplicationArea = All;
                // }
                field(Submitted; Rec.Submitted)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                    //Visible = false;
                }
                field("Station Manager comment"; Rec."Station Manager comment")
                {
                    ApplicationArea = All;
                }
                field("Head office comment"; Rec."Head office comment")
                {
                    ApplicationArea = All;
                }
                field("Sent to LIS"; Rec."Sent to LIS")
                {
                    ApplicationArea = All;
                }
                field("Inspection findings"; Rec."Inspection findings")
                {
                    visible = false;
                    ApplicationArea = All;
                }
            }
            group("Payment Details")
            {
                Visible = false;

                // field("Invoice No."; "Invoice No.")
                // {
                //     ApplicationArea = All;
                // }
                // field(Amount; Amount)
                // {
                //     ApplicationArea = All;
                // }
                // field("Receipt No."; "Receipt No.")
                // {
                //     ApplicationArea = All;
                // }
                field("License fee Invoice No."; Rec."License fee Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("License fee"; Rec."License fee")
                {
                    ApplicationArea = All;
                }
                field("License fee Receipt No."; Rec."License fee Receipt No.")
                {
                    ApplicationArea = All;
                }
            }
            group(License)
            {
                ShowCaption = false;
                visible = License;

                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("License No."; Rec."License No.")
                {
                    Caption = 'Regulatory Permit No.';
                    ApplicationArea = All;
                }
            }
            part(Documents; "Licensing Required Documents")
            {
                Caption = 'Required Documents';
                SubPageLink = "No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
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
                    App: record "Licensing dairy Enterprise";
                    Paymgmt: codeunit "Payments Management";
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    Cust: Record Customer;
                begin
                    Rec.TestField(Category);
                    if ApprovalsMgmt.CheckLicenseApplicationWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendLicenseApplicationForApproval(Rec);
                    Rec.Submitted := true;
                    Rec.Status := Rec.Status::"Pending inspection";
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
                    ApprovalsMgmt.OnCancelLicenseApplicationApprovalRequest(Rec);
                    Rec.Submitted := false;
                    CurrPage.Close;
                end;
            }
            action("Approve")
            {
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
            action(Approvals)
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
                    ApprovalEntry.SetRange("Table ID", Database::"License Applications");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.RunModal();
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
            action("Invoice Annual fee")
            {
                Visible = AnnualFee;
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
                    //TestField("Application Type");
                    if Rec."Application Type" = Rec."Application Type"::Application then Paymgmt.InvoiceLicenseAnnualFee(Rec."Applicant No.", Rec."No.");
                    if Rec."Application Type" = Rec."Application Type"::Renewal then Paymgmt.InvoiceLicenseRenewal(Rec."Applicant No.", Rec."No.");
                    currpage.close;
                end;
            }
            action("Issue Permit")
            {
                Visible = Rec.Submitted and not Archived;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CompMgmt: codeunit "Compliance Management";
                begin
                    Rec."Issued Date" := Today;
                    Rec."Expiry Date" := CalcDate('1Y', Rec."Issued Date");
                    Commit();
                    CompMgmt.IssueLicense(Rec."No.");
                    currpage.close;
                end;
            }
            action("HOD Approve")
            {
                Visible = Rec.Submitted and not Archived;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    OnlineMgmt: codeunit "Online Portal Services";
                begin
                    OnlineMgmt.HeadOfficeApproval(Rec."No.", '');
                    currpage.close;
                end;
            }
            //HODApproval
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
        AnnualFee: Boolean;
        Renewal: Boolean;
        PendingApproval: Boolean;
        Archived: Boolean;

    trigger OnAfterGetRecord()
    var
        App: record "Licensing dairy Enterprise";
        Paymgmt: codeunit "Payments Management";
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    var
        App: record "Licensing dairy Enterprise";
        Paymgmt: codeunit "Payments Management";
    begin
        SetControlAppearance();
    end;

    procedure SetControlAppearance()
    var
        RegPermits: Record "License and Permit Category";
    begin
        if Rec.Status <> Rec.Status::Open then
            payment := true
        else
            payment := false;
        if Rec.Status = Rec.Status::Approved then
            License := true
        else
            License := false;
        if Rec.Status <> Rec.Status::Archived then
            Archived := false
        else
            Archived := true;
        if Rec."Application Type" = Rec."Application Type"::Renewal then
            Renewal := true
        else
            Renewal := false;
        RegPermits.Reset();
        RegPermits.SetRange("License/Permit Category", Rec.Category);
        if RegPermits.FindFirst() then begin
            if (RegPermits."Annual fees(Ksh)" <> 0) and (Rec.Submitted = true) then
                AnnualFee := true
            else
                AnnualFee := false;
            if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then
                PendingApproval := true
            else
                PendingApproval := false;
        end;
    end;
}

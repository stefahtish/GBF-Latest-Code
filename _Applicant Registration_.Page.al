page 50952 "Applicant Registration"
{
    PageType = Card;
    SourceTable = "Licensing dairy Enterprise";
    PromotedActionCategories = 'New,Process,Report,Approvals';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application no"; Rec."Application no")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        Rec.InsertDocuments(Rec."Application no");
                    end;
                }
                group(Individual)
                {
                    ShowCaption = false;
                    Visible = Individual;

                    field(Salutation; Rec.Salutation)
                    {
                        ApplicationArea = All;
                    }
                    field("First Name"; Rec."First Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Middle Name"; Rec."Middle Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Last Name"; Rec."Last Name")
                    {
                        ApplicationArea = All;
                    }
                    field("ID Number"; Rec."ID Number")
                    {
                        ApplicationArea = basic, suite;
                    }
                    field("Individual Pin Number"; Rec."Individual Pin Number")
                    {
                        ApplicationArea = basic, suite;
                    }
                    field(Submitted; Rec.Submitted)
                    {
                        Visible = false;
                        ApplicationArea = All;
                    }
                }
                group(Company)
                {
                    Visible = Company;
                    ShowCaption = false;

                    field("Business Name"; Rec."Business Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Company Pin Number"; Rec."Company Pin Number")
                    {
                        ApplicationArea = basic, suite;
                    }
                    field("Company Registration Number"; Rec."Company Registration Number")
                    {
                        ApplicationArea = basic, suite;
                    }
                    field("Contact Person Salutation"; Rec."Contact Person Salutation")
                    {
                        ApplicationArea = All;
                    }
                    field("Contact Person Name"; Rec."Contact Person Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Contact Person Telephone"; Rec."Contact Person Telephone")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Office No."; Rec."Office No.")
                {
                    Caption = 'Office Number 1';
                    ApplicationArea = basic, suite;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = basic, suite;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = basic, suite;
                }
                field("E-Mail 1"; Rec."E-Mail 1")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Physical Address(Building)"; Rec."Physical Address(Building)")
                {
                    Caption = 'Building/Premise';
                    ApplicationArea = basic, suite;
                }
                field("Physical Address(Street/Road"; Rec."Physical Address(Street/Road")
                {
                    Caption = 'Street';
                    ApplicationArea = basic, suite;
                }
                field("Plot Number"; Rec."Plot Number")
                {
                    ApplicationArea = All;
                }
                field("Registered Office"; Rec."Registered Office")
                {
                    ApplicationArea = basic, suite;
                }
                field("Cell Phone Number 2"; Rec."Cell Phone Number 2")
                {
                    ApplicationArea = basic, suite;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = basic, suite;
                }
                field("County Name"; Rec."County Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(SubCounty; Rec.SubCounty)
                {
                    ApplicationArea = basic, suite;
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    Caption = 'Branch';
                    ApplicationArea = basic, suite;
                    Enabled = false;
                }
                field(Market; Rec.Market)
                {
                    ApplicationArea = All;
                }
                field("Cell Phone Number 1"; Rec."Cell Phone Number 1")
                {
                    ApplicationArea = basic, suite;
                }
                field(Website; Rec.Website)
                {
                    ApplicationArea = basic, suite;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = basic, suite;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Office Number 2"; Rec."Office Number 2")
                {
                    ApplicationArea = basic, suite;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = basic, suite;
                    Enabled = false;
                }
                field(Confirmed; Rec.Confirmed)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
            part("License applicant outlets"; "License applicant outlets")
            {
                Caption = 'Outlets';
                SubPageLink = "Application no" = field("Application no");
                ApplicationArea = All;
            }
            part(Products; "Licensing Required Documents")
            {
                Caption = 'Required Documents';
                SubPageLink = "No." = field("Application no");
                ApplicationArea = All;
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
            action("Send Approval Request")
            {
                Caption = 'Submit';
                Visible = not Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Paymgmt: codeunit "Payments Management";
                    Docs: Record "Licensing Required Documents";
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    CompSetup: Record "Compliance Setup";
                begin
                    Rec.TestField("Customer Type");
                    if Rec."Customer Type" = Rec."Customer Type"::Individual then begin
                        Rec.TestField("Individual Pin Number");
                        Rec.TestField("ID Number");
                    end;
                    if Rec."Customer Type" = Rec."Customer Type"::"Registered Entity" then begin
                        Rec.TestField("Company Pin Number");
                        Rec.TestField("Company Registration Number");
                    end;
                    CompSetup.get;
                    if CompSetup."Enforce Workflow" then begin
                        if ApprovalsMgmt.CheckLicenseRegistrationWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendLicenseRegistrationForApproval(Rec);
                    end
                    else begin
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        Rec.Submitted := true;
                    end;
                    if GuiAllowed then Message('Registration Successful');
                    CurrPage.Close();
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Visible = InvolveApprovals;
                Enabled = PendingApproval;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                begin
                    ApprovalsMgmt.OnCancelLicenseRegistrationApprovalRequest(Rec);
                    CurrPage.Close;
                end;
            }
            action(Approvals)
            {
                Visible = InvolveApprovals;
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
                    ApprovalEntry.SetRange("Table ID", Database::"Licensing dairy Enterprise");
                    ApprovalEntry.SetRange("Document No.", Rec."Application no");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.RunModal();
                end;
            }
            action(Permits)
            {
                Visible = Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = page "Issued Licenses";
                RunPageLink = "Applicant No." = field("Application no");
            }
        }
    }
    trigger OnafterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance;
    end;

    var
        Individual: Boolean;
        Company: Boolean;
        PendingApproval: Boolean;
        CompSetup: Record "Compliance Setup";
        InvolveApprovals: Boolean;

    local procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec."Customer Type" = Rec."Customer Type"::Individual then
            Individual := true
        else
            Individual := false;
        if Rec."Customer Type" = Rec."Customer Type"::"Registered Entity" then
            Company := true
        else
            Company := false;
        if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then
            PendingApproval := true
        else
            PendingApproval := false;
        CompSetup.Get;
        if CompSetup."Enforce Workflow" then
            InvolveApprovals := true
        else
            InvolveApprovals := false;
    end;
}

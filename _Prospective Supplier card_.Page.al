page 50819 "Prospective Supplier card"
{
    PageType = Card;
    SourceTable = "Prospective Suppliers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Editable = IsEditable;

                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Company PIN No"; Rec."Company PIN No.")
                {
                    ApplicationArea = all;
                }
                field("Supplier Types"; Rec."Supplier Types")
                {
                    Caption = 'Supplier Type';
                    VISIBLE = FALSE;
                    ApplicationArea = all;
                }
                field("Type of Supplier"; Rec."Type of Supplier")
                {
                    ApplicationArea = all;
                }
                field("Organization Type"; Rec."Organization Type")
                {
                    ApplicationArea = all;
                }
                field("Supplier Type"; Rec."Supplier Type")
                {
                    ApplicationArea = all;
                }
                field("Agpo Group"; Rec."Agpo Group")
                {
                    ApplicationArea = all;
                }
                field("Agpo Number"; Rec."Agpo Number")
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = all;
                }
                field(Submitted; Rec.Submitted)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    //  Visible = false;
                    ApplicationArea = all;
                    Editable = false;
                }
                group("Company Address")
                {
                    field("Physical Address"; Rec."Physical Address")
                    {
                        ApplicationArea = all;
                    }
                    field("E-mail"; Rec."E-mail")
                    {
                        ApplicationArea = all;
                    }
                    field("Telephone No"; Rec."Telephone No")
                    {
                        ApplicationArea = all;
                    }
                    field("Mobile No"; Rec."Mobile No")
                    {
                        ApplicationArea = all;
                    }
                    field("Postal Address"; Rec."Postal Address")
                    {
                        ApplicationArea = all;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = all;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = all;
                    }
                    field(Road; Rec.Road)
                    {
                        ApplicationArea = all;
                    }
                    field(Building; Rec.Building)
                    {
                        ApplicationArea = all;
                    }
                    field(Street; Rec.Street)
                    {
                        ApplicationArea = all;
                    }
                    field("Plot No"; Rec."Plot No")
                    {
                        ApplicationArea = all;
                    }
                }
                group("Contact Person")
                {
                    field(Title; Rec.Title)
                    {
                        ApplicationArea = all;
                    }
                    field("Contact Person Name"; Rec."Contact Person Name")
                    {
                        ApplicationArea = all;
                    }
                    field("Job Title"; Rec."Job Title")
                    {
                        ApplicationArea = all;
                    }
                    field("Contact Phone No."; Rec."Contact Phone No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Contact E-Mail Address"; Rec."Contact E-Mail Address")
                    {
                        ApplicationArea = all;
                    }
                }
                group("Bank Account Details")
                {
                    field("Bank Account Type"; Rec."Bank Account Type")
                    {
                        ApplicationArea = all;
                    }
                    field("KBA Bank Code"; Rec."KBA Bank Code")
                    {
                        ApplicationArea = all;
                        Caption = 'Bank Code';
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                        ToolTip = 'Specifies the value of the Bank Name field.';
                        ApplicationArea = All;
                    }
                    field("KBA Branch Code"; Rec."KBA Branch Code")
                    {
                        ApplicationArea = all;
                        Caption = 'Branch Code';
                    }
                    field("Bank Branch Name"; Rec."Bank Branch Name")
                    {
                        ToolTip = 'Specifies the value of the Bank Branch Name field.';
                        ApplicationArea = All;
                    }
                    field("Bank account No"; Rec."Bank account No")
                    {
                        ApplicationArea = all;
                    }
                    field("Currency Code"; Rec."Currency Code")
                    {
                        ApplicationArea = all;
                    }
                }
                // field(Category; Category)
                // {
                // }
                // field("Category Name"; "Category Name")
                // {
                //     Enabled = false;
                // }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                    ApplicationArea = all;
                }
                field("Supplier Status"; Rec."Supplier Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = all;
                }
                field("Pre Qualified"; Rec."Pre Qualified")
                {
                    ApplicationArea = all;
                }
                field("Fax No"; Rec."Fax No")
                {
                    ApplicationArea = all;
                }
                field("Registration No"; Rec."Registration No")
                {
                    ApplicationArea = all;
                }
                field("Certificate of incorporation"; Rec."Certificate of incorporation")
                {
                    ApplicationArea = all;
                }
                field("Tax Compliance Certificate"; Rec."Tax Compliance Certificate")
                {
                    ApplicationArea = all;
                }
                field("Tenders Applied"; Rec."Tenders Applied")
                {
                    ApplicationArea = all;
                    Caption = 'No of applications';
                }
                field("Vendor Created"; Rec."Vendor Created")
                {
                    ApplicationArea = all;
                }
            }
            part("Prequalified Supplier Codes"; "Prequalified Supplier Codes")
            {
                ApplicationArea = all;
                SubPageLink = Vendor = field("No.");
            }
            part("Prospective Supplier Documents"; "Prospective Supplier Documents")
            {
                ApplicationArea = all;
                SubPageLink = "Prospect No." = field("No.");
            }
            part("Prospective Board of Directors"; "Prospective Board of Directors")
            {
                ApplicationArea = all;
                SubPageLink = "Prospect No." = field("No.");
            }
            part(Addendum; "Addendum Registration")
            {
                ApplicationArea = all;
                SubPageLink = "Prospect No." = field("No.");
            }
            part("Tenders"; "Prospective Supplier Tenders")
            {
                ApplicationArea = all;
                Caption = 'Applications';
                SubPageLink = "Prospect No." = field("No.");
            }
            part("Prospective Supplier Lines"; "Prospective Supplier Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Response No" = field("No.");
                Visible = false;
            }
        }
        area(FactBoxes)
        {
            part("Document Attachment Factbox"; "Prospective Supp ListPart")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control53; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(CreateVendor)
            {
                Caption = 'Create Vendor';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = Rec."Vendor Created" = false;
                Enabled = Rec.Status = Rec.Status::Released;

                trigger OnAction()
                begin
                    Rec.CreateVendr(Rec);
                    Rec."Vendor Created" := true;
                    Rec.Modify();
                end;
            }
            action(Submit)
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Rec.Submitted := true;
                    commit;
                end;
            }
            action(Evaluate)
            {
                Visible = Rec.Submitted;
                ApplicationArea = all;
                Caption = 'Send for Evaluation';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SupplierTender: Record "Prospective Supplier Tender";
                begin
                    if Confirm('Are you sure?', false) then begin
                        // SupplierTender.SetRange("Prospect No.", "No.");
                        // ProcMgt.SendProspectiveSupplierForEvaluation(SupplierTender."Tender No.");
                        ProcMgt.SendProspectiveSupplierForEvaluation(Rec);
                    end;
                    CurrPage.Close();
                end;
            }
            action(Links)
            {
                Image = SelectEntries;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "Procurement Documents";
                RunPageLink = "Supplier No." = FIELD("No.");
            }
            action("Send for Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Send this Request for Approval', true) = false then
                        exit
                    else if ApprovalMgt.CheckProspectiveSupplierRequestWorkflowEnabled(Rec) then ApprovalMgt.OnSendProspectiveSuppliersApprovalRequest(Rec);
                end;
            }
            action("Cancel Approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Released);

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelProspectiveSuppliersApprovalRequest(Rec);
                end;
            }
        }
        area(Navigation)
        {
            action("Upload Document")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Upload documents for the record.';

                trigger OnAction()
                var
                    OnlinePortal: Codeunit "Online Portal Services";
                    Companyinformation: Record "Company Information";
                begin
                    Companyinformation.Get();
                    // FromFile := DocumentManagement.UploadSUpplierAppDocuments(Rec."No.", CurrPage.Caption, Rec.RecordId);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Tender;
        Rec.Submitted := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Tender;
        Rec.Submitted := true;
    end;

    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;

    var
        ProcMgt: Codeunit "Procurement Management";
        //eddie DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;
        IsEditable: Boolean;
        RecID: RecordId;

    local procedure SetPageView()
    begin
        IsEditable := false;
        if Rec.Status = Rec.Status::Open then IsEditable := true;
    end;
}

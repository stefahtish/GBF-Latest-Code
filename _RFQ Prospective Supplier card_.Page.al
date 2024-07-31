page 51314 "RFQ Prospective Supplier card"
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
                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                }
                field("Company PIN No"; Rec."Company PIN No.")
                {
                }
                field("Supplier Types"; Rec."Supplier Types")
                {
                    Caption = 'Supplier Type';
                    VISIBLE = FALSE;
                }
                field("Type of Supplier"; Rec."Type of Supplier")
                {
                }
                field("Organization Type"; Rec."Organization Type")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    Enabled = false;
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                group("Company Address")
                {
                    field("Physical Address"; Rec."Physical Address")
                    {
                    }
                    field("E-mail"; Rec."E-mail")
                    {
                    }
                    field("Telephone No"; Rec."Telephone No")
                    {
                    }
                    field("Mobile No"; Rec."Mobile No")
                    {
                    }
                    field("Postal Address"; Rec."Postal Address")
                    {
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                    }
                    field(City; Rec.City)
                    {
                    }
                    field(Road; Rec.Road)
                    {
                    }
                    field(Building; Rec.Building)
                    {
                    }
                    field(Street; Rec.Street)
                    {
                    }
                    field("Plot No"; Rec."Plot No")
                    {
                    }
                }
                group("Contact Person")
                {
                    field(Title; Rec.Title)
                    {
                    }
                    field("Contact Person Name"; Rec."Contact Person Name")
                    {
                    }
                    field("Job Title"; Rec."Job Title")
                    {
                    }
                    field("Contact Phone No."; Rec."Contact Phone No.")
                    {
                    }
                    field("Contact E-Mail Address"; Rec."Contact E-Mail Address")
                    {
                    }
                }
                group("Bank Account Details")
                {
                    field("Bank Account Type"; Rec."Bank Account Type")
                    {
                    }
                    field("KBA Bank Code"; Rec."KBA Bank Code")
                    {
                        Caption = 'Bank Code';
                    }
                    field("KBA Branch Code"; Rec."KBA Branch Code")
                    {
                        Caption = 'Branch Code';
                    }
                    field("Bank account No"; Rec."Bank account No")
                    {
                    }
                    field("Currency Code"; Rec."Currency Code")
                    {
                    }
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                }
                field("Contract Period"; Rec."Contract Period")
                {
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                }
                field("Supplier Status"; Rec."Supplier Status")
                {
                    Editable = false;
                }
                field(Selected; Rec.Selected)
                {
                }
                field("Pre Qualified"; Rec."Pre Qualified")
                {
                }
                field("Fax No"; Rec."Fax No")
                {
                }
                field("Category Name"; Rec."Category Name")
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                }
                field("Certificate of incorporation"; Rec."Certificate of incorporation")
                {
                }
                field("Tax Compliance Certificate"; Rec."Tax Compliance Certificate")
                {
                }
                field("Tenders Applied"; Rec."Tenders Applied")
                {
                }
            }
            part("Tenders"; "Prospective Supplier Tenders")
            {
                Caption = 'RFQ Applied';
                SubPageLink = "Prospect No." = field("No.");
            }
            part("Prospective Supplier Lines"; "Prospective Supplier Lines")
            {
                SubPageLink = "Response No" = field("No.");
                Visible = false;
            }
        }
        area(FactBoxes)
        {
            part(Attachments; "Document Attachment Factbox")
            {
                Caption = 'Portal Attachments';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(50729), "No." = field("No.");
            }
            systempart(Links; Links)
            {
                Caption = 'Attachments';
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
                Visible = false;

                trigger OnAction()
                begin
                    Rec.CreateVendr(Rec);
                end;
            }
            action(Submit)
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Submitted := true;
                    commit;
                end;
            }
            // action(Evaluate)
            // {
            //     Caption = 'Send for Evaluation';
            //     Image = SendConfirmation;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     begin
            //         if Confirm('Are you sure?', false) then
            //             ProcMgt.SendProspectiveSupplierForEvaluation(Rec);
            //         CurrPage.Close();
            //     end;
            // }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::RFQ;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::RFQ;
    end;

    var
        ProcMgt: Codeunit "Procurement Management";
}

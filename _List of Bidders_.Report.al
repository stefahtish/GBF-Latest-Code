report 50506 "List of Bidders"
{
    Caption = 'Bidders List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521638 BiddersList Report.rdl';

    dataset
    {
        dataitem(ProcurementRequest; "Procurement Request")
        {
            RequestFilterFields = "No.";

            column(No; ProcurementRequest."No.")
            {
            }
            column(Title; ProcurementRequest.Title)
            {
            }
            column(RequisitionNo; ProcurementRequest."Requisition No")
            {
            }
            column(Category; ProcurementRequest.Category)
            {
            }
            column(CategoryDescription; ProcurementRequest."Category Description")
            {
            }
            column(ProcurementPlanNo; ProcurementRequest."Procurement Plan No")
            {
            }
            column(QuotationDeadline_ProcurementRequest; "Quotation Deadline")
            {
            }
            column(ProcessType; ProcurementRequest."Process Type")
            {
            }
            column(CreationDate; ProcurementRequest."Creation Date")
            {
            }
            column(Logo; CompanyInformation.Picture)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPostCode; CompanyInformation."Post Code")
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(Homepage; CompanyInformation."Home Page")
            {
            }
            column(CountRows; CountRows)
            {
            }
            dataitem("Tender Evaluation Line"; "Tender Evaluation Line")
            {
                DataItemLink = "Quote No"=field("No.");

                column(Awarded_TenderEvaluationLine; Awarded)
                {
                }
            }
            dataitem("Tender Committees"; "Tender Committees")
            {
                DataItemLink = "Tender/Quotation No"=field("Requisition No");

                column(CommitteeType_TenderCommittees; "Committee Type")
                {
                }
            }
            dataitem(InvitedBids; "Supplier Selection")
            {
                DataItemLinkReference = ProcurementRequest;
                DataItemLink = "Reference No."=field("No."), "Supplier Category"=field(Category);

                column(SupplierCode; InvitedBids."Supplier Code")
                {
                }
                column(SupplierName; InvitedBids."Supplier Name")
                {
                }
                dataitem(ProspectiveSuppliers; "Prospective Suppliers")
                {
                    DataItemLinkReference = InvitedBids;
                    DataItemLink = "No."=field("Supplier Code");

                    column(SuppNo; ProspectiveSuppliers."No.")
                    {
                    }
                    column(SupplierType; ProspectiveSuppliers."Supplier Type")
                    {
                    }
                    column(AgpoGroup; ProspectiveSuppliers."Agpo Group")
                    {
                    }
                    column(AgpoNumber; ProspectiveSuppliers."Agpo Number")
                    {
                    }
                    column(RegistrationNo; ProspectiveSuppliers."Registration No")
                    {
                    }
                    column(Certificateofincorporation; ProspectiveSuppliers."Certificate of incorporation")
                    {
                    }
                    column(TaxComplianceCertificate; ProspectiveSuppliers."Tax Compliance Certificate")
                    {
                    }
                    column(ContactPhoneNo; ProspectiveSuppliers."Contact Phone No.")
                    {
                    }
                    column(MobileNo; ProspectiveSuppliers."Mobile No")
                    {
                    }
                    dataitem(ProspectiveSupplierDirectors; "Prospective Supplier Directors")
                    {
                        DataItemLinkReference = ProspectiveSuppliers;
                        DataItemLink = "Prospect No."=field("No.");

                        column(ProspectNo_; ProspectiveSupplierDirectors."Prospect No.")
                        {
                        }
                        column(Designation; ProspectiveSupplierDirectors.Designation)
                        {
                        }
                        column(Name; ProspectiveSupplierDirectors.Name)
                        {
                        }
                        column(Ethnicity; ProspectiveSupplierDirectors.Ethnicity)
                        {
                        }
                        column(EthnicityDescription; ProspectiveSupplierDirectors."Ethnicity Description")
                        {
                        }
                    }
                }
            }
            trigger OnAfterGetRecord()
            begin
                CountRows+=1;
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var CompanyInformation: Record "Company Information";
    BiddersName: Text[250];
    CountRows: Integer;
}

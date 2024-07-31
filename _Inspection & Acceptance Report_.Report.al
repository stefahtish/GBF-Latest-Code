report 50508 "Inspection & Acceptance Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521640 Inspection & Acceptance Report.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";

            column(No_PurchaseHeader; "No.")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
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
            column(Title_ProcurementRequest; Title)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No."=field("No.");

                column(Specifications_PurchaseLine; Specifications)
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
            }
            dataitem("Procurement Request"; "Procurement Request")
            {
                DataItemLink = "Requisition No"=field("Requisition No.");

                dataitem("Tender Committees"; "Tender Committees")
                {
                    DataItemLink = "Tender/Quotation No"=field("No.");

                    dataitem("Committee Members"; "Commitee Member")
                    {
                        DataItemLink = "Appointment No"=field("Appointment No");

                        column(Name_CommitteeMembers; Name)
                        {
                        }
                        column(EmployeeNo_CommitteeMembers; "Employee No")
                        {
                        }
                    }
                }
            }
            trigger OnAfterGetRecord()
            begin
                ProRequest.Reset();
                ProRequest.SetRange("Requisition No", "Requisition No.");
                If ProRequest.Find('-')then Title:=ProRequest.Title;
            end;
        }
    }
    var CompanyInformation: Record "Company Information";
    ProRequest: Record "Procurement Request";
    Title: Text[100];
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
}

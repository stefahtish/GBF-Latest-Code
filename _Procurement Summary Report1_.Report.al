report 50509 "Procurement Summary Report1"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521641 Procurement Summary Report1.rdl';

    dataset
    {
        dataitem("Internal Request Header"; "Internal Request Header")
        {
            RequestFilterFields = "No.";

            column(No_InternalRequestHeader; "Internal Request Header"."No.")
            {
            }
            column(Department; "Internal Request Header"."Shortcut Dimension 2 Code")
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
            dataitem("Internal Request Line"; "Internal Request Line")
            {
                DataItemLink = "Document No."=FIELD("No.");

                column(ProcurementPlanItem_InternalRequestLine; "Internal Request Line"."Procurement Plan Item")
                {
                }
                column(Description_InternalRequestLine; "Internal Request Line".Description)
                {
                }
                column(AmountIncludingVAT_InternalRequestLine; "Amount Including VAT")
                {
                }
                column(GLNo; GLNo)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    ProcurementPlan.Reset();
                    ProcurementPlan.SetRange("Plan Item No", "Procurement Plan Item");
                    if ProcurementPlan.Find('-')then GLNo:=ProcurementPlan."No.";
                end;
            }
            dataitem("Procurement Request"; "Procurement Request")
            {
                DataItemLink = "Requisition No"=field("No.");

                column(No_ProcurementRequest; "No.")
                {
                }
                column(Title_ProcurementRequest; Title)
                {
                }
                column(ProcessType_ProcurementRequest; "Process Type")
                {
                }
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Requisition No."=field("No.");

                column(No_PurchaseHeader; "No.")
                {
                }
                column(DocumentDate_PurchaseHeader; "Document Date")
                {
                }
                column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
                {
                }
                column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
                {
                }
                column(Amount_PurchaseHeader; Amount)
                {
                }
                dataitem("Prospective Suppliers"; "Prospective Suppliers")
                {
                    DataItemLink = "Vendor No"=field("Buy-from Vendor No.");

                    column(SupplierType_ProspectiveSuppliers; "Supplier Type")
                    {
                    }
                    column(AgpoGroup_ProspectiveSuppliers; "Agpo Group")
                    {
                    }
                    column(AgpoNumber_ProspectiveSuppliers; "Agpo Number")
                    {
                    }
                    column(DirName; DirName)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        ProSuppDir.Reset();
                        ProSuppDir.SetRange("Prospect No.", "No.");
                        if ProSuppDir.Find('-')then DirName:=ProSuppDir.Name;
                    end;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var CompanyInformation: Record "Company Information";
    GLNo: Code[20];
    ProcurementPlanItem: Code[20];
    DirName: Text[100];
    ProcurementPlan: Record "Procurement Plan";
    ProSuppDir: Record "Prospective Supplier Directors";
}

report 50520 "Weekly cashflow Report"
{
    ApplicationArea = All;
    Caption = 'Weekly cashflow Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Report/WeeklycashflowReport.rdl';
    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {
            DataItemTableView = where("Document Type" = const(Invoice));
            RequestFilterFields = "Vendor No.", "Posting Date", "Document No.";
            column(VendorNo; "Vendor No.")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(PostingDate_VendorLedgerEntry; format("Posting Date"))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(DueDate; format("Due Date"))
            {
            }
            column(OriginalAmount; abs("Original Amount"))
            {
            }
            column(RemainingAmount; Abs("Remaining Amount"))
            {
            }
            column(AppliestoDocNo; "Applies-to Doc. No.")
            {
            }
            column(AppliestoExtDocNo; "Applies-to Ext. Doc. No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }

            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CalcFields("Original Amount", "Remaining Amount");
                if "Currency Code" = '' then
                    "Currency Code" := 'KES'

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(ShowOnlyPositiveBalance; ShowOnlyPositiveBalance)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Positive Balance';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        ShowOnlyPositiveBalance: Boolean;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
        VendorLedgerEntry.CalcFields("Original Amount");
        VendorLedgerEntry.CalcFields("Remaining Amount");
        if ShowOnlyPositiveBalance then
            VendorLedgerEntry.SetFilter("Remaining Amount", '>0');
        // VendorLedgerEntry.SetFilter("Document Type", '%1', VendorLedgerEntry."Document Type"::Invoice);


    end;
}

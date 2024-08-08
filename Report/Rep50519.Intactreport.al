report 50519 "Intact report"
{
    ApplicationArea = All;
    Caption = 'Intact report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Report/Intactreport.rdl';
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            RequestFilterFields = "G/L Account No.", "Posting Date", "Global Dimension 2 Code", "Document No.";

            column(Description; Description)
            {
            }
            column(JournalBatchName; "Journal Batch Name")
            {
            }
            column(PostingDate; format("Posting Date"))
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(SourceNo; "Source No.")
            {
            }
            column(SourceCode; "Source Code")
            {
            }
            column(GLAccountNo; "G/L Account No.")
            {
            }
            column(GLAccountName; "G/L Account Name")
            {
            }
            column(GlobalDimension2Code_GLEntry; "Global Dimension 2 Code")
            {
            }
            column(Amount_GLEntry; Amount)
            {
            }
            column(Source_Currency_Amount; "Source Currency Amount")
            { }
            column(Source_Currency_Code; "Source Currency Code")
            { }
            // column(Exchange; ExchangeRate)
            // { }

            column(CalculatedAmount; CalculatedAmount)
            { }

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
            column(DebitAmount_GLEntry; "Debit Amount")
            {
            }
            column(CreditAmount_GLEntry; "Credit Amount")
            {
            }
            column(AddCurrencyCreditAmount_GLEntry; "Add.-Currency Credit Amount")
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
            begin
                if "Source Currency Code" <> '' then
                    CalculatedAmount := Amount / "Source Currency Amount"
                else
                    CalculatedAmount := 0;
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
        CalculatedAmount: Decimal;

    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;
}

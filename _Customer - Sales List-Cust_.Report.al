report 50152 "Customer - Sales List-Cust"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerSalesList-Cust.rdlc';
    Caption = 'Customer - Sales List';
    PreviewMode = PrintLayout;
    UsageCategory = None;
    DataAccessIntent = ReadOnly;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";

            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(MinAmtLCY; MinAmtLCY)
            {
                AutoFormatType = 1;
            }
            column(TABLECAPTION__________CustFilter; TableCaption + ': ' + CustFilter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__VAT_Registration_No__; "VAT Registration No.")
            {
            }
            column(AmtSalesLCY; AmtSalesLCY)
            {
                AutoFormatType = 1;
            }
            column(CustAddr_2_; CustAddr[2])
            {
            }
            column(CustAddr_3_; CustAddr[3])
            {
            }
            column(CustAddr_4_; CustAddr[4])
            {
            }
            column(CustAddr_5_; CustAddr[5])
            {
            }
            column(CustAddr_6_; CustAddr[6])
            {
            }
            column(CustAddr_7_; CustAddr[7])
            {
            }
            column(CustAddr_8_; CustAddr[8])
            {
            }
            column(HideAddress; HideAddress)
            {
            }
            column(Customer___Sales_ListCaption; Customer___Sales_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MinAmtLCYCaption; MinAmtLCYCaptionLbl)
            {
            }
            column(Customer__No__Caption; FieldCaption("No."))
            {
            }
            column(Customer_NameCaption; FieldCaption(Name))
            {
            }
            column(Customer__VAT_Registration_No__Caption; FieldCaption("VAT Registration No."))
            {
            }
            column(AmtSalesLCYCaption; AmtSalesLCYCaptionLbl)
            {
            }
            column(Total_Reported_Amount_of_Sales__LCY_Caption; Total_Reported_Amount_of_Sales__LCY_CaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            var
                FormatAddr: Codeunit "Format Address";
            begin
                AmtSalesLCY := CalculateAmtOfSaleLCY;
                if AmtSalesLCY < MinAmtLCY then CurrReport.Skip();
                if not HideAddress then FormatAddr.Customer(CustAddr, Customer);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(MinAmtLCY; MinAmtLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatType = 1;
                        Caption = 'Amounts (KES) Greater Than';
                        ToolTip = 'Specifies an amount so that the report will only include those customers to which you have sold more than this amount within the specified dates.';
                    }
                    field(HideAddress; HideAddress)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Hide Address Detail';
                        ToolTip = 'Specifies that you do not want the report to show address details for each customer.';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
    end;

    var
        MinAmtLCY: Decimal;
        HideAddress: Boolean;
        AmtSalesLCY: Decimal;
        CustAddr: array[8] of Text[100];
        CustFilter: Text;
        Customer___Sales_ListCaptionLbl: Label 'Customer - Sales List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MinAmtLCYCaptionLbl: Label 'Amounts (KES) greater than';
        AmtSalesLCYCaptionLbl: Label 'Amount of Sales (KES)';
        Total_Reported_Amount_of_Sales__LCY_CaptionLbl: Label 'Total Reported Amount of Sales (KES)';

    local procedure CalculateAmtOfSaleLCY(): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        Amt: Decimal;
        i: Integer;
    begin
        CustLedgEntry.SetCurrentKey("Document Type", "Customer No.", "Posting Date");
        CustLedgEntry.SetRange("Customer No.", Customer."No.");
        CustLedgEntry.SetFilter("Posting Date", Customer.GetFilter("Date Filter"));
        for i := 1 to 2 do begin
            case i of
                1:
                    CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
                2:
                    CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
            end;
            CustLedgEntry.CalcSums("Sales (LCY)");
            Amt := Amt + CustLedgEntry."Sales (LCY)";
        end;
        exit(Amt);
    end;

    procedure InitializeRequest(MinimumAmtLCY: Decimal; HideAddressDetails: Boolean)
    begin
        MinAmtLCY := MinimumAmtLCY;
        HideAddress := HideAddressDetails;
    end;
}

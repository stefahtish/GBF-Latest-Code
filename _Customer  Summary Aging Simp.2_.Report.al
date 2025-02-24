report 50431 "Customer  Summary Aging Simp.2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 51521560 CustomerSummaryAgingSimp.rdlc';
    AdditionalSearchTerms = 'customer balance simplify,payment due simplify';
    ApplicationArea = Suite;
    Caption = 'Customer - Summary Aging Simp.';
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Statistics Group", "Payment Terms Code";

            column(STRSUBSTNO_Text001_FORMAT_StartDate__; StrSubstNo(Text001, Format(StartDate)))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[5])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[4])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[3])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[2])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[1])
            {
            AutoFormatType = 1;
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustBalanceDueLCY_5__Control25; CustBalanceDueLCY[5])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control26; CustBalanceDueLCY[4])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control27; CustBalanceDueLCY[3])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control28; CustBalanceDueLCY[2])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control29; CustBalanceDueLCY[1])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control37; CustBalanceDueLCY[5])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control38; CustBalanceDueLCY[4])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control39; CustBalanceDueLCY[3])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control40; CustBalanceDueLCY[2])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control41; CustBalanceDueLCY[1])
            {
            AutoFormatType = 1;
            }
            column(Customer___Summary_Aging_Simp_Caption; Customer___Summary_Aging_Simp_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Customer__No__Caption; FieldCaption("No."))
            {
            }
            column(Customer_NameCaption; FieldCaption(Name))
            {
            }
            column(CustBalanceDueLCY_5__Control25Caption; CustBalanceDueLCY_5__Control25CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_4__Control26Caption; CustBalanceDueLCY_4__Control26CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_3__Control27Caption; CustBalanceDueLCY_3__Control27CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_2__Control28Caption; CustBalanceDueLCY_2__Control28CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control29Caption; CustBalanceDueLCY_1__Control29CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin
                PrintCust:=false;
                for i:=1 to 5 do begin
                    DtldCustLedgEntry.SetCurrentKey("Customer No.", "Initial Entry Due Date", "Posting Date");
                    DtldCustLedgEntry.SetRange("Customer No.", "No.");
                    //DtldCustLedgEntry.SetRange("Posting Date", 0D, StartDate);
                    DtldCustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
                    DtldCustLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.CalcSums("Amount (LCY)");
                    CustBalanceDueLCY[i]:=DtldCustLedgEntry."Amount (LCY)";
                    if CustBalanceDueLCY[i] <> 0 then PrintCust:=true;
                end;
                if not PrintCust then CurrReport.Skip();
            end;
            trigger OnPreDataItem()
            begin
                Clear(CustBalanceDueLCY);
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

                    field(StartingDate; StartDate)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = Suite;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the end date from which the report or batch job processes information.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
        // if StartDate = 0D then
        //     StartDate := WorkDate;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        if StartDate = 0D then Error(ErrorEmptyStartDate);
        if EndDate = 0D then Error(ErrorEmptyEndDate);
        CustFilter:=FormatDocument.GetRecordFiltersWithCaptions(Customer);
        //PeriodStartDate[5] := StartDate;
        PeriodStartDate[5]:=EndDate;
        PeriodStartDate[6]:=DMY2Date(31, 12, 9999);
        for i:=4 downto 2 do PeriodStartDate[i]:=CalcDate('<-30D>', PeriodStartDate[i + 1]);
    end;
    var Text001: Label 'As of %1';
    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    StartDate: Date;
    EndDate: Date;
    ErrorEmptyStartDate: Label 'Start date must have a value';
    ErrorEmptyEndDate: Label 'End date must have a value';
    CustFilter: Text;
    PeriodStartDate: array[6]of Date;
    CustBalanceDueLCY: array[5]of Decimal;
    PrintCust: Boolean;
    i: Integer;
    Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
    CustBalanceDueLCY_5__Control25CaptionLbl: Label 'Not Due';
    CustBalanceDueLCY_4__Control26CaptionLbl: Label '0-30 days';
    CustBalanceDueLCY_3__Control27CaptionLbl: Label '31-60 days';
    CustBalanceDueLCY_2__Control28CaptionLbl: Label '61-90 days';
    CustBalanceDueLCY_1__Control29CaptionLbl: Label 'Over 90 days';
    TotalCaptionLbl: Label 'Total';
    procedure InitializeRequest(StartingDate: Date)
    begin
        StartDate:=StartingDate;
    end;
}

report 50427 "Customer Summary Aging2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerSummaryAging.rdlc';
    AdditionalSearchTerms = 'customer balance,payment due';
    ApplicationArea = Basic, Suite;
    Caption = 'Customer - Summary Aging';
    UsageCategory = ReportsAndAnalysis;

    //DataAccessIntent = ReadOnly;
    dataset
    {
        dataitem(Customer; Customer)
        {
            //DataItemTableView = where(CustomerType = filter(License));
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
            column(CustBalanceDueLCY_14_; CustBalanceDueLCY[14])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_13_; CustBalanceDueLCY[13])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_12_; CustBalanceDueLCY[12])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_11_; CustBalanceDueLCY[11])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_10_; CustBalanceDueLCY[10])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_9_; CustBalanceDueLCY[9])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_8_; CustBalanceDueLCY[8])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_7_; CustBalanceDueLCY[7])
            {
            AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_6_; CustBalanceDueLCY[6])
            {
            AutoFormatType = 1;
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
            column(CustBalanceDueLCY_14__Control26Caption; CustBalanceDueLCY_14__Control25CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_13__Control27Caption; CustBalanceDueLCY_13__Control26CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_12__Control28Caption; CustBalanceDueLCY_12__Control27CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_11__Control29Caption; CustBalanceDueLCY_11__Control28CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_10__Control25Caption; CustBalanceDueLCY_10__Control30CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_9__Control26Caption; CustBalanceDueLCY_9__Control31CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_8__Control27Caption; CustBalanceDueLCY_8__Control32CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_7__Control28Caption; CustBalanceDueLCY_7__Control33CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_6__Control29Caption; CustBalanceDueLCY_6__Control35CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_5__Control25Caption; CustBalanceDueLCY_5__Control36CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_4__Control26Caption; CustBalanceDueLCY_4__Control37CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_3__Control27Caption; CustBalanceDueLCY_3__Control38CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_2__Control28Caption; CustBalanceDueLCY_2__Control39CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control29Caption; CustBalanceDueLCY_1__Control29CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control30Captionlbl; CustBalanceDueLCY_1__Control30Captionlbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(LineTotalCust; LineTotalCust)
            {
            }
            trigger OnAfterGetRecord()
            begin
                PrintCust:=false;
                LineTotalCust:=0;
                for i:=1 to 14 do begin
                    DtldCustLedgEntry.SetCurrentKey("Customer No.", "Initial Entry Due Date", "Posting Date");
                    DtldCustLedgEntry.SetRange("Customer No.", "No.");
                    //DtldCustLedgEntry.SetRange("Posting Date", 0D, StartDate);
                    DtldCustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
                    DtldCustLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.CalcSums("Amount (LCY)");
                    CustBalanceDueLCY[i]:=DtldCustLedgEntry."Amount (LCY)";
                    if CustBalanceDueLCY[i] <> 0 then PrintCust:=true;
                    LineTotalCust:=LineTotalCust + CustBalanceDueLCY[i];
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
                        ToolTip = 'Specifies the last date from which the report or batch job processes information.';
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
        //PeriodStartDate[14] := StartDate;
        PeriodStartDate[14]:=EndDate;
        PeriodStartDate[15]:=DMY2Date(31, 12, 9999);
        for i:=13 downto 2 do PeriodStartDate[i]:=CalcDate('<-30D>', PeriodStartDate[i + 1]);
    end;
    var Text001: Label 'As of %1';
    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    StartDate: Date;
    EndDate: Date;
    CustFilter: Text;
    PeriodStartDate: array[15]of Date;
    CustBalanceDueLCY: array[14]of Decimal;
    PrintCust: Boolean;
    i: Integer;
    Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
    CustBalanceDueLCY_14__Control25CaptionLbl: Label 'Current';
    CustBalanceDueLCY_13__Control26CaptionLbl: Label '0-30';
    LineTotalCust: Decimal;
    CustBalanceDueLCY_12__Control27CaptionLbl: Label '31-60';
    CustBalanceDueLCY_11__Control28CaptionLbl: Label '61-90';
    CustBalanceDueLCY_10__Control30CaptionLbl: Label '91-120';
    CustBalanceDueLCY_9__Control31CaptionLbl: Label '121-150';
    CustBalanceDueLCY_8__Control32CaptionLbl: Label '151-180';
    CustBalanceDueLCY_7__Control33CaptionLbl: Label '181-210';
    CustBalanceDueLCY_6__Control35CaptionLbl: Label '211-240';
    CustBalanceDueLCY_5__Control36CaptionLbl: Label '241-270';
    CustBalanceDueLCY_4__Control37CaptionLbl: Label '271-300';
    CustBalanceDueLCY_3__Control38CaptionLbl: Label '301-330';
    CustBalanceDueLCY_2__Control39CaptionLbl: Label '331-360';
    CustBalanceDueLCY_1__Control29CaptionLbl: Label 'Over 360';
    CustBalanceDueLCY_1__Control30Captionlbl: Label 'Total';
    TotalCaptionLbl: Label 'Total';
    ErrorEmptyStartDate: label 'Period start date must have a value';
    ErrorEmptyEndDate: label 'Period end date must have a value';
    procedure InitializeRequest(StartingDate: Date)
    begin
        StartDate:=StartingDate;
    end;
}

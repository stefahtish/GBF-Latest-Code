report 50170 "Budget Variance Analysis"
{
    DefaultLayout = RDLC;
    caption = 'Budget Variance Analysis';
    RDLCLayout = './Report 51519080 - Budget Variance Analysis.rdlc';
    AdditionalSearchTerms = 'Budget Variance Analysis';
    ApplicationArea = Basic, Suite;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    // DataAccessIntent = ReadOnly;
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(ReportTitle__1; ReportTitle1)
            {
            }
            column(ReportTitle__2; ReportTitle2)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(BudgetVarianceCaptionLbl; BudgetVarianceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                // column(G_L_Account___Actual_Amount_; "G/L Account"."Net Change")
                // {
                // }
                column(G_L_Account___Actual_Amount_; NetAmount)
                {
                }
                column(G_L_Account___Budget_Amount__; "G/L Account"."Budgeted Amount")
                {
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24;-"G/L Account"."Balance at Date")
                {
                AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                dataitem(BlankLineRepeater; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    column(BlankLineNo; BlankLineNo)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then CurrReport.Break();
                        BlankLineNo-=1;
                    end;
                }
                column(G_L_Account___VarianceIncomeAmt; VarianceIncome)
                {
                }
                column(G_L_Account___VarianceIncomePerc; VariancePercIncome)
                {
                }
                column(G_L_Account___VarianceExpenseAmt; VarianceExpense)
                {
                }
                column(G_L_Account___VarianceExpensePerc; VariancePercExpense)
                {
                }
                column(AccountTypeTotal; AccountTypeTotal)
                {
                }
                column(AccountCategoryIncome; AccountCategoryIncome)
                {
                }
                column(AccountCategoryExpense; AccountCategoryExpense)
                {
                }
                column(AccountTypePosting; AccountTypePosting)
                {
                }
                column(HideRevNetAmount; HideRevNetAmount)
                {
                }
                column(HideRevBudgAmount; HideRevBudgAmount)
                {
                }
                column(HideRevVarAmount; HideRevVarAmount)
                {
                }
                column(HideRevVarPerc; HideRevVarPerc)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    "G/L Account".CalcFields("Net Change", "Budgeted Amount");
                    BlankLineNo:="G/L Account"."No. of Blank Lines" + 1;
                    Amt_Actual:=0;
                    Amt_Budget:=0;
                    AccountTypeTotal:=0;
                    AccountCategoryIncome:=0;
                    AccountCategoryExpense:=0;
                    NetAmount:=0;
                    VariancePercExpense:=0;
                    VariancePercIncome:=0;
                    HideRevNetAmount:=0;
                    HideRevBudgAmount:=0;
                    HideRevVarAmount:=0;
                    HideRevVarPerc:=0;
                    if("G/L Account"."Net Change" < 0) and ("G/L Account"."Account Category" = "G/L Account"."Account Category"::Income)then NetAmount:=-"G/L Account"."Net Change"
                    else
                        NetAmount:="G/L Account"."Net Change";
                    if "G/L Account"."Account Category" = "G/L Account"."Account Category"::Income then begin
                        AccountCategoryIncome:=1;
                        VarianceIncome:=NetAmount - "G/L Account"."Budgeted Amount";
                        If "G/L Account"."Budgeted Amount" <> 0 then VariancePercIncome:=Round(VarianceIncome / "G/L Account"."Budgeted Amount" * 100, 0.01);
                    end
                    else if "G/L Account"."Account Category" = "G/L Account"."Account Category"::Expense then begin
                            AccountCategoryExpense:=1;
                            VarianceExpense:="G/L Account"."Budgeted Amount" - NetAmount;
                            If "G/L Account"."Budgeted Amount" <> 0 then VariancePercExpense:=Round(VarianceExpense / "G/L Account"."Budgeted Amount" * 100, 0.01);
                        end;
                    if "G/L Account"."Account Type" = "G/L Account"."Account Type"::Total then AccountTypeTotal:=1
                    else
                        AccountTypeTotal:=0;
                    if "G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting then AccountTypePosting:=1
                    else
                        AccountTypePosting:=0;
                    if("G/L Account"."Account Type" in["G/L Account"."Account Type"::Total, "G/L Account"."Account Type"::"Begin-Total", "G/L Account"."Account Type"::"End-Total"])then begin
                        if NetAmount = 0 then HideRevNetAmount:=1;
                        if "G/L Account"."Budgeted Amount" = 0 then HideRevBudgAmount:=1;
                        if VarianceExpense = 0 then HideRevVarAmount:=1;
                        if VariancePercExpense = 0 then HideRevVarPerc:=1;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Net Change", "Balance at Date", "Budgeted Amount");
                if ChangeGroupNo then begin
                    PageGroupNo+=1;
                    ChangeGroupNo:=false;
                end;
                ChangeGroupNo:="New Page";
            end;
            trigger OnPreDataItem()
            begin
                PageGroupNo:=0;
                ChangeGroupNo:=false;
                //GLAccount.SETFILTER("Date Filter", PeriodText);
                GLAccount.SETFILTER("Date Filter", '%1..%2', Startdate, EndDate);
                GLAccount.SETRANGE("Income/Balance", "Income/Balance"::"Income Statement");
                GLAccount.SetFilter("Account Category", '<>%1', "Account Category"::" ");
                //SETFILTER("Date Filter", PeriodText);
                SetFilter("Date Filter", '%1..%2', Startdate, EndDate);
                SETRANGE("Income/Balance", "Income/Balance"::"Income Statement");
                SetFilter("Account Category", '<>%1', "Account Category"::" ");
            end;
        }
    }
    requestpage
    {
        // SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Starting Date';
                        NotBlank = true;
                        ToolTip = 'Specifies the beginning of the period covered by the report.';
                    }
                    field(Enddate; Enddate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                        NotBlank = true;
                        ToolTip = 'Specifies the End of the period covered by the report.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            Startdate:=0D;
            EndDate:=0D;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
        minDate: Date;
        maxdate: Date;
    begin
        "G/L Account".SecurityFiltering(SecurityFilter::Filtered);
        GLFilter:="G/L Account".GetFilters;
        if Startdate = 0D then Error(ERR_StartDate);
        if EndDate = 0D then Error(ERR_EndDate);
        //PeriodText := "G/L Account".GetFilter("Date Filter");
        PeriodText:=Format(Startdate) + '..' + Format(EndDate);
        //Message('filter date is %1', PeriodText);
        if(PeriodText = '')then ERROR(ERR_FILTERPERIOD);
        // minDate := "G/L Account".GETRANGEMIN("Date Filter");
        // MaxDate := "G/L Account".GETRANGEMAX("Date Filter");
        minDate:=Startdate;
        MaxDate:=EndDate;
        Day:=DATE2DMY(MaxDate, 1);
        Month:=DATE2DMY(MaxDate, 2);
        Year:=DATE2DMY(MaxDate, 3);
        ReportTitle1:=STRSUBSTNO(TXT_REPORTTITLE1);
        ReportTitle2:=StrSubstNo(TXT_REPORTTITLE2, Day, Month, Year);
    end;
    var Text000: Label 'Period: %1';
    GLFilter: Text;
    PeriodText: Text[30];
    Startdate: Date;
    EndDate: Date;
    BudgetVarianceCaptionLbl: Label 'BUDGET VARIANCE ANALYSIS';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Net_ChangeCaptionLbl: Label 'Net Change';
    BalanceCaptionLbl: Label 'Balance';
    PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
    G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
    G_L_Account___Net_Change__Control22CaptionLbl: Label 'Budget Ksh';
    G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
    G_L_Account___Balance_at_Date__Control24CaptionLbl: Label 'Credit';
    PageGroupNo: Integer;
    ChangeGroupNo: Boolean;
    BlankLineNo: Integer;
    ReportTitle1: Text[80];
    ReportTitle2: text[80];
    TXT_REPORTTITLE1: Label 'BUDGET VARIANCE ANALYSIS';
    TXT_REPORTTITLE2: Label 'FOR THE PERIOD ENDED %1 (Date) %2 (Month)  %3 (Year)';
    ERR_FILTERPERIOD: Label 'Date filter must be specified.';
    ERR_StartDate: Label 'Period Start date must have a value';
    ERR_EndDate: Label 'Period End date must have a value';
    GLAccount: Record "G/L Account";
    VarianceIncome: Decimal;
    VariancePercIncome: Decimal;
    VarianceExpense: Decimal;
    VariancePercExpense: Decimal;
    Amt_Actual: Decimal;
    Amt_Budget: Decimal;
    AccountTypeTotal: Integer;
    AccountCategoryIncome: Integer;
    AccountCategoryExpense: Integer;
    AccountTypePosting: Integer;
    NetAmount: Decimal;
    HideRevNetAmount: Integer;
    HideRevBudgAmount: Integer;
    HideRevVarAmount: Integer;
    HideRevVarPerc: Integer;
}

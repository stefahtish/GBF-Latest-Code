report 50452 "Budget Tracker"
{
    ApplicationArea = All;
    Caption = 'Budget Tracker';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Budget Tracker.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(GLBudgetFilter; GLBudgetFilter)
            {
            }
            column(NoOfBlankLines_GLAcc; "No. of Blank Lines")
            {
            }
            column(AmtsInThousands; InThousands)
            {
            }
            column(GLFilterTableCaption_GLAcc; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(Type_GLAcc; "Account Type")
            {
            }
            column(AccountTypePosting; GLAccountTypePosting)
            {
            }
            column(No_GLAcc; "No.")
            {
            IncludeCaption = true;
            }
            column(BudgetCaption; BudgetCaptionTxt)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BudgetFilterCaption; BudgetFilterCaptionLbl)
            {
            }
            column(RowNumber; RowNumber)
            {
            }
            column(IncomeBalance_GLAccount; "Income/Balance")
            {
            }
            column(StartingDateAsText; StartingDateAsText)
            {
            }
            column(Name_GLAccount; Name)
            {
            }
            column(CommittedAmount; CommittedAmount)
            {
            }
            column(RealizedAmount; RealizedAmount)
            {
            }
            column(CummulativeAmount; CummulativeAmount)
            {
            }
            column(TotalBudgetAmount; TotalBudgetAmount)
            {
            DecimalPlaces = 0: 0;
            }
            column(EndDate; EndDate)
            {
            }
            column(BudgetPercentage; BudgetPercentage)
            {
            }
            column(Comp_Logo; CompInfo.Picture)
            {
            }
            column(Today; Today)
            {
            }
            dataitem(BlankLineCounter; "Integer")
            {
                DataItemTableView = SORTING(Number);

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, "G/L Account"."No. of Blank Lines");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                column(GLAccNo_BlankLineCounter; "G/L Account"."No.")
                {
                IncludeCaption = true;
                }
                column(PADSTRIndentName_GLAcc; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                TotalBudgetAmount:=0;
                CommittedAmount:=0;
                CummulativeAmount:=0;
                RealizedAmount:=0;
                BudgetPercentage:=0;
                for i:=1 to ArrayLen(GLBudgetedAmount)do begin
                    SetRange("Date Filter", 0D, PeriodStartDate[i + 1] - 1);
                    CalcFields("Budgeted Amount");
                    GLBudgetedAmount[i]:=MatrixMgt.RoundAmount("Budgeted Amount", RndFactor);
                    TotalBudgetAmount+=GLBudgetedAmount[i];
                end;
                SetRange("Date Filter", PeriodStartDate[1], PeriodStartDate[ArrayLen(PeriodStartDate)] - 1);
                // Message('%1 start date, %2 End date', PeriodStartDate[1], PeriodStartDate[ArrayLen(PeriodStartDate)] - 1);
                // GLAcc.Reset();
                // GLAcc.SetRange("No.", "G/L Account"."No.");
                // GLAcc.SetRange("Date Filter", PeriodStartDate[1], EndDate);
                // If GLAcc.FindSet() then begin
                //     GLAcc.CalcFields("Budgeted Amount");
                //     TotalBudgetAmount := GLAcc."Budgeted Amount";
                // end;
                GLAccountTypePosting:="Account Type" = "Account Type"::Posting;
                RowNumber+=1;
                //Committed amount
                Commitments.Reset();
                Commitments.SetRange(Account, "G/L Account"."No.");
                if Commitments.FindSet()then begin
                    repeat CommittedAmount:=CommittedAmount + Commitments."Committed Amount";
                    until Commitments.Next() = 0;
                end;
                //Realized Amount
                GLEntries.Reset();
                GLEntries.SetRange("Posting Date", 0D, PeriodStartDate[i + 1] - 1);
                GLEntries.SetRange("G/L Account No.", "G/L Account"."No.");
                If GLEntries.FindSet()then begin
                    repeat RealizedAmount:=RealizedAmount + GLEntries.Amount;
                    until GLEntries.Next() = 0;
                end;
                //CummulativeAmount
                GLEntries.Reset();
                GLEntries.SetRange("Posting Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                GLEntries.SetRange("G/L Account No.", "G/L Account"."No.");
                If GLEntries.FindSet()then begin
                    repeat CummulativeAmount:=CummulativeAmount + GLEntries.Amount;
                    until GLEntries.Next() = 0;
                end;
                If TotalBudgetAmount <> 0 then BudgetPercentage:=CummulativeAmount / TotalBudgetAmount * 100;
                BudgetPercentage:=Abs(BudgetPercentage);
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

                    field(StartingDate; PeriodStartDate[1])
                    {
                        ApplicationArea = Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if PeriodStartDate[1] = 0D then PeriodStartDate[1]:=CalcDate('<-CM+1D>', WorkDate);
            if Format(PeriodLength) = '' then Evaluate(PeriodLength, '<1M>');
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        GLFilter:="G/L Account".GetFilters;
        GLBudgetFilter:="G/L Account".GetFilter("Budget Filter");
        if PeriodStartDate[1] = 0D then PeriodStartDate[1]:=WorkDate;
        for i:=2 to ArrayLen(PeriodStartDate)do PeriodStartDate[i]:=CalcDate(PeriodLength, PeriodStartDate[i - 1]);
        BudgetCaptionTxt:=StrSubstNo(BudgetCaptionTok, Format(PeriodStartDate[1], 0, '<Year4>'));
        StartingDateAsText:=StrSubstNo(StartingDateTok, PeriodStartDate[1]);
        EndDate:=CalcDate(PeriodLength, PeriodStartDate[1]);
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;
    var MatrixMgt: Codeunit "Matrix Management";
    InThousands: Boolean;
    GLFilter: Text;
    GLBudgetFilter: Text[250];
    BudgetCaptionTxt: Text;
    PeriodLength: DateFormula;
    GLBudgetedAmount: array[12]of Decimal;
    TotalBudgetAmount: Decimal;
    PeriodStartDate: array[13]of Date;
    StartDate: Date;
    i: Integer;
    BudgetCaptionTok: Label 'Budget for %1', Comment = '%1 - year';
    PageCaptionLbl: Label 'Page';
    BudgetFilterCaptionLbl: Label 'Budget Filter';
    GLAccNameCaptionLbl: Label 'Name';
    RowNumber: Integer;
    GLAccountTypePosting: Boolean;
    RndFactor: Enum "Analysis Rounding Factor";
    TotalLbl: Label 'Total';
    StartingDateAsText: Text;
    StartingDateTok: Label 'Starting Date: %1', Comment = '%1 - date';
    Commitments: Record "Commitment Entries";
    CommittedAmount: Decimal;
    CummulativeAmount: decimal;
    RealizedAmount: Decimal;
    GLEntries: Record "G/L Entry";
    GLBudget: Record "G/L Budget Entry";
    EndDate: Date;
    BudgetPercentage: Decimal;
    CompInfo: Record "Company Information";
    GLAcc: Record "G/L Account";
}

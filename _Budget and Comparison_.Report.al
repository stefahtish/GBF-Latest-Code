report 50453 "Budget and Comparison"
{
    ApplicationArea = All;
    Caption = 'Budget and Comparison';
    DefaultLayout = RDLC;
    RDLCLayout = 'Budget and Comparison.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            RequestFilterFields = "Date Filter";

            column(No_GLAccount; "No.")
            {
            }
            column(Name_GLAccount; Name)
            {
            }
            column(Type_GLAcc; "Account Type")
            {
            }
            column(Today; Today)
            {
            }
            column(TotalBudgetAmount; TotalBudgetAmount)
            {
            DecimalPlaces = 0: 0;
            }
            column(CummulativeAmount; CummulativeAmount)
            {
            DecimalPlaces = 0: 0;
            }
            column(Variance; TotalBudgetAmount - CummulativeAmount)
            {
            }
            column(Comp_Logo; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(UtilizationPercentage; UtilizationPercentage)
            {
            }
            trigger OnAfterGetRecord()
            var
                GLAcc: Record "G/L Account";
            begin
                TotalBudgetAmount:=0;
                CummulativeAmount:=0;
                UtilizationPercentage:=0;
                GLAcc.Reset();
                GLAcc.SetRange("No.", "G/L Account"."No.");
                // GLAcc.SetRange("Date Filter", StartDate, EndDate);
                If GLAcc.Findset()then begin
                    GLAcc.CalcFields("Budgeted Amount");
                    TotalBudgetAmount:=GLAcc."Budgeted Amount";
                end;
                //cummulative to date
                //CummulativeAmount
                GLEntries.Reset();
                GLEntries.SetRange("Posting Date", StartDate, EndDate);
                GLEntries.SetRange("G/L Account No.", "G/L Account"."No.");
                If GLEntries.FindSet()then begin
                    repeat CummulativeAmount:=CummulativeAmount + GLEntries.Amount;
                    until GLEntries.Next() = 0;
                end;
                // UtilizationPercentage
                If TotalBudgetAmount <> 0 then UtilizationPercentage:=CummulativeAmount / TotalBudgetAmount * 100;
                UtilizationPercentage:=Round(Abs(UtilizationPercentage), 1, '<');
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfo.get();
        CompInfo.CalcFields(Picture);
        StartDate:="G/L Account".GETRANGEMIN("Date Filter");
        EndDate:="G/L Account".GETRANGEMAX("Date Filter");
    end;
    var TotalBudgetAmount: Decimal;
    CummulativeAmount: Decimal;
    UtilizationPercentage: Decimal;
    StartDate: Date;
    Vendor: Record Vendor;
    PeriodLength: DateFormula;
    GLEntries: Record "G/L Entry";
    EndDate: Date;
    CompInfo: Record "Company Information";
}

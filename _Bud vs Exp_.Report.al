report 50119 "Bud vs Exp"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BudvsExp.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Analysis View Budget Entry"; "Analysis View Budget Entry")
        {
            RequestFilterFields = "Dimension 1 Value Code", "Dimension 2 Value Code", "G/L Account No.", "Date Filter";

            column(AnalysisViewCode_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Analysis View Code")
            {
            }
            column(BudgetName_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Budget Name")
            {
            }
            column(BusinessUnitCode_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Business Unit Code")
            {
            }
            column(GLAccountNo_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."G/L Account No.")
            {
            }
            column(Dimension1ValueCode_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Dimension 1 Value Code")
            {
            }
            column(Dimension2ValueCode_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Dimension 2 Value Code")
            {
            }
            column(Dimension3ValueCode_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Dimension 3 Value Code")
            {
            }
            column(Dimension4ValueCode_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Dimension 4 Value Code")
            {
            }
            column(PostingDate_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Posting Date")
            {
            }
            column(EntryNo_AnalysisViewBudgetEntry; "Analysis View Budget Entry"."Entry No.")
            {
            }
            column(Amount_AnalysisViewBudgetEntry; "Analysis View Budget Entry".Amount)
            {
            }
            column(Encumberance_AnalysisViewBudgetEntry; "Analysis View Budget Entry".Encumberance)
            {
            }
            column(Commitments_AnalysisViewBudgetEntry; "Analysis View Budget Entry".Commitments)
            {
            }
            column(Actuals_AnalysisViewBudgetEntry; "Analysis View Budget Entry".Actuals)
            {
            }
            column(GLName; GLName)
            {
            }
            column(ActivityName; ActivityName)
            {
            }
            column(SubActivityName; SubActivityName)
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(CompanyPic; CompanyInformation.Picture)
            {
            }
            trigger OnAfterGetRecord()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Analysis View Budget Entry"."Dimension 1 Value Code");
                if DimensionValue.Find('-') then begin
                    if DimensionValue.Blocked = true then begin
                        CurrReport.Skip
                    end
                    else begin
                        "Analysis View Budget Entry".Validate("Analysis View Budget Entry"."Dimension 1 Value Code");
                        "Analysis View Budget Entry".Validate("Analysis View Budget Entry"."Dimension 2 Value Code");
                        "Analysis View Budget Entry".Validate("Analysis View Budget Entry"."Dimension 3 Value Code");
                        "Analysis View Budget Entry".Validate("Analysis View Budget Entry"."Dimension 4 Value Code");
                        "Analysis View Budget Entry".Modify;
                    end;
                end;
                if GLAccount.Get("Analysis View Budget Entry"."G/L Account No.") then begin
                    GLName := GLAccount.Name;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        ReportFilters := "Analysis View Budget Entry".GetFilters;
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        GLName: Text[250];
        ActivityName: Text[250];
        SubActivityName: Text[250];
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        ReportFilters: Code[250];
        CompanyInformation: Record "Company Information";
}

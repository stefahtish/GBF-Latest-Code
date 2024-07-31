report 50130 "Votebook Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './VotebookSummary.rdlc';
    Caption = 'Budget Variance';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Budget Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(GLBudgetFilter; GLBudgetFilter)
            {
            }
            column(NoOfBlankLines; "G/L Account"."No. of Blank Lines")
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; "G/L Account".TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(GLAccType; "G/L Account"."Account Type")
            {
            }
            column(EmptyString; '')
            {
            }
            column(Trial_Balance_BudgetCaption; Trial_Balance_BudgetCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(GLBudgetFilterCaption; GLBudgetFilterCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(DiffPctCaption; DiffPctCaptionLbl)
            {
            }
            column(G_L_Account___Budgeted_Amount_Caption; G_L_Account___Budgeted_Amount_CaptionLbl)
            {
            }
            column(Variance_Caption; Variance_CaptionLbl)
            {
            }
            column(Remarks_Caption; Remarks_CaptionLbl)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompPic; CompInfo.Picture)
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
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(CommittedAmount; "G/L Account".Commitment)
                {
                }
                column(EncumeranceAmount; "G/L Account".Encumberance)
                {
                }
                column(DiffPct; DiffPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(G_L_Account___Budgeted_Amount_; +"G/L Account"."Budgeted Amount")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Variance_Amount; VarianceAmt)
                {
                }
                column(Remarks; Remarks)
                {
                }
                column(G_L_Account___No___Control35; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name_Control36; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change__Control37; "G/L Account"."Net Change")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(DiffPct_Control39; DiffPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(G_L_Account___Budgeted_Amount__Control40; +"G/L Account"."Budgeted Amount")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Variance_Amount_2; VarianceAmt)
                {
                }
                column(Remarks_2; Remarks)
                {
                }
                column(Integer_Number; Number)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Net Change", "Budgeted Amount", "Balance at Date", Commitment, Encumberance);
                GLAcc2 := "G/L Account";
                GLAcc2.CalcFields("Budget at Date");
                Remarks := '';
                if "Budgeted Amount" = 0 then
                    DiffPct := 0
                else
                    DiffPct := "Net Change" / "Budgeted Amount" * 100;
                VarianceAmt := "Budgeted Amount" - "Net Change";
                if "Net Change" <= "Budgeted Amount" then
                    Remarks := FavourableText
                else if "Net Change" > "Budgeted Amount" then Remarks := UnfavourableText;
                if GLAcc2."Budget at Date" = 0 then
                    DiffAtDatePct := 0
                else
                    DiffAtDatePct := "Balance at Date" / GLAcc2."Budget at Date" * 100;
            end;

            trigger OnPreDataItem()
            begin
                GLAcc2.CopyFilters("G/L Account");
                AccountingPeriod.Reset;
                AccountingPeriod.SetRange("New Fiscal Year", true);
                EndDate := GetRangeMax("Date Filter");
                AccountingPeriod."Starting Date" := GetRangeMin("Date Filter");
                AccountingPeriod.Find('=<');
                GLAcc2.SetRange("Date Filter", AccountingPeriod."Starting Date", EndDate);
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
        GLFilter := "G/L Account".GetFilters;
        PeriodText := "G/L Account".GetFilter("Date Filter");
        GLBudgetFilter := "G/L Account".GetFilter("Budget Filter");
        if GLBudgetFilter = '' then Error('Please input Budget Filter');
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        Text000: Label 'Period: %1';
        GLAcc2: Record "G/L Account";
        AccountingPeriod: Record "Accounting Period";
        GLFilter: Text[250];
        GLBudgetFilter: Text[30];
        PeriodText: Text[30];
        EndDate: Date;
        DiffPct: Decimal;
        DiffAtDatePct: Decimal;
        VarianceAmt: Decimal;
        Remarks: Text[50];
        FavourableText: Label 'Favourable';
        UnfavourableText: Label 'Unfavourable';
        Trial_Balance_BudgetCaptionLbl: Label 'Budget Variance Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        GLBudgetFilterCaptionLbl: Label 'Budget Filter';
        Net_ChangeCaptionLbl: Label 'Actual Spent';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        DiffPctCaptionLbl: Label 'Variance % ';
        G_L_Account___Budgeted_Amount_CaptionLbl: Label 'Budget';
        Variance_CaptionLbl: Label 'Variance';
        Remarks_CaptionLbl: Label 'Remarks';
        CompInfo: Record "Company Information";
}

report 50207 "Training Need"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TrainingNeed.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(TrainingNeed; "Training Need")
        {
            RequestFilterFields = "Start Date", "End Date", Location, Provider, Status;

            column(Code_TrainingNeed; TrainingNeed.Code)
            {
            }
            column(Description_TrainingNeed; TrainingNeed.Description)
            {
            }
            column(StartDate_TrainingNeed; TrainingNeed."Start Date")
            {
            }
            column(EndDate_TrainingNeed; TrainingNeed."End Date")
            {
            }
            column(Duration_TrainingNeed; TrainingNeed.Duration)
            {
            }
            column(DurationUnits_TrainingNeed; TrainingNeed."Duration Units")
            {
            }
            column(Location_TrainingNeed; TrainingNeed.Location)
            {
            }
            column(Provider_TrainingNeed; TrainingNeed.Provider)
            {
            }
            column(ProviderName_TrainingNeed; TrainingNeed."Provider Name")
            {
            }
            column(CostOfTraining_TrainingNeed; TrainingNeed."Cost Of Training")
            {
            }
            column(Remarks_TrainingNeed; TrainingNeed.Remarks)
            {
            }
            column(StaffName; StaffName)
            {
            }
            column(TotalBudget; TotalBudget)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            trigger OnAfterGetRecord()
            begin
                StaffName := '';
                TotalBudget := 0;
                if StartDate = 0D then StartDate := CalcDate('-cm', TrainingNeed."Start Date");
                TrainingRequest.Reset;
                TrainingRequest.SetRange("Training Need", TrainingNeed.Code);
                if TrainingRequest.FindFirst then
                    repeat
                        if StaffName = '' then
                            StaffName := TrainingRequest."Employee Name"
                        else
                            StaffName += ' ' + TrainingRequest."Employee Name";
                    until TrainingRequest.Next = 0;
                TrainingNeedsLines.Reset;
                TrainingNeedsLines.SetCurrentKey("G/L Account");
                TrainingNeedsLines.SetRange("Document No.", TrainingNeed.Code);
                if TrainingNeedsLines.FindFirst then
                    repeat
                        if not GLAccountAdded(TrainingNeedsLines."G/L Account") then begin
                            if GLAccountFilter = '' then
                                GLAccountFilter := TrainingNeedsLines."G/L Account"
                            else
                                GLAccountFilter += '|' + TrainingNeedsLines."G/L Account";
                            p += 1;
                            GLAccount[p] := TrainingNeedsLines."G/L Account";
                        end;
                    until TrainingNeedsLines.Next = 0;
                GetBudget;
            end;

            trigger OnPreDataItem()
            begin
                TrainingNeed.SetCurrentKey("Start Date");
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        TotalBudget := 0;
        GLAccountFilter := '';
        Clear(GLAccount);
        p := 0;
        StartDate := 0D;
    end;

    var
        TrainingRequest: Record "Training Request";
        CompanyInfo: Record "Company Information";
        GLBudgetEntry: Record "G/L Budget Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        TrainingNeedsLines: Record "Training Needs Lines";
        TotalBudget: Decimal;
        StaffName: Text;
        GLAccountFilter: Text;
        GLAccount: array[50] of Code[20];
        Found: Boolean;
        i: Integer;
        p: Integer;
        StartDate: Date;

    local procedure GLAccountAdded(GLAccountNo: Code[20]): Boolean
    begin
        i := 0;
        repeat
            i += 1;
            if GLAccountNo = GLAccount[i] then Found := true;
            if Found then exit(true);
        until i = ArrayLen(GLAccount);
        exit(false);
    end;

    local procedure GetBudget()
    begin
        GLBudgetEntry.Reset;
        GLBudgetEntry.SetFilter("G/L Account No.", GLAccountFilter);
        //GLBudgetEntry.SETRANGE("Dimension Set ID","Dimension Set ID");
        GLBudgetEntry.SetRange(Date, StartDate, TrainingNeed."Start Date");
        if GLBudgetEntry.FindFirst then begin
            GLBudgetEntry.CalcSums(Amount);
            TotalBudget := GLBudgetEntry.Amount;
        end;
    end;
}

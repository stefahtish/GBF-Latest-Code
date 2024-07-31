report 50221 "Leave Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/LeaveBalance.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            //DataItemTableView = WHERE("Employment Status" = CONST(Active), "Status" = CONST(Active), "Employment Type" = FILTER(Permanent | Contract));
            DataItemTableView = WHERE("Employment Status" = CONST(Active), "Status" = CONST(Active));

            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name" + '  ' + Employee."Middle Name" + '  ' + Employee."Last Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(CurrentLeavePeriod_Employee; Employee."Salary Arrears")
            {
            }
            column(Entitlement; Entitlement)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Adjustment; Adjustment)
            {
            }
            column(BroughtForward; BroughtForward)
            {
            }
            column(Recall; Recall)
            {
            }
            column(Taken; Taken)
            {
            }
            column(Absent; Absent)
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
            column(Global_Dimension_1_Code; "Global Dimension 2 Code")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Entitlement := 0;
                BroughtForward := 0;
                Recall := 0;
                Taken := 0;
                Absent := 0;
                Balance := 0;
                Adjustment := 0;
                LeaveTypes.Reset();
                LeaveTypes.SetRange("Annual Leave", true);
                if LeaveTypes.FindFirst() then begin
                    Code1 := LeaveTypes.Code;
                end;
                // LeavePeriod.Reset();
                // LeavePeriod.SetRange("Employment Type", Employee."Employment Type");
                // LeavePeriod.SetRange(closed, false);
                // if LeavePeriod.FindFirst() then
                //     CurrPeriod := LeavePeriod."Leave Period";
                //Entitlement
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Leave Type", Code1);
                LeaveLedger.SetRange("Leave Period Code", CurrPeriod);
                LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave Allocation");
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days");
                    Entitlement := LeaveLedger."No. of days";
                end;
                //Brought Forward
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Leave Type", Code1);
                LeaveLedger.SetRange(Closed, false);
                LeaveLedger.SetRange("Leave Period Code", CurrPeriod);
                LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave B/F");
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days");
                    BroughtForward := LeaveLedger."No. of days";
                end;
                //Recall
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Leave Type", Code1);
                LeaveLedger.SetRange("Leave Period Code", CurrPeriod);
                LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave Recall");
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days");
                    Recall := LeaveLedger."No. of days";
                end;
                //Adjustment
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Leave Type", Code1);
                LeaveLedger.SetRange("Leave Period Code", CurrPeriod);
                LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave Adjustment");
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days");
                    Adjustment := LeaveLedger."No. of days";
                end;
                //Taken                
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Leave Type", Code1);
                LeaveLedger.SetRange("Leave Period Code", CurrPeriod);
                LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave Application");
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days");
                    Taken := -LeaveLedger."No. of days";
                end;
                //Absent
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Leave Period Code", CurrPeriod);
                LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::Absent);
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days");
                    Absent := -Abs(LeaveLedger."No. of days");
                end;
                //Balance
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Leave Type", Code1);
                LeaveLedger.SetRange("Leave Period Code", CurrPeriod);
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days");
                    //Balance := LeaveLedger."No. of days" + LeaveLedger."Balance Brought Forward";
                    //Balance := Entitlement + BroughtForward + Recall + Adjustment - Absent - Taken;
                    Balance := LeaveLedger."No. of days";
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Period)
                {
                    field(CurrPeriod; CurrPeriod)
                    {
                        Caption = 'Leave Period';
                        TableRelation = "Leave Periods";
                        ApplicationArea = All;
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
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            MaturityDateFilter := CalcDate('1Y', AccPeriod."Starting Date") - 1;
            FiscalStartDate := AccPeriod."Starting Date";
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        AccPeriod: Record "Payroll PeriodX";
        Name: Text[50];
        MaturityDateFilter: Date;
        DeptID: Code[30];
        LeaveEarnedToDate: Decimal;
        LeaveTypes: Record "Leave Type";
        NoofDaysWorked: Integer;
        NextDay: Date;
        FiscalStartDate: Date;
        CompanyID: Text[50];
        LeaveApplications: Record "Leave Application";
        LeaveAllowancePaid: Boolean;
        DimensionValue: Record "Dimension Value";
        Balance: Decimal;
        Entitlement: Decimal;
        BroughtForward: Decimal;
        Adjustment: Decimal;
        Recall: Decimal;
        Taken: Decimal;
        Absent: Decimal;
        LeaveLedger: Record "HR Leave Ledger Entries";
        UserSetup: Record "User Setup";
        Code1: Code[20];
        LeavePeriod: Record "Leave Periods";
        CurrPeriod: Code[20];
}

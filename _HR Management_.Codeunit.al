codeunit 50119 "HR Management"
{
    trigger OnRun()
    var
        mydate: Date;
        enddate: Date;
    begin
        IF CONFIRM('Are you sure you want to assign leave days?', false) THEN AssignLeaveDaysFromAccountingPeriod();
    end;

    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        leaveApp: Record "Leave Application";
        TempBlobCU: Codeunit "Temp Blob";
        Change: Record "Employee Change Request";
        CurrYear: Integer;
        Year: Integer;
        R: Date;
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        Email: codeunit email;
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: List of [Text];
        RecipientBCC: List of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ICTSetup: Record "ICT Setup";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        LeaveType: Record "Leave Type";
        AnnualLeave: Text;
        Assigned: Boolean;
        LeaveNotAssigned: Label 'There is nothing to assign. Goodbye';
        LeaveAssigned: Label 'Annual leave assigned successfully';
        Month: Text;
        LeavePeriod: Code[20];
        LeavePeriodStart: Date;
        LeavePeriodEnd: Date;
        LeaveEntry: Record "HR Leave Ledger Entries";
        Text005: Label 'End-Total %1 is missing a matching Begin-Total.';
        Text004: Label 'Indenting the Appraisal Goals #1##########';

    procedure AssignLeaveDaysFromAccountingPeriod()
    var
        DocNo: Code[50];
        NoSeriesManagement: Codeunit NoSeriesManagement;
        CurrPeriodStart: Date;
        FirstDayCurrMonth: Date;
        LastFiscalDate: Date;
        DaysEntitled: Decimal;
        EntryNo: Integer;
        AccountingPeriod: Record "Accounting Period";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        LeaveLedger: Record "HR Leave Ledger Entries";
        SalaryScale: Record "Salary Scale";
        EmployeeContracts: Record "Employee Contracts";
        LeavePeriodsRec: Record "Leave Periods";
        LeavePeriod: Code[20];
        BalBF: Decimal;
        LeaveEntitlement: Decimal;
        LeavePeriodError: Label 'Employee %1 has been assigned leave days for %2 leave period. Please close the leave period and create a new one to be used.';
    begin
        HRSetup.GET;
        HRSetup.TESTFIELD("Assignment Nos");
        DocNo := NoSeriesManagement.GetNextNo(HRSetup."Assignment Nos", 0D, TRUE);
        LeaveType.RESET;
        LeaveType.SETRANGE("Annual Leave", TRUE);
        IF LeaveType.FINDFIRST THEN AnnualLeave := LeaveType.Code;
        AccountingPeriod.RESET;
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        AccountingPeriod.SETFILTER("Starting Date", '<=%1', WORKDATE);
        IF AccountingPeriod.FINDLAST THEN BEGIN
            Assigned := FALSE;
            CurrYear := DATE2DMY(AccountingPeriod."Starting Date", 3);
            R := WORKDATE;
            Year := DATE2DMY(R, 3);
            LastFiscalDate := AccountingPeriod."Starting Date";
            CurrPeriodStart := CALCDATE('-CY', (CALCDATE('-1D', LastFiscalDate)));
            FirstDayCurrMonth := CALCDATE('-CM', TODAY);
            //set Document No
            IF LeaveLedger.FINDLAST THEN EntryNo := LeaveLedger."Entry No.";
            //Assign Leave Days
            Employee.RESET;
            Employee.SetFilter("Employment Type", '%1|%2', Employee."Employment Type"::Permanent, Employee."Employment Type"::Contract);
            Employee.SETRANGE(Status, Employee.Status::Active);
            Employee.SetRange("Employment Status", Employee."Employment Status"::Active);
            IF Employee.FIND('-') THEN
                REPEAT
                    LeaveEntitlement := 0;
                    BalBF := 0;
                    //Get Leave Period
                    LeavePeriod := GetLeavePeriodCode(Employee."Employment Type", Employee."No.");
                    LeaveLedger.RESET;
                    LeaveLedger.SETRANGE("Staff No.", Employee."No.");
                    LeaveLedger.SETRANGE("Leave Period Code", LeavePeriod);
                    LeaveLedger.SETRANGE("Leave Entry Type", LeaveLedger."Leave Entry Type"::Positive);
                    LeaveLedger.SETRANGE("Transaction Type", LeaveLedger."Transaction Type"::"Leave Allocation");
                    IF not LeaveLedger.FINDFIRST THEN begin
                        //ERROR(LeavePeriodError, Employee."No.", LeavePeriod);
                        DocNo := AnnualLeave + FORMAT(LeavePeriod);
                        LeaveLedger.RESET;
                        LeaveLedger.SETRANGE("Staff No.", Employee."No.");
                        LeaveLedger.SETRANGE("Document No.", DocNo);
                        IF NOT LeaveLedger.FINDFIRST THEN BEGIN
                            //close previous positive leave entries
                            LeaveLedger.RESET;
                            LeaveLedger.SETRANGE("Staff No.", Employee."No.");
                            LeaveLedger.SetFilter("Transaction Type", '<>%1', LeaveLedger."Transaction Type"::"Leave B/F");
                            LeaveLedger.SETRANGE(Closed, FALSE);
                            IF LeaveLedger.FINDFIRST THEN
                                REPEAT
                                    LeaveLedger.Closed := TRUE;
                                    LeaveLedger.MODIFY;
                                UNTIL LeaveLedger.NEXT = 0;
                            GetEntitlement(Employee."No.", LeaveEntitlement, BalBF);
                            LeaveLedger.INIT;
                            LeaveLedger."Entry No." := InitNextEntryNo;
                            LeaveLedger."Leave Period" := AccountingPeriod."Starting Date";
                            LeaveLedger."Staff No." := Employee."No.";
                            LeaveLedger."Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
                            LeaveLedger."Document No." := DocNo;
                            LeaveLedger."Job ID" := Employee."Job Title";
                            LeaveLedger."Job Group" := Employee."Salary Scale";
                            LeaveLedger."Leave Approval Date" := TODAY;
                            LeaveLedger."Contract Type" := FORMAT(Employee."Contract Type");
                            LeaveLedger."No. of days" := LeaveEntitlement;
                            LeaveLedger."Leave Posting Description" := 'Assignment for Accounting Period ' + FORMAT(AccountingPeriod."Starting Date");
                            LeaveLedger."Transaction Type" := LeaveLedger."Transaction Type"::"Leave Allocation";
                            LeaveLedger."User ID" := USERID;
                            LeaveLedger."Leave Type" := AnnualLeave;
                            LeaveLedger."Leave Period Code" := LeavePeriod;
                            LeaveLedger."Leave Start Date" := LeavePeriodStart;
                            LeaveLedger."Leave End Date" := LeavePeriodEnd;
                            LeaveLedger."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                            LeaveLedger."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                            IF LeaveLedger.INSERT THEN Assigned := TRUE;
                            //Carry Forward Days
                            IF BalBF > 0 THEN BEGIN
                                LeaveLedger.INIT;
                                LeaveLedger."Entry No." := InitNextEntryNo;
                                LeaveLedger."Leave Period" := AccountingPeriod."Starting Date";
                                LeaveLedger."Staff No." := Employee."No.";
                                LeaveLedger."Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                                LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
                                LeaveLedger."Document No." := DocNo;
                                LeaveLedger."Job ID" := Employee."Job Title";
                                LeaveLedger."Job Group" := Employee."Salary Scale";
                                LeaveLedger."Leave Approval Date" := TODAY;
                                LeaveLedger."Contract Type" := FORMAT(Employee."Contract Type");
                                LeaveLedger."No. of days" := BalBF;
                                LeaveLedger."Leave Posting Description" := 'Bal B/F for Accounting Period ' + FORMAT(AccountingPeriod."Starting Date");
                                LeaveLedger."Transaction Type" := LeaveLedger."Transaction Type"::"Leave B/F";
                                LeaveLedger."User ID" := USERID;
                                LeaveLedger."Leave Type" := AnnualLeave;
                                LeaveLedger."Leave Period Code" := LeavePeriod;
                                LeaveLedger."Leave Start Date" := LeavePeriodStart;
                                LeaveLedger."Leave End Date" := LeavePeriodEnd;
                                LeaveLedger."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                                LeaveLedger."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                                LeaveLedger.INSERT;
                            END;
                        END;
                    end;
                    Employee."Current Leave Period" := LeavePeriod;
                    Employee.MODIFY;
                UNTIL Employee.NEXT = 0;
            AccountingPeriod."Leave Assigned" := TRUE;
            AccountingPeriod.MODIFY;
            IF Assigned THEN
                MESSAGE(LeaveAssigned)
            ELSE
                MESSAGE(LeaveNotAssigned);
        END;
    end;

    procedure AssignLeaveDays()
    var
        LeaveLedgerEntry: Record "HR Leave Ledger Entries";
        Day: Date;
        ThisPeriod: Date;
        LastPeriod: Date;
    begin
        HRSetup.Get;
        HRSetup.TestField("Leave Days");
        Day := Today;
        ThisPeriod := (CalcDate('1Y', FindCurrentPeriod(true)) - 1);
        LastPeriod := (CalcDate('-1Y', ThisPeriod));
        if Day <= ThisPeriod then begin
            Employee.Reset;
            Employee.SetRange("Employment Type", Employee."Employment Type"::Permanent);
            Employee.SETRANGE(Status, Employee.Status::Active);
            Employee.SetRange("Employment Status", Employee."Employment Status"::Active);
            if Employee.Find('-') then begin
                repeat
                    LeaveLedgerEntry.SetRange("Staff No.", Employee."No.");
                    LeaveLedgerEntry.SetFilter("Leave Period", '>%1&<%2', LastPeriod, ThisPeriod);
                    if not LeaveLedgerEntry.Find('-') then begin
                        LeaveLedgerEntry.Init;
                        LeaveLedgerEntry."Leave Period" := ThisPeriod;
                        LeaveLedgerEntry."Staff No." := Employee."No.";
                        LeaveLedgerEntry."Staff No." := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        LeaveLedgerEntry."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                        LeaveLedgerEntry."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                        LeaveLedgerEntry."Job Group" := Employee."Salary Scale";
                        LeaveLedgerEntry."Job ID" := Employee."Job Title";
                        LeaveLedgerEntry."Leave Entry Type" := LeaveLedgerEntry."Leave Entry Type"::Positive;
                        LeaveLedgerEntry."Transaction Type" := LeaveLedgerEntry."Transaction Type"::"Leave Allocation";
                        LeaveLedgerEntry."No. of days" := HRSetup."Leave Days";
                        LeaveLedgerEntry."Leave Assignment" := true;
                        LeaveLedgerEntry.Insert;
                    end;
                until Employee.Next = 0;
            end;
        end;
    end;

    procedure LeaveApplication(LeaveAppNo: Code[50])
    var
        LeaveLedg: Record "HR Leave Ledger Entries";
        LeaveApp: Record "Leave Application";
        Employee: Record Employee;
    begin
        LeaveLedg.Init;
        LeaveLedg."Document No." := LeaveAppNo;
        if LeaveApp.Get(LeaveAppNo) then begin
            LeaveLedg."Leave Type" := LeaveApp."Leave Code";
            LeaveLedg."Leave Start Date" := LeaveApp."Start Date";
            LeaveLedg."Leave End Date" := LeaveApp."End Date";
            LeaveLedg."Leave Return Date" := LeaveApp."Resumption Date";
            LeaveLedg."Leave Approval Date" := Today;
            LeaveLedg."Leave Date" := Today;
            LeaveLedg."Leave Period" := GetLeavePeriod(LeaveApp."Start Date");
            LeaveLedg."Leave Application No." := LeaveApp."Application No";
            LeaveLedg."Leave Posting Description" := 'Leave Application';
            LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Application";
            LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Negative;
            LeaveLedg."User ID" := LeaveApp."User ID";
            if LeaveLedg."Leave Entry Type" = LeaveLedg."Leave Entry Type"::Negative then begin
                LeaveLedg."No. of days" := -LeaveApp."Days Applied";
            end
            else
                LeaveLedg."No. of days" := LeaveApp."Days Applied";
            LeaveLedg."Staff No." := LeaveApp."Employee No";
            if Employee.Get(LeaveLedg."Staff No.") then begin
                LeaveLedg."Staff Name" := LeaveApp."Employee Name";
                LeaveLedg."Job ID" := Employee."Job Title";
                LeaveLedg."Job Group" := Employee."Salary Scale";
                LeaveLedg."Contract Type" := Employee."Nature of Employment";
                LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
            end;
            LeaveLedg."Leave Period Code" := LeaveApp."Leave Period";
        end;
        LeaveLedg.Insert;
    end;

    procedure LeaveRecall(LeaveRecNo: Code[20])
    var
        EmpOff_Holiday: Record "Employee Off/Holiday";
        LeaveLedg: Record "HR Leave Ledger Entries";
        LeaveApp: Record "Leave Application";
        Employee: Record Employee;
    begin
        LeaveLedg.Init;
        LeaveLedg."Document No." := LeaveRecNo;
        if EmpOff_Holiday.Get(LeaveRecNo) then begin
            LeaveLedg."Leave End Date" := EmpOff_Holiday."Recalled To";
            LeaveLedg."Leave Application No." := EmpOff_Holiday."Leave Application";
            LeaveLedg."Leave Start Date" := EmpOff_Holiday."Recalled From";
            LeaveLedg."Leave Return Date" := EmpOff_Holiday."Recalled From";
            LeaveLedg."Leave Approval Date" := Today;
            LeaveLedg."Leave Period" := EmpOff_Holiday."Recalled From";
            LeaveApp.Reset;
            LeaveApp.SetRange("Application No", EmpOff_Holiday."Leave Application");
            if LeaveApp.FindFirst then begin
                LeaveLedg."Leave Type" := LeaveApp."Leave Code";
                LeaveLedg."Leave Period Code" := LeaveApp."Leave Period";
            end;
            LeaveLedg."Staff No." := EmpOff_Holiday."Employee No";
            if Employee.Get(LeaveLedg."Staff No.") then begin
                LeaveLedg."Job ID" := Employee."Job Title";
                LeaveLedg."Job Group" := Employee."Salary Scale";
                LeaveLedg."Contract Type" := Employee."Nature of Employment";
                LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
            end;
            LeaveLedg."Staff Name" := EmpOff_Holiday."Employee Name";
            LeaveLedg."User ID" := UserId;
            LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Positive;
            LeaveLedg."No. of days" := EmpOff_Holiday."No. of Off Days";
            LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Recall";
            LeaveLedg.Insert;
            EmpOff_Holiday.Completed := true;
            EmpOff_Holiday.Modify();
            if Confirm('Do you want to notify the Employee via mail?') then NotifyLeaveRecallee(EmpOff_Holiday);
        end;
    end;

    procedure LeaveAdjustment("Code": Code[20])
    var
        EmpLeave: Record "Employee Leave";
        LeaveLedg: Record "HR Leave Ledger Entries";
        LeaveAdjustHead: Record "Leave Bal Adjustment Header";
        LeaveAdjustLines: Record "Leave Bal Adjustment Lines";
        LeavePeriod: Record "Leave Periods";
    begin
        LeaveAdjustHead.Get(Code);
        LeaveAdjustLines.SetRange("Header No.", Code);
        if LeaveAdjustLines.Find('-') then begin
            repeat
                LeaveAdjustLines.TestField("Leave Period");
                LeaveAdjustLines.TestField("Leave Code");
                LeaveLedg.Init;
                LeaveLedg."Leave Entry Type" := LeaveAdjustLines."Leave Adj Entry Type";
                LeaveLedg."Staff No." := LeaveAdjustLines."Staff No.";
                LeaveLedg."Document No." := LeaveAdjustLines."Header No.";
                LeaveLedg."Leave Period Code" := LeaveAdjustLines."Leave Period";
                if Employee.Get(LeaveLedg."Staff No.") then begin
                    LeaveLedg."Job ID" := Employee."Job Title";
                    LeaveLedg."Job Group" := Employee."Salary Scale";
                    LeaveLedg."Contract Type" := Employee."Nature of Employment";
                    LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
                LeaveLedg."Staff Name" := LeaveAdjustLines."Employee Name";
                LeaveLedg."Leave Type" := LeaveAdjustLines."Leave Code";
                // if Employee."Employment Type" = Employee."Employment Type"::Permanent then
                LeaveLedg."Leave Period Code" := LeaveAdjustLines."Leave Period";
                // if Employee."Employment Type" = Employee."Employment Type"::Contract then
                //     LeaveLedg."Leave Period" := FindCurrentPeriod(false);
                LeaveLedg."Leave Date" := Today;
                LeaveLedg."Leave Approval Date" := Today;
                LeaveLedg."No. of days" := LeaveAdjustLines."New Entitlement";
                LeaveLedg."Leave Posting Description" := 'Leave Adjustment';
                CASE LeaveAdjustHead."Transaction Type" OF
                    LeaveAdjustHead."Transaction Type"::"Leave Brought Forward":
                        BEGIN
                            LeaveLedg."Balance Brought Forward" := LeaveAdjustLines."New Entitlement";
                            LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave B/F";
                        END;
                    LeaveAdjustHead."Transaction Type"::"Leave Adjustment":
                        LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Adjustment";
                    ELSE
                        LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Adjustment";
                END;
                LeaveLedg."Transaction Type" := LeaveAdjustLines."Transaction Type";
                GetLeavePeriodCode(Employee."Employment Type", Employee."No.");
                LeaveLedg."Leave Start Date" := LeavePeriodStart;
                LeaveLedg."Leave End Date" := LeavePeriodEnd;
                LeaveLedg."User ID" := UserId;
                LeaveLedg.Insert;
            until LeaveAdjustLines.Next = 0;
            LeaveAdjustHead.Posted := true;
            LeaveAdjustHead."Posted By" := UserId;
            LeaveAdjustHead."Posted Date" := Today;
            LeaveAdjustHead.Modify;
            Message('Leave adjustment posted successfully');
        end;
    end;

    procedure GetActingAllowance(ActingNo: Code[20])
    var
        Acting: Record "Employee Acting Position";
        PayPeriod: Record "Payroll PeriodX";
        AssignMatrix: Record "Assignment Matrix-X";
        Earnings: Record EarningsX;
        EarningCode: Code[50];
        PeriodDate: Date;
    begin
        Acting.Reset();
        Acting.SetRange(No, ActingNo);
        if Acting.Find('-') then begin
            PayPeriod.Reset;
            PayPeriod.SetRange(Closed, false);
            if PayPeriod.FindFirst then begin
                PeriodDate := PayPeriod."Starting Date";
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", PayPeriod."Starting Date");
                AssignMatrix.SetRange("Employee No", Acting."Employee No.");
                AssignMatrix.SetRange("Basic Salary Code", true);
                if AssignMatrix.Find('-') then begin
                    Acting."Basic Pay" := AssignMatrix.Amount;
                end;
                Acting.Modify();
            end;
            Earnings.Reset;
            Earnings.SetRange("Acting Allowance", true);
            if Earnings.FindFirst() then
                EarningCode := earnings.Code
            else
                Error('Please define an acting allowance');
            // if Acting.Qualified = true then begin
            if Acting."Qualified for position" = true then begin
                // PayPeriod.Reset;
                // PayPeriod.SetRange(Closed, false);
                // if PayPeriod.FindFirst then begin
                // AssignMatrix.Reset;
                // AssignMatrix.SetRange("Payroll Period", PayPeriod."Starting Date");
                // // AssignMatrix.SetRange("Employee No", Acting."Relieved Employee");
                // AssignMatrix.SetRange("Employee No", Acting."Employee No.");
                // AssignMatrix.SetRange("Basic Salary Code", true);
                // if AssignMatrix.Find('-') then begin
                //     Acting."Acting Amount" := ((Earnings.Percentage / 100) * (Acting."Basic Pay"));
                // end;
                Earnings.Reset;
                Earnings.SetRange("Acting Allowance", true);
                if Earnings.FindFirst() then begin
                    Acting."Acting Amount" := ((Earnings."Acting Not Qualify(%)" / 100) * (Acting."Basic Pay"));
                    Acting.Modify();
                end;
                // Acting.Modify();
                // end;
            end
            else begin
                Earnings.Reset;
                Earnings.SetRange("Acting Allowance", true);
                if Earnings.FindFirst() then begin
                    Acting."Acting Amount" := ((Earnings.Percentage / 100) * (Acting."Basic Pay"));
                    Acting.Modify();
                end;
                // AssignMatrix.Init;
                // AssignMatrix."Payroll Period" := PeriodDate;
                // AssignMatrix.Type := AssignMatrix.Type::Payment;                    
                // AssignMatrix."Employee No" := Acting."Employee No.";
                // AssignMatrix.Code := EarningCode;
                // AssignMatrix.Amount := Acting."Acting Amount";
                // AssignMatrix.Insert();
            end;
            // end;
        end;
    end;

    procedure CreateEmployee(AppNo: Code[20]) EmployeeNo: Code[20]
    var
        Applicant: record Applicants2;
    begin
        Applicant.Reset;
        Applicant.SetRange("No.", AppNo);
        if Applicant.FindFirst() then begin
            Employee.init;
            Employee."No." := '';
            Employee."First Name" := Applicant."First Name";
            Employee."Middle Name" := Applicant."Middle Name";
            Employee."Last Name" := Applicant."Last Name";
            Employee."Birth Date" := Applicant."Date Of Birth";
            Employee.Gender := Applicant.Gender;
            Employee."E-Mail" := Applicant."E-Mail";
            Employee.Address := Applicant."Residential Address";
            Employee."Phone No." := Applicant."Cellular Phone Number";
            Employee.Insert(true);
        end;
        Applicant."Employee No" := Employee."No.";
        exit(Employee."No.");
    end;

    procedure AssignTransferAllowance(TransferNo: Code[20])
    var
        Transfer: Record "Employee Transfers";
        HrMgmt: Codeunit "HR Management";
        AssignmentMatrixX: Record "Assignment Matrix-X";
        Employee: Record Employee;
        TransferEarningCode: Code[50];
        TransportEarningCode: Code[50];
        Earnings: Record EarningsX;
        BasicPay: Decimal;
        TransferAll: Decimal;
        TravelAll: Decimal;
        PayPeriod: Record "Payroll PeriodX";
        PeriodDate: Date;
    begin
        Transfer.Reset();
        Transfer.SetRange("Transfer No", TransferNo);
        if Transfer.Find('-') then begin
            PayPeriod.Reset;
            PayPeriod.SetRange(Closed, false);
            if PayPeriod.FindFirst then begin
                Earnings.reset;
                Earnings.SetRange("Transport Allowance", true);
                if earnings.Findfirst then begin
                    TransportEarningCode := Earnings.Code;
                    TransferAll := Earnings."Flat Amount";
                end
                else
                    Error('Please define a transport allowance');
                PayPeriod.Reset;
                PayPeriod.SetRange(Closed, false);
                if PayPeriod.FindFirst then begin
                    PeriodDate := PayPeriod."Starting Date";
                    AssignmentMatrixX.Reset;
                    AssignmentMatrixX.SetRange("Payroll Period", PayPeriod."Starting Date");
                    AssignmentMatrixX.SetRange("Employee No", Transfer."Employee No");
                    AssignmentMatrixX.SetRange("Basic Salary Code", true);
                    if AssignmentMatrixX.Find('-') then begin
                        BasicPay := AssignmentMatrixX.Amount;
                        //Travel allowance
                        AssignmentMatrixX.INIT;
                        AssignmentMatrixX.VALIDATE("Employee No", Transfer."Employee No");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Payment;
                        AssignmentMatrixX.VALIDATE(Code, TransportEarningCode);
                        AssignmentMatrixX.SetRange("Payroll Period", PayPeriod."Starting Date");
                        AssignmentMatrixX.Amount := TransferAll;
                        AssignmentMatrixX."Reference No" := TransferNo;
                        AssignmentMatrixX.INSERT;
                        Earnings.Reset;
                        Earnings.SetRange("Transfer Allowance", true);
                        if Earnings.FindFirst() then begin
                            TransferEarningCode := Earnings.Code;
                            TransferAll := ((Earnings.Percentage / 100) * (BasicPay));
                        end
                        else
                            Error('Please define a transfer allowance');
                        //Transfer allowance
                        AssignmentMatrixX.INIT;
                        AssignmentMatrixX.VALIDATE("Employee No", Transfer."Employee No");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Payment;
                        AssignmentMatrixX.SetRange("Payroll Period", PayPeriod."Starting Date");
                        AssignmentMatrixX.VALIDATE(Code, TransferEarningCode);
                        AssignmentMatrixX.Amount := TransferAll;
                        AssignmentMatrixX."Reference No" := TransferNo;
                        AssignmentMatrixX.INSERT;
                    end;
                end;
            end;
        end;
    end;
    //Leave allowance
    procedure AssignLeaveAllowance(LeaveNo: Code[20])
    var
        LeaveApp: Record "Leave Application";
        HrMgmt: Codeunit "HR Management";
        AssignmentMatrixX: Record "Assignment Matrix-X";
        Employee: Record Employee;
        LeaveEarningCode: Code[50];
        Earnings: Record EarningsX;
        BasicPay: Decimal;
        LeaveAll: Decimal;
        PayPeriod: Record "Payroll PeriodX";
        PeriodDate: Date;
        NoDays: Decimal;
    begin
        LeaveApp.Reset();
        LeaveApp.SetRange("Application No", LeaveNo);
        if LeaveApp.Find('-') then begin
            NoDays := LeaveApp."Days Applied";
            PayPeriod.Reset;
            PayPeriod.SetRange(Closed, false);
            if PayPeriod.FindFirst then begin
                Earnings.reset;
                Earnings.SetRange("Leave Allwance", true);
                if earnings.Findfirst then begin
                    LeaveEarningCode := Earnings.Code;
                end
                else
                    Error('Please define a leave commutation');
                PayPeriod.Reset;
                PayPeriod.SetRange(Closed, false);
                if PayPeriod.FindFirst then begin
                    PeriodDate := PayPeriod."Starting Date";
                    AssignmentMatrixX.Reset;
                    AssignmentMatrixX.SetRange("Payroll Period", PayPeriod."Starting Date");
                    AssignmentMatrixX.SetRange("Employee No", LeaveApp."Employee No");
                    AssignmentMatrixX.SetRange("Basic Salary Code", true);
                    if AssignmentMatrixX.Find('-') then begin
                        BasicPay := AssignmentMatrixX.Amount;
                        LeaveAll := NoDays * BasicPay * (8 / 176);
                        //Travel allowance
                        AssignmentMatrixX.INIT;
                        AssignmentMatrixX.VALIDATE("Employee No", LeaveApp."Employee No");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Payment;
                        AssignmentMatrixX.Frequency := AssignmentMatrixX.Frequency::"Non-recurring";
                        AssignmentMatrixX.VALIDATE(Code, LeaveEarningCode);
                        AssignmentMatrixX.SetRange("Payroll Period", PayPeriod."Starting Date");
                        AssignmentMatrixX.Amount := LeaveAll;
                        AssignmentMatrixX."Reference No" := LeaveNo;
                        AssignmentMatrixX.INSERT;
                    end;
                end;
            end;
        end;
    end;

    procedure SendActivityNotice(ActivityCode: Code[50])
    var
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        // SMTP  Codeunit "Email Message";
        //  SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: List of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        EmailBody: Label 'Dear %1, <br>Congratulations! You have Successfully secured a position at the <strong>Institute of Energy Studies & Research</strong>. <br>Kindly visit  your applicatioin Portal to Download the Admission Letter.';
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that there is a company activity:  <Strong> %2 </Strong>-<Strong> on %3 </Strong> that you have been chosen to oversee. The venue will be %4 and the duration is %5 -%6';
        MailSuccess: Label 'Employees have been notified successfully.';
        NoOfRecipients: Integer;
        CoActivities: Record "Company Activities";
    begin
        HRSetup.Get;
        CoActivities.Reset();
        CoActivities.SetRange(Code, ActivityCode);
        if CoActivities.find('-') then begin
            Employee.Reset;
            Employee.SetRange("No.", CoActivities.Responsibility);
            if Employee.Find('-') then begin
                //REPEAT
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient.Add(Employee."E-Mail");
                Subject := 'Company Activity Notification';
                TimeNow := Format(Time);
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendToBody(StrSubstNo(NewBody, Employee.Name, CoActivities.Code, CoActivities.Day, CoActivities.Venue, CoActivities.Duration, CoActivities."Unit of measure"));
                NoOfRecipients := RecipientCC.Count;
                if NoOfRecipients > 0 then //SMTP.AddCC(RecipientCC);
                    Email.Send(Emailmessage);
                CoActivities.Notified := true;
                CoActivities.Modify();
                //MESSAGE(MailSuccess);
                //UNTIL Employee.NEXT=0;
            end;
        end;
    end;

    procedure SendLeaveNotice(AppNo: Code[50])
    var
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        Email: Codeunit Email;
        SenderAddress: Text;
        Receipient: List of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: List of [Text];
        Attachment: Text;
        LeaveReliever: Record "Leave Relievers";
        RelieverName: Text;
        ErrorMsg: Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that<Strong> %2 </Strong>-<Strong> %3 </Strong> has approved your therefore you can send for approval.<br> <br>Thank you. <br><br> Kind Regards, <br><br> %8';
        MailSuccess: Label 'Employee has been notified successfully.';
        NoOfRecipients: Integer;
    begin
        HRSetup.Get;
        if leaveApp.Get(AppNo) then begin
            Employee.Reset;
            if Employee.Get(leaveApp."Employee No") then begin
                LeaveReliever.Reset();
                LeaveReliever.SetRange("Leave Code", leaveApp."Application No");
                If LeaveReliever.FindFirst() then begin
                    RelieverName := LeaveReliever."Staff Name";
                end;
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient.Add(Employee."E-Mail");
                Subject := 'Leave Notification-' + leaveApp."Employee No" + leaveApp."Employee Name";
                TimeNow := Format(Time);
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendToBody(StrSubstNo(NewBody, Employee."First Name", RelieverName, CompanyInfo.Name));
                NoOfRecipients := RecipientCC.Count;
                if NoOfRecipients > 0 then //eddieEmailmessage.AddCC(RecipientCC);
                    Email.Send(Emailmessage);
            end;
        end;
    end;

    procedure SendLeaveRelieverNotice(AppNo: Code[50])
    var
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        Email: codeunit email;
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: List of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        LeaveReliever: Record "Leave Relievers";
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that<Strong> %2 </Strong>-<Strong> %3 </Strong>is going on Leave from<Strong> %4</Strong> to<Strong> %5</Strong>.<br> Their Duties will be taken over by <Strong>%6  %7</Strong>.<br> <br>Thank you. <br><br> Kind Regards, <br><br> %8';
        MailSuccess: Label 'Employee has been notified successfully.';
        NoOfRecipients: Integer;
    begin
        HRSetup.Get;
        if leaveApp.Get(AppNo) then begin
            LeaveReliever.Reset();
            LeaveReliever.SetRange("Leave Code", leaveApp."Application No");
            If LeaveReliever.FindFirst() then begin
                Employee.Reset;
                if Employee.Get(LeaveReliever."Staff No") then begin
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("E-Mail");
                    SenderName := CompanyInfo.Name;
                    SenderAddress := CompanyInfo."E-Mail";
                    Receipient.Add(Employee."E-Mail");
                    Subject := 'Leave Notification-' + leaveApp."Employee No" + leaveApp."Employee Name";
                    TimeNow := Format(Time);
                    Emailmessage.create(Receipient, Subject, '', true);
                    Emailmessage.AppendToBody(StrSubstNo(NewBody, Employee."First Name", leaveApp."Employee No", leaveApp."Employee Name", leaveApp."Start Date", leaveApp."End Date", Employee.Name, leaveApp."Relieving Name", CompanyInfo.Name));
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //eddie Emailmessage.AddCC(RecipientCC);
                        email.Send(emailmessage);
                end;
            end;
        end;
    end;

    local procedure GetUserFullName(UserName: Code[100]): Text[250]
    var
        Users: Record User;
    begin
        CompanyInfo.Get;
        Users.Reset;
        Users.SetRange("User Name", UserName);
        if Users.FindFirst then
            exit(Users."Full Name")
        else
            exit(CompanyInfo.Name);
    end;

    procedure GetEmail(EmployeeNo: Code[20]): Text
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmployeeNo) then begin
            Employee.TestField("E-Mail");
            exit(Employee."E-Mail");
        end;
    end;

    local procedure GetEntitlement(EmpNo: Code[50]): Decimal
    var
        SalaryScale: Record "Salary Scale";
        Emp: Record Employee;
    begin
        Emp.Reset;
        Emp.SetRange("Employment Type", Emp."Employment Type"::Permanent);
        Emp.SetRange("No.", EmpNo);
        if Emp.Find('-') then begin
            if SalaryScale.Get(Emp."Salary Scale") then exit(SalaryScale."Leave Days");
            //MESSAGE(FORMAT(SalaryScale."Leave Days"/12));
        end;
    end;

    procedure GetEntitlement2(EmpNo: Code[50]): Decimal
    var
        SalaryScale: Record "Salary Scale";
        Emp: Record Employee;
        Contract: Record "Employment Contract";
        DateText: Text;
        EndDate: Date;
        StartDate: Date;
        EmployeeTab: Record Employee;
    begin
        EmployeeTab.Reset;
        EmployeeTab.SetRange("No.", EmpNo);
        if Employee.Find('-') then begin
            //EmployeeTab.TESTFIELD("Employment Type");
            Contract.Reset;
            Contract.SetRange("Employee Type", EmployeeTab."Employment Type");
            if Contract.Find('-') then begin
                exit(Contract."Annual Leave Days");
            end;
        end;
    end;

    procedure GetVendor(VendorNo: Code[20]): Text[100]
    var
        Vendor: Record Vendor;
        Email: Text[100];
    begin
        Vendor.Reset;
        Vendor.SetRange("No.", VendorNo);
        if Vendor.Find('-') then begin
            exit(Vendor."E-Mail");
        end;
    end;

    procedure EmployeeBirthday(EmployeeRec: Record Employee)
    var
        BirthDate: Integer;
        BirthMonth: Integer;
        TodayDate: Integer;
        TodayMonth: Integer;
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmesssage: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: List of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        EmailBody: Label 'Dear %1, <br>Congratulations! You have Successfully secured a position at the <strong>Institute of Energy Studies & Research</strong>. <br>Kindly visit  your applicatioin Portal to Download the Admission Letter.';
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">HAPPY BIRTHDAY<br> Enjoy!<br> Thank you. <br> Kind Regards, <br> %2';
        MailSuccess: Label 'Employees have been notified successfully.';
        CompInfo: Record "Company Information";
        NoOfRecipients: Integer;
    begin
        TodayDate := Date2DMY(Today, 1);
        TodayMonth := Date2DMY(Today, 2);
        BirthDate := 0;
        BirthMonth := 0;
        Employee.Reset;
        Employee.SetRange(Status, EmployeeRec.Status::Active);
        Employee.SetRange("No.", EmployeeRec."No.");
        if Employee.Find('-') then begin
            Message('found emp %1-DOB %2-Email %3', Employee."No.", Employee."Birth Date", Employee."E-Mail");
            BirthDate := Date2DMY(Employee."Birth Date", 1);
            BirthMonth := Date2DMY(Employee."Birth Date", 2);
            if (BirthDate = TodayDate) and (BirthMonth = TodayMonth) then begin
                Message('true');
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient.Add(Employee."E-Mail");
                Subject := 'Happy Birthday';
                TimeNow := Format(Time);
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
                //eddie change parameters
                Emailmesssage.Create(Receipient, Subject, '', true);
                Emailmesssage.AppendToBody(StrSubstNo(NewBody, Employee."First Name", CompanyInfo.Name));
                Emailmesssage.AppendToBody('<a href="http://edwinbundik@gmail.com"/a>');
                Emailmesssage.AppendToBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="D:\Agile\Agile\Agile.jpg"' + 'width=100 height=100>');
                NoOfRecipients := RecipientCC.Count;
                if NoOfRecipients <> 0 then //eddie SMTP.AddCC(RecipientCC);
                    email.Send(Emailmesssage);
            end;
        end
        else
            Message('not found`');
    end;

    procedure UpdateContract(ContractNo: Code[20]; EmployeeNo: Code[20])
    var
        Contract: Record "Employee Contracts";
    begin
        Contract.Reset;
        Contract.SetRange("No.", ContractNo);
        Contract.SetRange("Employee No", EmployeeNo);
        if Contract.Find('-') then begin
            Employee.Reset;
            Employee.SetRange("No.", EmployeeNo);
            if Employee.Find('-') then begin
                Employee."Contract Type" := Contract."Contract Type";
                Employee."Contract Number" := Contract."No.";
                Employee."Contract Length" := Contract.Tenure;
                Employee."Contract Start Date" := Contract."Start Date";
                Employee."Contract End Date" := Contract."End Date";
                Employee.Modify;
            end;
        end;
    end;

    procedure EmployeeChangeRequest(var ChangeRec: Record "Employee Change Request")
    var
        EmployeeRec: Record Employee;
        NextofKin: Record Relative;
        LineNo: Integer;
        Contracts: Record "Employment Contract";
    begin
        /*
        IF ChangeRec."Approval Status"=ChangeRec."Approval Status"::Approved THEN
          EXIT;
        
        EmployeeRec.RESET;
        EmployeeRec.SETRANGE("No.",ChangeRec."No.");
        IF EmployeeRec.FIND('-') THEN
          BEGIN
            EmployeeRec.TRANSFERFIELDS(ChangeRec);
            EmployeeRec.MODIFY;
          END;
        */
        if Confirm('Do you want to Update these Employees Records?') then Employee.Reset;
        if Employee.Find('-') then begin
            repeat
                if Employee.Get(ChangeRec."No.") then begin
                    /*
                      IF ChangeRec."First Name"<>'' THEN
                        Employee."First Name":=ChangeRec."First Name";
                      IF ChangeRec."Middle Name"<>'' THEN
                        Employee."Middle Name":=ChangeRec."Middle Name";
                      IF ChangeRec."Last Name"<>'' THEN
                        Employee."Last Name":=ChangeRec."Last Name";
                      IF ChangeRec."ID No."<>'' THEN
                        Employee."ID No.":=ChangeRec."ID No.";

                      IF ChangeRec."Passport No."<>'' THEN
                        Employee."Passport No.":=ChangeRec."Passport No.";
                      IF ChangeRec."Phone No."<>'' THEN
                        Employee."Phone No.":=ChangeRec."Phone No.";
                      IF ChangeRec."E-Mail"<>'' THEN
                        Employee."E-Mail":=ChangeRec."E-Mail";

                      IF ChangeRec."KRA PIN No."<>'' THEN
                        Employee."KRA PIN No.":=ChangeRec."KRA PIN No.";
                      IF ChangeRec."PIN Number"<>'' THEN
                        Employee."PIN Number":=ChangeRec."PIN Number";
                      IF ChangeRec."NHIF No"<>'' THEN
                        Employee."NHIF No":=ChangeRec."NHIF No";
                      IF ChangeRec."Social Security No."<>'' THEN
                        Employee."Social Security No.":=ChangeRec."Social Security No.";
                      IF ChangeRec."Salary Scale"<>'' THEN
                        Employee."Salary Scale":=ChangeRec."Salary Scale";
                      IF ChangeRec.Area<>'' THEN
                        Employee.Area:=ChangeRec.Area;
                      IF ChangeRec."Date Of Join"<>0D THEN
                        Employee."Date Of Join":=ChangeRec."Date Of Join";
                      IF ChangeRec."Employment Date"<>0D THEN
                        Employee."Employment Date":=ChangeRec."Employment Date";
                      IF ChangeRec."Date of Birth"<>0D THEN
                        Employee."Date of Birth":=ChangeRec."Date of Birth";
                      IF ChangeRec."Ethnic Group"<>'' THEN
                        Employee."Ethnic Group":=ChangeRec."Ethnic Group";

                      IF ChangeRec.Gender<>ChangeRec.Gender::" " THEN
                        Employee.Gender:=ChangeRec.Gender;

                      IF ChangeRec."Ethnic Name"<>'' THEN
                        Employee."Ethnic Name":=ChangeRec."Ethnic Name";

                        //Employment Type
                        Employee."Employment Type":=ChangeRec."Employment Type";

                      IF ChangeRec."ID No."<>'' THEN
                        Employee."ID No.":=ChangeRec."ID No.";
                      IF ChangeRec."Job Title"<>'' THEN
                        Employee."Job Title":=ChangeRec."Job Title";
                      IF ChangeRec."Home District"<>'' THEN
                        Employee."Home District":=ChangeRec."Home District";
                      IF ChangeRec.County<>'' THEN
                        Employee.County:=ChangeRec.County;

                      IF ChangeRec."E-Mail"<>'' THEN
                        Employee."E-Mail":=ChangeRec."E-Mail";

                      IF ChangeRec."Global Dimension 1 Code"<>'' THEN
                        Employee."Global Dimension 1 Code":=ChangeRec."Global Dimension 1 Code";
                      IF ChangeRec."NHIF No"<>'' THEN
                        Employee."NHIF No":=ChangeRec."NHIF No";
                      IF ChangeRec."Employee's Bank"<>'' THEN
                        Employee."Employee's Bank":=ChangeRec."Employee's Bank";
                      IF ChangeRec."Bank Branch"<>'' THEN
                        Employee."Bank Branch":=ChangeRec."Bank Branch";
                      IF ChangeRec."Bank Account Number"<>'' THEN
                        Employee."Bank Account Number":=ChangeRec."Bank Account Number";

                      IF ChangeRec."Global Dimension 2 Code"<>'' THEN
                        BEGIN
                          IF Employee."Global Dimension 2 Code"='' THEN
                            Employee."Global Dimension 2 Code":=ChangeRec."Global Dimension 2 Code";
                        END;


                        IF ChangeRec."Date of Birth"<>0D THEN
                          Employee."Date of Birth":=ChangeRec."Date of Birth";
                        IF ChangeRec."Employment Date"<>0D THEN
                          Employee."Employment Date":=ChangeRec."Employment Date";
                        IF ChangeRec."Date Of Join"<>0D THEN
                          Employee."Date Of Join":=ChangeRec."Date Of Join";

                      Employee."Employment Type":=ChangeRec."Employment Type";

                      IF Employee."Employment Type"=Employee."Employment Type"::Contract THEN
                        BEGIN
                          IF ChangeRec."Date Of Join"<>0D THEN
                            Employee."Date Of Join":=ChangeRec."Date Of Join";
                            Employee."Employment Date":=ChangeRec."Date Of Join";
                            Employee."Contract Length":=ChangeRec."Contract Length";
                            Employee."Contract Start Date":=ChangeRec."Date Of Join";
                            Employee.VALIDATE("Contract Start Date");
                            Employee.VALIDATE("Date Of Join");
                            Employee.VALIDATE("Employment Date");
                            Employee."Employee Type":=Employee."Employee Type"::Contract;
                        END ELSE

                      IF Employee."Employment Type"=Employee."Employment Type"::Permanent THEN
                        BEGIN
                          IF ChangeRec."Date Of Join"<>0D THEN
                          Employee."Date Of Leaving":=ChangeRec."Date Of Join";
                          Employee."Employment Date":=ChangeRec."Date Of Join";
                          Employee.VALIDATE("Date Of Join");
                          Employee.VALIDATE("Employment Date");
                          Employee."Employee Type":=Employee."Employee Type"::Permanent;
                        END;
                      */
                    if Employee."Employment Type" = Employee."Employment Type"::Contract then begin
                        Contracts.Reset;
                        //Contracts.SETRANGE(Tenure,Employee."Contract Length");
                        //Contracts.SETFILTER('%1,%2'(Contracts.Tenure,Employee."Contract Length"));
                        if Contracts.Find('-') then begin
                            Employee."Contract Type" := Contracts.Code;
                        end;
                    end;
                    Employee.Modify;
                end;
            until ChangeRec.Next = 0;
        end;
        /*
        IF Employee."Date Of Join"=0D THEN
          Employee."Date Of Join":=Employee."Employment Date";
          Employee.MODIFY;
        */
        Message('changes made Successfully');
    end;

    procedure NextofKinChangeRequest(var NextofKinChange: Record "Next of Kin Change Request")
    var
        LineNo: Integer;
        NextofKin: Record "Employee Relative";
    begin
        NextofKin.Reset;
        NextofKin.SetRange("Employee No.", NextofKinChange."Employee No.");
        //NextofKin.SETRANGE("Line No.",NextofKinChange."Relative Code");
        if NextofKin.Find('-') then begin
            NextofKin.TransferFields(NextofKinChange);
            NextofKin.Modify;
        end
        else begin
            NextofKin.Init;
            NextofKin.TransferFields(NextofKinChange);
            NextofKin.Insert;
        end;
    end;

    procedure EmployeeLoan()
    var
        Employeee: Record Employee;
        LoanApp: Record "Loan Application";
    begin
        repeat
            if Employeee.Get(LoanApp."Employee No") then LoanApp."Shortcut Dimension 1 Code" := Employeee."Global Dimension 1 Code";
            LoanApp."Shortcut Dimension 2 Code" := Employeee."Global Dimension 2 Code";
            LoanApp."Payment Date" := 20190101D;
        //LoanApp.MODIFY;
        until LoanApp.Next = 0;
        Message('Updated Successfully');
    end;

    procedure FindCurrentPeriod(AnnualPeriod: Boolean): Date
    var
        AccPeriod: Record "Accounting Period";
        PeriodStart: Date;
        PeriodEnd: Date;
    begin
        if AnnualPeriod then begin
            AccPeriod.Reset;
            AccPeriod.SetRange("New Fiscal Year", true);
            AccPeriod."Starting Date" := WorkDate;
            AccPeriod.Find('=<');
            PeriodStart := AccPeriod."Starting Date";
            if AccPeriod.Next = 0 then
                PeriodEnd := 99991231D
            else
                PeriodEnd := AccPeriod."Starting Date" - 1;
        end
        else begin
            AccPeriod.Reset;
            AccPeriod.SetFilter("Starting Date", '>=%1', CalcDate('-CM', WorkDate));
            if AccPeriod.FindFirst then PeriodStart := AccPeriod."Starting Date";
        end;
        exit(PeriodStart);
    end;

    procedure AssignContracteeLeave(No: Code[20]; ContractType: Code[20]; EndDate: Date; EmployeeContracts: Record "Employee Contracts")
    var
        EmpContracts: Record "Employment Contract";
        LeaveLedger: Record "HR Leave Ledger Entries";
        LeaveType: Record "Leave Type";
        Employee: Record Employee;
        DocNo: Text;
        LeaveDays: Decimal;
        EntryNo: Integer;
        LeavePeriod: Date;
        NoOfDays: Decimal;
        LeaveAllocatedError: Label '%1 leave days have been allocated for %2 employee in the %3 period.';
        AnnualleaveError: Label 'Please an annual leave type.';
        LeavePeriodsRec: Record "Leave Periods";
    begin
        if EmpContracts.Get(ContractType) then begin
            Employee.Get(No);
            LeaveType.Reset;
            LeaveType.SetRange("Annual Leave", true);
            if LeaveType.FindFirst then
                AnnualLeave := LeaveType.Code
            else
                Error(AnnualleaveError);
            //close previous leave periods
            LeaveLedger.Reset;
            LeaveLedger.SetRange("Staff No.", No);
            LeaveLedger.SetFilter("Leave Period", '<%1', Employee."Contract Start Date");
            if LeaveLedger.FindFirst then
                repeat
                    LeaveLedger.Closed := true;
                    LeaveLedger.Modify;
                until LeaveLedger.Next = 0;
            DocNo := 'CONTRACT ' + UpperCase(Format(WorkDate, 0, '<closing><Month Text,3> <Year4>'));
            if EmpContracts."Allocate Periodically" then begin
                LeaveDays := EmpContracts."Period Leave Days";
                NoOfDays := EmpContracts."Period Leave Days";
                LeavePeriod := FindCurrentPeriod(false);
            end
            else begin
                LeaveDays := EmpContracts."Annual Leave Days";
                NoOfDays := EmpContracts."Annual Leave Days";
                LeavePeriod := FindCurrentPeriod(true);
            end;
            //Close previous Leave Period
            LeavePeriodsRec.Reset;
            LeavePeriodsRec.SetRange("Employee No.", No);
            LeavePeriodsRec.SetRange(closed, false);
            if LeavePeriodsRec.FindFirst then
                repeat
                    LeavePeriodsRec.closed := true;
                    LeavePeriodsRec.Modify;
                until LeavePeriodsRec.Next = 0;
            //Create new Leave Period
            LeavePeriodsRec.Init;
            LeavePeriodsRec."Leave Period" := EmployeeContracts."No.";
            LeavePeriodsRec."Start Date" := EmployeeContracts."Start Date";
            LeavePeriodsRec."End Date" := EmployeeContracts."End Date";
            LeavePeriodsRec."Leave Type" := AnnualLeave;
            LeavePeriodsRec."Employment Type" := Employee."Employment Type";
            LeavePeriodsRec."Employee No." := No;
            LeavePeriodsRec.Insert;
            //update employee current leave period
            Employee."Current Leave Period" := EmployeeContracts."No.";
            Employee.Modify;
            EntryNo := 1;
            LeaveLedger.Reset;
            if LeaveLedger.FindLast then EntryNo := LeaveLedger."Entry No.";
            LeaveLedger.Reset;
            LeaveLedger.SetRange("Staff No.", No);
            LeaveLedger.SetRange("Document No.", DocNo);
            if not LeaveLedger.FindFirst then begin
                LeaveLedger.Init;
                LeaveLedger."Entry No." := EntryNo + 1;
                LeaveLedger."Leave Period" := LeavePeriod;
                LeaveLedger."Staff No." := Employee."No.";
                LeaveLedger."Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
                LeaveLedger."Document No." := DocNo;
                LeaveLedger."Job ID" := Employee."Job Title";
                LeaveLedger."Job Group" := Employee."Salary Scale";
                LeaveLedger."Leave Date" := WorkDate;
                LeaveLedger."Leave Approval Date" := WorkDate;
                LeaveLedger."Contract Type" := Format(Employee."Contract Type");
                LeaveLedger."No. of days" := NoOfDays;
                LeaveLedger."Leave Posting Description" := 'Assignment for Accounting Period ' + Format(LeavePeriod);
                LeaveLedger."Transaction Type" := LeaveLedger."Transaction Type"::"Leave Allocation";
                LeaveLedger."User ID" := UserId;
                LeaveLedger."Leave Type" := AnnualLeave;
                LeaveLedger."Transaction Type" := LeaveLedger."Transaction Type"::"Leave Allocation";
                LeaveLedger."Leave Period Code" := EmployeeContracts."No.";
                LeaveLedger."Leave Start Date" := EmployeeContracts."Start Date";
                LeaveLedger."Leave End Date" := EmployeeContracts."End Date";
                LeaveLedger.Insert;
            end
            else
                Error(LeaveAllocatedError, AnnualLeave, No, DocNo);
        end;
    end;

    procedure GetLeaveEntitlement(No: Code[20]): Decimal
    var
        LeaveEntries: Record "HR Leave Ledger Entries";
        LeaveDays: Decimal;
        ContractStart: Date;
        ContractEnd: Date;
        PeriodEndDate: Date;
    begin
        PeriodEndDate := (CalcDate('1Y', FindCurrentPeriod(true)) - 1);
        if Employee.Get(No) then begin
            if Employee."Employment Type" = Employee."Employment Type"::Contract then begin
                ContractStart := Employee."Contract Start Date";
                ContractEnd := Employee."Contract End Date";
                LeaveEntries.Reset;
                LeaveEntries.SetRange("Staff No.", No);
                LeaveEntries.SetFilter("Leave Period", '>%1&<=%2', ContractStart, ContractEnd);
                LeaveEntries.CalcSums("No. of days");
                LeaveDays := LeaveEntries."No. of days";
                //MESSAGE(FORMAT(LeaveDays));
            end
            else if Employee."Employment Type" = Employee."Employment Type"::Permanent then begin
                LeaveEntries.Reset;
                LeaveEntries.SetRange("Staff No.", No);
                LeaveEntries.SetFilter("Leave Period", '>%1&<=%2', FindCurrentPeriod(true), PeriodEndDate);
                LeaveEntries.CalcSums("No. of days");
                LeaveDays := LeaveEntries."No. of days";
            end;
        end;
        exit(LeaveDays);
    end;

    procedure TransferEmployee(TransNo: Code[20]; EmpNo: Code[20])
    var
        Dimensions: Record "Dimension Value";
        Transfer: Record "Employee Transfers";
        Employee2: Record Employee;
    begin
        Transfer.Reset;
        Transfer.SetRange("Transfer No", TransNo);
        if Transfer.Find('-') then begin
            if Transfer."Transfer Type" = Transfer."Transfer Type"::Department then begin
                Employee.Reset;
                Employee.SetRange("No.", EmpNo);
                if Employee.Find('-') then begin
                    Employee."Global Dimension 2 Code" := Transfer."Department Name";
                    Employee.Validate("Global Dimension 2 Code");
                    Employee.Modify;
                end;
            end;
            if Transfer."Transfer Type" = Transfer."Transfer Type"::Branch then begin
                Employee.Reset;
                Employee.SetRange("No.", EmpNo);
                if Employee.Find('-') then begin
                    Employee."Global Dimension 1 Code" := Transfer."Station To Transfer";
                    Employee.Modify;
                end;
            end;
        end;
    end;

    procedure DeleteEmployee(No: Code[20])
    var
        Trans: Record "Employee Transfers";
    begin
        if Employee.Get(No) then begin
            Employee.Delete;
        end;
    end;

    procedure NotifyLeaveReliever(ApplicationNo: Code[20])
    var
        LeaveApp: Record "Leave Application";
        LeaveRelievers: Record "Leave Relievers";
        i: Integer;
        Relievers: Text;
        RelievingEmpMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt">This is to Notify you that <Strong>%2 - %3</Strong> is going on Leave from <Strong>%4</Strong>.  to <Strong>%5</Strong>. You will be taking over their duties from <Strong>%4</Strong>  to <Strong>%5</Strong>. <br><br>Thank you.<br><br>Kind Regards,<br><br><Strong>%6. </Strong></p>';
        Head: Label 'Relieving Employee -';
        Space: Label '  ';
        ApplicantMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> Your leave application <Strong>%2</Strong> for <Strong>%3</Strong> has been Approved. You can proceed from <Strong>%4</Strong> to <Strong>%5</Strong> and you are to resume work on <Strong>%6</Strong>. Your duties will be taken over by <Strong>%7 - %8</Strong>.<br><br>Thank you.<br><br>Kind regards,<br><br><Strong>%9<Strong></p>';
        HODMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to notify you that Employee <Strong>%2 - %3</Strong> will be going on leave from <Strong>%4</Strong> to <Strong>%5</Strong> and will be resuming work on <Strong>%6</Strong>. Their duties will be taken over by <Strong>%7 - %8</Strong>.<br><br>Thank you.<br><br>Kind regards,<br><br><Strong>%9</Strong></p>';
        NoOfRecipients: Integer;
    begin
        HRSetup.Get;
        //Notify Relieving Employee
        if LeaveApp.Get(ApplicationNo) then begin
            LeaveRelievers.Reset();
            LeaveRelievers.SetRange("Leave Code", ApplicationNo);
            if LeaveRelievers.FindSet() then begin
                repeat
                    Employee.Reset;
                    if Employee.Get(LeaveApp."Duties Taken Over By") then begin
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        CompanyInfo.TestField("E-Mail");
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyInfo.Name;
                        Employee.TestField("Company E-Mail");
                        Receipient.Add(Employee."Company E-Mail");
                        Subject := ('Relieving - ' + Space + LeaveApp."Employee No" + Space + LeaveApp."Employee Name");
                        TimeNow := Format(Time);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(RelievingEmpMsg, Employee."First Name", LeaveApp."Employee No", LeaveApp."Employee Name", LeaveApp."Start Date", LeaveApp."End Date", CompanyInfo.Name));
                        NoOfRecipients := RecipientCC.count;
                        if NoOfRecipients > 0 then //eddie  SMTP.AddCC(RecipientCC);
                            email.Send(Emailmessage);
                    end;
                until LeaveRelievers.Next() = 0;
            end;
        end;
        //Get Relievers
        if LeaveApp.Get(ApplicationNo) then begin
            LeaveRelievers.Reset();
            LeaveRelievers.SetRange("Leave Code", ApplicationNo);
            if LeaveRelievers.FindSet(false, false) then begin
                i := 1;
                repeat
                    if i = 1 then
                        Relievers := LeaveRelievers."Staff Name"
                    else
                        Relievers := Relievers + ', ' + LeaveRelievers."Staff Name";
                    i := i + 1;
                until LeaveRelievers.Next() = 0;
            end;
        end;
        //Notify Employee
        if LeaveApp.Get(ApplicationNo) then begin
            LeaveRelievers.Reset();
            LeaveRelievers.SetRange("Leave Code", ApplicationNo);
            Employee.Reset;
            if Employee.Get(LeaveApp."Employee No") then begin
                CompanyInfo.Get;
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderAddress := CompanyInfo."E-Mail";
                SenderName := CompanyInfo.Name;
                Employee.TestField("Company E-Mail");
                Receipient.add(Employee."Company E-Mail");
                Subject := ('Leave Application - ' + Space + LeaveApp."Application No");
                TimeNow := Format(Time);
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendToBody(StrSubstNo(ApplicantMsg, Employee."First Name", LeaveApp."Application No", GetLeaveName(LeaveApp."Leave Code"), LeaveApp."Start Date", LeaveApp."End Date", LeaveApp."Resumption Date", LeaveApp."Duties Taken Over By", Relievers, CompanyInfo.Name));
                NoOfRecipients := RecipientCC.count;
                if NoOfRecipients > 0 then //SMTP.AddCC(RecipientCC);
                    Email.Send(Emailmessage);
            end;
        end;
        //Notify HOD
        if LeaveApp.Get(ApplicationNo) then begin
            UserSetup.Reset;
            UserSetup.SetRange("Global Dimension 1 Code", LeaveApp."Shortcut Dimension 1 Code");
            UserSetup.SetRange("Global Dimension 2 Code", LeaveApp."Shortcut Dimension 2 Code");
            UserSetup.SetRange("HOD User", true);
            if UserSetup.FindFirst then begin
                if Employee.Get(UserSetup.Picture) then begin
                    CompanyInfo.Get;
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("E-Mail");
                    SenderAddress := CompanyInfo."E-Mail";
                    SenderName := CompanyInfo.Name;
                    Employee.TestField("Company E-Mail");
                    Receipient.Add(Employee."Company E-Mail");
                    Subject := ('Employee - ' + Space + LeaveApp."Employee No" + Space + '-' + Space + LeaveApp."Employee Name" + Space + 'Leave');
                    TimeNow := Format(Time);
                    Emailmessage.Create(Receipient, Subject, '', true);
                    Emailmessage.AppendToBody(StrSubstNo(HODMsg, Employee."First Name", LeaveApp."Employee No", LeaveApp."Employee Name", LeaveApp."Start Date", LeaveApp."End Date", LeaveApp."Resumption Date", Relievers, CompanyInfo.Name));
                    NoOfRecipients := RecipientCC.count;
                    if NoOfRecipients > 0 then //eddieEmailmessage.AddCC(RecipientCC);
                        email.Send(Emailmessage);
                end;
            end;
        end;
    end;

    procedure GetLeaveName(LeaveCode: Code[30]): Text[250]
    var
        LeaveType: Record "Leave Type";
    begin
        if LeaveType.Get(LeaveCode) then exit(LeaveType.Description);
        //MESSAGE(LeaveType.Description);
    end;

    procedure EmployeeChangeReq(Emp: Record Employee): Code[20]
    var
        NextNumber: Code[20];
        EmpChangeReq: Record "Employee Change Request";
    begin
        HRSetup.Get;
        NextNumber := NoSeriesMgt.GetNextNo(HRSetup."Employee Change Nos", 0D, true);
        EmpChangeReq.Init;
        EmpChangeReq.TransferFields(Emp);
        EmpChangeReq.Number := NextNumber;
        EmpChangeReq.Insert;
        exit(NextNumber);
    end;

    procedure GenerateCommUsers(var CommHeader: Record "Communication Header")
    var
        Text0001: Label 'Generate %1 User lines. Would you like to Proceed?';
        Text0002: Label 'Generate Users fo which Group?';
        OptStrng: Label 'Customers,Vendors,Students,Employees,Contacts';
        Selection: Integer;
    begin
        if Confirm(Text0001, true, CommHeader."Communication Type") then begin
            Selection := StrMenu(OptStrng, 3, Text0002);
            case true of
                Selection = 1:
                    begin
                        InsertCustomers(CommHeader."No.");
                    end;
                Selection = 2:
                    begin
                        InsertVendors(CommHeader."No.");
                    end;
                Selection = 3:
                    begin
                        InsertEmployees(CommHeader."No.");
                    end;
                Selection = 4:
                    begin
                        InsertContact(CommHeader."No.");
                    end;
            end;
        end;
    end;

    procedure InsertEmployees(No: Code[20])
    var
        Employee: Record Employee;
        FilterEmployee: FilterPageBuilder;
        CommLines: Record "Communication Lines";
    begin
        Clear(FilterEmployee);
        FilterEmployee.AddTable(Employee.TableName, DATABASE::Employee);
        FilterEmployee.ADdField(Employee.TableName, Employee."Global Dimension 2 Code");
        if not FilterEmployee.RunModal then exit;
        Employee.SetView(FilterEmployee.GetView(Employee.TableName));
        if Employee.FindSet then
            repeat
                CommLines.Init;
                CommLines."No." := No;
                CommLines.Category := CommLines.Category::Staff;
                CommLines."Recipient No." := Employee."No.";
                CommLines."Recipient Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                CommLines."Recipient E-Mail" := Employee."E-Mail";
                CommLines."Recipient Phone No." := Employee."Phone No.";
                CommLines.Insert;
            until Employee.Next = 0;
    end;

    procedure InsertVendors(CommNo: Code[20])
    var
        Vendor: Record Vendor;
        CommLines: Record "Communication Lines";
        FilterVendor: FilterPageBuilder;
    begin
        Clear(FilterVendor);
        FilterVendor.AddTable(Vendor.TableName, DATABASE::Vendor);
        FilterVendor.ADdField(Vendor.TableName, Vendor."No.");
        if not FilterVendor.RunModal then exit;
        Vendor.SetView(FilterVendor.GetView(Vendor.TableName));
        if Vendor.FindSet then
            repeat
                CommLines.Init;
                CommLines."No." := CommNo;
                CommLines.Category := CommLines.Category::Vendor;
                CommLines."Recipient No." := Vendor."No.";
                CommLines."Recipient Name" := Vendor.Name;
                CommLines."Recipient E-Mail" := Vendor."E-Mail";
                CommLines."Recipient Phone No." := Vendor."Phone No.";
                CommLines.Insert;
            until Vendor.Next = 0;
    end;

    procedure InsertCustomers(CommNo: Code[20])
    var
        FilterCustomer: FilterPageBuilder;
        Customer: Record Customer;
        CommLines: Record "Communication Lines";
    begin
        Clear(FilterCustomer);
        FilterCustomer.AddTable(Customer.TableName, DATABASE::Customer);
        FilterCustomer.ADdField(Customer.TableName, Customer."No.");
        if not FilterCustomer.RunModal then exit;
        Customer.SetView(FilterCustomer.GetView(Customer.TableName));
        if Customer.FindSet then
            repeat
                CommLines.Init;
                CommLines."No." := CommNo;
                CommLines.Category := CommLines.Category::Customer;
                CommLines."Recipient No." := Customer."No.";
                CommLines."Recipient Name" := Customer.Name;
                CommLines."Recipient E-Mail" := Customer."E-Mail";
                CommLines."Recipient Phone No." := Customer."Phone No.";
                CommLines.Insert;
            until Customer.Next = 0;
    end;

    procedure SendCorporateEmails(CommNo: Code[20])
    var
        OptStrng: Label 'SMS,E-Mail';
        CommHeader: Record "Communication Header";
        CommLines: Record "Communication Lines";
        Text0001: Label 'Do you want to send %1 to the Selected Users?';
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
    begin
        ICTSetup.Get;
        CompanyInfo.Get;
        if CommHeader.Get(CommNo) then begin
            CommHeader.CalcFields("E-Mail Body");
            if Confirm(Text0001, true, CommHeader."Communication Type") then begin
                case CommHeader."Communication Type" of
                    CommHeader."Communication Type"::"E-Mail":
                        begin
                            //Calc E-Mail Body
                            CommHeader.CalcFields("E-Mail Body");
                            CommHeader."E-Mail Body".CreateInStream(Instr);
                            EmailBodyBigText.Read(Instr);
                            EmailBodyText := Format(EmailBodyBigText);
                            CommLines.Reset;
                            CommLines.SetRange("No.", CommNo);
                            if CommLines.Find('-') then
                                repeat
                                    SenderName := CompanyInfo.Name;
                                    SenderAddress := CompanyInfo."E-Mail";
                                    Receipient.Add(CommLines."Recipient E-Mail");
                                    Subject := CommHeader."E-Mail Subject";
                                    TimeNow := Format(Time);
                                    FileName := CommHeader.Attachment;
                                    Emailmessage.Create(Receipient, Subject, '', true);
                                    Emailmessage.AppendToBody(StrSubstNo(EmailBodyText));
                                    Emailmessage.AddAttachment(FileName, Attachment, '');
                                    EMAIL.Send(Emailmessage);
                                    //eddie ErrorMsg := Emailmessage.GetLastSendMailErrorText();
                                    if ErrorMsg <> '' then
                                        CommLines."E-Mail Sent" := false
                                    else
                                        CommLines."E-Mail Sent" := true;
                                    CommLines.Modify;
                                until CommLines.Next = 0;
                            Message('E-Mails have been sent Successfully');
                        end;
                end;
            end
            else
                exit;
        end;
    end;

    procedure InsertContact(ComNo: Code[30])
    var
        Contact: Record Contact;
        CommLine: Record "Communication Lines";
        FilterContact: FilterPageBuilder;
    begin
        Clear(FilterContact);
        FilterContact.AddTable(Contact.TableName, DATABASE::Contact);
        FilterContact.ADdField(Contact.TableName, Contact."No.");
        FilterContact.ADdField(Contact.TableName, Contact.Type);
        if not FilterContact.RunModal then exit;
        Contact.SetView(FilterContact.GetView(Contact.TableName));
        if Contact.FindSet then begin
            CommLine.Init;
            CommLine."No." := ComNo;
            CommLine.Category := CommLine.Category::Contact;
            CommLine."Recipient No." := Contact."No.";
            CommLine."Recipient Name" := Contact.Name;
            CommLine."Recipient E-Mail" := Contact."E-Mail";
            CommLine."Recipient Phone No." := Contact."Phone No.";
            CommLine.Insert;
        end;
    end;

    [TryFunction]
    /* procedure CallRESTWebService(BaseUrl: Text; Method: Text; RestMethod: Text; var HttpContent: DotNet BCHttpContent; var HttpResponseMessage: DotNet BCHttpResponseMessage)
     var
         HttpClient: DotNet BCHttpClient;
         Uri: DotNet BCUri;
     begin
         HttpClient := HttpClient.HttpClient();
         HttpClient.BaseAddress := Uri.Uri(BaseUrl);

         case RestMethod of
             'GET':
                 HttpResponseMessage := HttpClient.GetAsync(Method).Result;
             'POST':
                 HttpResponseMessage := HttpClient.PostAsync(Method, HttpContent).Result;
             'PUT':
                 HttpResponseMessage := HttpClient.PutAsync(Method, HttpContent).Result;
             'DELETE':
                 HttpResponseMessage := HttpClient.DeleteAsync(Method).Result;
         end;

         HttpResponseMessage.EnsureSuccessStatusCode(); // Throws an error when no success
     end;
 */
    procedure EmailInstitutionReports(Institution: Code[20]; PayrollPeriod: Date; var EmailSent: Boolean)
    var
        CompanyInformation: Record "Company Information";
        InstitutionBasedReport: Report "Institution Based Report";
        PayrollPeriodX: Record "Payroll PeriodX";
        AssignmentMatrixX: Record "Assignment Matrix-X";
        Month: Date;
        Emailmessage: Codeunit "Email Message";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        Subject: Text;
        FileName: Text;
        //FileSystem: Automation BC;
        Attachment: Text;
        InstitutionRec: Record Institutions;
        FilePath: Text;
        HRSetup: Record "Human Resources Setup";
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:9pt" Kindly find attached the <b>%1</b> report from <b>%2</b> for the payroll period  <b>%3</b> .<br>Regards,<p style="font-family:Verdana,Arial;font-size:9pt">%4<br><b>%2</b></p>';
        SubjectTxt: Label 'Institution Report';
        FileError: Label ' A file with the name %1 already exists in the folder %2. Please rename, move or delete to continue.';
        FileNm: Text;
        DeductionsX: Record DeductionsX;
        DeductionsReport: Report Deductions;
    begin
        EmailSent := false;
        HRSetup.Get;
        HRSetup.TestField("Email Institutions Path");
        /* Clear(FileSystem);
        if Create(FileSystem, false, true) then begin
            if not FileSystem.FolderExists(HRSetup."Email Institutions Path") then
                FileSystem.CreateFolder(HRSetup."Email Institutions Path");
        end;
        FileNm := Institution + '-' + Format(PayrollPeriod, 0, '<closing><Month Text> <Year4>') + '.xlsx';
        FileName := HRSetup."Email Institutions Path" + FileNm;
        if FileSystem.FileExists(FileName) then
            Error(FileError, FileNm, HRSetup."Email Institutions Path"); */
        InstitutionRec.Reset;
        InstitutionRec.SetRange(Code, Institution);
        if InstitutionRec.FindFirst then begin
            InstitutionRec.TestField("Deduction Code");
            PayrollPeriodX.Reset;
            PayrollPeriodX.SetFilter("Pay Period Filter", '%1', PayrollPeriod);
            PayrollPeriodX.SetFilter("Deductions Code Filter", '%1', InstitutionRec."Deduction Code");
            if PayrollPeriodX.FindFirst then begin
                DeductionsReport.SetTableView(PayrollPeriodX);
                //EDDIEDeductionsReport.SaveAsExcel(FileName);
                CompanyInformation.Get;
                CompanyInformation.TestField(Name);
                CompanyInformation.TestField("E-Mail");
                SenderName := CompanyInformation.Name;
                SenderAddress := CompanyInformation."E-Mail";
                Receipient.Add(InstitutionRec.Email);
                Subject := SubjectTxt;
                Emailmessage.Create(Receipient, Subject, '', true);
                //SMTP.AppendBody(STRSUBSTNO(NewBody,Institution,SenderName,FORMAT(PayrollPeriod),StudentMgt.GetUserFullName(USERID)));
                Emailmessage.AddAttachment(FileName, FileNm, '');
                Email.Send(Emailmessage);
                EmailSent := true
            end;
        end;
    end;

    procedure ValidateAssignMatrix(AssignMatrix: Record "Assignment Matrix-X")
    begin
        AssignMatrix.Validate(AssignMatrix."Employee No");
        AssignMatrix.Modify;
    end;

    procedure UpdateAppraisalScores(AppraisalNo: Code[20]; EmployeeNo: Code[10])
    var
        Competences: Record "Appraisal Competences";
        Appraisal: Record "Employee Appraisal";
    begin
        Appraisal.Reset;
        Appraisal.SetRange("Appraisal No", AppraisalNo);
        Appraisal.SetRange("Employee No", EmployeeNo);
        if Appraisal.FindFirst then begin
            //Values
            // Competences.Reset;
            // Competences.SetRange("Appraisal No.", AppraisalNo);
            // Competences.SetRange("Core Value/Competence", Competences."Value/Core Competence"::Values);
            // if Competences.FindFirst then begin
            //     Appraisal.CalcFields("Values Total");
            //     Appraisal."Values Mean" := Appraisal."Values Total" / Competences.Count;
            // end;
            //Core Competences
            Competences.Reset;
            Competences.SetRange("Appraisal No.", AppraisalNo);
            Competences.SetRange("Core Value/Competence", Competences."Core Value/Competence"::"Core Values/Competences");
            if Competences.FindFirst then begin
                Appraisal.CalcFields("Competences Total");
                Appraisal."Competences Mean" := Appraisal."Competences Total" / Competences.Count;
            end;
            //Curriculum Delivery
            // Competences.Reset;
            // Competences.SetRange("Appraisal No.", AppraisalNo);
            // Competences.SetRange("Core Value/Competence", Competences."Value/Core Competence"::"Curriculum Delivery");
            // if Competences.FindFirst then begin
            //     Appraisal.CalcFields("Curriculum Total");
            //     Appraisal."Curriculum Mean" := Appraisal."Curriculum Total" / Competences.Count;
            // end;
            //Initiative & Willingness
            // Competences.Reset;
            // Competences.SetRange("Appraisal No.", AppraisalNo);
            // Competences.SetRange("Core Value/Competence", Competences."Core Value/Competence"::"Initiative & Willingness");
            // if Competences.FindFirst then begin
            //     Appraisal.CalcFields("Initiative Total");
            //     Appraisal."Initiative Mean" := Appraisal."Initiative Total" / Competences.Count;
            // end;
            //Managerial & Supervisory
            Competences.Reset;
            Competences.SetRange("Appraisal No.", AppraisalNo);
            Competences.SetRange("Core Value/Competence", Competences."Core Value/Competence"::"Core Managerial Values/Competence");
            if Competences.FindFirst then begin
                Appraisal.CalcFields("Managerial Total");
                Appraisal."Managerial  Mean" := Appraisal."Managerial Total" / Competences.Count;
            end;
            //Research
            // Competences.Reset;
            // Competences.SetRange("Appraisal No.", AppraisalNo);
            // Competences.SetRange("Core Value/Competence", Competences."Core Value/Competence"::Research);
            // if Competences.FindFirst then begin
            //     Appraisal.CalcFields("Research Total");
            //     Appraisal."Research Mean" := Appraisal."Research Total" / Competences.Count;
            // end;
            // Appraisal.Modify;
        end;
    end;

    procedure GetLeavePeriod(ApplicationDate: Date): Date
    var
        AccPeriod: Record "Accounting Period";
        PeriodStart: Date;
        PeriodEnd: Date;
    begin
        AccPeriod.Reset;
        AccPeriod.SetFilter("Starting Date", '>=%1', CalcDate('-CM', ApplicationDate));
        if AccPeriod.FindFirst then PeriodStart := AccPeriod."Starting Date";
        exit(PeriodStart);
    end;

    local procedure GetLeavePeriodCode(EmploymentType: Option Permanent,Partime,Locum,Casual,Contract,Trustee,Attachee,Intern; EmployeeNo: Code[20]): Code[10]
    var
        ErrorLeavePeriod: Label 'Please setup current leave period for permanent employment type to continue.';
        LeavePeriodsRec: Record "Leave Periods";
        ErrorLeaveContract: Label 'Please setup current leave period for contract employee %1 to continue.';
        Employee: Record Employee;
    begin
        if Employee.Get(EmployeeNo) then;
        LeavePeriod := '';
        LeavePeriodsRec.Reset;
        LeavePeriodsRec.SetRange("Employment Type", Employee."Employment Type");
        LeavePeriodsRec.SetRange(closed, false);
        if LeavePeriodsRec.Find('-') then begin
            LeavePeriodsRec.TestField("Start Date");
            LeavePeriodsRec.TestField("End Date");
            LeavePeriodStart := LeavePeriodsRec."Start Date";
            LeavePeriodEnd := LeavePeriodsRec."End Date";
            exit(LeavePeriodsRec."Leave Period")
        end
        else begin
            if Employee."Employment Type" = Employee."Employment Type"::Permanent then
                Error(ErrorLeavePeriod)
            else
                Error(ErrorLeaveContract, EmployeeNo);
        end;
    end;

    procedure LeaveAbsentism(EmployeeAbsence: Record "Employee Absence")
    var
        LeaveLedg: Record "HR Leave Ledger Entries";
        Employee: Record Employee;
        LeaveType: Record "Leave Type";
    begin
        Employee.Get(EmployeeAbsence."Employee No.");
        LeaveLedg.Init;
        LeaveLedg."Document No." := Employee."No." + '-' + Format(EmployeeAbsence."Entry No.");
        LeaveLedg."Leave Period" := EmployeeAbsence."From Date";
        LeaveLedg."Leave Start Date" := EmployeeAbsence."From Date";
        LeaveLedg."Leave End Date" := EmployeeAbsence."To Date";
        LeaveLedg."Leave Approval Date" := Today;
        LeaveType.Reset;
        LeaveType.SetRange("Annual Leave", true);
        if LeaveType.FindFirst then LeaveLedg."Leave Type" := LeaveType.Code;
        LeaveLedg."Leave Period Code" := Employee."Current Leave Period";
        LeaveLedg."Staff No." := Employee."No.";
        LeaveLedg."Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        LeaveLedg."Job ID" := Employee."Job Title";
        LeaveLedg."Job Group" := Employee."Salary Scale";
        LeaveLedg."Contract Type" := Employee."Nature of Employment";
        LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
        LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
        LeaveLedg."User ID" := UserId;
        LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Negative;
        LeaveLedg."No. of days" := -((EmployeeAbsence."To Date" - EmployeeAbsence."From Date") + 1);
        LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Adjustment";
        LeaveLedg.Insert;
    end;

    procedure UpdateUserExpiry(EmployeeRec: Record "Employee Contracts")
    var
        UserSetup: Record "User Setup";
        user: Record User;
    begin
        UserSetup.Reset;
        UserSetup.SetRange("Employee No.", EmployeeRec."Employee No");
        if UserSetup.FindFirst then begin
            user.Reset;
            user.SetRange("User Name", UserSetup."User ID");
            if user.FindFirst then begin
                user."Expiry Date" := CreateDateTime(EmployeeRec."End Date", 235959T);
                user.Modify;
            end;
        end;
    end;

    procedure NotifyStaffDisciplinary(EmployeeDiscplinary: Record "Employee Discplinary")
    var
        EmailBodyBigText: BigText;
        SMTP: Codeunit "Email Message";
        Instr: InStream;
        SenderName: Text;
        SenderAddress: Text;
        Attachment: Text;
        ErrorMsg: Text;
        EmailBodyText: Text;
    begin
        CompanyInfo.Get;
        HRSetup.Get;
        HRSetup.TestField("Human Resource Emails");
        EmployeeDiscplinary.TestField("E-Mail Subject");
        EmployeeDiscplinary.TestField("Recipient Email");
        EmployeeDiscplinary.CalcFields("E-Mail Body Text");
        EmployeeDiscplinary."E-Mail Body Text".CreateInStream(Instr);
        EmailBodyBigText.Read(Instr);
        EmailBodyText := Format(EmailBodyBigText);
        SenderName := CompanyInfo.Name;
        SenderAddress := HRSetup."Human Resource Emails";
        Receipient.Add(EmployeeDiscplinary."Recipient Email");
        Emailmessage.Create(Receipient, EmployeeDiscplinary."E-Mail Subject", '', true);
        Emailmessage.AppendToBody(EmailBodyText);
        if EmployeeDiscplinary."Recipient CC" <> '' then begin
            RecipientCC.Add(EmployeeDiscplinary."Recipient CC");
            //eddieSMTP.AddCC(RecipientCC);
        end;
        if EmployeeDiscplinary."Recipient BCC" <> '' then begin
            RecipientBCC.Add(EmployeeDiscplinary."Recipient BCC");
            //eddie  SMTP.AddBCC(RecipientBCC);
        end;
        Email.send(Emailmessage);
        //eddieErrorMsg := SMTP.GetLastSendMailErrorText();
        if ErrorMsg = '' then Message('Notified Successfully');
    end;

    procedure NotifyCommitteeDisciplinary(EmployeeDiscplinary: Record "Employee Discplinary")
    var
        EmailBodyBigText: BigText;
        EmailMessage: Codeunit "Email Message";
        Instr: InStream;
        SenderName: Text;
        SenderAddress: Text;
        Attachment: Text;
        ErrorMsg: Text;
        EmailBodyText: Text;
        CommitteeLine: Record "Committee Member Lines";
    begin
        CompanyInfo.Get;
        HRSetup.Get;
        HRSetup.TestField("Human Resource Emails");
        EmployeeDiscplinary.TestField("Committee E-Mail Subject");
        If EmployeeDiscplinary."Select Email Type" = EmployeeDiscplinary."Select Email Type"::"Committee Email" then begin
            EmployeeDiscplinary.TestField("Committee Recipient Email");
            Receipient.Add(EmployeeDiscplinary."Committee Recipient Email");
        end
        else If EmployeeDiscplinary."Select Email Type" = EmployeeDiscplinary."Select Email Type"::"Individual Email" then begin
            CommitteeLine.Reset();
            CommitteeLine.SetRange("Batch No.", EmployeeDiscplinary."Committee No");
            If CommitteeLine.Find('-') then
                repeat
                    CommitteeLine.TestField("Employee Email");
                    Receipient.Add(CommitteeLine."Employee Email");
                until CommitteeLine.Next() = 0;
        end;
        EmployeeDiscplinary.CalcFields("Committee E-Mail Body Text");
        EmployeeDiscplinary."Committee E-Mail Body Text".CreateInStream(Instr);
        EmailBodyBigText.Read(Instr);
        EmailBodyText := Format(EmailBodyBigText);
        SenderName := CompanyInfo.Name;
        SenderAddress := HRSetup."Human Resource Emails";
        Emailmessage.Create(Receipient, EmployeeDiscplinary."Committee E-Mail Subject", '', true);
        Emailmessage.AppendToBody(EmailBodyText);
        if EmployeeDiscplinary."Committee Recipient CC" <> '' then begin
            RecipientCC.Add(EmployeeDiscplinary."Committee Recipient CC");
            ///eddie Emailmessage.AddCC(RecipientCC);
        end;
        if EmployeeDiscplinary."Committee Recipient BCC" <> '' then begin
            RecipientBCC.Add(EmployeeDiscplinary."Committee Recipient BCC");
            //eddie Emailmessage.AddBCC(RecipientBCC);
        end;
        email.send(EmailMessage);
        //ErrorMsg := SMTP.GetLastSendMailErrorText();
        if ErrorMsg = '' then Message('Committee Members Notified Successfully');
    end;

    procedure CheckIfLeaveAllowanceExists(LeaveAppRec: Record "Leave Application")
    var
        LeaveLedger: Record "HR Leave Ledger Entries";
        LeaveAppRec2: Record "Leave Application";
        AllExistsError: Label 'You have already applied for leave allowance for the period %1';
    begin
        LeaveAppRec2.Reset;
        LeaveAppRec2.SetRange("Employee No", LeaveAppRec."Employee No");
        LeaveAppRec2.SetRange(Status, LeaveAppRec2.Status::Released);
        LeaveAppRec2.SetRange("Leave Period", LeaveAppRec."Leave Period");
        LeaveAppRec2.SetRange("Leave Allowance Payable", true);
        if LeaveAppRec2.FindFirst then Error(AllExistsError, LeaveAppRec."Leave Period");
    end;

    procedure GetCurrentLeavePeriod(EmpType: Option Permanent,Partime,Locum,Casual,Contract,Trustee,Attachee,Intern): Code[20]
    var
        LeavePeriods: Record "Leave Periods";
    begin
        LeavePeriods.Reset;
        LeavePeriods.SetRange(closed, false);
        LeavePeriods.SetRange("Employment Type", EmpType);
        if LeavePeriods.Find('-') then
            exit(LeavePeriods."Leave Period")
        else
            Error('Please define a new leave period for %1 employee type', EmpType);
    end;

    procedure NotifyLeaveRecallee(LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveApp: Record "Leave Application";
        Head: Label 'Relieving Employee -';
        Space: Label '  ';
        RecallMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that we have decided to recall you from your leave that was to run from <Strong>%2</Strong> to <Strong>%3</Strong>. </br><br>The reason for recall is: <b>%4</b><br> You are therefore advised to report back to work from <Strong>%5</Strong> to <Strong>%6</Strong>. <br><br> Thank you for your cooperation.<br><br>Kind regards,<br><br><Strong>%7<Strong></p>';
    begin
        HRSetup.Get;
        HRSetup.TestField("Human Resource Emails");
        Employee.Reset;
        if Employee.Get(LeaveRecall."Employee No") then begin
            CompanyInfo.Get;
            CompanyInfo.TestField(Name);
            SenderAddress := HRSetup."Human Resource Emails";
            SenderName := CompanyInfo.Name;
            Receipient.Add(Employee."E-Mail");
            Subject := 'Leave Recall';
            TimeNow := Format(Time);
            Emailmessage.Create(Receipient, Subject, '', true);
            Emailmessage.AppendToBody(StrSubstNo(RecallMsg, Employee."First Name", Format(LeaveRecall."Leave Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), Format(LeaveRecall."Leave Ending Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), LeaveRecall."Reason for Recall", Format(LeaveRecall."Recalled From", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), Format(LeaveRecall."Recalled To", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), CompanyInfo.Name));
            Email.Send(Emailmessage);
        end;
    end;

    procedure IndentAppraisalGoals(DocNo: Code[20])
    var
        AppraisalLines: Record "Appraisal Lines";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        i: Integer;
    begin
        //Window.OPEN(Text004);
        AppraisalLines.SetRange("Appraisal No", DocNo);
        if AppraisalLines.Find('-') then
            repeat //Window.UPDATE(1,"Line No");
                case AppraisalLines."Appraisal Line Type" of
                    AppraisalLines."Appraisal Line Type"::"Objective Heading", AppraisalLines."Appraisal Line Type"::"Objective Heading End":
                        i := 0;
                    AppraisalLines."Appraisal Line Type"::"Sub-Heading", AppraisalLines."Appraisal Line Type"::"Sub-Heading End":
                        i := 1;
                    AppraisalLines."Appraisal Line Type"::Objective:
                        i := 2;
                end;
                if AppraisalLines."Appraisal Line Type" = AppraisalLines."Appraisal Line Type"::"Sub-Heading End" then begin
                    if i < 1 then Error(Text005, AppraisalLines."Line No");
                    //i := i - 1;
                end;
                AppraisalLines.Indentation := i;
                AppraisalLines.Modify;
            /*IF "Appraisal Line Type" = "Appraisal Line Type"::"Sub-Heading" THEN BEGIN
              i := i + 1;
              AccNo[i] := FORMAT("Line No");
            END;*/
            until AppraisalLines.Next = 0;
        //Window.CLOSE;
    end;

    procedure CheckTrainingCostExceeded(RequestNo: Code[20]; NeedNo: Code[20])
    var
        TrainingRequest: Record "Training Request";
        TrainingNeed: Record "Training Need";
        TrainingRequestLines: Record "Training Request Lines";
        TrainingNeedsLines: Record "Training Needs Lines";
        Text001: Label 'The Training Need %1 must have lines to approve %2 Request.';
        Expense: Decimal;
        TotalExpense: Decimal;
        Text002: Label 'The Expense Code %1 was allocated %2 in Training Need %3. A total of %4 has been used in approved requests. There is a remainder of %5 that can be used.';
    begin
        TrainingRequest.Get(RequestNo);
        TrainingRequest.TestField("Training Need");
        TrainingNeed.Get(NeedNo);
        TrainingNeedsLines.Reset;
        TrainingNeedsLines.SetRange("Document No.", NeedNo);
        if TrainingNeedsLines.FindFirst then begin
            repeat
                TrainingRequestLines.Reset;
                TrainingRequestLines.SetRange("Training Need No", NeedNo);
                TrainingRequestLines.SetRange("Expense Code", TrainingNeedsLines."Expense Code");
                TrainingRequestLines.SetFilter(Status, '=%1', TrainingRequestLines.Status::Released);
                if TrainingRequestLines.FindFirst then begin
                    TrainingRequestLines.CalcSums(Amount);
                    Expense := TrainingRequestLines.Amount;
                end;
                TrainingRequestLines.Reset;
                TrainingRequestLines.SetRange("Document No.", RequestNo);
                TrainingRequestLines.SetRange("Expense Code", TrainingNeedsLines."Expense Code");
                if TrainingRequestLines.FindFirst then begin
                    TotalExpense := Expense + TrainingRequestLines.Amount;
                    if TotalExpense > TrainingNeedsLines.Amount then Error(Text002, TrainingNeedsLines."Expense Code", Format(TrainingNeedsLines.Amount), NeedNo, Format(Expense), Format(TrainingNeedsLines.Amount - Expense));
                end;
            until TrainingNeedsLines.Next = 0;
        end
        else
            Error(Text001, NeedNo, RequestNo);
    end;

    procedure GetVacantPositions(Vacant: Record "Company Job")
    begin
        Vacant.CalcFields("Occupied Position");
        Vacant.Vacancy := Vacant."No of Posts" - Vacant."Occupied Position";
        if Vacant.Vacancy < 0 then Vacant.Vacancy := 0;
        Vacant.Modify();
    end;

    procedure SendToFinalYearAppraisal(EmpAppraisal: Record "Employee Appraisal")
    var
        AppTypes: Record "Appraisal Type";
        AppPeriod: Record "Appraisal Periods";
    begin
        Message('This appraisal shall be moved to pending final year appraisal');
        //EmpAppraisal.Type := EmpAppraisal.Type::"Final Year";
        //EmpAppraisal."Appraisal Period" := GetOpenAppraisalPeriod(AppPeriod."Appraisal Type"::"Final Year");
        EmpAppraisal.Validate("Appraisal Period");
        EmpAppraisal.Status := EmpAppraisal.Status::Released;
        EmpAppraisal."Appraisal Status" := EmpAppraisal."Appraisal Status"::Review;
        EmpAppraisal.Modify;
    end;

    procedure SendToFinalYear(EmpAppraisal: Record "Employee Appraisal")
    var
        prevGoals: Record "Appraisal Lines";
        AppPeriod: Record "Appraisal Periods";
        Appr: Record "Employee Appraisal";
        ApprGoals: Record "Appraisal Lines";
    begin
        Message('This appraisal shall be send to final year');
        Appr.Init();
        Appr."Appraisal No" := '';
        //Appr.AppraisalType := Appr.AppraisalType::"Final Year";
        Appr."Appraisee ID" := EmpAppraisal."Appraisee ID";
        //Appr."Appraisal Period" := GetOpenAppraisalPeriod(AppPeriod."Appraisal Type"::"Final Year");
        Appr."Appraisee ID" := EmpAppraisal."Appraisee ID";
        Appr."Employee No" := EmpAppraisal."Employee No";
        Appr."Total Mid-Year" := EmpAppraisal."Total Mid-Year";
        Appr.Validate("Employee No");
        Appr.Validate("Appraisee ID");
        Appr.Validate("Appraisal Period");
        Appr."Appraisal Status" := Appr."Appraisal Status"::Review;
        Appr.Status := Appr.Status::Released;
        Appr.Insert(true);
        prevGoals.Reset();
        prevGoals.SetRange("Appraisal No", EmpAppraisal."Appraisal No");
        // if prevGoals.Find('-') then
        //     repeat
        //         ApprGoals.Init;
        //         ApprGoals."Appraisal No" := Appr."Appraisal No";
        //         ApprGoals."Objective Code" := prevGoals."Objective Code";
        //         ApprGoals.Validate("Objective Code");
        //         ApprGoals."Initiative code" := prevGoals."Initiative code";
        //         ApprGoals.Validate("Initiative code");
        //         ApprGoals."Line No" := prevGoals."Line No";
        //         ApprGoals."Activity code" := prevGoals."Activity code";
        //         ApprGoals.Validate("Activity code");
        //         ApprGoals."Agreed perfomance targets" := prevGoals."Agreed perfomance targets";
        //         ApprGoals.Weighting := prevGoals.Weighting;
        //         ApprGoals."FY Target" := prevGoals."FY Target";
        //         ApprGoals.Insert(true);
        //     until prevGoals.Next() = 0;
        // Message('appraisal send to final year');
    end;

    procedure SendToQ2(EmpAppraisal: Record "Employee Appraisal")
    var
        prevGoals: Record "Appraisal Lines";
        AppPeriod: Record "Appraisal Periods";
        Appr: Record "Employee Appraisal";
        ApprGoals: Record "Appraisal Lines";
    begin
        Message('This appraisal shall be send to Q2, review ');
        Appr.Init();
        Appr."Appraisal No" := '';
        //Appr.AppraisalType := Appr.AppraisalType::Q2;
        Appr."Appraisal Period" := GetOpenAppraisalPeriod(AppPeriod."Appraisal Type"::Q2);
        Appr."Appraisee ID" := EmpAppraisal."Appraisee ID";
        Appr."Employee No" := EmpAppraisal."Employee No";
        Appr.Validate("Employee No");
        Appr.Validate("Appraisee ID");
        Appr.Validate("Appraisal Period");
        Appr."Appraisal Status" := Appr."Appraisal Status"::Review;
        Appr.Status := Appr.Status::Released;
        Appr.Insert(true);
        prevGoals.Reset();
        prevGoals.SetRange("Appraisal No", EmpAppraisal."Appraisal No");
        if prevGoals.Find('-') then
            repeat
                ApprGoals.Init;
                ApprGoals."Appraisal No" := Appr."Appraisal No";
                ApprGoals."Key Responsibility" := prevGoals."Key Responsibility";
                ApprGoals.Description := prevGoals.Description;
                ApprGoals."Line No" := prevGoals."Line No";
                ApprGoals."Key Indicators" := prevGoals."Key Indicators";
                ApprGoals.Task := prevGoals.Task;
                ApprGoals."Agreed perfomance targets" := ApprGoals."Agreed perfomance targets";
                ApprGoals.Weighting := prevGoals.Weighting;
                ApprGoals.Insert(true);
            until prevGoals.Next() = 0;
        Message('appraisal send to next quarter');
    end;

    procedure SendToQ3(EmpAppraisal: Record "Employee Appraisal")
    var
        prevGoals: Record "Appraisal Lines";
        AppPeriod: Record "Appraisal Periods";
        Appr: Record "Employee Appraisal";
        ApprGoals: Record "Appraisal Lines";
    begin
        Message('This appraisal shall be send to Q3, review ');
        Appr.Init();
        Appr."Appraisal No" := '';
        //Appr.AppraisalType := Appr.AppraisalType::Q3;
        Appr."Appraisal Period" := GetOpenAppraisalPeriod(AppPeriod."Appraisal Type"::Q3);
        Appr."Appraisee ID" := EmpAppraisal."Appraisee ID";
        Appr."Employee No" := EmpAppraisal."Employee No";
        Appr.Validate("Employee No");
        Appr.Validate("Appraisee ID");
        Appr.Validate("Appraisal Period");
        Appr."Appraisal Status" := Appr."Appraisal Status"::Review;
        Appr.Status := Appr.Status::Released;
        Appr.Insert(true);
        prevGoals.Reset();
        prevGoals.SetRange("Appraisal No", EmpAppraisal."Appraisal No");
        if prevGoals.Find('-') then
            repeat
                ApprGoals.Init;
                ApprGoals."Appraisal No" := Appr."Appraisal No";
                ApprGoals."Key Responsibility" := prevGoals."Key Responsibility";
                ApprGoals.Description := prevGoals.Description;
                ApprGoals."Line No" := prevGoals."Line No";
                ApprGoals."Key Indicators" := prevGoals."Key Indicators";
                ApprGoals.Task := prevGoals.Task;
                ApprGoals."Agreed perfomance targets" := ApprGoals."Agreed perfomance targets";
                ApprGoals.Weighting := prevGoals.Weighting;
                // ApprGoals."Appraisal No" := Appr."Appraisal No";
                // ApprGoals."Objective Code" := prevGoals."Objective Code";
                // ApprGoals.Validate("Objective Code");
                // ApprGoals."Initiative code" := prevGoals."Initiative code";
                // ApprGoals.Validate("Initiative code");
                // ApprGoals."Line No" := prevGoals."Line No";
                // ApprGoals."Activity code" := prevGoals."Activity code";
                // ApprGoals.Validate("Activity code");
                // ApprGoals.Weighting := prevGoals.Weighting;
                // ApprGoals."FY Target" := prevGoals."FY Target";
                ApprGoals.Insert(true);
            until prevGoals.Next() = 0;
        Message('appraisal send to next quarter');
    end;

    procedure SendToQ4(EmpAppraisal: Record "Employee Appraisal")
    var
        prevGoals: Record "Appraisal Lines";
        AppPeriod: Record "Appraisal Periods";
        Appr: Record "Employee Appraisal";
        ApprGoals: Record "Appraisal Lines";
    begin
        Message('This appraisal shall be send to Q4');
        Appr.Init();
        Appr."Appraisal No" := '';
        //Appr.AppraisalType := Appr.AppraisalType::Q4;
        Appr."Appraisal Period" := GetOpenAppraisalPeriod(AppPeriod."Appraisal Type"::Q4);
        Appr."Appraisee ID" := EmpAppraisal."Appraisee ID";
        Appr."Employee No" := EmpAppraisal."Employee No";
        Appr.Validate("Employee No");
        Appr.Validate("Appraisee ID");
        Appr.Validate("Appraisal Period");
        Appr."Appraisal Status" := Appr."Appraisal Status"::Review;
        Appr.Status := Appr.Status::Released;
        Appr.Insert(true);
        prevGoals.Reset();
        prevGoals.SetRange("Appraisal No", EmpAppraisal."Appraisal No");
        if prevGoals.Find('-') then
            repeat
                ApprGoals.Init;
                // ApprGoals."Appraisal No" := Appr."Appraisal No";
                // ApprGoals."Objective Code" := prevGoals."Objective Code";
                // ApprGoals.Validate("Objective Code");
                // ApprGoals."Initiative code" := prevGoals."Initiative code";
                // ApprGoals.Validate("Initiative code");
                // ApprGoals."Line No" := prevGoals."Line No";
                // ApprGoals."Activity code" := prevGoals."Activity code";
                // ApprGoals.Validate("Activity code");
                // ApprGoals.Weighting := prevGoals.Weighting;
                // ApprGoals."FY Target" := prevGoals."FY Target";
                ApprGoals."Appraisal No" := Appr."Appraisal No";
                ApprGoals."Key Responsibility" := prevGoals."Key Responsibility";
                ApprGoals.Description := prevGoals.Description;
                ApprGoals."Line No" := prevGoals."Line No";
                ApprGoals."Key Indicators" := prevGoals."Key Indicators";
                ApprGoals.Task := prevGoals.Task;
                ApprGoals."Agreed perfomance targets" := ApprGoals."Agreed perfomance targets";
                ApprGoals.Weighting := prevGoals.Weighting;
                ApprGoals.Insert(true);
            until prevGoals.Next() = 0;
        Message('appraisal send to next quarter');
    end;

    procedure GetAverageRating(AppraisalLines: Record "Appraisal Lines")
    var
    begin
        if (AppraisalLines."Employee's Marks" <> 0) and (AppraisalLines."Supervisor's Marks" <> 0) then AppraisalLines."Total marks per target" := (AppraisalLines."Supervisor's Marks" + AppraisalLines."Employee's Marks") / 2;
        AppraisalLines.Modify();
    end;

    procedure GetTotalRating(Appraisal: Record "Employee Appraisal")
    var
        Matrix: Record "Perfomance rating matrix";
    begin
        Appraisal.CalcFields("Total FY Attributes", "Expected TR -attributes");
        if (Appraisal."Total FY Attributes" <> 0) and (Appraisal."Expected TR -attributes" <> 0) then Appraisal."Total Percentage-Attributes" := (Appraisal."Total FY Attributes" / Appraisal."Expected TR -attributes") * 30;
        Matrix.Reset();
        Matrix.SetFilter(Start, '<=%1', Appraisal."Total Percentage-Attributes");
        Matrix.SetFilter("End", '>=%1', Appraisal."Total Percentage-Attributes");
        IF Matrix.FindFirst() then Appraisal."Grade-Attributes" := Matrix.Grade;
        Appraisal.CalcFields("Total FY Rating", "Total Weighting");
        if (Appraisal."Total FY Rating" <> 0) and (Appraisal."Total Weighting" <> 0) then Appraisal."Total Percentage FY Rating" := (Appraisal."Total FY Rating" / Appraisal."Total Weighting") * 70;
        if (Appraisal."Total Percentage FY Rating" <> 0) and (Appraisal."Total Percentage-Attributes" <> 0) then Appraisal."Total score" := (Appraisal."Total Percentage FY Rating" + Appraisal."Total Percentage-Attributes");
        Matrix.Reset();
        Matrix.SetFilter(Start, '<=%1', Appraisal."Total Percentage FY Rating");
        Matrix.SetFilter("End", '>=%1', Appraisal."Total Percentage FY Rating");
        IF Matrix.FindFirst() then Appraisal."Grade final year rating" := Matrix.Grade;
        Appraisal.Modify();
    end;

    procedure InsertFuelAllocLines(FuelAllocation: Record "Fuel Allocations")
    var
        FixedAsset: Record "Fixed Asset";
        FuelAlloc: Record "Fuel Allocation Lines";
    begin
        FixedAsset.Reset();
        FixedAsset.SetRange("Fixed Asset Type", FixedAsset."Fixed Asset Type"::Fleet);
        FixedAsset.SetRange("Vehicle Type", FixedAsset."Vehicle Type"::Company);
        if FixedAsset.Find('-') then begin
            FuelAlloc.Reset();
            FuelAlloc.SetRange(Period, FuelAllocation.Period);
            if FuelAlloc.Find('-') then FuelAlloc.DeleteAll();
            repeat
                FuelAlloc.Init();
                FuelAlloc.Vehicle := FixedAsset."No.";
                FuelAlloc."Card No" := FixedAsset."Card No";
                FuelAlloc.Period := FuelAllocation.Period;
                FuelAlloc.Validate(Vehicle);
                FuelAlloc.Insert();
            until FixedAsset.Next() = 0;
        end;
    end;

    procedure GetFuelBalance(var FuelAlloc: Record "Fuel Allocation Lines")
    var
        FA: Record "Fixed Asset";
    begin
        FA.Reset();
        FA.SetRange("No.", FuelAlloc.Vehicle);
        if FA.FindFirst() then begin
            FA.CalcFields("Card balance");
            FuelAlloc.Balance := FA."Card balance";
            FuelAlloc.Modify();
        end;
    end;

    procedure TransferFuelBalances(FuelAllocPer: Record "Fuel Allocation Periods")
    var
        FuelAllocLines: Record "Fuel Allocation Lines";
        FuelAllocLines2: Record "Fuel Allocation Lines";
        FuelAlloc: Record "Fuel Allocations";
    begin
        FuelAllocPer.closed := true;
        FuelAllocPer.Modify();
        FuelAlloc.SetRange(Period, FuelAllocPer.Period);
        if FuelAlloc.FindFirst() then begin
            FuelAllocLines.Reset();
            FuelAllocLines.SetRange(Period, FuelAlloc.Period);
            if FuelAllocLines.Find('-') then
                repeat
                    FuelAllocLines2.Init();
                    FuelAllocLines2."Previous Balance" := FuelAllocLines.Balance;
                    FuelAllocLines2.Vehicle := FuelAllocLines.Vehicle;
                    FuelAllocLines2.Period := GetNextFuelPeriod();
                    FuelAllocLines2.Insert();
                until FuelAllocLines.Next() = 0;
        end;
    end;

    procedure GetPreviousBalances(FuelAllocPer: Record "Fuel Allocation Periods")
    var
        FuelAllocLines: Record "Fuel Allocation Lines";
        FuelAllocLines2: Record "Fuel Allocation Lines";
        FuelAlloc: Record "Fuel Allocations";
    begin
        FuelAllocPer.closed := true;
        FuelAllocPer.Modify();
        FuelAlloc.SetRange(Period, FuelAllocPer.Period);
        if FuelAlloc.FindFirst() then begin
            FuelAllocLines.Reset();
            FuelAllocLines.SetRange(Period, FuelAlloc.Period);
            if FuelAllocLines.Find('-') then
                repeat
                    FuelAllocLines2.Init();
                    FuelAllocLines2."Previous Balance" := FuelAllocLines.Balance;
                    FuelAllocLines2.Vehicle := FuelAllocLines.Vehicle;
                    FuelAllocLines2.Period := GetNextFuelPeriod();
                    FuelAllocLines2.Insert();
                until FuelAllocLines.Next() = 0;
        end;
    end;

    procedure GetNextFuelPeriod(): Code[20]
    var
        NextPeriod: Code[20];
        NextPeriodStart: Date;
        FuelPeriod: Record "Fuel Allocation Periods";
        FuelPeriodCopy: Record "Fuel Allocation Periods";
    begin
        FuelPeriod.SetCurrentKey("Start Date");
        FuelPeriod.SetRange(closed, false);
        if FuelPeriod.FindFirst() then NextPeriodStart := FuelPeriod."Start Date";
        FuelPeriod.Reset();
        FuelPeriod.SetRange("Start Date", NextPeriodStart);
        if FuelPeriod.FindFirst() then NextPeriod := FuelPeriod.Period;
        exit(NextPeriod);
    end;

    procedure TransferAsset(TransNo: Code[20])
    var
        Dimensions: Record "Dimension Value";
        Transfer: Record "Asset Allocation and Transfer";
        Asset: Record "Fixed Asset";
    begin
        Transfer.Reset;
        Transfer.SetRange("No.", TransNo);
        if Transfer.Find('-') then begin
            Asset.Reset();
            Asset.SetRange("No.", Transfer.Asset);
            if Asset.Find('-') then begin
                Asset."Responsible Employee" := Transfer."New Employee No.";
                Asset."Global Dimension 1 Code" := Transfer."Transfer Branch";
                Asset."Global Dimension 2 Code" := Transfer."Current Department";
                Asset.Validate("Responsible Employee");
                Asset.Modify();
                NotifyAssetEmployee(TransNo);
                Message('Asset transferred sucessfully');
            end;
            Transfer.Transferred := true;
            Transfer.Modify();
        end;
    end;

    procedure AllocateAsset(AllocNo: Code[20])
    var
        Dimensions: Record "Dimension Value";
        Transfer: Record "Asset Allocation and Transfer";
        Asset: Record "Fixed Asset";
    begin
        Transfer.Reset;
        Transfer.SetRange("No.", AllocNo);
        if Transfer.Find('-') then begin
            Asset.Reset();
            Asset.SetRange("No.", Transfer.Asset);
            if Asset.Find('-') then begin
                Asset."Responsible Employee" := Transfer."New Employee No.";
                Asset.Validate("Responsible Employee");
                Asset."Global Dimension 1 Code" := Transfer."Current Branch";
                Asset."Global Dimension 2 Code" := Transfer."Current Department";
                Asset.Modify();
                NotifyAssetEmployee(AllocNo);
                Message('Asset allocated sucessfully');
            end;
            Transfer.Allocated := true;
            Transfer.Modify();
        end;
    end;

    procedure GetOpenAppraisalPeriod(AppType: Option): Code[20]
    var
        AppPeriod: Record "Appraisal Periods";
    begin
        AppPeriod.Reset;
        AppPeriod.SetRange("Appraisal Type", AppType);
        if AppPeriod.FindFirst then
            exit(AppPeriod.Period)
        else
            Error('Please define an the next period');
    end;

    procedure NotifyTransportEmployees(DocNo: Code[50])
    var
        LeaveApp: Record "Leave Application";
        Head: Label 'Relieving Employee -';
        Space: Label '  ';
        RecallMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that we have decided to recall you from your leave that was to run from <Strong>%2</Strong> to <Strong>%3</Strong>. </br><br>The reason for recall is: <b>%4</b><br> You are therefore advised to report back to work from <Strong>%5</Strong> to <Strong>%6</Strong>. <br><br> Thank you for your cooperation.<br><br>Kind regards,<br><br><Strong>%7<Strong></p>';
        Employee: Record Employee;
        TransportTrips: Record "Transport Trips";
        TravellingEmployees: Record "Travelling Employee";
        ReqMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that your transport request to <strong>%7</strong> planned from <Strong>%2</Strong> to <Strong>%3</Strong> has been approved. </br><br>You have been assigned Vehicle No. <strong>%9 - %8</strong> and Driver Staff No. <strong>%4 - %5 </strong>. <br><br> Thank you.<br><br>Kind regards,<br><br><Strong>%6<Strong></p>';
        TravEmployeeMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that your trip to <strong>%7</strong> planned from <Strong>%2</Strong> to <Strong>%3</Strong> has started. </br><br>You were assigned Vehicle No. <strong>%9 - %8</strong> and Driver Staff No. <strong>%4 - %5 </strong>. <br><br> Thank you.<br><br>Kind regards,<br><br><Strong>%6<Strong></p>';
        DriverMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that you have been assigned a travel request raised by Staff No. <strong>%8 - %9</strong> to <strong>%7</strong> planned from <Strong>%2</Strong> to <Strong>%3</Strong>. </br><br>You have been allocated Vehicle No. <strong>%4 - %5</strong>. <br><br> Thank you.<br><br>Kind regards,<br><br><Strong>%6<Strong></p>';
        TravelRequests: Record "Travel Requests";
    begin
        if TravelRequests.Get(DocNo) then begin
            HRSetup.Get;
            HRSetup.TestField("Human Resource Emails");
            TransportTrips.Reset;
            TransportTrips.SetRange("Request No", TravelRequests."Request No.");
            if TransportTrips.FindFirst then begin
                //Notify Requester
                if Employee.Get(TravelRequests."Employee No.") then begin
                    Clear(Receipient);
                    Employee.TestField("E-Mail");
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    SenderAddress := HRSetup."Human Resource Emails";
                    SenderName := CompanyInfo.Name;
                    Receipient.add(Employee."E-Mail");
                    Subject := StrSubstNo('Travel Request - %1', TravelRequests."Request No.");
                    TimeNow := Format(Time);
                    Emailmessage.Create(Receipient, Subject, '', true);
                    Emailmessage.AppendToBody(StrSubstNo(ReqMsg, TravelRequests."Employee Name", Format(TravelRequests."Trip Planned Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), Format(TravelRequests."Trip Planned End Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), TransportTrips.Driver, TransportTrips."Drivers Name", CompanyInfo.Name, TravelRequests.Destination, TransportTrips."Vehicle Description", TransportTrips."Vehicle No"));
                    Email.Send(Emailmessage);
                end;
            end;
            //Notify Driver(s)
            TransportTrips.Reset;
            TransportTrips.SetRange("Request No", TravelRequests."Request No.");
            if TransportTrips.Find('-') then begin
                repeat
                    if Employee.Get(TransportTrips.Driver) then begin
                        Clear(Receipient);
                        Employee.TestField("E-Mail");
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        SenderAddress := HRSetup."Human Resource Emails";
                        SenderName := CompanyInfo.Name;
                        Receipient.Add(Employee."E-Mail");
                        Subject := StrSubstNo('Travel Request - %1', TravelRequests."Request No.");
                        TimeNow := Format(Time);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(DriverMsg, TransportTrips."Drivers Name", Format(TravelRequests."Trip Planned Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), Format(TravelRequests."Trip Planned End Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), TransportTrips."Vehicle No", TransportTrips."Vehicle Description", CompanyInfo.Name, TravelRequests.Destination, TravelRequests."Employee No.", TravelRequests."Employee Name"));
                        Email.Send(Emailmessage);
                    end;
                until TransportTrips.Next = 0;
            end;
            //Notify travelling employees
            TravellingEmployees.Reset;
            TravellingEmployees.SetRange("Request No.", TravelRequests."Request No.");
            if TravellingEmployees.FindFirst then begin
                //Notify Requester
                if Employee.Get(TravellingEmployees."Employee No.") then begin
                    Employee.TestField("E-Mail");
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    SenderAddress := HRSetup."Human Resource Emails";
                    SenderName := CompanyInfo.Name;
                    Receipient.add(Employee."E-Mail");
                    Subject := StrSubstNo('Travel Request - %1', TravelRequests."Request No.");
                    TimeNow := Format(Time);
                    Emailmessage.Create(Receipient, Subject, '', true);
                    Emailmessage.AppendToBody(StrSubstNo(TravEmployeeMsg, TravellingEmployees."Employee Name", Format(TravelRequests."Trip Planned Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), Format(TravelRequests."Trip Planned End Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), TransportTrips.Driver, TransportTrips."Drivers Name", CompanyInfo.Name, TravelRequests.Destination, TransportTrips."Vehicle Description", TransportTrips."Vehicle No"));
                    Email.Send(Emailmessage);
                end;
            end;
        end;
    end;

    procedure CheckDateStatusCustom(CalendarCode: Code[10]; TargetDate: Date; VAR Description: Text[50]): Boolean
    var
        BaseCalChange: Record "Base Calendar Change";
    begin
        BaseCalChange.RESET;
        BaseCalChange.SETRANGE("Base Calendar Code", CalendarCode);
        IF BaseCalChange.FINDSET THEN
            REPEAT
                CASE BaseCalChange."Recurring System" OF
                    BaseCalChange."Recurring System"::" ":
                        IF TargetDate = BaseCalChange.Date THEN BEGIN
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                    BaseCalChange."Recurring System"::"Weekly Recurring":
                        IF DATE2DWY(TargetDate, 1) = BaseCalChange.Day THEN BEGIN
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                    BaseCalChange."Recurring System"::"Annual Recurring":
                        IF (DATE2DMY(TargetDate, 2) = DATE2DMY(BaseCalChange.Date, 2)) AND (DATE2DMY(TargetDate, 1) = DATE2DMY(BaseCalChange.Date, 1)) THEN BEGIN
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                END;
            UNTIL BaseCalChange.NEXT = 0;
        Description := '';
    end;

    procedure SubmitAplication(RefNo: Code[10])
    var
        Applicants: Record Applicants2;
        CompanyInfo: Record "Company Information";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        JobsApplied: Record "Applicant job applied";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        Attachment: Text;
        ErrorMsg: Text;
        NewBody: Label 'Dear %1, <br><br> This is to Confirm receipt of your Job application for the Position of <Strong>%2 </Strong>.<br> <br> <br>Kind Regards <br><br>%3.';
        Instr: InStream;
        EmailSignText: Text;
        EmailSignBigText: BigText;
        TempBlobNew: Codeunit "Temp Blob";
    //TempBlob: Record TempBlob;
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture, "E-Mail Signature");
        CompanyInfo."E-Mail Signature".CreateInStream(Instr);
        EmailSignBigText.Read(Instr);
        EmailSignText := Format(EmailSignBigText);
        JobsApplied.Reset();
        JobsApplied.SetRange("No.", RefNo);
        if JobsApplied.FindFirst() then begin
            Applicants.Reset();
            Applicants.SetFilter("No.", JobsApplied."Application No.");
            if Applicants.FindFirst() then begin
                //if Applicants.Get(ApplicationNo) then begin
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient.Add(Applicants."E-Mail");
                Subject := 'Application Received';
                TimeNow := (Format(Time));
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendToBody(StrSubstNo(NewBody, (Applicants."First Name" + ' ' + Applicants."Middle Name" + ' ' + Applicants."Last Name"), JobsApplied.Job, CompanyInfo.Name));
                Emailmessage.AppendToBody(EmailSignText);
                EMAIL.Send(Emailmessage);
                if Guiallowed then Message('Application Submitted Successfully.');
                JobsApplied.Submitted := true;
                JobsApplied."Status" := JobsApplied."Status"::Submitted;
                JobsApplied.Modify;
            end;
        end;
    end;

    local procedure GetEntitlement(EmpNo: Code[50]; VAR LeaveEntitlement: Decimal; VAR BalBF: Decimal)
    var
        SalaryScale: Record "Salary Scale";
        Emp: Record Employee;
        EmpCopy: Record Employee;
    begin
        IF Emp.GET(EmpNo) THEN BEGIN
            Emp.TESTFIELD("Salary Scale");
            SalaryScale.Get(Emp."Salary Scale");
            LeaveEntitlement := SalaryScale."Leave Days";
            //Get Carry Forward Days
            LeaveType.RESET;
            LeaveType.SETRANGE("Annual Leave", TRUE);
            IF LeaveType.FINDFIRST THEN BEGIN
                IF LeaveType."Max Carry Forward Days" <> 0 THEN BEGIN
                    EmpCopy.COPY(Emp);
                    EmpCopy.SETRANGE("Leave Type Filter", LeaveType.Code);
                    EmpCopy.SETRANGE("Leave Period Filter", GetPreviousLeavePeriod);
                    EmpCopy.CALCFIELDS("Total Leave Balance");
                    IF EmpCopy."Total Leave Balance" > 0 THEN BEGIN
                        IF EmpCopy."Total Leave Balance" >= LeaveType."Max Carry Forward Days" THEN
                            BalBF := LeaveType."Max Carry Forward Days"
                        ELSE
                            BalBF := EmpCopy."Total Leave Balance";
                    END;
                END;
            END;
        END;
    end;

    procedure GetCurrentPeriodStart(InitialDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.RESET;
        AccountingPeriod.SETFILTER("Starting Date", '<=%1', InitialDate);
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        IF AccountingPeriod.FIND('+') THEN EXIT(AccountingPeriod."Starting Date");
    end;

    procedure GetPreviousPeriodStart(): Date
    var
        AccountingPeriod: Record "Accounting Period";
        CurrentPeriodStart: Date;
    begin
        CurrentPeriodStart := GetCurrentPeriodStart(TODAY);
        AccountingPeriod.RESET;
        AccountingPeriod.SETFILTER("Starting Date", '<%1', CurrentPeriodStart);
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        IF AccountingPeriod.FIND('+') THEN EXIT(AccountingPeriod."Starting Date");
    end;

    procedure GetPreviousPeriodEnd(): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.RESET;
        AccountingPeriod.SETFILTER("Starting Date", '>%1', GetPreviousPeriodStart);
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        IF AccountingPeriod.FINDFIRST THEN BEGIN
            EXIT(AccountingPeriod."Starting Date");
        END;
    end;

    procedure GetPreviousLeavePeriod(): Code[50]
    var
        AccountingPeriod: Record "Accounting Period";
        LeavePeriods: Record "Leave Periods";
    begin
        LeavePeriods.RESET;
        LeavePeriods.SETFILTER("Start Date", '>=%1', GetPreviousPeriodStart);
        LeavePeriods.SETFILTER("End Date", '<=%1', GetPreviousPeriodEnd);
        IF LeavePeriods.FINDFIRST THEN EXIT(LeavePeriods."Leave Period");
    end;

    LOCAL procedure InitNextEntryNo() NextEntryNo: Integer
    begin
        LeaveEntry.LOCKTABLE;
        IF LeaveEntry.FINDLAST THEN
            NextEntryNo := LeaveEntry."Entry No." + 1
        ELSE
            NextEntryNo := 1;
    end;

    procedure ShortlistApplicants(RecruitmentNo: Code[20])
    var
        RecruitmentNeeds: Record "Recruitment Needs";
        Applicants: Record Applicants2;
        Academics: Record "Applicant Job Education2";
        Experience: Record "Applicant Job Experience2";
        Prof: record "Applicant Prof Membership";
        NoYears: Integer;
        JobsApplied: Record "Applicant job applied";
    begin
        RecruitmentNeeds.Get(RecruitmentNo);
        JobsApplied.Reset();
        JobsApplied.SetRange("Need Code", RecruitmentNo);
        if JobsApplied.Find('-') then begin
            repeat
                Applicants.Reset();
                Applicants.SetRange("No.", JobsApplied."Application No.");
                if Applicants.Find('-') then
                    repeat
                        JobsApplied.Qualified := true;
                        if RecruitmentNeeds."Field of Study" <> '' then begin
                            Academics.Reset;
                            Academics.SetRange("Applicant No.", Applicants."No.");
                            //Academics.SetRange("Need Code", RecruitmentNeeds."No.");
                            Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                            if Academics.FindFirst then
                                JobsApplied.Qualified := true
                            else
                                JobsApplied.Qualified := false;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds."Education Level" <> RecruitmentNeeds."Education Level"::" " then begin
                                Academics.Reset;
                                Academics.SetRange("Applicant No.", Applicants."No.");
                                //Academics.SetRange("Need Code", RecruitmentNeeds."No.");
                                if RecruitmentNeeds."Field of Study" <> '' then Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                                Academics.SetRange("Education Level", RecruitmentNeeds."Education Level");
                                if Academics.FindFirst then
                                    JobsApplied.Qualified := true
                                else
                                    JobsApplied.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds."Education Type" <> RecruitmentNeeds."Education Type"::" " then begin
                                Academics.Reset;
                                Academics.SetRange("Applicant No.", Applicants."No.");
                                //Academics.SetRange("Need Code", RecruitmentNeeds."No.");
                                if RecruitmentNeeds."Field of Study" <> '' then Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                                if RecruitmentNeeds."Education Level" <> RecruitmentNeeds."Education Level"::" " then Academics.SetRange("Education Level", RecruitmentNeeds."Education Level");
                                Academics.SetRange("Education Type", RecruitmentNeeds."Education Type");
                                if Academics.FindFirst then
                                    JobsApplied.Qualified := true
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds."Proficiency Level" <> RecruitmentNeeds."Proficiency Level"::"Not Rated" then begin
                                Academics.Reset;
                                Academics.SetRange("Applicant No.", Applicants."No.");
                                //Academics.SetRange("Need Code", RecruitmentNeeds."No.");
                                if RecruitmentNeeds."Field of Study" <> '' then Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                                if RecruitmentNeeds."Education Level" <> RecruitmentNeeds."Education Level"::" " then Academics.SetRange("Education Level", RecruitmentNeeds."Education Level");
                                if RecruitmentNeeds."Education Type" <> RecruitmentNeeds."Education Type"::" " then Academics.SetRange("Education Type", RecruitmentNeeds."Education Type");
                                Academics.SetRange("Proficiency Level", RecruitmentNeeds."Proficiency Level");
                                if Academics.FindFirst then
                                    Applicants.Qualified := true
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds."Professional Course" <> '' then begin
                                Academics.Reset;
                                Academics.SetRange("Applicant No.", Applicants."No.");
                                //Academics.SetRange("Need Code", RecruitmentNeeds."No.");
                                if RecruitmentNeeds."Field of Study" <> '' then Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                                if RecruitmentNeeds."Education Level" <> RecruitmentNeeds."Education Level"::" " then Academics.SetRange("Education Level", RecruitmentNeeds."Education Level");
                                if RecruitmentNeeds."Education Type" <> RecruitmentNeeds."Education Type"::" " then Academics.SetRange("Education Type", RecruitmentNeeds."Education Type");
                                if RecruitmentNeeds."Proficiency Level" <> RecruitmentNeeds."Proficiency Level"::"Not Rated" then Academics.SetRange("Proficiency Level", RecruitmentNeeds."Proficiency Level");
                                Academics.SetRange("Qualification Code", RecruitmentNeeds."Professional Course");
                                if Academics.FindFirst then
                                    Applicants.Qualified := true
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds."Professional Membership" <> '' then begin
                                Prof.Reset;
                                Prof.SetRange("Applicant No.", Applicants."No.");
                                //Prof.SetRange("Need Code", RecruitmentNeeds."No.");
                                Prof.SetRange("Professional Body", RecruitmentNeeds."Professional Membership");
                                if Prof.FindFirst then
                                    Applicants.Qualified := true
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds.Gender <> RecruitmentNeeds.Gender::" " then begin
                                Applicants.SetRange(gender, RecruitmentNeeds.Gender);
                                if Applicants.FindFirst then
                                    Applicants.Qualified := true
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds."County Code" <> '' then begin
                                Applicants.SetRange("County Code", RecruitmentNeeds."County Code");
                                if Applicants.FindFirst then
                                    Applicants.Qualified := true
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if RecruitmentNeeds."Experience industry" <> '' then begin
                                Experience.Reset;
                                Experience.SetRange("Applicant No.", Applicants."No.");
                                //Experience.SetRange("Need Code", RecruitmentNeeds."No.");
                                Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");
                                if Experience.FindFirst then
                                    Applicants.Qualified := true
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if (RecruitmentNeeds."Minimum years of experience" <> 0) then begin
                                Experience.Reset;
                                Experience.SetRange("Applicant No.", Applicants."No.");
                                //Experience.SetRange("Need Code", RecruitmentNeeds."No.");
                                if RecruitmentNeeds."Experience industry" <> '' then Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");
                                if Experience.Find('-') then begin
                                    Experience.CalcSums("No. of Years");
                                    NoYears := Round(Experience."No. of Years", 1, '=');
                                    if (NoYears >= RecruitmentNeeds."Minimum years of experience") and (NoYears <= RecruitmentNeeds."Maximum years of experience") then
                                        Applicants.Qualified := true
                                    else
                                        Applicants.Qualified := false;
                                end
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then begin
                            if (RecruitmentNeeds."Maximum years of experience" <> 0) then begin
                                Experience.Reset;
                                Experience.SetRange("Applicant No.", Applicants."No.");
                                Experience.SetRange("Hierarchy Level", Experience."Hierarchy Level"::"Top-Level Manager");
                                //Experience.SetRange("Need Code", RecruitmentNeeds."No.");
                                if RecruitmentNeeds."Experience industry" <> '' then Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");
                                if Experience.Find('-') then begin
                                    Experience.CalcSums("No. of Years");
                                    NoYears := Round(Experience."No. of Years", 1, '=');
                                    if NoYears >= RecruitmentNeeds."Minimum years of experience" then
                                        Applicants.Qualified := true
                                    else
                                        Applicants.Qualified := false;
                                end
                                else
                                    Applicants.Qualified := false;
                            end;
                        end;
                        if Applicants.Qualified = true then JobsApplied.Qualified := true;
                        Applicants.Modify;
                    until Applicants.Next = 0;
                JobsApplied.Modify();
            until JobsApplied.Next = 0;
        end;
    end;
    // local procedure GetNextLineNo(): Integer
    // var
    //     ApprGoals: Record "Appraisal Lines";
    // begin
    //     ApprGoals.RESET;
    //     ApprGoals.SETRANGE(ApprGoals."Appraisal No", app);
    //     IF ApprGoals.FINDLAST THEN
    //         EXIT(ApprGoals."Line No" + 10000)
    //     ELSE
    //         EXIT(10000);
    // END;
    procedure NotifyAssetEmployee(RefNo: Code[10])
    var
        Assets: Record "Asset Allocation and Transfer";
        CompanyInfo: Record "Company Information";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        Employee: Record Employee;
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        Attachment: Text;
        ErrorMsg: Text;
        AllocBody: Label 'Dear %1, <br><br> This is to notify you that asset <Strong>%2, %3 </Strong> has been allocated to you<br> <br> <br>Kind Regards <br><br>.';
        TransferBody: Label 'Dear %1, <br><br> This is to notify you that asset <Strong>%2, %3 </Strong> has been transferred to you<br> <br> <br>Kind Regards <br><br>%3.';
        Instr: InStream;
        EmailSignText: Text;
        EmailSignBigText: BigText;
        TempBlobNew: Codeunit "Temp Blob";
    //TempBlob: Record TempBlob;
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture, "E-Mail Signature");
        CompanyInfo."E-Mail Signature".CreateInStream(Instr);
        EmailSignBigText.Read(Instr);
        EmailSignText := Format(EmailSignBigText);
        Assets.Reset();
        Assets.SetRange("No.", RefNo);
        if Assets.FindFirst() then begin
            Employee.Reset();
            Employee.SetRange("No.", Assets."New Employee No.");
            if Employee.FindFirst() then begin
                //if Applicants.Get(ApplicationNo) then begin
                Clear(Receipient);
                Employee.TestField("Company E-Mail");
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient.Add(Employee."Company E-Mail");
                if Assets.Type = Assets.Type::"Initial Allocation" then begin
                    Subject := 'Asset Allocation';
                    TimeNow := (Format(Time));
                    SMTP.Create(Receipient, Subject, '', true);
                    SMTP.AppendToBody(StrSubstNo(AllocBody, Employee."First Name", Assets.Asset, Assets."Asset Description"));
                end;
                if Assets.Type = Assets.Type::Transfer then begin
                    Subject := 'Asset Transfer';
                    TimeNow := (Format(Time));
                    SMTP.Create(Receipient, Subject, '', true);
                    SMTP.AppendToBody(StrSubstNo(TransferBody, Employee."First Name", Assets.Asset, Assets."Asset Description"));
                    SMTP.AppendToBody(EmailSignText);
                end;
                Email.Send(Emailmessage);
                if Guiallowed then Message('Employee notified Successfully.');
            end;
        end;
    end;
    // notify all employees
    procedure NotifyAllEmployees(EmpNo: Code[50])
    var
        EmpRec: Record Employee;
        ToReceipients, Subject, Body : text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        EmpRec.Reset();
        If EmpRec.Get(EmpNo) then begin
            If EmpRec."E-Mail" = '' then begin
                ToReceipients := EmpRec."Company E-Mail";
            end
            else begin
                ToReceipients := EmpRec."E-Mail";
            end;
            EmailMessage.Create(ToReceipients, Subject, Body, true);
            Email.OpenInEditorModally(EmailMessage);
        end;
    end;

    procedure GetUserName(UID: Code[50]): Text[100]
    var
        Users: record User;
    begin
        Users.reset;
        Users.SetRange("User Name", UID);
        if Users.FindFirst() then exit(Users."Full Name");
    end;

    procedure GetFullName(FirstName: text; OtherName: Text; LastName: text): Text
    var
        FullName: Text;
    begin
        FullName := FirstName;
        if OtherName <> '' then begin
            if FullName <> '' then
                FullName += ' ' + OtherName
            else
                FullName := OtherName;
        end;
        if LastName <> '' then begin
            if FullName <> '' then
                FullName += ' ' + LastName
            else
                FullName := LastName;
        end;
        exit(FullName);
    end;

    procedure GetPayrollApprovalCode(PayDate: Date): Code[20]
    var
        PayApproval: Record "Payroll Approval";
    begin
        PayApproval.Reset();
        PayApproval.SetRange("Payroll Type", PayApproval."Payroll Type"::Employee);
        PayApproval.SetRange("Payroll Period", PayDate);
        if PayApproval.FindFirst then exit(PayApproval."No.");
    end;
}

table 50215 "Leave Application"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                /*
                UserSertup.RESET;
                UserSertup.SETRANGE("Employee No","Employee No");
                IF UserSertup.FIND('-') THEN
                 "User ID":=UserSertup."User ID";
                */
                if emp.Get("Employee No") then begin
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                    "Date of Joining Company" := emp."Date Of Join";
                    //"Balance brought forward":=EmpLeave."Balance Brought Forward";
                    "Shortcut Dimension 1 Code" := emp."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := emp."Global Dimension 2 Code";
                    "Mobile No" := emp."Phone No.";
                end;
            end;
        }
        field(2; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;

            trigger OnValidate()
            begin
                "Application Date" := Today;
                if "Application No" <> xRec."Application No" then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Leave Application Nos.");
                    "No. series" := '';
                end;
            end;
        }
        field(3; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Type";

            trigger OnValidate()
            var
                AnnualEntitlement: Decimal;
            begin
                "Leave Entitlment" := 0;
                if xRec.Status <> Status::Open then Error('You cannot change a document an approved document');
                if emp.Get("Employee No") then
                    if LeaveTypes.Get("Leave Code") then begin
                        if LeaveTypes.Gender = LeaveTypes.Gender::Female then begin
                            if emp.Gender = emp.Gender::Male then Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
                        end;
                        if LeaveTypes.Gender = LeaveTypes.Gender::Male then begin
                            if emp.Gender = emp.Gender::Female then Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
                        end;
                        CalcFields("Total Leave Days Taken", "Recalled Days", "Off Days", "Leave balance");
                        //"Leave balance":="Leave Entitlment"+"Recalled Days"+"Off Days"-"Total Leave Days Taken"+LeaveAdjustments;
                        GetContrateesEntitlement("Employee No", "Leave Code");
                        begin
                            "Leave Earned to Date" := 0;
                            //"Leave Entitlment":=LeaveTypes.Days;
                            "Date of Joining Company" := emp."Date Of Join";
                            CalcFields("Total Leave Days Taken", "Recalled Days", "Off Days");
                            //"Leave balance":="Leave Entitlment"-"Total Leave Days Taken";
                            //"Leave balance":="Leave Entitlment"+"Recalled Days"+"Off Days"-"Total Leave Days Taken"+LeaveAdjustments;
                        end;
                    end;
                //LeaveAdjustments:=HRmgt.GetLeaveEntitlement("Employee No");
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            begin
                if xRec.Status <> Status::Open then Error('You cannot change a document an approved document');
                Validate("Start Date");
                Validate("Leave Code");
                CalcFields("Leave balance");
                CalcFields("Balance brought forward");
                "Annual Leave Entitlement Bal" := "Leave balance";
                if LeaveTypes.Get("Leave Code") then if LeaveTypes."Annual Leave" then if "Days Applied" > "Annual Leave Entitlement Bal" then Error(Error008); //commented for testing
                /*END ELSE
                  IF "Days Applied">"Leave Entitlment" THEN
                    ERROR(Error011,"Leave Entitlment");*/
                if "Days Applied" < 0.5 then Error(Error009);
                if LeaveTypes.Get("Leave Code") then
                    if LeaveTypes."Annual Leave" then begin
                        "Annual Leave Entitlement Bal" := "Leave balance" - "Days Applied";
                    end
                    else
                        "Annual Leave Entitlement Bal" := "Leave balance";
                //"Annual Leave Entitlement Bal":="Leave balance"-"Days Applied";
            end;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                LeaveLedger.RESET;
                LeaveLedger.SETRANGE("Staff No.","Employee No");
                LeaveLedger.SETFILTER('%1'
                IF LeaveLedger.FINDLAST THEN
                  BEGIN
                    IF LeaveLedger."Leave End Date">"Start Date" THEN
                      ERROR('You are already on leave %1 ending on %2',LeaveLedger."Leave Type",LeaveLedger."Leave End Date");
                      //MESSAGE('%1-%2',LeaveLedger."Leave End Date","Start Date");
                  END;
                */
                if xRec.Status <> Status::Open then Error('You cannot change a document an approved document');
                GeneralOptions.Get;
                HRSetup.Get();
                HRSetup.TestField("Base Calendar Code");
                NoOfWorkingDays := 0;
                if "Days Applied" <> 0 then begin
                    if "Start Date" <> 0D then begin
                        NextWorkingDate := "Start Date";
                        // while "Days Applied" <= NoOfWorkingDays do begin
                        repeat
                            if "Days Applied" <> 1 then begin
                                if LeaveTypes.Get("Leave Code") then begin
                                    If (LeaveTypes."Inclusive of Holidays") and (LeaveTypes."Inclusive of Saturday") and (LeaveTypes."Inclusive of Sunday") then begin
                                        if not CalendarMgmt.CheckDateStatus(HRSetup."Base Calendar Code", NextWorkingDate, Description) then NoOfWorkingDays := NoOfWorkingDays + 1;
                                    end;
                                    if LeaveTypes."Inclusive of Holidays" then begin
                                        BaseCalendar.Reset;
                                        BaseCalendar.SetRange("Base Calendar Code", HRSetup."Base Calendar Code");
                                        BaseCalendar.SetRange(Date, NextWorkingDate);
                                        BaseCalendar.SetRange(Nonworking, true);
                                        BaseCalendar.SetRange("Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                        if BaseCalendar.FindFirst() then begin
                                            NoOfWorkingDays := NoOfWorkingDays + 1;
                                        end;
                                    end;
                                    if LeaveTypes."Inclusive of Saturday" then begin
                                        BaseCalender.Reset;
                                        BaseCalender.SetRange("Period Type", BaseCalender."Period Type"::Date);
                                        BaseCalender.SetRange("Period Start", NextWorkingDate);
                                        BaseCalender.SetRange("Period No.", 6);
                                        if BaseCalender.FindFirst() then begin
                                            NoOfWorkingDays := NoOfWorkingDays + 1;
                                            // MESSAGE('SATURDAY =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                        end;
                                    end;
                                    if LeaveTypes."Inclusive of Sunday" then begin
                                        BaseCalender.Reset;
                                        BaseCalender.SetRange("Period Type", BaseCalender."Period Type"::Date);
                                        BaseCalender.SetRange("Period Start", NextWorkingDate);
                                        BaseCalender.SetRange(BaseCalender."Period No.", 7);
                                        if BaseCalender.FindFirst() then begin
                                            NoOfWorkingDays := NoOfWorkingDays + 1;
                                            //MESSAGE('Sunday =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                        end;
                                    end;
                                    If not (LeaveTypes."Inclusive of Holidays") and not (LeaveTypes."Inclusive of Saturday") and not (LeaveTypes."Inclusive of Sunday") then begin // Check if is working Day
                                        BaseCalendar.Reset;
                                        BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", HRSetup."Base Calendar Code");
                                        BaseCalendar.SetRange(BaseCalendar.Date, NextWorkingDate);
                                        BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                        //  BaseCalendar.SetRange(BaseCalendar.Holiday, true);
                                        //  BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                        if BaseCalendar.IsEmpty() then begin
                                            BaseCalender.Reset;
                                            BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                            BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                            BaseCalender.SetFilter(BaseCalender."Period No.", '%1|%2', 6, 7);
                                            if BaseCalender.IsEmpty() then begin
                                                NoOfWorkingDays := NoOfWorkingDays + 1;
                                            end;
                                        end;
                                        if LeaveTypes."Off/Holidays Days Leave" then;
                                    end;
                                end;
                            end
                            else begin
                                NoOfWorkingDays := 1;
                            end;
                            NextWorkingDate := CalcDate('1D', NextWorkingDate);
                        // end;
                        until NoOfWorkingDays = Round("Days Applied", 1, '=');
                        "End Date" := CalcDate('-1WD', NextWorkingDate);
                        "Resumption Date" := CalcDate('1WD', "End Date");
                    end;
                end;
                //serem
                //check if the date that the person is supposed to report back is a working day or not
                //get base calendar to use
                HumanResSetup.Reset();
                HumanResSetup.Get();
                HumanResSetup.TestField(HumanResSetup."Base Calendar Code");
                NonWorkingDay := false;
                if "Start Date" <> 0D then begin
                    while NonWorkingDay = false do begin
                        NonWorkingDay := CalendarMgmt.CheckDateStatus(HumanResSetup."Base Calendar Code", "Resumption Date", Dsptn);
                        if NonWorkingDay then begin
                            NonWorkingDay := false;
                            "Resumption Date" := CalcDate('1D', "Resumption Date");
                        end
                        else begin
                            NonWorkingDay := true;
                        end;
                    end;
                end;
                //New Joining Employees
                if ("Date of Joining Company" <> 0D) and ("Fiscal Start Date" <> 0D) then
                    if "Date of Joining Company" > "Fiscal Start Date" then begin
                        NoofMonthsWorked := 0;
                        Nextmonth := "Date of Joining Company";
                        repeat
                            Nextmonth := CalcDate('1M', Nextmonth);
                            NoofMonthsWorked := NoofMonthsWorked + 1;
                        until Nextmonth >= "Start Date";
                        NoofMonthsWorked := NoofMonthsWorked - 1;
                        "No. of Months Worked" := NoofMonthsWorked;
                        if LeaveTypes.Get("Leave Code") then "Leave Earned to Date" := Round(((LeaveTypes.Days / 12) * NoofMonthsWorked), 1);
                        //"Leave Entitlment":="Leave Earned to Date";
                        Validate("Leave Code");
                    end;
                //"Annual Leave Entitlement Bal":="Leave balance"-"Days Applied";
            end;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"Approved To Date":="To Date";
                if xRec.Status <> Status::Open then Error('You cannot change a document an approved document');
                Validate("Start Date");
                Validate("Leave Code");
            end;
        }
        field(22; "Reliever No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(60; "Leave Reliever"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;

            //  Editable = false;
            trigger OnValidate()
            begin
                if "Leave Code" <> '' then Validate("Leave Code");
            end;
        }
        field(8; "Approved Days"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                days := "Approved Days";
            end;
        }
        field(9; "Approved Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Verified By Manager"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Verification Date" := Today;
            end;
        }
        field(11; "Verification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Leave Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Being Processed,Approved,Rejected,Canceled';
            OptionMembers = "Being Processed",Approved,Rejected,Canceled;

            trigger OnValidate()
            begin
                if ("Leave Status" = "Leave Status"::Approved) /* AND (xRec."Leave Status" <> "Leave Status"::Approved)*/then begin
                    "Approval Date" := Today;
                    CalcFields("Leave balance");
                    "Annual Leave Entitlement Bal" := "Leave balance" - "Approved Days";
                    "Balance brought forward" := "Balance brought forward";
                    Modify;
                end
                else if ("Leave Status" <> "Leave Status"::Approved) and (xRec."Leave Status" = "Leave Status"::Approved) then begin
                    "Approval Date" := Today;
                    "Employee Leaves".Reset;
                    "Employee Leaves".SetRange("Employee Leaves"."Employee No", "Employee No");
                    "Employee Leaves".SetRange("Employee Leaves"."Leave Code", "Leave Code");
                    if "Employee Leaves".Find('-') then;
                    "Employee Leaves".Balance := "Employee Leaves".Balance + "Approved Days";
                    "Employee Leaves".Validate("Employee Leaves".Balance);
                    "Employee Leaves".Modify;
                end;
            end;
        }
        field(13; "Approved End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Taken; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Acrued Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Over used Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Leave Allowance Payable"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                HumanResSetup.Get;
                if HumanResSetup."Qualification Days (Leave)" <= 0 then Error('%1 must have a value', StrSubstNo(HumanResSetup.FieldCaption("Qualification Days (Leave)")));
                if "Leave Allowance Payable" then begin
                    HRmgt.CheckIfLeaveAllowanceExists(Rec);
                    if emp.Get("Employee No") then begin
                        if emp."Employment Type" <> emp."Employment Type"::Permanent then Error('Only Applicable to Permanent Employees');
                    end;
                    if "Days Applied" < HumanResSetup."Qualification Days (Leave)" then Error('You can only be paid leave allowance if you take %1 or more Days', HumanResSetup."Qualification Days (Leave)");
                end;
            end;
        }
        field(20; Post; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; days; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "No. series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Leave balance"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"), "Leave Type" = FILTER('ANNUAL'), Closed = CONST(false)));
            // CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"), "Leave Type" = field("Leave Code")));
            // //  "Leave Type" = field("Leave Code"),
            // //    "Transaction Type" = filter(<> "Leave B/F"),
            // //  Closed = CONST(false)));
            FieldClass = FlowField;
        }
        field(25; "Resumption Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,Archived,"Reliever Approved","Reliever Open";

            trigger OnValidate()
            begin
                if Status = Status::Released then "Approval Date" := Today;
            end;
        }
        field(28; "Leave Entitlment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Total Leave Days Taken"; Decimal)
        {
            CalcFormula = - Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"), "Leave Type" = field("Leave Code"), Closed = CONST(false), "Leave Entry Type" = CONST(Negative)));
            FieldClass = FlowField;
        }
        field(30; "Duties Taken Over By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then Error('You cannot change a document an approved document');
                if emp.Get("Employee No") then begin
                    emp.SetRange("No.", "Duties Taken Over By");
                    if emp.Find('-') then begin
                        if "Duties Taken Over By" = "Employee No" then
                            Error('You Cannot take duties over for yourself')
                        else
                            "Relieving Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                    end;
                end;
            end;
        }
        field(31; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Mobile No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Balance brought forward"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"), "Leave Type" = field("Leave Code"), "Transaction Type" = filter("Leave B/F"), Closed = CONST(false)));
            FieldClass = FlowField;
        }
        field(34; "Leave Earned to Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Date of Joining Company"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Fiscal Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "No. of Months Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Annual Leave Entitlement Bal"; Decimal)
        {
            FieldClass = Normal;
        }
        field(40; "Recalled Days"; Decimal)
        {
            CalcFormula = Sum("Employee Off/Holiday"."No. of Off Days" WHERE("Employee No" = FIELD("Employee No")));
            FieldClass = FlowField;
        }
        field(41; "Off Days"; Decimal)
        {
            CalcFormula = Sum("Holiday_Off Days"."No. of Days" WHERE("Employee No." = FIELD("Employee No"), "Leave Type" = FIELD("Leave Code"), "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(42; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(43; "User ID"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = CONST(51404832), "Document No." = FIELD("Application No")));
            FieldClass = FlowField;
        }
        field(45; "Days Absent"; Decimal)
        {
            CalcFormula = Sum("Employee Absence".Quantity WHERE("Employee No." = FIELD("Employee No"), "Affects Leave" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(46; "Contract No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Other Contact Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Other Contact Phone"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Manager,Employee';
            OptionMembers = Manager,Employee;
        }
        field(50; LeaveAdjustments; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Relieving Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = FILTER(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(53; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = FILTER(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(54; "Application Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Periods";
        }
        field(56; "Employment Type"; Option)
        {
            CalcFormula = Lookup(Employee."Employment Type" WHERE("No." = FIELD("Employee No")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Contract,Permanent,Trustee';
            OptionMembers = Contract,Permanent,Trustee;
        }
        field(57; "Area"; Code[50])
        {
            CalcFormula = Lookup(Employee.Area WHERE("No." = FIELD("Employee No")));
            FieldClass = FlowField;
        }
        field(58; "Responsibility Center"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(59; "Leave Balance on leave Period"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
        key(Key2; "Employee No", "Leave Code", Status, "Maturity Date", "Contract No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Application No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No. series", 0D, "Application No", "No. series");
        end;
        "Application Date" := Today;
        "Application Time" := Time;
        "User ID" := UserId;
        if GuiAllowed then begin
            if UserSertup.Get("User ID") then begin
                if emp.Get(UserSertup."Employee No.") then begin
                    "Employee No" := emp."No.";
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                    "Mobile No" := emp."Phone No.";
                    "Shortcut Dimension 1 Code" := emp."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := emp."Global Dimension 2 Code";
                end;
                UserSertup.TestField("User Responsibility Center");
                "Responsibility Center" := UserSertup."User Responsibility Center";
                LeaveTypes.Reset();
                LeaveTypes.SetRange("Annual Leave", true);
                if LeaveTypes.FindFirst() then;
                "Leave Code" := LeaveTypes.Code;
                Validate("Leave Code");
            end;
        end
        else
            Validate("Employee No");
        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
        CalcFields("Employment Type");
        "Leave Period" := HRmgt.GetCurrentLeavePeriod("Employment Type");
    end;

    trigger OnRename()
    begin
        if Post = true then Error(Error007);
    end;

    var
        Error001: Label 'You Cannot change an approved Document';
        Error002: Label '%1 is not applicable to your %2 Gender';
        Error003: Label 'The days applied for are more than your Leave Balance';
        Error004: Label 'You can only be paid leave allowance if you take %1 or more Days';
        Error005: Label '%1 can only be assigned to %2 employees';
        Error006: Label 'You Cannot Apply beyond the current financial period';
        Error007: Label 'You cannot Rename the Record';
        Error008: Label 'The Number of Days applied is more than you Leave Days Balance ';
        Error009: Label 'You cannot take a Leave less than 1 Day';
        Text001: Label 'Leave allowance paid on %1';
        "Employee Leaves": Record "Employee Leave";
        BaseCalender: Record Date;
        CurDate: Date;
        LeaveTypes: Record "Leave Type";
        DayApp: Decimal;
        Dayofweek: Integer;
        i: Integer;
        textholder: Text[30];
        emp: Record Employee;
        leaveapp: Record "Leave Application";
        GeneralOptions: Record "Company Information";
        NoOfDays: Integer;
        BaseCalendar: Record "Base Calendar Change";
        yearend: Date;
        d: Date;
        d2: Integer;
        d3: Integer;
        d4: Integer;
        d1: Integer;
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        earn: Record EarningsX;
        assmatrix: Record "Assignment Matrix-X";
        ecode: Code[10];
        ldated: Date;
        UserSertup: Record "User Setup";
        CalendarMgmt: Codeunit "Calendar Management Ext";
        NextWorkingDate: Date;
        Description: Text[30];
        NoOfWorkingDays: Integer;
        LeaveAllowancePaid: Boolean;
        PayrollPeriod: Record "Payroll PeriodX";
        PayPeriodStart: Date;
        EmpRec: Record Employee;
        MaturityDate: Date;
        EmpLeave: Record "Employee Leave";
        NoofMonthsWorked: Integer;
        FiscalStart: Date;
        Nextmonth: Date;
        DimVal: Record "Dimension Value";
        NonWorkingDay: Boolean;
        Dsptn: Text[30];
        HRSetup: Record "Human Resources Setup";
        JobGroup: Record "Salary Scale";
        Contracts: Record "Employment Contract";
        DimMgt: Codeunit DimensionManagement;
        Dim: Record "Dimension Value";
        Error010: Label 'Leave Start Date should be 2 days from the Application Date';
        Error011: Label 'The Number of days applied is more than the Entitlement days of %1 days';
        LeaveLedger: Record "HR Leave Ledger Entries";
        HRmgt: Codeunit "HR Management";
        Test: Decimal;

    procedure CreateLeaveAllowance(var LeaveApp: Record "Leave Application")
    var
        HRSetup: Record "Human Resources Setup";
        FiscalStart: Date;
        FiscalEnd: Date;
        AccPeriod: Record "Payroll PeriodX";
        ScaleBenefits: Record "Scale Benefits";
    begin
        if LeaveApp."Leave Allowance Payable" then begin
            AccPeriod.Reset;
            AccPeriod.SetRange("Starting Date", 0D, Today);
            AccPeriod.SetRange("New Fiscal Year", true);
            if AccPeriod.Find('+') then FiscalStart := AccPeriod."Starting Date";
            FiscalEnd := CalcDate('1Y', FiscalStart) - 1;
            assmatrix.Reset;
            assmatrix.SetRange("Payroll Period", FiscalStart, FiscalEnd);
            assmatrix.SetRange(Type, assmatrix.Type::Payment);
            assmatrix.SetRange(Code, HRSetup."Leave Allowance Code");
            if assmatrix.Find('-') then begin
                LeaveAllowancePaid := true;
                Message(Text001, assmatrix."Payroll Period");
            end;
            if not LeaveAllowancePaid then begin
                if HRSetup.Get then begin
                    if "Days Applied" >= HRSetup."Qualification Days (Leave)" then begin
                        if emp.Get("Employee No") then begin
                            ScaleBenefits.Reset;
                            ScaleBenefits.SetRange("Salary Scale", emp."Salary Scale");
                            ScaleBenefits.SetRange("Salary Pointer", emp.Present);
                            ScaleBenefits.SetRange("ED Code", HRSetup."Leave Allowance Code");
                            if ScaleBenefits.Find('-') then begin
                                PayrollPeriod.Reset;
                                PayrollPeriod.SetRange("Close Pay", false);
                                if PayrollPeriod.Find('-') then PayPeriodStart := PayrollPeriod."Starting Date";
                                assmatrix.Init;
                                assmatrix."Employee No" := "Employee No";
                                assmatrix.Type := assmatrix.Type::Payment;
                                assmatrix.Code := HRSetup."Leave Allowance Code";
                                assmatrix.Validate(Code);
                                assmatrix."Payroll Period" := PayPeriodStart;
                                assmatrix.Amount := ScaleBenefits.Amount;
                                if not assmatrix.Get(assmatrix."Employee No", assmatrix.Type, assmatrix.Code, assmatrix."Payroll Period") then assmatrix.Insert;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    procedure FindMaturityDate()
    var
        AccPeriod: Record "Payroll PeriodX";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            FiscalStart := AccPeriod."Starting Date";
            MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;
        end;
    end;

    local procedure GetLeaveEntitlement(EmpNo: Code[50]; LeaveCode: Code[50]): Decimal
    var
        Entitlement: Record "Employee Leave";
        DaysTotal: Decimal;
    begin
        DaysTotal := 0;
        with Entitlement do begin
            Reset;
            SetRange("Employee No", EmpNo);
            SetRange("Leave Code", LeaveCode);
            SetFilter("Maturity Date", '<=%1', "Application Date");
            if Find('-') then begin
                repeat
                    DaysTotal := DaysTotal + Balance;
                until Next = 0;
                // MESSAGE(FORMAT(DaysTotal));
                exit(DaysTotal);
            end;
        end;
    end;

    local procedure GetLeaveEarned(EmployeeNo: Code[50]): Decimal
    var
        DaysTotal: Decimal;
        Employee: Record Employee;
        JobGroup: Record "Salary Scale";
        LeaveLedger: Record "HR Leave Ledger Entries";
    begin
        DaysTotal := 0;
        with LeaveLedger do begin
            Reset;
            SetRange("Staff No.", "Employee No");
            SetRange("Leave Type", "Leave Code");
            SetFilter("Leave Period", '<=%1', "Application Date");
            SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave Allocation");
            if Find('-') then begin
                CalcSums("No. of days");
                exit("No. of days");
            end;
        end;
    end;

    procedure LeaveEntitlement(EmployeeNo: Code[10]): Decimal
    var
        TotalDays: Decimal;
        Employee: Record Employee;
        JobGroup: Record "Salary Scale";
    begin
        TotalDays := 0;
        if Employee.Get(EmployeeNo) then begin
            Employee.TestField("Salary Scale");
            with JobGroup do begin
                Reset;
                SetRange(Scale, Employee."Salary Scale");
                if FindFirst then begin
                    TotalDays := "Leave Days";
                    exit(TotalDays);
                end;
            end;
        end;
    end;

    procedure GetContrateesEntitlement(StaffNo: Code[20]; LCode: Code[20])
    var
        Contrs: Record "Employment Contract";
        Employee: Record Employee;
    begin
        if LeaveTypes.Get("Leave Code") then begin
            if LeaveTypes."Annual Leave" = true then begin
                if Employee.Get("Employee No") then begin
                    if Employee."Employment Type" = Employee."Employment Type"::Contract then begin
                        /*IF Employee."Contract End Date"<TODAY THEN
                          ERROR('Hapana');*/
                        Contracts.Reset;
                        Contracts.SetRange(Tenure, Employee."Contract Length");
                        if Contracts.Find('-') then begin
                            "Leave Entitlment" := Contracts."Annual Leave Days";
                        end;
                    end
                    else if Employee."Employment Type" = Employee."Employment Type"::Permanent then begin
                        "Leave Entitlment" := LeaveTypes.Days;
                    end;
                end;
            end
            else begin
                "Leave Entitlment" := LeaveTypes.Days;
            end;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Leave Application", "Employee No", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    procedure DocumentAttached(): Boolean
    var
        DocumentAttachment: Record "Document Attachment";
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Leave Application");
        DocumentAttachment.SetRange("No.", "Application No");
        if DocumentAttachment.FindFirst() then
            exit(true)
        else
            exit(false);
    end;

    procedure TotalLeaveDayPerLeavePeriod1()
    var
        LeaveTypes: Record "Leave Type";
    begin
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Code, Rec."Leave Code");
        CalcFields("Total Leave Days Taken");
        if LeaveTypes.FindFirst() then "Leave Balance on leave Period" := LeaveTypes.Days - "Total Leave Days Taken";
        if "Days Applied" > "Leave balance" then
            Message('You dont have enough leave days accrued,but you have a balance of %1 days this year,you can proceed to apply', "Leave Balance on leave Period")
        else if "Days Applied" > "Leave Balance on leave Period" then Error('You cannot apply more than your annual leave');
        Message(Format("Leave Balance on leave Period"));
        Message('Yes');
    end;
}

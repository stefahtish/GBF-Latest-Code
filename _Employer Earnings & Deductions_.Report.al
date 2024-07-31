report 50211 "Employer Earnings & Deductions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployerEarnings.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Payroll PeriodX"; "Payroll PeriodX")
        {
            RequestFilterFields = "Pay Period Filter", "Earnings Code Filter", "Deductions Code Filter";

            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompPicture; CompanyInfo.Picture)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompAddr2; CompanyInfo."Address 2")
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(Tel; Tel)
            {
            }
            column(Address; Address)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(Payroll_PeriodX_Name; Name)
            {
            }
            column(Payroll_PeriodX__Starting_Date_; UpperCase(Format("Starting Date", 0, '<month text> <year4>')))
            {
            }
            column(Payroll_PeriodCaption; Payroll_PeriodCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(TEL_NOCaption; TEL_NOCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption; Name_of_EmployeeCaptionLbl)
            {
            }
            column(ADDRESSCaption; ADDRESSCaptionLbl)
            {
            }
            column(EMPLOYER_NOCaption; EMPLOYER_NOCaptionLbl)
            {
            }
            column(EMPLOYERCaption; EMPLOYERCaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NOCaption; EMPLOYER_PIN_NOCaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(MONTHLY_EARNINGS_REPORTCaption; MONTHLY_EARNINGS_REPORTCaptionLbl)
            {
            }
            column(Payroll_PeriodX_Starting_Date; "Starting Date")
            {
            }
            column(Payroll_PeriodX_Earnings_Code_Filter; "Earnings Code Filter")
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            dataitem(EarningsX; EarningsX)
            {
                DataItemLink = Code = FIELD("Earnings Code Filter"), "Pay Period Filter" = FIELD("Starting Date");
                DataItemTableView = SORTING(Code);

                column(EarningsX_Description; Description)
                {
                }
                column(EarningsX_Code; Code)
                {
                }
                column(EarningsX_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
                {
                    DataItemLink = Code = FIELD(Code), "Payroll Period" = FIELD("Pay Period Filter");
                    DataItemTableView = SORTING(Type, Code, "Payroll Period", "Reference No") WHERE(Type = CONST(Payment), "Employee type" = filter(<> trustee), "Employer Amount" = filter(> 0));

                    column(Assignment_Matrix_X__Assignment_Matrix_X__Amount; "Employer Amount")
                    {
                    }
                    column(LastName; LastName)
                    {
                    }
                    column(Assignment_Matrix_X__Assignment_Matrix_X___Employee_No_; "Employee No")
                    {
                    }
                    column(FirstName; FirstName)
                    {
                    }
                    column(TotalAmount; TotalAmount)
                    {
                    }
                    column(Counter; Counter)
                    {
                    }
                    column(Total_AmountCaption; Total_AmountCaptionLbl)
                    {
                    }
                    column(Assignment_Matrix_X_Type; Type)
                    {
                    }
                    column(Assignment_Matrix_X_Code; Code)
                    {
                    }
                    column(Assignment_Matrix_X_Payroll_Period; "Payroll Period")
                    {
                    }
                    column(Assignment_Matrix_X_Reference_No; "Reference No")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if Emp.Get("Assignment Matrix-XD"."Employee No") then begin
                            NhifNo := Emp."NHIF No";
                            FirstName := Emp."First Name";
                            LastName := Emp."Last Name";
                            TotalAmount := TotalAmount + "Assignment Matrix-XD".Amount;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Assignment Matrix-X".SetRange("Payroll Period", "Payroll PeriodX"."Starting Date");
                        if CompInfoSetup.Get() then;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    if DedFilter <> '' then CurrReport.Skip();
                end;
            }
            dataitem(DeductionsX; DeductionsX)
            {
                DataItemLink = Code = FIELD("Deductions Code Filter"), "Pay Period Filter" = FIELD("Starting Date");
                DataItemTableView = SORTING(Code);

                column(EarningsXD_Description; Description)
                {
                }
                column(EarningsXD_Code; Code)
                {
                }
                column(EarningsXD_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                dataitem("Assignment Matrix-XD"; "Assignment Matrix-X")
                {
                    DataItemLink = Code = FIELD(Code), "Payroll Period" = FIELD("Pay Period Filter");
                    DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE(Type = CONST(Deduction), "Employer Amount" = filter(> 0));

                    column(Assignment_Matrix_XD__Assignment_Matrix_X__Amount; "Employer Amount")
                    {
                    }
                    column(LastNameD; LastName)
                    {
                    }
                    column(Assignment_Matrix_XD__Assignment_Matrix_X___Employee_No_; "Employee No")
                    {
                    }
                    column(FirstNameD; FirstName)
                    {
                    }
                    column(TotalAmountD; TotalAmount)
                    {
                    }
                    column(CounterD; Counter)
                    {
                    }
                    column(Total_AmountCaptionD; Total_AmountCaptionLbl)
                    {
                    }
                    column(Assignment_Matrix_XD_Type; Type)
                    {
                    }
                    column(Assignment_Matrix_XD_Code; Code)
                    {
                    }
                    column(Assignment_Matrix_XD_Payroll_Period; "Payroll Period")
                    {
                    }
                    column(Assignment_Matrix_XD_Reference_No; "Reference No")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if Emp.Get("Assignment Matrix-XD"."Employee No") then begin
                            NhifNo := Emp."NHIF No";
                            FirstName := Emp."First Name";
                            LastName := Emp."Last Name";
                            //TotalAmount := TotalAmount + "Assignment Matrix-XD".Amount;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Assignment Matrix-XD".SetRange("Payroll Period", "Payroll PeriodX"."Starting Date");
                        if CompInfoSetup.Get() then;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    if EarnFilter <> '' then CurrReport.Skip();
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                GetDefaults(PayApprovalCode);
                DateSpecified := "Payroll PeriodX"."Pay Period Filter";
                ApprovalEntries.Reset;
                ApprovalEntries.SetRange("Table ID", Database::"Payroll Approval");
                ApprovalEntries.SetRange("Document No.", HRMgmt.GetPayrollApprovalCode(DateSpecified));
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[1] := ApprovalEntries."Sender ID";
                            ApproverDate[1] := ApprovalEntries."Date-Time Sent for Approval";
                            if UserSetup.Get(Approver[1]) then UserSetup.CalcFields(Signature);
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup3.Get(Approver[4]) then UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Payroll PeriodX".SetFilter("Starting Date", "Payroll PeriodX".GetFilter("Pay Period Filter"));
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        DedFilter := "Payroll PeriodX".GetFilter("Deductions Code Filter");
        EarnFilter := "Payroll PeriodX".GetFilter("Earnings Code Filter");
        // DateSpecified := "Payroll PeriodX".GetRangeMin("Payroll PeriodX"."Pay Period Filter");
    end;

    trigger OnInitReport()
    begin
    end;

    trigger OnPostReport()
    begin
    end;

    var
        DateSpecified: Date;
        NhifNo: Code[20];
        Emp: Record Employee;
        AssignM: Record "Assignment Matrix-X";
        AssignD: Record "Assignment Matrix-X";
        Id: Code[20];
        FirstName: Text[30];
        LastName: Text[30];
        TotalAmount: Decimal;
        "Count": Integer;
        Deductions: Record "Assignment Matrix-X";
        EmployerNHIFNo: Code[20];
        DOB: Date;
        CompInfoSetup: Record "Employee Earnings History";
        "HR Details": Record Employee;
        CompPINNo: Code[20];
        YEAR: Integer;
        Address: Text[90];
        Tel: Text[30];
        Counter: Integer;
        StopDate: Date;
        StartDate: array[1000] of Date;
        InitialDate: Date;
        i: Integer;
        CurrentDate: Date;
        DedFilter: Text[100];
        EarnFilter: Text[100];
        EarningsRec: Record EarningsX;
        Payroll_PeriodCaptionLbl: Label 'Payroll Period';
        AmountCaptionLbl: Label 'Amount';
        PERIODCaptionLbl: Label 'PERIOD';
        TEL_NOCaptionLbl: Label 'TEL NO';
        Name_of_EmployeeCaptionLbl: Label 'Name of Employee';
        ADDRESSCaptionLbl: Label 'ADDRESS';
        EMPLOYER_NOCaptionLbl: Label 'EMPLOYER NO';
        EMPLOYERCaptionLbl: Label 'EMPLOYER';
        EMPLOYER_PIN_NOCaptionLbl: Label 'EMPLOYER PIN NO';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        PageCaptionLbl: Label 'Page';
        MONTHLY_EARNINGS_REPORTCaptionLbl: Label 'MONTHLY EARNINGS REPORT';
        Total_AmountCaptionLbl: Label 'Total Amount';
        CompanyInfo: Record "Company Information";
        ApprovalEntries: Record "Approval Entry";
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        EmployeeType: option Staff,"Board Member";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        PayApprovalCode: Code[50];
        Payroll: Codeunit Payroll;
        HRMgmt: codeunit "HR Management";

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;

    procedure GetDefaults(var PayAppCode: Code[50])
    begin
        PayApprovalCode := PayAppCode;
    end;
}

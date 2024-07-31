report 50254 "Net Pay Bank Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NetPayBankTransfer.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") WHERE("Employee Job Type" = CONST("  "), "Employment type" = filter(<> trustee));
            RequestFilterFields = "Pay Period Filter"; // "No.", Status;

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
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
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(TIME; Time)
            {
            }
            column(Net_Pay_; 'Net Pay')
            {
            }
            column(PF_No__; 'PF No.')
            {
            }
            column(Name_; 'Name')
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Employee__National_ID_; "ID No.")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankBranch; BankBranch)
            {
            }
            column(Sort_Code; GetSortCode("No."))
            {
            }
            column(Employee__Bank_Account_Number_; "Bank Account Number")
            {
            }
            column(NetPay_Control1000000039; NetPay)
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; StrSubstNo('Employees=%1', counter))
            {
            }
            column(NET_PAY_TO_BANKCaption; NET_PAY_TO_BANKCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ID_NumberCaption; ID_NumberCaptionLbl)
            {
            }
            column(BankCaption; BankCaptionLbl)
            {
            }
            column(BranchCaption; BranchCaptionLbl)
            {
            }
            column(Account_NumberCaption; Account_NumberCaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(Approving_OfficerCaption; Approving_OfficerCaptionLbl)
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption_Control1000000021; DESIGNATION____________________________________________________________Caption_Control1000000021Lbl)
            {
            }
            column(DATE_____________________________________________________________________Caption_Control1000000022; DATE_____________________________________________________________________Caption_Control1000000022Lbl)
            {
            }
            column(NAME_________________________________________________________________________Caption_Control1000000023; NAME_________________________________________________________________________Caption_Control1000000023Lbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption_Control1000000024; SIGNATURE___________________________________________________________Caption_Control1000000024Lbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }
            column(Today; Today)
            {
            }
            trigger OnAfterGetRecord()
            var
                EmpRec: Record Employee;
                TotalGratuity: Decimal;
            begin
                BankName := '';
                BankBranch := '';
                TotalRelief := 0;
                NetPay := 0;
                if EmpBank.Get(Employee."Employee's Bank") then;
                BankName := EmpBank.Name;
                if EmpBankBranch.Get(Employee."Employee's Bank", Employee."Bank Branch") then;
                BankBranch := EmpBankBranch."Branch Name";
                EmpRec.Reset();
                If EmpRec.Get(Employee."No.") then begin
                    EmpRec.SetRange("Pay Period Filter", DateSpecified);
                    EmpRec.CalcFields(EmpRec."Total Allowances", EmpRec."Total Deductions", EmpRec."Loan Interest", EmpRec."Pension Contribution Benefit");
                    if (EmpRec."Total Allowances" + EmpRec."Total Deductions" + EmpRec."Loan Interest") = 0 then CurrReport.Skip;
                    counter := counter + 1;
                    Gratuity := 0;
                    NetPay := Round(Abs(EmpRec."Total Allowances") - Abs(EmpRec."Total Deductions") + Abs(EmpRec."Loan Interest"), RoundPrecision, RoundDirection);
                    // Gratuity
                    EarnRec.Reset;
                    EarnRec.SetRange("Employee Filter", Employee."No.");
                    EarnRec.SetRange("Pay Period Filter", DateSpecified);
                    EarnRec.SetRange(Gratuity, true);
                    if EarnRec.FindFirst() then begin
                        Gratuity := 0;
                        EarnRec.Calcfields("Total Amount");
                        Gratuity := EarnRec."Total Amount";
                        //NetPay := NetPay - Gratuity;
                    end;
                    // netpay
                    //NetPay := NetPay - Gratuity;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Employment Status", Employee."Employment Status"::Active);
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
    trigger OnInitReport()
    begin
    end;

    trigger OnPostReport()
    begin
    end;

    trigger OnPreReport()
    begin
        DateSpecified := Employee.GetRangeMin(Employee."Pay Period Filter");
        Payroll.GetNetPayRounding(RoundPrecision, RoundDirection);
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Allowances: array[100] of Decimal;
        Deductions: array[100] of Decimal;
        EarnRec: Record EarningsX;
        DedRec: Record DeductionsX;
        Earncode: array[100] of Code[10];
        deductcode: array[100] of Code[10];
        EarnDesc: array[30] of Text[150];
        DedDesc: array[30] of Text[150];
        i: Integer;
        j: Integer;
        AssignMatrix: Record "Assignment Matrix-X";
        Gratuity: Decimal;
        DateSpecified: Date;
        Totallowances: Decimal;
        TotalRelief: Decimal;
        TotalDeductions: Decimal;
        OtherEarn: Decimal;
        OtherDeduct: Decimal;
        counter: Integer;
        HRSetup: Record "Human Resources Setup";
        NetPay: Decimal;
        Payroll: Codeunit Payroll;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Text002: Label 'MASTER ROLL';
        Text001: Label 'BRAND KENYA BOARD';
        NoOfEarnings: Integer;
        NoOfDeductions: Integer;
        PG: Code[20];
        Dpt: Code[20];
        Emp: Code[20];
        EmpBank: Record Banks;
        EmpBankBranch: Record "Bank Branches";
        EmpNo: Code[10];
        BankName: Text[100];
        BankBranch: Text[100];
        NET_PAY_TO_BANKCaptionLbl: Label 'NET PAY TO BANK';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ID_NumberCaptionLbl: Label 'ID Number';
        BankCaptionLbl: Label 'Bank';
        BranchCaptionLbl: Label 'Branch';
        Account_NumberCaptionLbl: Label 'Account Number';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        Approving_OfficerCaptionLbl: Label 'Approving Officer';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DESIGNATION____________________________________________________________Caption_Control1000000021Lbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________Caption_Control1000000022Lbl: Label 'DATE ....................................................................';
        NAME_________________________________________________________________________Caption_Control1000000023Lbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________Caption_Control1000000024Lbl: Label 'SIGNATURE ..........................................................';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';
        RoundPrecision: Decimal;
        RoundDirection: Text;
        CompanyInfo: Record "Company Information";

    procedure GetSortCode(No: Code[50]): Code[50]
    begin
        if Employee.Get(No) then exit(Employee."Employee Bank Sort Code");
    end;
}

codeunit 50125 Payroll
{
    trigger OnRun()
    var
    begin
    end;
    var AmountRemaining: Decimal;
    TaxableAmount: Decimal;
    TaxCode: Code[20];
    IncomeTax: Decimal;
    GrossTaxCharged: Decimal;
    relief: Decimal;
    PayPeriod: Record "Payroll PeriodX";
    BeginDate: Date;
    BasicSalary: Decimal;
    HRSetup: Record "Human Resources Setup";
    HseLimit: Decimal;
    Employee: Record Employee;
    retirecontribution: Decimal;
    ExcessRetirement: Decimal;
    PAYE: Decimal;
    TaxablePay: Decimal;
    BfMpr: Decimal;
    CfMpr: Decimal;
    GrossPay: Decimal;
    TotalBenefits: Decimal;
    RetireCont: Decimal;
    TotalQuarters: Decimal;
    LowInterestBenefits: Decimal;
    Netpay: Decimal;
    Earnings: Record EarningsX;
    TerminalDues: Decimal;
    TaxTable: Record BracketsX;
    Ded: Record DeductionsX;
    i: Integer;
    OnesText: array[20]of Text[30];
    TensText: array[10]of Text[30];
    ExponentText: array[5]of Text[30];
    mine: Text[30];
    OwnerOccupier: Decimal;
    Text000: Label 'Preview is not allowed.';
    Text001: Label 'Last Check No. must be filled in.';
    Text002: Label 'Filters on %1 and %2 are not allowed.';
    Text003: Label 'XXXXXXXXXXXXXXXX';
    Text004: Label 'must be entered.';
    Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
    Text006: Label 'Salesperson';
    Text007: Label 'Purchaser';
    Text008: Label 'Both Bank Accounts must have the same currency.';
    Text009: Label 'Our Contact';
    Text010: Label 'XXXXXXXXXX';
    Text011: Label 'XXXX';
    Text012: Label 'XX.XXXXXXXXXX.XXXX';
    Text013: Label '%1 already exists.';
    Text014: Label 'Check for %1 %2';
    Text015: Label 'Payment';
    Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
    Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
    Text018: Label 'XXX';
    Text019: Label 'Total';
    Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
    Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
    Text022: Label 'NON-NEGOTIABLE';
    Text023: Label 'Test print';
    Text024: Label 'XXXX.XX';
    Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
    Text026: Label 'ZERO';
    Text027: Label 'HUNDRED';
    Text028: Label '-';
    Text029: Label '%1 results in a written number that is too long.';
    Text030: Label ' is already applied to %1 %2 for customer %3.';
    Text031: Label ' is already applied to %1 %2 for vendor %3.';
    Text032: Label 'ONE';
    Text033: Label 'TWO';
    Text034: Label 'THREE';
    Text035: Label 'FOUR';
    Text036: Label 'FIVE';
    Text037: Label 'SIX';
    Text038: Label 'SEVEN';
    Text039: Label 'EIGHT';
    Text040: Label 'NINE';
    Text041: Label 'TEN';
    Text042: Label 'ELEVEN';
    Text043: Label 'TWELVE';
    Text044: Label 'THIRTEEN';
    Text045: Label 'FOURTEEN';
    Text046: Label 'FIFTEEN';
    Text047: Label 'SIXTEEN';
    Text048: Label 'SEVENTEEN';
    Text049: Label 'EIGHTEEN';
    Text050: Label 'NINETEEN';
    Text051: Label 'TWENTY';
    Text052: Label 'THIRTY';
    Text053: Label 'FORTY';
    Text054: Label 'FIFTY';
    Text055: Label 'SIXTY';
    Text056: Label 'SEVENTY';
    Text057: Label 'EIGHTY';
    Text058: Label 'NINETY';
    Text059: Label 'THOUSAND';
    Text060: Label 'MILLION';
    Text061: Label 'BILLION';
    Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
    Text063: Label 'Net Amount %1';
    Text064: Label '%1 must not be %2 for %3 %4.';
    Text065: Label 'AND // text0028 removed the AND';
    Text066: Label 'No PAYE Deduction has been defined';
    Text067: Label 'You haven''t been setup in the payroll';
    CompanyInfo: Record "Company Information";
    Calender: Record Date;
    NoofWarnings: Integer;
    Act: Record "Employee Acting Position";
    LoanLedgEntryNo: Integer;
    procedure GetTaxBracket(var TaxableAmount: Decimal; Employee: Record Employee)GetTaxBracket: Decimal var
        TaxTable: Record BracketsX;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        //Modified on 31st August 2016 by Coremen to cater for employees taxed elsewhere
        HRSetup.Get;
        TaxCode:=GetTaxCode;
        AmountRemaining:=TaxableAmount;
        AmountRemaining:=Round(AmountRemaining, 0.01);
        EndTax:=false;
        TaxTable.Reset;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-')then begin
            repeat if AmountRemaining <= 0 then EndTax:=true
                else
                begin
                    if(Round((TaxableAmount), 1) >= TaxTable."Upper Limit") and (Employee."Min Tax Rate" <= TaxTable.Percentage)then begin
                        //Tax:=ROUND((TaxTable."Taxable Amount"*TaxTable.Percentage/100),1);
                        Tax:=(TaxTable."Taxable Amount" * TaxTable.Percentage / 100);
                        TotalTax:=TotalTax + Tax;
                    end
                    else if(Employee."Min Tax Rate" <= TaxTable.Percentage)then begin
                            //Deducted 1 here and got the xact figures just chek incase this may have issues
                            //Only the amount in the last Tax band had issues.
                            case true of(Tax = 0) and (Employee."Min Tax Rate" <> 0): AmountRemaining:=AmountRemaining;
                            else
                                AmountRemaining:=AmountRemaining - TaxTable."Lower Limit";
                            end;
                            Tax:=AmountRemaining * (TaxTable.Percentage / 100);
                            EndTax:=true;
                            TotalTax:=TotalTax + Tax;
                        end;
                end;
            until(TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax:=TotalTax;
        //MESSAGE('%1',TotalTax);
        TotalTax:=PayrollRounding(TotalTax);
        IncomeTax:=-TotalTax;
        //GetTaxBracket:=ROUND(TotalTax,1,'<');
        GetTaxBracket:=TotalTax;
    end;
    procedure GetPayPeriod(): Date begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-')then begin
            //PayPeriodtext:=PayPeriod.Name;
            BeginDate:=PayPeriod."Starting Date";
        end;
        exit(BeginDate);
    end;
    procedure CalculateTaxableAmount(var EmployeeNo: Code[20]; var DateSpecified: Date; var FinalTax: Decimal; var TaxableAmountNew: Decimal; var RetirementCont: Decimal)
    var
        Assignmatrix: Record "Assignment Matrix-X";
        Employee: Record Employee;
        Earnings: Record EarningsX;
        InsuranceRelief: Decimal;
        PersonalRelief: Decimal;
        HRSetup: Record "Human Resources Setup";
        MortgageRelief: Decimal;
        PPSetup: Record "Purchases & Payables Setup";
    begin
        CfMpr:=0;
        FinalTax:=0;
        i:=0;
        TaxableAmount:=0;
        RetirementCont:=0;
        InsuranceRelief:=0;
        PersonalRelief:=0;
        OwnerOccupier:=0;
        //Get payroll period
        GetPayPeriod;
        if DateSpecified = 0D then Error('Pay period must be specified for this report');
        HRSetup.Get;
        // Taxable Amount
        Employee.Reset;
        Employee.SetRange("No.", EmployeeNo);
        Employee.SetRange("Pay Period Filter", DateSpecified);
        if Employee.FindFirst then begin
            if Employee."Pays tax?" = true then begin
                Employee.CalcFields("Taxable Allowance", "Tax Deductible Amount", "Relief Amount");
                TaxableAmount:=Employee."Taxable Allowance";
                Ded.Reset;
                Ded.SetRange(Ded."Tax deductible", true);
                Ded.SetRange(Ded."Owner Occupied Interest", false);
                if Ded.Find('-')then begin
                    repeat Assignmatrix.Reset;
                        Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SetRange(Type, Assignmatrix.Type::Deduction);
                        Assignmatrix.SetRange(Assignmatrix.Code, Ded.Code);
                        Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.Find('-')then if Ded."Pension Limit Amount" > 0 then begin
                                if Abs(Assignmatrix.Amount) > Ded."Pension Limit Amount" then RetirementCont:=Abs(RetirementCont) + Ded."Pension Limit Amount"
                                else
                                    RetirementCont:=Abs(RetirementCont) + Abs(Assignmatrix.Amount);
                            end
                            else
                                RetirementCont:=Abs(RetirementCont) + Abs(Assignmatrix.Amount);
                    until Ded.Next = 0;
                end;
                HRSetup.Get;
                if RetirementCont > HRSetup."Pension Limit Amount" then RetirementCont:=HRSetup."Pension Limit Amount";
                TaxableAmount:=TaxableAmount - RetirementCont;
                if Employee.Disabled = Employee.Disabled::Yes then TaxableAmount:=TaxableAmount - HRSetup."Disabililty Tax Exp. Amt";
                // end Taxable Amount
                //Owner occupier occupied interest
                Ded.Reset;
                Ded.SetRange(Ded."Tax deductible", true);
                Ded.SetRange(Ded."Owner Occupied Interest", true);
                if Ded.Find('-')then begin
                    repeat Assignmatrix.Reset;
                        Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SetRange(Type, Assignmatrix.Type::Deduction);
                        Assignmatrix.SetRange(Assignmatrix.Code, Ded.Code);
                        Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.FindFirst then begin
                            repeat OwnerOccupier:=OwnerOccupier + Abs(Assignmatrix.Amount);
                            until Assignmatrix.Next = 0;
                        end;
                    until Ded.Next = 0;
                end;
                if OwnerOccupier > 0 then begin
                    if HRSetup.Get then if HRSetup."Owner Occupied Interest Limit" < OwnerOccupier then OwnerOccupier:=HRSetup."Owner Occupied Interest Limit";
                    TaxableAmount:=TaxableAmount - OwnerOccupier;
                end;
                //End of owner occupied interest
                //Add Owner Occuppier
                if OwnerOccupier > 0 then begin
                    Earnings.Reset;
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Owner Occupier");
                    if Earnings.Find('-')then begin
                        repeat if Employee.Get(EmployeeNo)then;
                            if Assignmatrix.Find('-')then Assignmatrix.Init;
                            Assignmatrix."Employee No":=Employee."No.";
                            Assignmatrix.Type:=Assignmatrix.Type::Payment;
                            Assignmatrix.Code:=Earnings.Code;
                            Assignmatrix."Reference No":='';
                            Assignmatrix.Validate(Code);
                            Assignmatrix."Payroll Period":=DateSpecified;
                            Assignmatrix."Department Code":=Employee."Global Dimension 1 Code";
                            Assignmatrix.Amount:=OwnerOccupier;
                            Assignmatrix."Posting Group Filter":=Employee."Posting Group";
                            Assignmatrix."Department Code":=Employee."Global Dimension 1 Code";
                            Assignmatrix.Validate(Amount);
                            if(Assignmatrix.Amount <> 0) and (not Assignmatrix.Get(Assignmatrix."Employee No", Assignmatrix.Type, Assignmatrix.Code, Assignmatrix."Payroll Period", Assignmatrix."Reference No"))then Assignmatrix.Insert
                            else
                            begin
                                Assignmatrix.Reset;
                                Assignmatrix.SetRange("Payroll Period", DateSpecified);
                                Assignmatrix.SetRange(Type, Assignmatrix.Type::Payment);
                                Assignmatrix.SetRange(Code, Earnings.Code);
                                Assignmatrix.SetRange("Employee No", EmployeeNo);
                                if Assignmatrix.Find('-')then begin
                                    Assignmatrix.Amount:=OwnerOccupier;
                                    Assignmatrix.Validate(Amount);
                                    Assignmatrix.Modify;
                                end;
                            end;
                        until Earnings.Next = 0;
                    end;
                end;
                //if OwnerOccupier = 0 then begin//For cases with deductions elsewhere
                OwnerOccupier:=0; // Mortgage Relief
                Earnings.Reset;
                Earnings.SetCurrentKey("Earning Type");
                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Owner Occupier");
                if Earnings.Find('-')then begin
                    repeat Assignmatrix.Reset;
                        Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SetRange(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                        Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.Find('-')then OwnerOccupier:=OwnerOccupier + Assignmatrix.Amount;
                    until Earnings.Next = 0;
                end;
                if OwnerOccupier > 0 then begin
                    HRSetup.Get;
                    /* if HRSetup."Owner Occupied Interest Limit" < OwnerOccupier then
                        OwnerOccupier := HRSetup."Owner Occupied Interest Limit"; */
                    TaxableAmount:=TaxableAmount - OwnerOccupier;
                end;
                //end;
                // End ofOwner occupier Specific
                /*
                // Low Interest Benefits
                     EarnRec.RESET;
                     EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                     EarnRec.SETRANGE(EarnRec."Earning Type",EarnRec."Earning Type"::"Low Interest");
                     IF EarnRec.FIND('-') THEN BEGIN
                      REPEAT
                       Assignmatrix.RESET;
                       Assignmatrix.SETRANGE(Assignmatrix."Payroll Period",DateSpecified);
                       Assignmatrix.SETRANGE(Type,Assignmatrix.Type::Payment);
                       Assignmatrix.SETRANGE(Assignmatrix.Code,EarnRec.Code);
                       Assignmatrix.SETRANGE(Assignmatrix."Employee No",EmployeeNo);
                       IF Assignmatrix.FIND('-') THEN
                        TaxableAmount:=TaxableAmount+Assignmatrix.Amount;
                      UNTIL EarnRec.NEXT=0;
                     END;
                 //End of Low Interest benefits
                */
                //Per Diem
                PPSetup.Get;
                Earnings.Reset;
                Earnings.SetRange("Per Diem", true);
                if Earnings.Find('-')then begin
                    repeat Assignmatrix.Reset;
                        Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SetRange(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                        Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.Find('-')then begin
                            if Assignmatrix."No of Days" > 0 then begin
                                TaxableAmount:=TaxableAmount - (Assignmatrix."No of Days" * PPSetup."Daily Tax Exempt Rate");
                            end
                            else if Assignmatrix."No of Days" = 0 then begin
                                    TaxableAmount:=TaxableAmount;
                                end;
                        end;
                    until Earnings.Next = 0;
                end;
                //
                TaxableAmount:=Round(TaxableAmount, 0.01, '<');
                TaxableAmountNew:=TaxableAmount;
                // Get PAYE
                if Employee."Secondary Employee" then begin
                    HRSetup.TestField("Secondary PAYE %");
                    FinalTax:=TaxableAmount * (HRSetup."Secondary PAYE %" / 100);
                end
                else
                    FinalTax:=GetTaxBracket(TaxableAmount, Employee);
                if Employee.Get(EmployeeNo)then;
                if Employee."Employee Job Type" <> Employee."Employee Job Type"::Director then begin
                    // Get Reliefs
                    InsuranceRelief:=0;
                    // Calculate insurance relief;
                    Earnings.Reset;
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Insurance Relief");
                    if Earnings.Find('-')then begin
                        repeat Assignmatrix.Reset;
                            Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SetRange(Type, Assignmatrix.Type::Payment);
                            Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                            Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                            if Assignmatrix.Find('-')then InsuranceRelief:=InsuranceRelief + Assignmatrix.Amount;
                        until Earnings.Next = 0;
                    end;
                    // Personal Relief
                    PersonalRelief:=0;
                    Earnings.Reset;
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Tax Relief");
                    if Earnings.Find('-')then begin
                        repeat Assignmatrix.Reset;
                            Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SetRange(Type, Assignmatrix.Type::Payment);
                            Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                            Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                            if Assignmatrix.Find('-')then PersonalRelief:=PersonalRelief + Assignmatrix.Amount;
                        until Earnings.Next = 0;
                    end;
                end;
                // Get PAYE
                if not Employee."Secondary Employee" then FinalTax:=FinalTax - (PersonalRelief + InsuranceRelief + MortgageRelief)
                else
                    FinalTax:=FinalTax;
                if FinalTax < 0 then FinalTax:=0;
            end
            else
                FinalTax:=0;
        end;
    end;
    procedure GetUserGroup(var UserIDs: Code[10]; var PGroup: Code[20])
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserIDs)then begin
            PGroup:=UserSetup."Employee No.";
            Message('pgroup is ' + PGroup);
            if PGroup = '' then Error(Text067);
        end;
    end;
    procedure FormatNoText(var NoText: array[2]of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        Clear(NoText);
        NoTextIndex:=1;
        NoText[1]:='****';
        if No < 1 then AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else
        begin
            for Exponent:=4 downto 1 do begin
                PrintExponent:=false;
                Ones:=No div Power(1000, Exponent - 1);
                Hundreds:=Ones div 100;
                Tens:=(Ones mod 100) div 10;
                Ones:=Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end
                else if(Tens * 10 + Ones) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1)then AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;
        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        //FORMAT(No * 100) + '/100');
        if CurrencyCode <> '' then AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;
    local procedure AddToNoText(var NoText: array[2]of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent:=true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1])do begin
            NoTextIndex:=NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText)then Error(Text029, AddText);
        end;
        NoText[NoTextIndex]:=DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;
    procedure InitTextVariable()
    begin
        OnesText[1]:=Text032;
        OnesText[2]:=Text033;
        OnesText[3]:=Text034;
        OnesText[4]:=Text035;
        OnesText[5]:=Text036;
        OnesText[6]:=Text037;
        OnesText[7]:=Text038;
        OnesText[8]:=Text039;
        OnesText[9]:=Text040;
        OnesText[10]:=Text041;
        OnesText[11]:=Text042;
        OnesText[12]:=Text043;
        OnesText[13]:=Text044;
        OnesText[14]:=Text045;
        OnesText[15]:=Text046;
        OnesText[16]:=Text047;
        OnesText[17]:=Text048;
        OnesText[18]:=Text049;
        OnesText[19]:=Text050;
        TensText[1]:='';
        TensText[2]:=Text051;
        TensText[3]:=Text052;
        TensText[4]:=Text053;
        TensText[5]:=Text054;
        TensText[6]:=Text055;
        TensText[7]:=Text056;
        TensText[8]:=Text057;
        TensText[9]:=Text058;
        ExponentText[1]:='';
        ExponentText[2]:=Text059;
        ExponentText[3]:=Text060;
        ExponentText[4]:=Text061;
    end;
    procedure PayrollRounding(var Amount: Decimal)PayrollRounding: Decimal var
        HRsetup: Record "Human Resources Setup";
        amt: Decimal;
        DecPosistion: Integer;
        Decvalue: Text[30];
        amttext: Text[30];
        Wholeamt: Text[30];
        Stringlen: Integer;
        Decplace: Integer;
        holdamt: Text[30];
        FirstNoText: Text[30];
        SecNoText: Text[30];
        FirstNo: Integer;
        SecNo: Integer;
        Amttoround: Decimal;
    begin
        Evaluate(amttext, Format(Amount));
        DecPosistion:=StrPos(amttext, '.');
        Stringlen:=StrLen(amttext);
        if DecPosistion > 0 then begin
            Wholeamt:=CopyStr(amttext, 1, DecPosistion - 1);
            Decplace:=Stringlen - DecPosistion;
            Decvalue:=CopyStr(amttext, DecPosistion + 1, 2);
            if StrLen(Decvalue) = 1 then holdamt:=Decvalue + '0';
            if StrLen(Decvalue) > 1 then begin
                FirstNoText:=CopyStr(Decvalue, 1, 1);
                SecNoText:=CopyStr(Decvalue, 2, 1);
                Evaluate(SecNo, Format(SecNoText));
                if SecNo >= 5 then holdamt:=FirstNoText + '5'
                else
                    holdamt:=FirstNoText + '0' end;
            amttext:=Wholeamt + '.' + holdamt;
            Evaluate(Amttoround, Format(amttext));
        end
        else
        begin
            Evaluate(amttext, Format(Amount));
            Evaluate(Amttoround, Format(amttext));
        end;
        Amount:=Amttoround;
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
    procedure GetTaxCode()TaxCode: Code[20]var
        Deductions: Record DeductionsX;
    begin
        Deductions.Reset;
        Deductions.SetRange("PAYE Code", true);
        Deductions.SetFilter("Deduction Table", '<>%1', ' ');
        if Deductions.FindFirst then exit(Deductions."Deduction Table")
        else
            Error(Text066);
    end;
    procedure PayPertimers(EmplyeeNo: Code[20]; EDCode: Code[20])
    var
        PartimePayments: Record "Employee Pay Requests";
        PartimePayments2: Record "Employee Pay Requests";
        EmpNo: Code[30];
        Amnt: Decimal;
        EmployeeAmt: array[1000]of Decimal;
        i: Integer;
        EmployeeRef: array[1000]of Code[10];
        "Code": array[1000]of Code[10];
        AssignmentMatrix: Record "Assignment Matrix-X";
        ReferenceNo: Code[10];
    begin
        PartimePayments.Reset;
        PartimePayments.SetRange(Status, PartimePayments.Status::Approved);
        PartimePayments.SetRange(Date, 0D, Today);
        PartimePayments.SetRange("Employee No.", EmplyeeNo);
        PartimePayments.SetRange("ED Code", EDCode);
        if PartimePayments.Find('-')then begin
            repeat //PartimePayments.CALCSUMS(Amount);
                Amnt:=PartimePayments.Amount;
                if Amnt = 0 then exit;
                if not AssignmentMatrix.Get(EmplyeeNo, AssignmentMatrix.Type::Payment, EDCode, GetPayPeriod(), ReferenceNo)then begin
                    AssignmentMatrix.Init;
                    AssignmentMatrix."Employee No":=EmplyeeNo;
                    AssignmentMatrix.Type:=AssignmentMatrix.Type::Payment;
                    AssignmentMatrix.Code:=EDCode;
                    AssignmentMatrix.Validate(Code);
                    AssignmentMatrix."Payroll Period":=GetPayPeriod;
                    AssignmentMatrix.Amount:=Amnt;
                    AssignmentMatrix.Insert;
                end
                else
                    AssignmentMatrix.Amount:=Amnt;
                AssignmentMatrix.Modify;
                // PartimePayments.RESET;
                // PartimePayments.SETRANGE(Status,PartimePayments.Status::Approved);
                // PartimePayments.SETRANGE(Date,0D,TODAY);
                // PartimePayments.SETRANGE("Employee No.",EmplyeeNo);
                PartimePayments.ModifyAll(Status, PartimePayments.Status::Paid);
            until PartimePayments.Next = 0;
        end;
    end;
    procedure CheckIfPartime(Emp: Code[10]): Integer var
        EmpContract: Record "Employment Contract";
    begin
        if Employee.Get(Emp)then begin
            if EmpContract.Get(Employee."Nature of Employment")then exit(EmpContract."Employee Type")end;
    end;
    procedure GetCurrentBasicPay(EmpNo: Code[20]; PayPeriod: Date): Decimal var
        AssignmentMatrix: Record "Assignment Matrix-X";
    begin
        Earnings.Reset;
        Earnings.SetRange("Basic Salary Code", true);
        if Earnings.FindFirst then begin
            AssignmentMatrix.Reset;
            AssignmentMatrix.SetRange(Code, Earnings.Code);
            AssignmentMatrix.SetRange("Employee No", EmpNo);
            AssignmentMatrix.SetRange("Payroll Period", PayPeriod);
            AssignmentMatrix.SetCurrentKey("Employee No", Code, "Payroll Period");
            if AssignmentMatrix.FindFirst then exit((AssignmentMatrix.Amount * 12 / 100));
        end;
    end;
    local procedure CalcLeaveAllowance(var EmpNo: Code[20]; var PayPeriod: Date): Decimal var
        HRSetup: Record "Human Resources Setup";
    begin
        exit(GetCurrentBasicPay(EmpNo, PayPeriod) * HRSetup."Leave Allowance");
    end;
    procedure GetPureFormula(EmpCode: Code[20]; Payperiod: Date; strFormula: Text[250])Formula: Text[250]var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        TransCode:='';
        for i:=1 to StrLen(strFormula)do begin
            Char:=CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy:=true;
            if StartCopy then TransCode:=TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then FinalFormula:=FinalFormula + Char;
            if Char = ']' then begin
                StartCopy:=false;
                //Get Transcode
                Where:='=';
                Which:='[]';
                TransCode:=DelChr(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount:=GetCurrentPay(EmpCode, Payperiod, TransCode);
                //Reset Transcode
                TransCode:='';
                //Get Final Formula
                FinalFormula:=FinalFormula + Format(TransCodeAmount);
            //End Get Transcode
            end;
        end;
        Formula:=FinalFormula;
    end;
    procedure GetCurrentPay(EmpNo: Code[20]; PayPeriod: Date; "Code": Code[10]): Decimal var
        AssignmentMatrix: Record "Assignment Matrix-X";
    begin
        AssignmentMatrix.Reset;
        AssignmentMatrix.SetRange(Code, Code);
        AssignmentMatrix.SetRange("Employee No", EmpNo);
        AssignmentMatrix.SetRange("Payroll Period", PayPeriod);
        AssignmentMatrix.SetCurrentKey("Employee No", Code, "Payroll Period");
        if AssignmentMatrix.FindFirst then exit(AssignmentMatrix.Amount);
    end;
    procedure GetResult(strFormula: Text[250])Results: Decimal var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
    //Results :=
    //AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;
    procedure CalculateMonths(StartDate: Date; EndDate: Date)"count": Integer var
        NextDate: Date;
        PreviousDate: Date;
    begin
        PreviousDate:=StartDate;
        count:=-1;
        while PreviousDate <= EndDate do begin
            NextDate:=CalcDate('1M', PreviousDate);
            count+=1;
            PreviousDate:=NextDate;
        end;
    end;
    procedure PostPayrollRequest(PaymentReq: Record "Payroll Requests")
    var
        PayrollRequestLines: Record "Payroll Request Lines";
        AssignMatrix: Record "Assignment Matrix-X";
        AssignMatrix2: Record "Assignment Matrix-X";
        AssType: Option Payment, Deduction, "Saving Scheme", Loan;
    begin
        if PaymentReq.Type = PaymentReq.Type::Earning then AssType:=AssType::Payment
        else if PaymentReq.Type = PaymentReq.Type::Deduction then AssType:=AssType::Deduction;
        case PaymentReq.Applies of PaymentReq.Applies::Specific: begin
            //Special Condition;
            if PaymentReq."Special Condition" <> PaymentReq."Special Condition"::" " then begin
                if PaymentReq."Special Condition" = PaymentReq."Special Condition"::Suspend then begin
                    Message(PaymentReq."Employee No.");
                    AssignMatrix.Reset;
                    AssignMatrix.SetRange("Employee No", PaymentReq."Employee No.");
                    AssignMatrix.SetRange("Payroll Period", PaymentReq."Payroll Period");
                    AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                    if AssignMatrix.FindFirst then begin
                        repeat if Earnings.Get(AssignMatrix.Code)then begin
                                AssignMatrix.Amount:=AssignMatrix.Amount * Earnings."Supension Earnings Percentage" / 100;
                                AssignMatrix."Reason For Chage":=PaymentReq.Remarks;
                                AssignMatrix.Modify;
                                if Employee.Get(PaymentReq."Employee No.")then Employee."Payroll Suspenstion Date":=PaymentReq."Payroll Period";
                                Employee.Modify;
                            end;
                        until AssignMatrix.Next = 0;
                    end;
                end
                else if PaymentReq."Special Condition" = PaymentReq."Special Condition"::"Re-Instatement" then begin
                        //Delete the current ones
                        AssignMatrix.Reset;
                        AssignMatrix.SetRange("Employee No", PaymentReq."Employee No.");
                        AssignMatrix.SetRange("Payroll Period", PaymentReq."Payroll Period");
                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.DeleteAll;
                        //Get the last supension date and re-instate
                        if Employee.Get(PaymentReq."Employee No.")then begin
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange("Employee No", PaymentReq."Employee No.");
                            AssignMatrix.SetRange("Payroll Period", CalcDate('-1M', Employee."Payroll Suspenstion Date"));
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            if AssignMatrix.FindFirst then begin
                                AssignMatrix2.Init;
                                AssignMatrix2."Employee No":=PaymentReq."Employee No.";
                                AssignMatrix2.Type:=AssignMatrix.Type;
                                AssignMatrix2.Code:=AssignMatrix.Code;
                                AssignMatrix."Reference No":=PaymentReq."No.";
                                AssignMatrix2."Payroll Period":=PaymentReq."Payroll Period";
                                AssignMatrix2."Reason For Chage":=PaymentReq.Remarks;
                                AssignMatrix2.Amount:=AssignMatrix.Amount * CalculateMonths(Employee."Payroll Suspenstion Date", PaymentReq."Payroll Period");
                                AssignMatrix2.TransferFields(AssignMatrix);
                                AssignMatrix2.Insert;
                            end;
                        end;
                    end;
            //Non Special
            end
            else
            begin
                //Gratuity
                if PaymentReq.Gratuity then begin
                    if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, PaymentReq."Payroll Period", PaymentReq."No.")then begin
                        AssignMatrix.Amount:=PaymentReq.Amount;
                        AssignMatrix.Modify;
                    end
                    else
                    begin
                        AssignMatrix.Init;
                        AssignMatrix."Employee No":=PaymentReq."Employee No.";
                        AssignMatrix."Payroll Period":=PaymentReq."Payroll Period";
                        if PaymentReq.Type = PaymentReq.Type::Earning then AssignMatrix.Type:=AssignMatrix.Type::Payment
                        else if PaymentReq.Type = PaymentReq.Type::Deduction then AssignMatrix.Type:=AssignMatrix.Type::Deduction;
                        AssignMatrix.Code:=PaymentReq.Code;
                        AssignMatrix.Validate(Code);
                        AssignMatrix."Reference No":=PaymentReq."No.";
                        AssignMatrix.Amount:=PaymentReq.Amount;
                        AssignMatrix.Insert;
                    end;
                end;
                //Locum
                if PaymentReq.Locum then begin
                    if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, PaymentReq."Payroll Period", PaymentReq."No.")then begin
                        AssignMatrix.Amount:=PaymentReq.Amount;
                        AssignMatrix.Modify;
                    end
                    else
                    begin
                        AssignMatrix.Init;
                        AssignMatrix."Employee No":=PaymentReq."Employee No.";
                        AssignMatrix."Payroll Period":=PaymentReq."Payroll Period";
                        if PaymentReq.Type = PaymentReq.Type::Earning then AssignMatrix.Type:=AssignMatrix.Type::Payment
                        else if PaymentReq.Type = PaymentReq.Type::Deduction then AssignMatrix.Type:=AssignMatrix.Type::Deduction;
                        AssignMatrix.Code:=PaymentReq.Code;
                        AssignMatrix.Validate(Code);
                        AssignMatrix."Reference No":=PaymentReq."No.";
                        AssignMatrix.Amount:=PaymentReq.Amount;
                        AssignMatrix.Insert;
                    end;
                end; // Locum
            end; //Non special
        end; //Specific
        //All Employees
        PaymentReq.Applies::All: begin
            PayrollRequestLines.Reset;
            PayrollRequestLines.SetRange("No.", PaymentReq."No.");
            if PayrollRequestLines.FindFirst then begin
                repeat if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, PaymentReq."Payroll Period", PaymentReq."No.")then begin
                        AssignMatrix.Amount:=PayrollRequestLines."New Value";
                        AssignMatrix.Modify;
                    end
                    else
                    begin
                        AssignMatrix.Init;
                        AssignMatrix."Employee No":=PayrollRequestLines."Employee No.";
                        AssignMatrix.Code:=PaymentReq.Code;
                        AssignMatrix.Validate(Code);
                        AssignMatrix.Type:=AssType;
                        AssignMatrix."Payroll Period":=PaymentReq."Payroll Period";
                        AssignMatrix."Reference No":=PaymentReq."No.";
                        AssignMatrix.Amount:=PayrollRequestLines."New Value";
                        AssignMatrix.Insert;
                    end;
                until PayrollRequestLines.Next = 0;
            end;
        end;
        //A group of employees
        PaymentReq.Applies::Group: begin
            PayrollRequestLines.Reset;
            PayrollRequestLines.SetRange("No.", PaymentReq."No.");
            if PayrollRequestLines.FindFirst then begin
                repeat if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, PaymentReq."Payroll Period", PaymentReq."No.")then begin
                        AssignMatrix.Amount:=PayrollRequestLines."New Value";
                        AssignMatrix.Modify;
                    end
                    else
                    begin
                        AssignMatrix.Init;
                        AssignMatrix."Employee No":=PayrollRequestLines."Employee No.";
                        AssignMatrix.Code:=PaymentReq.Code;
                        AssignMatrix.Validate(Code);
                        AssignMatrix.Type:=AssType;
                        AssignMatrix."Payroll Period":=PaymentReq."Payroll Period";
                        AssignMatrix."Reference No":=PaymentReq."No.";
                        AssignMatrix.Amount:=PayrollRequestLines."New Value";
                        AssignMatrix.Insert;
                    end;
                until PayrollRequestLines.Next = 0;
            end;
        end;
        end;
        PaymentReq.Status:=PaymentReq.Status::Acctioned;
        PaymentReq.Modify;
        Message('Payroll updated successfully!!!');
    end;
    procedure PostInternalLoan(LoanApp: Record "Loan Application")
    var
        LoanBatch: Code[50];
        LoanTemplate: Code[50];
        LineNo: Integer;
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        CashSetup: Record "Cash Management Setups";
        AssMatrix: Record "Assignment Matrix-X";
        InterestAmt: Decimal;
        Schedule: Record "Repayment Schedule";
        Emp: Record Employee;
        PreviewShedule: Record "Repayment Schedule";
        GLEntry: Record "G/L Entry";
        LoanPostingGroup: Code[30];
        LoanProduct: Record "Loan Product Type";
    begin
        //Insert Loan Deduction
        IF LoanApp."Issued Date" = 0D THEN ERROR('You must specify the issue date before issuing the loan');
        IF LoanApp."Approved Amount" = 0 THEN ERROR('You must specify the Approved amount before issuing the loan');
        IF LoanApp."Interest Rate" <> 0 THEN InterestAmt:=(LoanApp."Approved Amount" * (LoanApp."Interest Rate" / 100));
        LoanApp.TestField("Loan Status", LoanApp."Loan Status"::Approved);
        LoanProduct.Reset();
        LoanProduct.SetRange(Code, LoanApp."Loan Product Type");
        if LoanProduct.FindFirst()then begin
            LoanProduct.TestField("Principal Receivable PG");
            LoanPostingGroup:=LoanProduct."Principal Receivable PG";
        end;
        IF LoanApp."Loan Customer Type" = LoanApp."Loan Customer Type"::Staff THEN BEGIN
            IF NOT LoanApp."Opening Loan" THEN BEGIN
                Emp.GET(LoanApp."Employee No");
                AssMatrix.INIT;
                AssMatrix."Employee No":=LoanApp."Employee No";
                AssMatrix.Type:=AssMatrix.Type::Deduction;
                AssMatrix."Reference No":=LoanApp."Loan No";
                IF LoanApp."Deduction Code" = '' THEN ERROR('Loan %1 must be associated with a deduction', LoanApp."Loan Product Type")
                ELSE
                    AssMatrix.Code:=LoanApp."Deduction Code";
                AssMatrix."Payroll Period":=LoanApp."Issued Date";
                AssMatrix.Description:=LoanApp.Description;
                AssMatrix."Payroll Group":=Emp."Posting Group";
                AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                CASE LoanApp."Interest Calculation Method" OF LoanApp."Interest Calculation Method"::"Reducing Balance": BEGIN
                    PreviewShedule.RESET;
                    PreviewShedule.SETRANGE("Loan No", LoanApp."Loan No");
                    PreviewShedule.SETRANGE("Repayment Date", LoanApp."Issued Date");
                    IF PreviewShedule.FINDFIRST THEN BEGIN
                        //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                        AssMatrix.Amount:=LoanApp.Repayment;
                        AssMatrix."Loan Interest":=PreviewShedule."Monthly Interest";
                    END;
                END;
                LoanApp."Interest Calculation Method"::"Flat Rate": BEGIN
                    PreviewShedule.RESET;
                    PreviewShedule.SETRANGE("Loan No", LoanApp."Loan No");
                    PreviewShedule.SETRANGE("Repayment Date", LoanApp."Issued Date");
                    IF PreviewShedule.FINDFIRST THEN BEGIN
                        //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                        AssMatrix.Amount:=LoanApp.Repayment;
                        ;
                        AssMatrix."Loan Interest":=PreviewShedule."Monthly Interest";
                    END;
                END;
                LoanApp."Interest Calculation Method"::Amortised: BEGIN
                    PreviewShedule.RESET;
                    PreviewShedule.SETRANGE("Loan No", LoanApp."Loan No");
                    PreviewShedule.SETRANGE("Repayment Date", LoanApp."Issued Date");
                    IF PreviewShedule.FINDFIRST THEN BEGIN
                        //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                        AssMatrix.Amount:=LoanApp.Repayment;
                        AssMatrix."Loan Interest":=PreviewShedule."Monthly Interest";
                    END;
                END
                ELSE
                BEGIN
                    AssMatrix.Amount:=LoanApp.Repayment;
                    AssMatrix."Loan Interest":=InterestAmt;
                END;
                END;
                AssMatrix."Next Period Entry":=TRUE;
                AssMatrix."Loan Repay":=TRUE;
                AssMatrix.VALIDATE(AssMatrix.Amount);
                AssMatrix.VALIDATE("Loan Interest");
                IF NOT AssMatrix.GET(AssMatrix."Employee No", AssMatrix.Type, LoanApp."Deduction Code", LoanApp."Issued Date", LoanApp."Loan No")THEN AssMatrix.INSERT
                ELSE
                BEGIN
                    Emp.GET(LoanApp."Employee No");
                    AssMatrix."Employee No":=LoanApp."Employee No";
                    AssMatrix.Type:=AssMatrix.Type::Deduction;
                    AssMatrix."Reference No":=LoanApp."Loan No";
                    IF LoanApp."Deduction Code" = '' THEN ERROR('Loan %1 must be associated with a deduction', LoanApp."Loan Product Type")
                    ELSE
                        AssMatrix.Code:=LoanApp."Deduction Code";
                    AssMatrix."Payroll Period":=LoanApp."Issued Date";
                    AssMatrix.Description:=LoanApp.Description;
                    AssMatrix."Payroll Group":=Emp."Posting Group";
                    AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                    CASE LoanApp."Interest Calculation Method" OF LoanApp."Interest Calculation Method"::"Reducing Balance": BEGIN
                        PreviewShedule.RESET;
                        PreviewShedule.SETRANGE("Loan No", LoanApp."Loan No");
                        PreviewShedule.SETRANGE("Repayment Date", LoanApp."Issued Date");
                        IF PreviewShedule.FINDFIRST THEN BEGIN
                            AssMatrix.Amount:=PreviewShedule."Principal Repayment";
                            AssMatrix."Loan Interest":=PreviewShedule."Monthly Interest";
                        END;
                    END;
                    LoanApp."Interest Calculation Method"::"Flat Rate": BEGIN
                        PreviewShedule.RESET;
                        PreviewShedule.SETRANGE("Loan No", LoanApp."Loan No");
                        PreviewShedule.SETRANGE("Repayment Date", LoanApp."Issued Date");
                        IF PreviewShedule.FINDFIRST THEN BEGIN
                            AssMatrix.Amount:=PreviewShedule."Principal Repayment";
                            AssMatrix."Loan Interest":=PreviewShedule."Monthly Interest";
                        END;
                    END;
                    LoanApp."Interest Calculation Method"::Amortised: BEGIN
                        PreviewShedule.RESET;
                        PreviewShedule.SETRANGE("Loan No", LoanApp."Loan No");
                        PreviewShedule.SETRANGE("Repayment Date", LoanApp."Issued Date");
                        IF PreviewShedule.FINDFIRST THEN BEGIN
                            //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                            AssMatrix.Amount:=PreviewShedule."Principal Repayment";
                            AssMatrix."Loan Interest":=PreviewShedule."Monthly Interest";
                        END;
                    END
                    ELSE
                    BEGIN
                        AssMatrix.Amount:=LoanApp.Repayment;
                        AssMatrix."Loan Interest":=InterestAmt;
                    END;
                    END;
                    AssMatrix."Next Period Entry":=TRUE;
                    AssMatrix."Loan Repay":=TRUE;
                    AssMatrix.VALIDATE(AssMatrix.Amount);
                    AssMatrix.VALIDATE("Loan Interest");
                    AssMatrix.MODIFY;
                END;
            //Opening Loan
            END
            ELSE
            BEGIN
                Emp.GET(LoanApp."Employee No");
                AssMatrix.INIT;
                AssMatrix."Employee No":=LoanApp."Employee No";
                AssMatrix.Type:=AssMatrix.Type::Deduction;
                AssMatrix.Code:=LoanApp."Deduction Code";
                AssMatrix."Payroll Period":=LoanApp."Issued Date";
                AssMatrix."Reference No":=LoanApp."Loan No";
                AssMatrix.Description:=LoanApp.Description;
                AssMatrix."Payroll Group":=Emp."Posting Group";
                AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                CASE LoanApp."Interest Calculation Method" OF LoanApp."Interest Calculation Method"::"Reducing Balance": BEGIN
                    IF NOT LoanApp.Suggested THEN AssMatrix.Amount:=LoanApp.Repayment
                    ELSE
                        AssMatrix.Amount:=LoanApp."Suggested Repayment Amount";
                    AssMatrix."Loan Interest":=InterestAmt;
                END;
                LoanApp."Interest Calculation Method"::"Flat Rate": BEGIN
                    AssMatrix.Amount:=LoanApp."Flat Rate Principal";
                    AssMatrix."Loan Interest":=LoanApp."Flat Rate Interest";
                END
                ELSE
                BEGIN
                    AssMatrix.Amount:=LoanApp.Repayment;
                    AssMatrix."Loan Interest":=InterestAmt;
                END;
                END;
                AssMatrix.Amount:=LoanApp.Repayment + InterestAmt;
                AssMatrix.VALIDATE(AssMatrix.Amount);
                AssMatrix.VALIDATE("Loan Interest");
                AssMatrix."Next Period Entry":=TRUE;
                AssMatrix."Loan Repay":=TRUE;
                IF NOT AssMatrix.GET(AssMatrix."Employee No", AssMatrix.Type, LoanApp."Deduction Code", LoanApp."Issued Date", LoanApp."Loan No")THEN AssMatrix.INSERT
                ELSE
                BEGIN
                    Emp.GET(LoanApp."Employee No");
                    AssMatrix."Employee No":=LoanApp."Employee No";
                    AssMatrix.Type:=AssMatrix.Type::Deduction;
                    AssMatrix.Code:=LoanApp."Deduction Code";
                    AssMatrix."Payroll Period":=LoanApp."Issued Date";
                    AssMatrix."Reference No":=LoanApp."Loan No";
                    AssMatrix.Description:=LoanApp.Description;
                    AssMatrix."Payroll Group":=Emp."Posting Group";
                    AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                    CASE LoanApp."Interest Calculation Method" OF LoanApp."Interest Calculation Method"::"Reducing Balance": BEGIN
                        AssMatrix.Amount:=LoanApp.Repayment;
                        AssMatrix."Loan Interest":=InterestAmt;
                    END;
                    LoanApp."Interest Calculation Method"::"Flat Rate": BEGIN
                        AssMatrix.Amount:=LoanApp."Flat Rate Principal";
                        AssMatrix."Loan Interest":=LoanApp."Flat Rate Interest";
                    END
                    ELSE
                    BEGIN
                        AssMatrix.Amount:=LoanApp.Repayment;
                        AssMatrix."Loan Interest":=InterestAmt;
                    END;
                    END;
                    AssMatrix.Amount:=LoanApp.Repayment + InterestAmt;
                    AssMatrix.VALIDATE(AssMatrix.Amount);
                    AssMatrix.VALIDATE("Loan Interest");
                    AssMatrix."Next Period Entry":=TRUE;
                    AssMatrix."Loan Repay":=TRUE;
                    AssMatrix.MODIFY;
                END;
            END;
        END;
        //Init Loan Ledger Entry
        InitLoanLedgerEntry(LoanApp);
        //Post Loan
        CashSetup.GET;
        CashSetup.TESTFIELD("Loan Batch Template");
        CashSetup.TESTFIELD("Loan Journal Template");
        LoanTemplate:=CashSetup."Loan Journal Template";
        LoanBatch:=LoanApp."Loan No"; //CashSetup."Loan Batch Template";
        LoanApp.TESTFIELD("Payment Date");
        //Delete existing records in batch
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", LoanTemplate);
        GenJournalLine.SETRANGE("Journal Batch Name", LoanBatch);
        GenJournalLine.DELETEALL;
        //Initialise Loan Batch
        GenJournalBatch.INIT;
        IF CashSetup.GET THEN;
        GenJournalBatch."Journal Template Name":=LoanTemplate;
        GenJournalBatch.Name:=LoanBatch;
        IF NOT GenJournalBatch.GET(GenJournalBatch."Journal Template Name", GenJournalBatch.Name)THEN GenJournalBatch.INSERT;
        //Debit Customer Loan
        LineNo:=LineNo + 1000;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Journal Template Name":=LoanTemplate;
        GenJournalLine."Journal Batch Name":=LoanBatch;
        GenJournalLine."Document No.":=LoanApp."Loan No";
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
        GenJournalLine.VALIDATE("Account Type");
        IF LoanApp."Loan Customer Type" = LoanApp."Loan Customer Type"::Staff THEN begin
            GenJournalLine."Account No.":=LoanApp."Debtors Code";
            GenJournalLine."Posting Group":=LoanPostingGroup;
        end;
        // END ELSE BEGIN
        //     GenJournalLine."Account No." := LoanApp."Employee No";
        // END:
        GenJournalLine.VALIDATE("Account No.");
        GenJournalLine."Posting Date":=LoanApp."Payment Date";
        GenJournalLine.Description:=GetLoanProductName(LoanApp."Loan Product Type") + '-' + LoanApp."Employee No" + '(' + FORMAT(LoanApp."Issued Date") + ')';
        GenJournalLine.Amount:=LoanApp."Amount Requested";
        GenJournalLine.VALIDATE(Amount);
        GenJournalLine."Loan No":=LoanApp."Loan No";
        GenJournalLine."Posting Group":=LoanPostingGroup;
        if LoanProduct.GET(LoanApp."Loan Product Type")then begin
            if LoanProduct."Loan Category" = LoanProduct."Loan Category"::Advance then GenJournalLine."Customer Transaction Type":=GenJournalLine."Customer Transaction Type"::Advance
            else
                GenJournalLine."Customer Transaction Type":=GenJournalLine."Customer Transaction Type"::"Car Loan";
        end;
        // GenJournalLine."Loan Transaction Type" := GenJournalLine."Loan Transaction Type"::"Principal Due";
        GenJournalLine."Shortcut Dimension 1 Code":=LoanApp."Shortcut Dimension 1 Code";
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code");
        GenJournalLine."Shortcut Dimension 2 Code":=LoanApp."Shortcut Dimension 2 Code";
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
        //Credit Bank Account
        LineNo:=LineNo + 1000;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Journal Template Name":=LoanTemplate;
        GenJournalLine."Journal Batch Name":=LoanBatch;
        GenJournalLine."Document No.":=LoanApp."Loan No";
        // GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account"; 
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
        GenJournalLine.VALIDATE("Account Type");
        IF LoanApp."Loan Customer Type" = LoanApp."Loan Customer Type"::Staff THEN begin
            GenJournalLine."Account No.":=LoanApp."Debtors Code";
            GenJournalLine."Posting Group":=LoanPostingGroup;
        end;
        // GenJournalLine."Account No." := LoanApp."Paying Bank";
        GenJournalLine.VALIDATE("Account No.");
        GenJournalLine."Posting Date":=LoanApp."Payment Date";
        GenJournalLine.Description:=GetLoanProductName(LoanApp."Loan Product Type") + '-' + LoanApp."Employee No" + '(' + FORMAT(LoanApp."Issued Date") + ')';
        GenJournalLine.Amount:=-LoanApp."Amount Requested";
        GenJournalLine.VALIDATE(Amount);
        GenJournalLine."Loan No":=LoanApp."Loan No";
        // GenJournalLine."Loan Transaction Type" := GenJournalLine."Loan Transaction Type"::"Principal Due";
        GenJournalLine."Shortcut Dimension 1 Code":=LoanApp."Shortcut Dimension 1 Code";
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code");
        GenJournalLine."Shortcut Dimension 2 Code":=LoanApp."Shortcut Dimension 2 Code";
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
        //Post Entries
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", LoanTemplate);
        GenJournalLine.SETRANGE("Journal Batch Name", LoanBatch);
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
        //Init Loan Repayment
        InitLoanRepayment(LoanApp);
        //Modify Loan as Issued
        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", LoanApp."Loan No");
        GLEntry.SETRANGE(Reversed, FALSE);
        IF GLEntry.FINDFIRST THEN BEGIN
            LoanApp."Loan Status":=LoanApp."Loan Status"::Issued;
            LoanApp."Initial Instalments":=LoanApp.Instalment;
            LoanApp.MODIFY;
            MESSAGE('Loan %1 issued and posted successfully', LoanApp."Loan No");
        END;
    end;
    procedure GetCustomerPostingGroup(DocNo: Code[20]): Code[20]var
        Cust: Record Customer;
    begin
        Cust.SetRange("No.", DocNo);
        if Cust.FindFirst()then begin
            Cust.TestField("Imprest Posting Group");
            exit(Cust."Imprest Posting Group");
        end;
    end;
    local procedure GetLoanProductName(LoanType: Code[50]): Text var
        LoanProductType: Record "Loan Product Type";
    begin
        if LoanProductType.Get(LoanType)then exit(LoanProductType.Description);
    end;
    procedure MailRepaymentSchedule(EmailHeader: Record "Email Header")
    var
        Institution: Record Institutions;
        EmailLines: Record "Email Logging Liness";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        email: Codeunit Email;
        SenderAddress: Text;
        Receipient: list of[text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of[text];
        Attachment: Text;
        ErrorMsg: Text;
        NewBody: Label 'Dear %1, <br> This is to Confirm your Submission of you Job application of Position <Strong>%2 </Strong>has been received.<br> Kindly wait for further Communication from the Institution. <br> Kind Regards %3.';
        NoOfRecipients: Integer;
    begin
        EmailLines.Reset;
        EmailLines.SetRange(No, EmailHeader.No);
        if EmailLines.Find('-')then begin
            repeat Institution.Reset;
                Institution.SetRange(Code, EmailLines."Client Code");
                if Institution.FindFirst then begin
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("E-Mail");
                    SenderName:=CompanyInfo.Name;
                    SenderAddress:=CompanyInfo."E-Mail";
                    Receipient.Add(Institution.Email);
                    Subject:='';
                    TimeNow:=(Format(Time));
                    SMTP.Create(Receipient, Subject, '', true);
                    SMTP.AppendToBody(StrSubstNo(NewBody, Employee."First Name", CompanyInfo.Name));
                    NoOfRecipients:=RecipientCC.Count;
                    if NoOfRecipients > 0 then //eddieSMTP.AddCC(RecipientCC);
                        email.Send(SMTP);
                end;
            until EmailLines.Next = 0;
        end;
    end;
    procedure GetMonthWorked(No: Code[20]): Integer var
        Employee: Record Employee;
        DaysWorked: Integer;
        Months: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        if Employee.Get(No)then StartDate:=Employee."Contract Start Date";
        EndDate:=Employee."Contract End Date";
        begin
            DaysWorked:=(EndDate - StartDate);
            if(StartDate <> 0D) and (EndDate > StartDate)then begin
                Calender.Reset;
                Calender.SetRange("Period Type", Calender."Period Type"::Month);
                Calender.SetRange("Period Start", StartDate, EndDate);
                Months:=Calender.Count;
            end;
        //MESSAGE(FORMAT(Months));
        end;
    end;
    procedure GetYearlyBonus(EmployeeNo: Code[20])
    var
        Cases: Record "Employee Disciplinary Cases";
        "Actions": Record "Disciplinary Actions";
        EmployeeRec: Record Employee;
        AssMatrix: Record "Assignment Matrix-X";
        Earn: Record EarningsX;
        YearlyBonus: Decimal;
    begin
        if EmployeeRec.Get(EmployeeNo)then begin
            Cases.Reset;
            Cases.SetRange("Employee No", EmployeeNo);
            if Cases.Find('-')then begin
                if Actions.Get(Cases."Action Taken")then begin
                    if Actions."Warning Letter" then //EXIT(Cases.COUNT);
                        NoofWarnings:=Cases.Count;
                //MESSAGE(FORMAT(NoofWarnings));
                end;
            end;
        end;
        AssMatrix.Reset;
        AssMatrix.SetRange("Employee No", EmployeeNo);
        AssMatrix.SetRange(Type, AssMatrix.Type::Payment);
        if AssMatrix.Find('-')then begin
            if Earn.Get(AssMatrix.Code)then begin
                if Earn."Yearly Bonus" = true then begin
                    YearlyBonus:=AssMatrix.Amount;
                    //MESSAGE(FORMAT(YearlyBonus));
                    if NoofWarnings = 1 then AssMatrix.Amount:=(AssMatrix.Amount * 0.75);
                    if NoofWarnings = 2 then AssMatrix.Amount:=(AssMatrix.Amount * 0.5);
                    if NoofWarnings = 3 then AssMatrix.Amount:=(AssMatrix.Amount * 0.25);
                    if NoofWarnings > 3 then AssMatrix.Amount:=(AssMatrix.Amount * 0.0);
                end;
                AssMatrix.Modify;
                Message('%1', YearlyBonus);
            end;
        end;
    end;
    procedure GetQuatersEmp("Code": Code[20])
    var
        Employee: Record Employee;
        AssignMatrix: Record "Assignment Matrix-X";
    begin
    end;
    procedure GetActingEmployees(var Acting: Record "Employee Acting Position")
    var
        Employee: Record Employee;
        StartDate: Date;
        EndDate: Date;
        TodayDate: Date;
        Counter: Integer;
    begin
        TodayDate:=Today;
        Acting.Reset;
        Acting.SetFilter("Start Date", '<=%1', TodayDate);
        Acting.SetFilter("End Date", '>=%1', TodayDate);
        if Acting.Find('-')then begin
            Counter:=Acting.Count;
            Message(Format(Counter));
        end;
    end;
    procedure SendAllowancesToPayroll(DocNo: Code[20])
    var
        Allowance: Record "Board Attendance Register";
        AllowanceLine: Record "Board Attendance Reg. Lines";
        AllowanceLineRec: Record "Board Attendance Reg. Lines";
        EarningsX: Record EarningsX;
        AssignmentMatrixX: Record "Assignment Matrix-X";
        AllowanceCode: code[20];
        Text001: Label 'There must be at least one line in Board sitting allowance register line %1.';
        Text002: label 'You have to define an Earnings Code for Sitting allowances in Earnings.';
    begin
        Allowance.GET(DocNo);
        AllowanceLine.RESET;
        AllowanceLine.SETRANGE("Document No.", DocNo);
        IF AllowanceLine.FINDFIRST THEN BEGIN
            EarningsX.RESET;
            EarningsX.SETRANGE(BoardSittingAllowance, TRUE);
            IF EarningsX.FINDFIRST THEN AllowanceCode:=EarningsX.Code
            ELSE
                ERROR(Text002);
            REPEAT AssignmentMatrixX.RESET;
                AssignmentMatrixX.SETRANGE("Employee No", AllowanceLine."Employee No.");
                AssignmentMatrixX.SETRANGE("Payroll Period", AllowanceLine."Payroll Period");
                AssignmentMatrixX.SETRANGE(Type, AssignmentMatrixX.Type::Payment);
                AssignmentMatrixX.SETRANGE(Code, AllowanceCode);
                IF NOT AssignmentMatrixX.FINDFIRST THEN BEGIN
                    AllowanceLineRec.RESET;
                    AllowanceLineRec.SETRANGE("Document No.", DocNo);
                    AllowanceLineRec.SETRANGE("Employee No.", AllowanceLine."Employee No.");
                    IF AllowanceLineRec.FINDFIRST THEN BEGIN
                        AllowanceLineRec.CALCSUMS(Amount);
                        AssignmentMatrixX.INIT;
                        AssignmentMatrixX.VALIDATE("Employee No", AllowanceLine."Employee No.");
                        AssignmentMatrixX.Type:=AssignmentMatrixX.Type::Payment;
                        AssignmentMatrixX.VALIDATE(Code, AllowanceCode);
                        AssignmentMatrixX.Amount+=AllowanceLineRec.Amount;
                        AssignmentMatrixX.INSERT;
                    END;
                END
                ELSE
                BEGIN
                    AllowanceLineRec.RESET;
                    AllowanceLineRec.SETRANGE("Document No.", DocNo);
                    AllowanceLineRec.SETRANGE("Employee No.", AllowanceLine."Employee No.");
                    IF AllowanceLineRec.FINDFIRST THEN BEGIN
                        AllowanceLineRec.CALCSUMS(Amount);
                        AssignmentMatrixX.VALIDATE("Employee No", AllowanceLine."Employee No.");
                        AssignmentMatrixX.Type:=AssignmentMatrixX.Type::Payment;
                        AssignmentMatrixX.VALIDATE(Code, AllowanceCode);
                        AssignmentMatrixX.Amount+=AllowanceLineRec.Amount;
                        AssignmentMatrixX.Imprest:=TRUE;
                        AssignmentMatrixX.MODIFY;
                    END;
                END;
            UNTIL AllowanceLine.NEXT = 0;
        END
        ELSE
            ERROR(Text001, DocNo);
        Allowance."Date Posted":=TODAY;
        Allowance."Posted By":=USERID;
        Allowance.Status:=Allowance.Status::Released;
        Allowance.MODIFY;
    end;
    procedure CheckOneThirdRule(AssignMat: Record "Assignment Matrix-X"; EmpNo: Code[20]; PayP: Date; var NetPay: Decimal; NewDed: Decimal): Boolean var
        Earnin: Decimal;
        Deduc: Decimal;
        EmpRec: Record Employee;
        ExemptAmt: Decimal;
        EarningRec: Record "Assignment Matrix-X";
        EarningRec2: Record "Assignment Matrix-X";
        EmpBasic: Decimal;
        TotalEarnings: Decimal;
        TotalDeds: Decimal;
        DeductionsRec: Record "Assignment Matrix-X";
    begin
        HRSetup.Get();
        if HRSetup."Enforce a third rule" then begin
            HRSetup.TestField("Net pay ratio to Earnings");
            EmpRec.Reset();
            EmpRec.SetRange("No.", EmpNo);
            EmpRec.SetRange("Pay Period Filter", PayP);
            if EmpRec.Find('-')then begin
                Clear(EmpBasic);
                EmpRec.CalcFields("Total Allowances", "Total Deductions", "Cumm. PAYE");
                EarningRec.Reset();
                EarningRec.SetRange("Basic Salary Code", true);
                EarningRec.SetRange(EarningRec."Employee No", EmpNo);
                EarningRec.SetRange(EarningRec."Payroll Period", PayP);
                if EarningRec.FindFirst()then begin
                    EmpBasic:=EarningRec.Amount;
                end;
                if EmpRec."Total Allowances" <> 0 then begin
                    if not GetExemptDeductions(EmpNo, PayP)then begin
                        /*if ((Abs(EmpRec."Total Allowances")) - (Abs(EmpRec."Total Deductions") + NewDed)) /
                            (EmpRec."Total Allowances") >= HRSetup."Net pay ratio to Earnings" then
                            exit(true)
                        else begin
                            NetPay := EmpRec."Total Allowances" * HRSetup."Net pay ratio to Earnings";
                            exit(false);
                        end;*/
                        NetPay:=Abs(EmpRec."Total Allowances") - Abs(EmpRec."Total Deductions");
                        if(EmpBasic / 3) >= NetPay then begin
                            exit(false);
                        end
                        else
                        begin
                            NetPay:=EmpRec."Total Allowances" * HRSetup."Net pay ratio to Earnings";
                            exit(true);
                        end;
                    end
                    else
                        exit(true);
                end;
            end;
        end
        else
            exit(true);
    /* AssignMat.Reset;
        AssignMat.SetRange("Employee No", EmpNo);
        AssignMat.SetRange("Payroll Period", PayP);
        if AssignMat.Find('-') then;
        begin
            AssignMat.SetRange(Type, AssignMat.Type::Payment);
            AssignMat.CalcSums(Amount);
            Earnin := AssignMat.Amount;
            Message(Format(Earnin));
        end;

        begin
            AssignMat.SetRange(Type, AssignMat.Type::Deduction);
            AssignMat.CalcSums(Amount);
            Deduc := AssignMat.Amount;
            Message(Format(Deduc));
        end;
        Message(Format(Earnin + Deduc));
        if ((Earnin + Deduc) > (AssignMat."Basic Pay" / HRSetup."Net pay ratio to Earnings")) then
            Message('Insert') else
            Message('Reduce Deductions'); */
    end;
    procedure SendPayslipMail(StaffNo: Code[20]; PaymentPeriod: Date; Mail: Text)
    var
        //FileSystem: Automation BC;
        FormattedAppNo: Code[100];
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of[text];
        Subject: Text;
        EMAIL: Codeunit Email;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of[text];
        Attachment: Text;
        ErrorMsg: Text;
        EmailBody: Label 'Dear %1, <br>Congratulations! You have Successfully secured a position at the <strong>Institute of Energy Studies & Research</strong>. <br>Kindly visit  your applicatioin Portal to Download the Admission Letter.';
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly find attached your Payslip for the Month of <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong>%3</Strong>';
        MailSuccess: Label 'Payslip sent Successfully!';
        PayPeriodText: Text;
        Dash001: Label '-';
    begin
        HRSetup.Get;
        HRSetup.TestField("Payslips Path");
        CompanyInfo.Get;
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");
        /* Clear(FileSystem);
        if Create(FileSystem, false, true) then begin
            if not FileSystem.FolderExists(HRSetup."Payslips Path") then
                FileSystem.CreateFolder(HRSetup."Payslips Path");
        end; */
        PayPeriodText:=Format(PaymentPeriod, 0, '<Month Text> <Year4>');
        SenderName:=HRSetup."General Payslip Message";
        SenderAddress:=HRSetup."Human Resource Emails";
        Receipient.Add(Mail); //Employee."E-Mail";
        Subject:='Payslip for  Period - ' + PayPeriodText;
        TimeNow:=Format(Time);
        FileName:=HRSetup."Payslips Path" + PayPeriodText + '-' + Employee."No." + '.pdf';
        Employee.Reset;
        Employee.SetRange("No.", StaffNo);
        Employee.SetRange("Pay Period Filter", PaymentPeriod);
        if Employee.FindFirst then begin
        //EDDIER EPORT.SaveAsPdf(Report::"New Payslipx", FileName, Employee);
        end;
        SMTP.Create(Receipient, Subject, '', TRUE);
        //smtp.(ToRecipients, Subject, Body, HtmlFormatted, CCRecipients, BCCRecipients); 
        SMTP.AppendToBody(StrSubstNo(NewBody, Employee."First Name", PayPeriodText, HRSetup."General Payslip Message"));
        SMTP.AddAttachment(FileName, Attachment, '');
        //if RecipientCC <> '' then
        //  SMTP.AddCC(RecipientCC);
        EMAIL.Send(SMTP);
    //MESSAGE(MailSuccess);
    //Delete Saved Payslip
    //FileManagement.DeleteClientFile(FileName);
    end;
    procedure GetPrevMonth(PayPeriod: Date; EmplNo: Code[10])
    var
        Payments: Record "Assignment Matrix-X";
    begin
    end;
    procedure SendBulkPayslipMail(PaymentPeriod: Date)
    var
        //FileSystem: Automation BC;
        FormattedAppNo: Code[100];
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        email: Codeunit Email;
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of[text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of[text];
        Attachment: Text;
        ErrorMsg: Text;
        EmailBody: Label 'Dear %1, <br>Congratulations! You have Successfully secured a position at the <strong>Institute of Energy Studies & Research</strong>. <br>Kindly visit  your applicatioin Portal to Download the Admission Letter.';
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly find attached your Payslip for the Month of <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong>%3</Strong>';
        MailSuccess: Label 'Payslip sent Successfully!';
        PayPeriodText: Text;
        Dash001: Label '-';
        EmployeeRec: Record Employee;
    begin
        HRSetup.Get;
        HRSetup.TestField("Payslips Path");
        CompanyInfo.Get;
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");
        /* Clear(FileSystem);
        if Create(FileSystem, false, true) then begin
            if not FileSystem.FolderExists(HRSetup."Payslips Path") then
                FileSystem.CreateFolder(HRSetup."Payslips Path");
        end; */
        PayPeriodText:=Format(PaymentPeriod, 0, '<Month Text> <Year4>');
        SenderName:=HRSetup."General Payslip Message";
        SenderAddress:=HRSetup."Human Resource Emails";
        EmployeeRec.Reset;
        EmployeeRec.SetRange(Status, EmployeeRec.Status::Active);
        EmployeeRec.SetRange("Pay Period Filter", PaymentPeriod);
        EmployeeRec.SetFilter("E-Mail", '<>%1', '');
        if EmployeeRec.Find('-')then begin
            repeat Receipient.Add(EmployeeRec."E-Mail");
                Subject:='Payslip for  Period - ' + PayPeriodText;
                TimeNow:=Format(Time);
                FileName:=HRSetup."Payslips Path" + PayPeriodText + '-' + EmployeeRec."No." + '.pdf';
                //Save Pdf
                //EDDIEREPORT.SaveAsPdf(Report::"New Payslipx", FileName, EmployeeRec);
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendToBody(StrSubstNo(NewBody, EmployeeRec."First Name", PayPeriodText, HRSetup."General Payslip Message"));
                Emailmessage.AddAttachment(FileName, Attachment, '');
                /* if RecipientCC <> '' then
                    SMTP.AddCC(RecipientCC); */
                EMAIL.Send(Emailmessage);
            //Delete Saved Payslip
            //FileManagement.DeleteClientFile(FileName);
            until EmployeeRec.Next = 0;
        end;
    //MESSAGE(MailSuccess);
    end;
    procedure InsertAssignMatrix(Header: Record "Import Earn & Ded Header")
    var
        Lines: Record "Import Earn & Ded Lines";
        AssignMatrix: Record "Assignment Matrix-X";
    begin
        Lines.Reset;
        Lines.SetRange(No, Header.No);
        if Lines.Find('-')then begin
            repeat AssignMatrix.Init;
                AssignMatrix.Type:=Header.Type;
                AssignMatrix.Code:=Header.Code;
                AssignMatrix."Payroll Period":=Header."Pay Period";
                AssignMatrix.Validate(Code);
                AssignMatrix."Reference No":='';
                AssignMatrix."Employee No":=Lines."Employee No";
                if AssignMatrix.Type = AssignMatrix.Type::Deduction then begin
                    AssignMatrix.Amount:=-Lines.Amount;
                end
                else
                    AssignMatrix.Amount:=Lines.Amount;
                if not AssignMatrix.Get(Lines."Employee No", Header.Type, Header.Code, Header."Pay Period", AssignMatrix."Reference No")then AssignMatrix.Insert
                else
                begin
                    AssignMatrix.Type:=Header.Type;
                    AssignMatrix.Code:=Header.Code;
                    AssignMatrix."Payroll Period":=Header."Pay Period";
                    AssignMatrix.Validate(Code);
                    AssignMatrix."Reference No":='';
                    AssignMatrix."Employee No":=Lines."Employee No";
                    if AssignMatrix.Type = AssignMatrix.Type::Deduction then begin
                        AssignMatrix.Amount:=-Lines.Amount;
                    end
                    else
                        AssignMatrix.Amount:=Lines.Amount;
                    AssignMatrix.Modify;
                end;
            until Lines.Next = 0;
        end;
    end;
    procedure GetPayrollRounding(var RoundPrecision: Decimal; var RoundDirection: Text)
    var
        HRSetup: Record "Human Resources Setup";
    begin
        HRSetup.Get;
        HRSetup.TestField("Payroll Rounding Precision");
        RoundPrecision:=HRSetup."Payroll Rounding Precision";
        case HRSetup."Payroll Rounding Type" of HRSetup."Payroll Rounding Type"::Down: RoundDirection:='<';
        HRSetup."Payroll Rounding Type"::Nearest: RoundDirection:='=';
        HRSetup."Payroll Rounding Type"::Up: RoundDirection:='>';
        end;
    end;
    procedure GetNetPayRounding(var RoundPrecision: Decimal; var RoundDirection: Text)
    var
        HRSetup: Record "Human Resources Setup";
    begin
        HRSetup.Get;
        HRSetup.TestField("Net Pay Rounding Precision");
        RoundPrecision:=HRSetup."Net Pay Rounding Precision";
        case HRSetup."Net Pay Rounding Type" of HRSetup."Net Pay Rounding Type"::Down: RoundDirection:='<';
        HRSetup."Net Pay Rounding Type"::Nearest: RoundDirection:='=';
        HRSetup."Net Pay Rounding Type"::Up: RoundDirection:='>';
        end;
    end;
    procedure ValidateFormulaAmounts(AssignRec: Record "Assignment Matrix-X")
    var
        AssignmentMatrixX: Record "Assignment Matrix-X";
        Deductions: Record DeductionsX;
        Earnings: Record EarningsX;
        ValidateAmountTxt: Label 'You have earnings or deductions that depend on changing this amount.\Do you wish to update them?';
    begin
        if AssignRec.Amount > 0 then begin
            if AssignRec."Basic Salary Code" or AssignRec."House Allowance Code" or AssignRec."Commuter Allowance Code" or AssignRec."Salary Arrears Code" or AssignRec."Insurance Code" then begin
                AssignmentMatrixX.Reset;
                AssignmentMatrixX.SetRange(AssignmentMatrixX."Employee No", AssignRec."Employee No");
                AssignmentMatrixX.SetRange(AssignmentMatrixX."Payroll Period", AssignRec."Payroll Period");
                if AssignmentMatrixX.Find('-')then begin
                    repeat //Deductions
                        Deductions.Reset;
                        Deductions.SetRange(Code, AssignmentMatrixX.Code);
                        Deductions.SetFilter("Calculation Method", '%1|%2|%3', Deductions."Calculation Method"::"% of Basic Pay", Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance", Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance + Comm Allowance + Sal Arrears");
                        if Deductions.Find('-')then begin
                            if Confirm(ValidateAmountTxt, false)then begin
                                AssignmentMatrixX.Validate(Code);
                                AssignmentMatrixX.Modify;
                            end;
                        end;
                        //Earnings
                        Earnings.Reset;
                        Earnings.SetRange(Code, AssignmentMatrixX.Code);
                        Earnings.SetFilter("Calculation Method", '%1|%2', Earnings."Calculation Method"::"% of Basic pay", Earnings."Calculation Method"::"% of Insurance Amount");
                        if Earnings.Find('-')then begin
                            AssignmentMatrixX.Validate(Code);
                            AssignmentMatrixX.Modify;
                        end;
                    until AssignmentMatrixX.Next = 0;
                end;
            end;
        end;
    end;
    procedure SuggestLoanInterestLines(IntHeader: Record "Loan Interest Header")
    var
        LoanAmt: Decimal;
        LoanBal: Decimal;
        RoundPrecisionDec: Decimal;
        LineNo: Integer;
        RoundDirectionCode: Text;
        IntLines: Record "Loan Interest Lines";
        LoanHeader: Record "Loan Application";
        LoanTypeRec: Record "Loan Product Type";
        Customer: Record Customer;
    begin
        //clear lines
        IntLines.SETRANGE("Document No.", IntHeader."No.");
        IntLines.DELETEALL;
        LoanHeader.RESET;
        LoanHeader.SETRANGE("Loan Status", LoanHeader."Loan Status"::Issued);
        LoanHeader.SETRANGE("Transaction Type", LoanHeader."Transaction Type"::"Loan Application");
        IF LoanHeader.FIND('-')THEN BEGIN
            LineNo:=0;
            REPEAT LoanTypeRec.GET(LoanHeader."Loan Product Type");
                LoanTypeRec.TESTFIELD("Rounding Precision");
                LoanHeader.TESTFIELD("Debtors Code");
                CASE LoanTypeRec.Rounding OF LoanTypeRec.Rounding::Nearest: RoundDirectionCode:='=';
                LoanTypeRec.Rounding::Down: RoundDirectionCode:='<';
                LoanTypeRec.Rounding::Up: RoundDirectionCode:='>';
                END;
                RoundPrecisionDec:=LoanTypeRec."Rounding Precision";
                LoanAmt:=0;
                LoanBal:=0;
                //Get Loan Balance
                IF Customer.GET(LoanHeader."Debtors Code")THEN BEGIN
                    Customer.SETRANGE("Payroll Loan No. Filter", LoanHeader."Loan No");
                    Customer.SETRANGE("Date Filter", 0D, IntHeader."Posting Date");
                    //Customer.SETRANGE("Date Filter",0D,IntHeader."Period Reference");
                    Customer.SETFILTER("Loan Transaction Type Filter", '%1|%2', Customer."Loan Transaction Type Filter"::"Principal Due", Customer."Loan Transaction Type Filter"::"Principal Repayment");
                    Customer.CALCFIELDS("Net Change", "Net Change (LCY)");
                    LoanBal:=Customer."Net Change (LCY)";
                    LoanAmt:=LoanHeader."Approved Amount";
                END;
                IF(LoanHeader."Approved Amount" > 0) AND (LoanBal > 0)THEN BEGIN
                    LineNo:=LineNo + 10000;
                    IntLines.INIT;
                    IntLines."Document No.":=IntHeader."No.";
                    IntLines."Line No.":=LineNo;
                    IntLines."Loan No.":=LoanHeader."Loan No";
                    IntLines."Employee No.":=LoanHeader."Employee No";
                    IntLines.VALIDATE("Employee No.");
                    IntLines."Period Reference":=IntHeader."Period Reference";
                    IntLines."Loan Amount":=LoanHeader."Approved Amount";
                    IntLines."Loan Balance":=LoanBal;
                    CASE LoanHeader."Interest Calculation Method" OF LoanHeader."Interest Calculation Method"::Amortised, LoanHeader."Interest Calculation Method"::"Reducing Balance": IntLines."Interest Due":=ROUND(LoanBal / 100 / 12 * LoanHeader."Interest Rate", RoundPrecisionDec, RoundDirectionCode);
                    LoanHeader."Interest Calculation Method"::"Flat Rate": IntLines."Interest Due":=ROUND(LoanHeader."Flat Rate Interest" / 12, RoundPrecisionDec, RoundDirectionCode);
                    END;
                    IntLines.INSERT;
                END;
            UNTIL LoanHeader.NEXT = 0;
        END;
    end;
    procedure GetEmpName(EmpCode: Code[20]): Text var
        Employee: Record Employee;
    begin
        if Employee.Get(EmpCode)then exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;
    procedure PostLoanInterest(IntHeader: Record "Loan Interest Header")
    var
        LineNo: Integer;
        LoanInterestLines: Record "Loan Interest Lines";
        GenJnLine: Record "Gen. Journal Line";
        Currency: Record Currency;
        GenJournalBatch: Record "Gen. Journal Batch";
        InvestmentSetup_FM: Record "Investment Setup";
        GLEntry: Record "G/L Entry";
    begin
        IntHeader.TestField(Posted, false);
        IntHeader.TestField("Posting Date");
        HRSetup.Get;
        HRSetup.TestField("Loan Interest Template");
        GenJournalBatch.Init;
        GenJournalBatch."Journal Template Name":=HRSetup."Loan Interest Template";
        GenJournalBatch.Name:=IntHeader."No.";
        if not GenJournalBatch.Get(HRSetup."Loan Interest Template", IntHeader."No.")then GenJournalBatch.Insert;
        GenJnLine.SetRange("Journal Template Name", HRSetup."Loan Interest Template");
        GenJnLine.SetRange("Journal Batch Name", IntHeader."No.");
        GenJnLine.DeleteAll;
        LoanInterestLines.Reset;
        LoanInterestLines.SetRange("Document No.", IntHeader."No.");
        if LoanInterestLines.Find('-')then begin
            repeat LoanInterestLines.TestField("Debtor Code");
                LineNo+=1000;
                GenJnLine.Init;
                GenJnLine."Journal Template Name":=HRSetup."Loan Interest Template";
                GenJnLine."Journal Batch Name":=IntHeader."No.";
                GenJnLine."Line No.":=LineNo;
                GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
                GenJnLine."Account No.":=LoanInterestLines."Debtor Code";
                GenJnLine.Validate(GenJnLine."Account No.");
                GenJnLine."Posting Date":=IntHeader."Posting Date";
                GenJnLine."Document No.":=IntHeader."No.";
                GenJnLine."External Document No.":=LoanInterestLines."Loan No.";
                GenJnLine.Description:=IntHeader.Description + StrSubstNo('-%1', LoanInterestLines."Loan No.");
                GenJnLine.Amount:=LoanInterestLines."Interest Due";
                GenJnLine.Validate(GenJnLine.Amount);
                GenJnLine."Shortcut Dimension 1 Code":=IntHeader."Shortcut Dimension 1 Code";
                GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                GenJnLine."Shortcut Dimension 2 Code":=IntHeader."Shortcut Dimension 2 Code";
                GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                GenJnLine."Dimension Set ID":=IntHeader."Dimension Set ID";
                GenJnLine."Property Transaction Type":=GenJnLine."Property Transaction Type"::Interest;
                GenJnLine."Loan No":=LoanInterestLines."Loan No.";
                GenJnLine."Posting Group":=GetIntPostingGroup(LoanInterestLines."Loan No.");
                GenJnLine."Loan Transaction Type":=GenJnLine."Loan Transaction Type"::"Interest Due";
                GenJnLine."Period Reference":=IntHeader."Period Reference";
                GenJnLine.Validate("Bal. Account No.");
                if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                GenJnLine.Init;
                GenJnLine."Journal Template Name":=HRSetup."Loan Interest Template";
                GenJnLine."Journal Batch Name":=IntHeader."No.";
                LineNo+=1000;
                GenJnLine."Line No.":=LineNo;
                GenJnLine."Account Type":=GenJnLine."Bal. Account Type"::"G/L Account";
                GenJnLine."Account No.":=GetIntReceivableAccount(LoanInterestLines."Loan No.");
                GenJnLine.Validate(GenJnLine."Account No.");
                GenJnLine."Posting Date":=IntHeader."Posting Date";
                GenJnLine."Document No.":=IntHeader."No.";
                GenJnLine."External Document No.":=LoanInterestLines."Loan No.";
                GenJnLine.Description:=IntHeader.Description + StrSubstNo('-%1', LoanInterestLines."Loan No.");
                GenJnLine.Amount:=-LoanInterestLines."Interest Due";
                GenJnLine.Validate(GenJnLine.Amount);
                GenJnLine."Shortcut Dimension 1 Code":=IntHeader."Shortcut Dimension 1 Code";
                GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                GenJnLine."Shortcut Dimension 2 Code":=IntHeader."Shortcut Dimension 2 Code";
                GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                GenJnLine."Dimension Set ID":=IntHeader."Dimension Set ID";
                GenJnLine."Property Transaction Type":=GenJnLine."Property Transaction Type"::Interest;
                GenJnLine."Loan No":=LoanInterestLines."Loan No.";
                GenJnLine."Posting Group":=GetIntPostingGroup(LoanInterestLines."Loan No.");
                GenJnLine."Period Reference":=IntHeader."Period Reference";
                GenJnLine.Validate("Bal. Account No.");
                if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            until LoanInterestLines.Next = 0;
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", HRSetup."Loan Interest Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", IntHeader."No.");
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", IntHeader."No.");
            GLEntry.SetRange("Posting Date", IntHeader."Posting Date");
            if GLEntry.Find('-')then begin
                IntHeader.Posted:=true;
                IntHeader."Date Posted":=Today;
                IntHeader."Time Posted":=Time;
                IntHeader."Posted By":=UserId;
                IntHeader.Modify;
            end;
        end;
    end;
    procedure GetIntReceivableAccount(LoanNo: Code[50]): Code[20]var
        LoanProductType: Record "Loan Product Type";
        LoanApp: Record "Loan Application";
    begin
        if LoanApp.Get(LoanNo)then begin
            if LoanProductType.Get(LoanApp."Loan Product Type")then begin
                LoanProductType.TestField("Interest Receivable Account");
                exit(LoanProductType."Interest Receivable Account");
            end;
        end;
    end;
    procedure GetIntPostingGroup(LoanNo: Code[50]): Code[20]var
        LoanProductType: Record "Loan Product Type";
        LoanApp: Record "Loan Application";
    begin
        if LoanApp.Get(LoanNo)then begin
            if LoanProductType.Get(LoanApp."Loan Product Type")then begin
                LoanProductType.TestField("Interest Posting Group");
                exit(LoanProductType."Interest Posting Group");
            end;
        end;
    end;
    procedure ReverseTrusteePayment(TrusteeRev: Record "Trustee Payment Reversal")
    var
        AccType: enum "Gen. Journal Account Type";
        AccNo: Code[50];
        LineNo: Integer;
        TrustRevLines: Record "Trustee Reversal Lines";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnline: Record "Gen. Journal Line";
        AssignMatrix: Record "Assignment Matrix-X";
        GLEntry: Record "G/L Entry";
    begin
        TrusteeRev.TestField(Posted, false);
        TrusteeRev.TestField("Posting Date");
        TrusteeRev.TestField("Bank Account");
        HRSetup.Get;
        HRSetup.TestField("Trustee Reversal Template");
        GenJournalBatch.Init;
        GenJournalBatch."Journal Template Name":=HRSetup."Trustee Reversal Template";
        GenJournalBatch.Name:=TrusteeRev."No.";
        if not GenJournalBatch.Get(HRSetup."Trustee Reversal Template", TrusteeRev."No.")then GenJournalBatch.Insert;
        GenJnline.SetRange("Journal Template Name", HRSetup."Trustee Reversal Template");
        GenJnline.SetRange("Journal Batch Name", TrusteeRev."No.");
        GenJnline.DeleteAll;
        TrustRevLines.Reset;
        TrustRevLines.SetRange("Document No.", TrusteeRev."No.");
        if TrustRevLines.Find('-')then begin
            repeat TrustRevLines.CalcFields("Total Allowances", "Total Deductions", "Net Pay");
                //Reverse Paye
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Employee Type", AssignMatrix."Employee Type"::Trustee);
                AssignMatrix.SetRange("Employee No", TrustRevLines."Trustee No");
                AssignMatrix.SetRange("Payroll Period", TrustRevLines."Pay Period");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SetRange(Paye, true);
                if AssignMatrix.Find('-')then repeat LineNo:=LineNo + 10000;
                        GenJnline.Init;
                        GenJnline."Journal Template Name":=HRSetup."Trustee Reversal Template";
                        GenJnline."Journal Batch Name":=TrusteeRev."No.";
                        GenJnline."Line No.":=LineNo;
                        GenJnline."Account Type":=GenJnline."Account Type"::"G/L Account";
                        GenJnline."Account No.":=GetGrossPayableAccount(TrustRevLines."Trustee No");
                        GenJnline.Validate(GenJnline."Account No.");
                        GenJnline."Posting Date":=TrusteeRev."Posting Date";
                        GenJnline."Document No.":=TrusteeRev."No.";
                        GenJnline.Description:='Reversal of ' + AssignMatrix.Description + '-' + TrustRevLines."Trustee Name" + ' Period-' + Format(TrustRevLines."Pay Period");
                        GenJnline.Amount:=AssignMatrix.Amount;
                        GenJnline.Validate(GenJnline.Amount);
                        GetNetPayableAccount(AssignMatrix.Type, AssignMatrix.Code, AccType, AccNo);
                        GenJnline."Bal. Account Type":=AccType;
                        GenJnline."Bal. Account No.":=AccNo;
                        GenJnline.Validate("Bal. Account No.");
                        if GenJnline.Amount <> 0 then GenJnline.Insert;
                    until AssignMatrix.Next = 0;
                //Reverse bank
                LineNo:=LineNo + 10000;
                GenJnline.Init;
                GenJnline."Journal Template Name":=HRSetup."Trustee Reversal Template";
                GenJnline."Journal Batch Name":=TrusteeRev."No.";
                GenJnline."Line No.":=LineNo;
                GenJnline."Account Type":=GenJnline."Account Type"::"Bank Account";
                GenJnline."Account No.":=TrusteeRev."Bank Account";
                GenJnline.Validate(GenJnline."Account No.");
                GenJnline."Posting Date":=TrusteeRev."Posting Date";
                GenJnline."Document No.":=TrusteeRev."No.";
                GenJnline.Description:='Reversal of Net Pay' + '-' + TrustRevLines."Trustee Name" + ' Period-' + Format(TrustRevLines."Pay Period");
                GenJnline.Amount:=TrustRevLines."Net Pay";
                GenJnline.Validate(GenJnline.Amount);
                GenJnline."Bal. Account Type":=GenJnline."Bal. Account Type"::"G/L Account";
                GenJnline."Bal. Account No.":=GetGrossPayableAccount(TrustRevLines."Trustee No");
                GenJnline.Validate("Bal. Account No.");
                if GenJnline.Amount <> 0 then GenJnline.Insert;
            until TrustRevLines.Next = 0;
            //Post
            GenJnline.Reset;
            GenJnline.SetRange(GenJnline."Journal Template Name", HRSetup."Trustee Reversal Template");
            GenJnline.SetRange(GenJnline."Journal Batch Name", TrusteeRev."No.");
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnline);
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", TrusteeRev."No.");
            if GLEntry.Find('-')then begin
                TrusteeRev.Posted:=true;
                TrusteeRev."Posted Date-Time":=CurrentDateTime;
                TrusteeRev."Posted By":=UserId;
                TrusteeRev.Modify;
                TrustRevLines.Reset;
                TrustRevLines.SetRange("Document No.", TrusteeRev."No.");
                if TrustRevLines.Find('-')then begin
                    repeat //Delete entries
                        AssignMatrix.Reset;
                        AssignMatrix.SetRange("Employee Type", AssignMatrix."Employee Type"::Trustee);
                        AssignMatrix.SetRange("Employee No", TrustRevLines."Trustee No");
                        AssignMatrix.SetRange("Payroll Period", TrustRevLines."Pay Period");
                        AssignMatrix.DeleteAll;
                    until TrustRevLines.Next = 0;
                end;
            end;
        end;
    end;
    local procedure GetGrossPayableAccount(EmpCode: Code[50]): Code[50]var
        EarningsX: Record EarningsX;
        DeductionsX: Record DeductionsX;
        PostingGroup: Record "Employee Posting GroupX";
        Employee: Record Employee;
    begin
        if Employee.Get(EmpCode)then begin
            Employee.TestField("Posting Group");
            if PostingGroup.Get(Employee."Posting Group")then begin
                PostingGroup.TestField("Salary Account");
                exit(PostingGroup."Salary Account");
            end
            else
                Error('Posting group %1 not set up under Emp Posting Groups', Employee."Posting Group");
        end;
    end;
    local procedure GetNetPayableAccount(PayType: Option Payment, Deduction, "Saving Scheme", Loan; AssgnCode: Code[50]; var AccType: enum "Gen. Journal Account Type"; var AccNo: Code[50]): Code[50]var
        EarningsX: Record EarningsX;
        DeductionsX: Record DeductionsX;
        PostingGroup: Record "Employee Posting GroupX";
        Employee: Record Employee;
    begin
        case PayType of PayType::Payment: begin
            if EarningsX.Get(AssgnCode)then begin
                EarningsX.TestField("Account No.");
                AccType:=EarningsX."Account Type";
                AccNo:=EarningsX."Account No.";
            end;
        end;
        PayType::Deduction: begin
            if DeductionsX.Get(AssgnCode)then begin
                DeductionsX.TestField("Account No.");
                AccType:=DeductionsX."Account Type";
                AccNo:=DeductionsX."Account No.";
            end;
        end;
        end;
    end;
    procedure SendImprestToPayroll(DocNo: Code[20])
    var
        Deduction: Record "Imprest Deduction";
        DeductionLine: Record "Imprest Deduction Line";
        DeductionLineRec: Record "Imprest Deduction Line";
        DeductionsX: Record DeductionsX;
        AssignmentMatrixX: Record "Assignment Matrix-X";
        Imprest: Record Payments;
        DeductionCode: code[20];
        Text001: Label 'There must be at least one line in Imprest Deduction %1.';
        Text002: label 'You have to define a Deduction Code for Imprest in the Deductions.';
    begin
        Deduction.GET(DocNo);
        DeductionLine.RESET;
        DeductionLine.SETRANGE("Document No.", DocNo);
        IF DeductionLine.FINDFIRST THEN BEGIN
            DeductionsX.RESET;
            DeductionsX.SETRANGE(Imprest, TRUE);
            IF DeductionsX.FINDFIRST THEN DeductionCode:=DeductionsX.Code
            ELSE
                ERROR(Text002);
            REPEAT AssignmentMatrixX.RESET;
                AssignmentMatrixX.SETRANGE("Employee No", DeductionLine."Employee No.");
                AssignmentMatrixX.SETRANGE("Payroll Period", DeductionLine."Payroll Period");
                AssignmentMatrixX.SETRANGE(Type, AssignmentMatrixX.Type::Deduction);
                AssignmentMatrixX.SETRANGE(Code, DeductionCode);
                IF NOT AssignmentMatrixX.FINDFIRST THEN BEGIN
                    DeductionLineRec.RESET;
                    DeductionLineRec.SETRANGE("Document No.", DocNo);
                    DeductionLineRec.SETRANGE("Employee No.", DeductionLine."Employee No.");
                    IF DeductionLineRec.FINDFIRST THEN BEGIN
                        DeductionLineRec.CALCSUMS(Amount);
                        AssignmentMatrixX.INIT;
                        AssignmentMatrixX.VALIDATE("Employee No", DeductionLine."Employee No.");
                        AssignmentMatrixX.Type:=AssignmentMatrixX.Type::Deduction;
                        AssignmentMatrixX.VALIDATE(Code, DeductionCode);
                        AssignmentMatrixX.Amount:=-DeductionLineRec.Amount;
                        AssignmentMatrixX.Imprest:=TRUE;
                        AssignmentMatrixX.INSERT;
                    END;
                END
                ELSE
                BEGIN
                    DeductionLineRec.RESET;
                    DeductionLineRec.SETRANGE("Document No.", DocNo);
                    DeductionLineRec.SETRANGE("Employee No.", DeductionLine."Employee No.");
                    IF DeductionLineRec.FINDFIRST THEN BEGIN
                        DeductionLineRec.CALCSUMS(Amount);
                        AssignmentMatrixX.VALIDATE("Employee No", DeductionLine."Employee No.");
                        AssignmentMatrixX.Type:=AssignmentMatrixX.Type::Deduction;
                        AssignmentMatrixX.VALIDATE(Code, DeductionCode);
                        AssignmentMatrixX.Amount:=-DeductionLineRec.Amount;
                        AssignmentMatrixX.Imprest:=TRUE;
                        AssignmentMatrixX.MODIFY;
                    END;
                END;
                Imprest.RESET;
                Imprest.SETRANGE("Payment Type", Imprest."Payment Type"::Imprest);
                Imprest.SETRANGE("No.", DeductionLine."Imprest No");
                IF Imprest.FINDFIRST THEN BEGIN
                    Imprest."Payroll Transfered":=TRUE;
                    Imprest.MODIFY;
                END;
            UNTIL DeductionLine.NEXT = 0;
        END
        ELSE
            ERROR(Text001, DocNo);
        Deduction."Date Posted":=TODAY;
        Deduction."Posted By":=USERID;
        Deduction.Status:=Deduction.Status::Released;
        Deduction.MODIFY;
    end;
    procedure GetExemptDeductions(EmpNo: Code[20]; Period: Date): Boolean var
        AssignMat: Record "Assignment Matrix-X";
    begin
        Ded.reset;
        Ded.SetRange("Exempt from a third rule", true);
        if Ded.find('-')then repeat AssignMat.Reset();
                AssignMat.SetRange("Employee No", EmpNo);
                AssignMat.SetRange(Type, AssignMat.Type::Deduction);
                AssignMat.SetRange("Payroll Period", Period);
                AssignMat.SetRange(Code, Ded.Code);
                if AssignMat.Find('-')then exit(true)
                else
                    exit(false);
            until Ded.Next = 0;
    end;
    procedure InitLoanLedgerEntry(Var Loans: Record "Loan Application")
    var
        LoanLedgEntry: Record "Loan Ledger Entry-Payroll";
    begin
        LoanLedgEntry.INIT;
        GetNextLoanEntryNo;
        LoanLedgEntry."Entry No.":=LoanLedgEntryNo;
        LoanLedgEntry."Loan Customer Type":=Loans."Loan Customer Type";
        LoanLedgEntry."Employee No.":=Loans."Employee No";
        LoanLedgEntry."Debtor's Code":=Loans."Debtors Code";
        LoanLedgEntry."Document No.":=Loans."Loan No";
        LoanLedgEntry."Loan No.":=Loans."Loan Application No.";
        LoanLedgEntry."Posting Date":=Loans."Application Date";
        LoanLedgEntry."User ID":=USERID;
        CASE Loans."Transaction Type" OF Loans."Transaction Type"::"Loan Application": BEGIN
            LoanLedgEntry."Loan No.":=Loans."Loan No";
            LoanLedgEntry.VALIDATE("Transaction Type", LoanLedgEntry."Transaction Type"::Principal);
            LoanLedgEntry.Amount:=Loans."Approved Amount";
            LoanLedgEntry."Payment Mode":=Loans."Payment Method";
            LoanLedgEntry."Payment Reference No.":=Loans."Payment Refrence No.";
            LoanLedgEntry.Description:='Loan Application Loan No. ' + Loans."Loan No" + ' for ' + Loans."Employee No" + ' - ' + Loans."Employee Name";
        END;
        Loans."Transaction Type"::"Loan Settlement": BEGIN
            LoanLedgEntry."Loan No.":=Loans."Loan Application No.";
            LoanLedgEntry.VALIDATE("Transaction Type", LoanLedgEntry."Transaction Type"::Settlement);
            LoanLedgEntry.Amount:=-Loans."Settlement Amount";
            LoanLedgEntry."Payment Mode":=Loans."Payment Method";
            LoanLedgEntry."Payment Reference No.":=Loans."Payment Refrence No.";
            LoanLedgEntry.Description:='Loan Settlement Loan No. ' + Loans."Loan Application No." + ' for ' + Loans."Employee No" + ' - ' + Loans."Employee No";
        END;
        END;
        LoanLedgEntry."Shortcut Dimension 1 Code":=Loans."Shortcut Dimension 1 Code";
        LoanLedgEntry.VALIDATE("Shortcut Dimension 1 Code");
        LoanLedgEntry."Shortcut Dimension 2 Code":=Loans."Shortcut Dimension 2 Code";
        LoanLedgEntry.VALIDATE("Shortcut Dimension 2 Code");
        LoanLedgEntry.INSERT;
    end;
    local procedure GetNextLoanEntryNo()
    var
        LoanLedgerEntry: Record "Loan Ledger Entry-Payroll";
    begin
        LoanLedgerEntry.LOCKTABLE;
        IF LoanLedgerEntry.FINDLAST THEN LoanLedgEntryNo:=LoanLedgerEntry."Entry No." + 1
        ELSE
            LoanLedgEntryNo:=1;
    end;
    procedure InitLoanRepayment(var LoanRec: Record "Loan Application")
    var
        LoanRepayment: Record "Loan Repayment-Payroll";
        EndDate: date;
    begin
        LoanRepayment.INIT;
        LoanRepayment."Loan No.":=LoanRec."Loan No";
        LoanRepayment."Start Date":=LoanRec."Issued Date";
        LoanRepayment."End Date":=CALCDATE('-1M', CALCDATE((FORMAT(LoanRec.Instalment) + 'M'), LoanRec."Issued Date"));
        LoanRepayment."No. of Periods":=LoanRec.Instalment;
        LoanRepayment."Customer No.":=LoanRec."Debtors Code";
        LoanRepayment."Repayment Amount":=LoanRec.Repayment;
        IF NOT LoanRepayment.GET(LoanRepayment."Loan No.", LoanRepayment."Start Date")THEN LoanRepayment.INSERT
        ELSE
        BEGIN
            LoanRepayment.INIT;
            LoanRepayment."Loan No.":=LoanRec."Loan No";
            LoanRepayment."Start Date":=LoanRec."Issued Date";
            LoanRepayment."End Date":=CALCDATE('-1M', CALCDATE((FORMAT(LoanRec.Instalment) + 'M'), LoanRec."Issued Date"));
            LoanRepayment."No. of Periods":=LoanRec.Instalment;
            LoanRepayment."Customer No.":=LoanRec."Debtors Code";
            LoanRepayment."Repayment Amount":=LoanRec.Repayment;
            LoanRepayment.MODIFY;
        END;
    end;
    // increment salary code 
    procedure IncrementEmployeeSalary(EmployeeNo: code[20]; PayrollPeriod: Date /* ; var NextScale: Code[10]; var NextPointer: Code[10] */)
    var
        Employee: Record Employee;
        SalaryScale: Record "Salary Scale";
        SalaryPointer: Record "Salary Pointer";
        HRSetup: Record "Human Resources Setup";
        SalaryIncrement: Record "Employee Salary Increment";
        CurrentScale: Code[10];
        CurrentPointer: Code[10];
        NextScale: Code[10];
        NextPointer: Code[10];
        IncrementDate: Date;
        CurrentSalary: Decimal;
        NextSalary: Decimal;
        Increment: boolean;
        Months: text;
        FirstMonth: Integer;
        FourthMonth: Integer;
        SeventhMonth: Integer;
        TenthMonth: Integer;
        Text001: Label 'There is no salary pointer set for salary scale %1.';
        Text002: Label 'Employee %1 has the last salary scale %2 and salary pointer %3. To increment salary, add more pointers or a salary scale.';
    begin
        HRSetup.Get();
        HRSetup.TestField("Paid Months Before Increament");
        Employee.SetRange("No.", EmployeeNo);
        Employee.SetRange("Employment Status", Employee."Employment Status"::Active);
        If Employee.FindFirst()then begin
            Employee.TestField("Employment Date");
            Employee.TestField("Salary Scale");
            Employee.TestField(Present);
            Employee.Validate(Present);
            Employee.Modify();
        end;
        Months:=Format(HRSetup."Paid Months Before Increament") + 'M';
        IncrementDate:=CalcDate(Months, Employee."Employment Date");
        if SalaryIncrement.Get(EmployeeNo, PayrollPeriod)then exit;
        //increment in the next month if date is greater than 1
        if Date2DMY(IncrementDate, 1) > 1 then IncrementDate:=CalcDate('-cm', IncrementDate);
        FirstMonth:=Date2DMY(IncrementDate, 2);
        case FirstMonth of 10: FourthMonth:=1;
        11: FourthMonth:=2;
        12: FourthMonth:=3;
        else
            FourthMonth:=FirstMonth + 3;
        end;
        case FourthMonth of 10: SeventhMonth:=1;
        11: SeventhMonth:=2;
        12: SeventhMonth:=3;
        else
            SeventhMonth:=FourthMonth + 3;
        end;
        case SeventhMonth of 10: TenthMonth:=1;
        11: TenthMonth:=2;
        12: TenthMonth:=3;
        else
            TenthMonth:=SeventhMonth + 3;
        end;
        if HRSetup."Increment Annually" then begin
            if Date2DMY(PayrollPeriod, 2) = FirstMonth then if PayrollPeriod = IncrementDate then Increment:=true;
        end
        else if HRSetup."Increment Semi-Annually" then begin
                if(Date2DMY(PayrollPeriod, 2) = FirstMonth) or (Date2DMY(PayrollPeriod, 2) = SeventhMonth)then if PayrollPeriod = IncrementDate then Increment:=true;
            end
            else if HRSetup."Increment Quarterly" then begin
                    if(Date2DMY(PayrollPeriod, 2) = FirstMonth) or (Date2DMY(PayrollPeriod, 2) = 4) or (Date2DMY(PayrollPeriod, 2) = SeventhMonth) or (Date2DMY(PayrollPeriod, 2) = TenthMonth)then if PayrollPeriod = IncrementDate then Increment:=true;
                end;
        if not Increment then exit;
        SalaryPointer.Reset();
        SalaryPointer.SetCurrentKey(Priority);
        SalaryPointer.SetRange("Salary Scale", Employee."Salary Scale");
        if SalaryPointer.FindFirst()then repeat SalaryPointer.TestField(Priority);
                if SalaryPointer."Salary Pointer" = Employee.Present then CurrentPointer:=SalaryPointer."Salary Pointer"
                else
                begin
                    if CurrentPointer <> '' then begin
                        NextScale:=Employee."Salary Scale";
                        NextPointer:=SalaryPointer."Salary Pointer";
                    end;
                end;
            until(SalaryPointer.Next() = 0) or (NextPointer <> '');
        if NextPointer = '' then begin
            SalaryScale.Reset();
            SalaryScale.SetCurrentKey(Priority);
            if SalaryScale.FindFirst()then repeat SalaryScale.TestField(Priority);
                    if SalaryScale.Scale = Employee."Salary Scale" then CurrentScale:=SalaryScale.Scale
                    else
                    begin
                        if CurrentScale <> '' then NextScale:=SalaryScale.Scale;
                    end;
                until(SalaryScale.Next() = 0) or (NextScale <> '');
            if NextScale <> '' then begin
                SalaryPointer.Reset();
                SalaryPointer.SetRange("Salary Scale", NextScale);
                if SalaryPointer.FindFirst()then NextPointer:=SalaryPointer."Salary Pointer"
                else
                    Error(Text001, NextScale);
            end
            else
                Error(Text002, EmployeeNo, CurrentScale, CurrentPointer);
        end;
        CurrentSalary:=GetCurrentSalary(EmployeeNo, CalcDate('-1M', PayrollPeriod));
        UpdatePointers(EmployeeNo, PayrollPeriod, NextScale, NextPointer, CurrentSalary, NextSalary);
        UpdateEarnings(EmployeeNo, PayrollPeriod, NextScale, NextPointer);
        Employee.Previous:=CurrentPointer;
        Employee."Salary Scale":=NextScale;
        Employee.Present:=NextPointer;
        Employee.Validate(Present);
        Employee.Modify();
    end;
    procedure UpdatePointers(EmployeeNo: code[20]; PayrollPeriod: Date; NextScale: Code[10]; NextPointer: Code[10]; CurrentSalary: Decimal; NextSalary: Decimal)
    var
        Employee: Record Employee;
        SalaryIncrement: Record "Employee Salary Increment";
    begin
        Employee.Get(EmployeeNo);
        SalaryIncrement.Reset();
        if not SalaryIncrement.Get(EmployeeNo, PayrollPeriod)then begin
            SalaryIncrement.Init;
            SalaryIncrement."Employee No.":=EmployeeNo;
            SalaryIncrement."Payroll Period":=PayrollPeriod;
            SalaryIncrement."Previous Salary":=CurrentSalary;
            SalaryIncrement."Previous Salary Scale":=Employee."Salary Scale";
            SalaryIncrement."Previous Salary Pointer":=Employee.Present;
            SalaryIncrement."Current Salary":=NextSalary;
            SalaryIncrement."Current Salary Scale":=NextScale;
            SalaryIncrement."Current Salary Pointer":=NextPointer;
            SalaryIncrement."Created By":=UserId;
            SalaryIncrement."Date Created":=Today;
            SalaryIncrement.Insert;
        end;
    end;
    procedure UpdateEarnings(EmployeeNo: code[20]; PayrollPeriod: Date; NextScale: Code[10]; NextPointer: Code[10])
    var
        AssignMatrix: Record "Assignment Matrix-X";
        ScaleBenefits: Record "Scale Benefits";
    begin
        Earnings.Reset;
        if Earnings.Find('-')then repeat if ScaleBenefits.Get(NextScale, NextPointer, Earnings.Code)then begin
                    AssignMatrix.Reset;
                    AssignMatrix.SetRange(AssignMatrix.Code, Earnings.Code);
                    AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Payment);
                    AssignMatrix.SetRange(AssignMatrix."Employee No", EmployeeNo);
                    AssignMatrix.SetRange(AssignMatrix."Payroll Period", PayrollPeriod);
                    if AssignMatrix.Find('-')then begin
                        AssignMatrix.Amount:=ScaleBenefits.Amount;
                        if AssignMatrix."Manual Entry" = false then AssignMatrix.Modify;
                    end
                    else
                    begin
                        AssignMatrix.Init;
                        AssignMatrix."Employee No":=EmployeeNo;
                        AssignMatrix.Type:=AssignMatrix.Type::Payment;
                        AssignMatrix.Code:=Earnings.Code;
                        AssignMatrix.Validate(AssignMatrix.Code);
                        AssignMatrix."Payroll Period":=PayrollPeriod;
                        AssignMatrix.Amount:=ScaleBenefits.Amount;
                        AssignMatrix."Manual Entry":=false;
                        AssignMatrix.Insert;
                    end;
                end;
            until Earnings.Next = 0;
    end;
    procedure GetCurrentSalary(EmployeeNo: code[20]; PayrollPeriod: Date)Salary: Decimal var
        Employee: Record Employee;
    begin
        Employee.Get(EmployeeNo);
        Employee.SetRange("Pay Period Filter", PayrollPeriod);
        Employee.CalcFields("Total Allowances", "Total Deductions");
        Salary:=Employee."Total Allowances" + Employee."Total Deductions";
    end;
    procedure UpdateSalaryIncrement(EmployeeNo: code[20]; PayrollPeriod: Date)
    var
        SalaryIncrement: Record "Employee Salary Increment";
    begin
        if SalaryIncrement.Get(Employee."No.", PayrollPeriod)then begin
            SalaryIncrement."Current Salary":=GetCurrentSalary(EmployeeNo, PayrollPeriod);
            SalaryIncrement.Modify();
        end;
    end;
}

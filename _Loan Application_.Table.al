table 50366 "Loan Application"
{
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Loan No" <> xRec."Loan No" then begin
                    HRsetup.Get;
                    case "Transaction Type" of "Transaction Type"::"Loan Application": begin
                        NoSeriesMgt.TestManual(HRsetup."Loan App No");
                        "No Series":='';
                    end;
                    "Transaction Type"::"Loan Settlement": begin
                    //NoSeriesMgt.TestManual(HRsetup."Secondary PAYE %");
                    end;
                    end;
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Product Type".Code;

            trigger OnValidate()
            begin
                if LoanType.Get("Loan Product Type")then begin
                    "Interest Deduction Code":=LoanType."Interest Deduction Code";
                    "Deduction Code":=LoanType."Deduction Code";
                    Description:=LoanType.Description;
                    "Interest Rate":=LoanType."Interest Rate";
                    Instalment:=LoanType."No of Instalment";
                    "Interest Calculation Method":=LoanType."Interest Calculation Method";
                end;
            end;
        }
        field(4; "Amount Requested"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Approved Amount":="Amount Requested";
                Validate("Approved Amount");
            end;
        }
        field(5; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if LoanType.Get("Loan Product Type")then begin
                    if LoanType.Rounding = LoanType.Rounding::Up then RoundingPrecision:='>'
                    else if LoanType.Rounding = LoanType.Rounding::Nearest then RoundingPrecision:='='
                        else if LoanType.Rounding = LoanType.Rounding::Down then RoundingPrecision:='<';
                end;
                if "Interest Calculation Method" = "Interest Calculation Method"::" " then Error('Interest Calculation method can only be Balance');
                // Installments := Instalment;
                if Installments2 <= 0 then Error('Number of installments must be greater than Zero!');
                if LoanType.Get("Loan Product Type")then begin
                    if "Interest Calculation Method" in["Interest Calculation Method"::Amortised]then begin
                        Repayment:=Round(("Interest Rate" / 12 / 100) / (1 - Power((1 + ("Interest Rate" / 12 / 100)), -Installments2)) * "Approved Amount", LoanType."Rounding Precision", RoundingPrecision);
                    end;
                end;
                //Sacco Loan Reducing balance
                //Principal Repayment is calculated as straight line
                //Monthly Interest is based on the balance
                //Monthly Repayment is based on the principal repayment + monthly interest
                if LoanType.Get("Loan Product Type")then begin
                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then begin
                        Repayment:=Round("Approved Amount" / Installments2, LoanType."Rounding Precision", RoundingPrecision);
                    end;
                end;
                if "Interest Calculation Method" = "Interest Calculation Method"::"Flat Rate" then begin
                    Repayment:=Round(("Approved Amount" / Installments2) + FlatRateCalc("Approved Amount", Interest), LoanType."Rounding Precision", RoundingPrecision);
                    "Flat Rate Interest":=Round(FlatRateCalc("Approved Amount", "Interest Rate"), LoanType."Rounding Precision", RoundingPrecision);
                    "Flat Rate Principal":=Repayment;
                end
                else
                begin
                    "Flat Rate Interest":=0;
                    "Flat Rate Principal":=0;
                end;
                "Approved Amount":=Abs("Approved Amount");
            end;
        }
        field(6; "Loan Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Application,Being Processed,Rejected,Approved,Issued,Being Repaid,Repaid';
            OptionMembers = Application, "Being Processed", Rejected, Approved, Issued, "Being Repaid", Repaid;
        }
        field(7; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Employee Type"=FILTER(Permanent|Contract|Trustee), "Loan Customer Type"=CONST(Staff))"Payroll PeriodX"
            ELSE IF("Employee Type"=CONST("Part Time"), "Loan Customer Type"=CONST(Staff))"Payroll Period Casuals"
            ELSE IF("Loan Customer Type"=CONST("External Customer"))"Accounting Period";
        }
        field(8; Instalment; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Loan Product Type");
                if LoanType.Get("Loan Product Type")then begin
                    if Instalment > LoanType."No of Instalment" then Error('Installments cannot exceed the maximum number of installments of %1', LoanType."No of Instalment");
                end;
                if "Approved Amount" <> 0 then Validate("Approved Amount");
            end;
        }
        field(9; Repayment; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 4;
        }
        field(10; "Flat Rate Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Flat Rate Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Flat Rate,Reducing Balance,Amortised';
            OptionMembers = " ", "Flat Rate", "Reducing Balance", Amortised;

            trigger OnValidate()
            begin
                if "Approved Amount" <> 0 then Validate("Approved Amount");
            end;
        }
        field(15; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Loan Customer Type"=CONST(Staff))Employee."No."
            ELSE IF("Loan Customer Type"=CONST("External Customer"))Customer."No." WHERE("Customer Posting Group"=CONST('SLOANS'));

            trigger OnValidate()
            begin
                case "Loan Customer Type" of "Loan Customer Type"::Staff: begin
                    if EmpRec.Get("Employee No")then begin
                        "Employee Name":=EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                        "Payroll Group":=EmpRec."Posting Group";
                        "Employee Type":=EmpRec."Employment Type";
                        EmpRec.TestField("Debtor Code");
                        "Debtors Code":=EmpRec."Debtor Code";
                    end;
                end;
                "Loan Customer Type"::"External Customer": begin
                    if Customer.Get("Employee No")then "Employee Name":=Customer.Name;
                end;
                end;
            end;
        }
        field(16; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Payroll Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Posting GroupX".Code;
        }
        field(18; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Opening Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(20; "Total Repayment"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No"), Type=CONST(Deduction), Code=FIELD("Deduction Code"), "Payroll Period"=FIELD(UPPERLIMIT("Date filter")), "Reference No"=FIELD("Loan No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(22; "Period Repayment"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No"), Type=CONST(Deduction), Code=FIELD("Deduction Code"), "Payroll Period"=FIELD(UPPERLIMIT("Date filter")), "Reference No"=FIELD("Loan No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; Interest; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Interest Imported"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "principal imported"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Interest Rate Per"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Annum, Monthly;
        }
        field(27; "Reference No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Interest Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(29; "Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(30; "Debtors Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(31; "Interest Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No"), Type=CONST(Deduction), Code=FIELD("Interest Deduction Code"), "Payroll Period"=FIELD(UPPERLIMIT("Date filter")), "Reference No"=FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(32; "External Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Receipts; Decimal)
        {
            CalcFormula = Sum("Non Payroll Receipts".Amount WHERE("Loan No"=FIELD("Loan No"), "Receipt Date"=FIELD("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "HELB No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "University Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Stop Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Interest Repaid"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Loan Interest" WHERE("Employee No"=FIELD("Employee No"), Type=CONST(Deduction), Code=FIELD("Deduction Code"), "Payroll Period"=FIELD(UPPERLIMIT("Date filter")), "Reference No"=FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(38; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Contract,Permanent,Trustee,Attachee,Intern,Part Time';
            OptionMembers = Contract, Permanent, Trustee, Attachee, Intern, "Part Time";
        }
        field(39; "Paying Bank"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if Banks.Get("Paying Bank")then "Bank Name":=Banks.Name;
            end;
        }
        field(40; "Bank Name"; Text[100])
        {
            FieldClass = Normal;
        }
        field(41; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Shortcut Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(43; "Shortcut Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(44; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Last Interest Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Monthly,Quaterly,Semi-Annually,Annually,Biennial';
            OptionMembers = Monthly, Quaterly, "Semi-Annually", Annually, Biennial;
        }
        field(48; Rescheduled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Rescheduled By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Date Rescheduled"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Reschedule Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Loan Reschedule Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Suggested Repayment Amount"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Suggested:=false;
                if "Suggest Repayment Amount" then begin
                    if "Suggested Repayment Amount" <> 0 then "Suggested Installments":=Round(("Amount Requested" / "Suggested Repayment Amount"), 1, '>')
                    else
                        "Suggested Installments":=0;
                end;
            end;
        }
        field(54; "Suggested Installments"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Suggested:=false;
            end;
        }
        field(55; "Suggest Repayment Amount"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Suggested:=false;
            end;
        }
        field(56; Suggested; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Reschedule Amount Suggested"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Resch Suggested Instalments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Resch Suggested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Suggest Reschedule Amount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Application,Loan Settlement';
            OptionMembers = " ", "Loan Application", "Loan Settlement";
        }
        field(62; "Loan Balance"; Decimal)
        {
            CalcFormula = Sum("Loan Ledger Entry-Payroll".Amount WHERE("Loan No."=FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(63; "Loan Repayments"; Decimal)
        {
            CalcFormula = -Sum("Loan Ledger Entry-Payroll".Amount WHERE("Loan No."=FIELD("Loan No"), "Transaction Type"=FILTER("Principal Repayment"|Settlement)));
            FieldClass = FlowField;
        }
        field(64; "Settlement Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Partial Settlement,Full Settlement';
            OptionMembers = " ", "Partial Settlement", "Full Settlement";

            trigger OnValidate()
            begin
                Validate("Loan Application No.");
            end;
        }
        field(65; "Loan Application No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Application" WHERE("Transaction Type"=FILTER("Loan Application"), "Employee No"=FIELD("Employee No"));

            trigger OnValidate()
            begin
                if LoanApp.Get("Loan Application No.")then begin
                    case "Transaction Type" of "Transaction Type"::"Loan Settlement": begin
                        LoanApp.CalcFields("Loan Balance", "Loan Repayments", "Total Repayment", "Period Repayment");
                        "Approved Amount":=LoanApp."Approved Amount";
                        "Loan Balance":=LoanApp."Approved Amount" + LoanApp."Total Repayment";
                        "Loan Repayments":=LoanApp."Total Repayment";
                        case "Settlement Type" of "Settlement Type"::"Full Settlement": begin
                            "Settlement Amount":=LoanApp."Approved Amount" - LoanApp."Total Repayment";
                        end;
                        "Settlement Type"::"Partial Settlement": begin
                        end;
                        end;
                    end;
                    end;
                end;
            end;
        }
        field(66; "Settlement Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Payment Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Bank Account,Cash,Cheque,EFT,RTGS,MPESA,PDQ';
            OptionMembers = "G/L Account", "Bank Account", Cash, Cheque, EFT, RTGS, MPESA, PDQ;
        }
        field(68; "Payment Refrence No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Initial Instalments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Payment Ref No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(73; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(74; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Date-Time Reversed"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Loan Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Staff,External Customer';
            OptionMembers = Staff, "External Customer";
        }
        field(78; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Customer.Get("Customer Code")then "Customer Name":=Customer.Name;
            end;
        }
        field(79; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Schedule Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Next Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(82; Repayment2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Installments2"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Instalment:=Round(Installments2, 2, '=');
                TestField("Loan Product Type");
                if LoanType.Get("Loan Product Type")then begin
                    if Instalment > LoanType."No of Instalment" then Error('Installments cannot exceed the maximum number of installments of %1', LoanType."No of Instalment");
                end;
                if "Approved Amount" <> 0 then Validate("Approved Amount");
            end;
        }
    }
    keys
    {
        key(Key1; "Loan No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        HRsetup.Get;
        if "Loan No" = '' then begin
            case "Transaction Type" of "Transaction Type"::"Loan Application": begin
                HRsetup.TestField("Loan App No");
                NoSeriesMgt.InitSeries(HRsetup."Loan App No", xRec."No Series", 0D, "Loan No", "No Series");
                InsertUserAccount;
            end;
            "Transaction Type"::"Loan Settlement": begin
                HRsetup.TestField("Secondary PAYE %");
            //NoSeriesMgt.InitSeries(HRsetup."Secondary PAYE %",xRec."No Series",TODAY,"Loan No","No Series");
            end;
            end;
        end;
        "User ID":=UserId;
        "Application Date":=today;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    HRsetup: Record "Human Resources Setup";
    LoanType: Record "Loan Product Type";
    EmpRec: Record Employee;
    PeriodInterest: Decimal;
    Installments: Decimal;
    NewSchedule: Record "Repayment Schedule";
    RunningDate: Date;
    Interest: Decimal;
    FlatPeriodInterest: Decimal;
    FlatRateTotalInterest: Decimal;
    FlatPeriodInterval: Code[10];
    LineNoInt: Integer;
    RemainingPrincipalAmountDec: Decimal;
    AssMatrix: Record "Assignment Matrix-X";
    RoundingPrecision: Text[30];
    Banks: Record "Bank Account";
    LoanType2: Record "Loan Product Type";
    LoanApp: Record "Loan Application";
    Customer: Record Customer;
    NoUserAcc: Label 'You do not have a user account. Please contact the system administrator.';
    procedure DebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal var
        PeriodInterest: Decimal;
    begin
        //PeriodInterval:=
        //EVALUATE(PeriodInterval,FORMAT("Instalment Period"));
        //1M
        //IF PeriodInterval='1M' THEN
        PeriodInterest:=Interest / 12 / 100;
        exit(PeriodInterest / (1 - Power((1 + PeriodInterest), -PayPeriods)) * Principal);
    /*
         //1W
        IF PeriodInterval='1W' THEN
         PeriodInterest:= Interest / 52 / 100;
         //2W
        IF PeriodInterval='2W' THEN
         PeriodInterest:= Interest / 26 / 100;
         //1Q
        IF PeriodInterval='1Q' THEN
         PeriodInterest:= Interest / 4 / 100;
        
        
        */
    end;
    procedure CreateAnnuityLoan()
    var
        LoanEntryRec: Record "Loan Application";
        LoanTypeRec: Record "Loan Product Type";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
        MonthlyRepayment: Decimal;
    begin
        //Loan Applic. No.,Group Code,Client Code,Loan no
        Installments:=Instalment;
        if Installments <= 0 then Error('Instalment Amount must be specified');
        LoopEndBool:=false;
        LineNoInt:=0;
        LoanTypeRec.Get("Loan Product Type");
        case LoanTypeRec.Rounding of LoanTypeRec.Rounding::Nearest: RoundDirectionCode:='=';
        LoanTypeRec.Rounding::Down: RoundDirectionCode:='<';
        LoanTypeRec.Rounding::Up: RoundDirectionCode:='>';
        end;
        RoundPrecisionDec:=LoanTypeRec."Rounding Precision";
        RemainingPrincipalAmountDec:="Approved Amount";
        RunningDate:="Issued Date";
        repeat InterestAmountDec:=Round(RemainingPrincipalAmountDec / 100 / 12 * LoanTypeRec."Interest Rate", RoundPrecisionDec, RoundDirectionCode);
            if InterestAmountDec >= Repayment then Error('This Loan is not possible because\the the instalment Amount must\be higher than %1', InterestAmountDec);
            LineNoInt:=LineNoInt + 1;
            NewSchedule."Instalment No":=LineNoInt;
            NewSchedule."Loan Customer Type":="Loan Customer Type";
            NewSchedule."Employee No":="Employee No";
            NewSchedule."Loan No":="Loan No";
            NewSchedule."Repayment Date":=RunningDate;
            NewSchedule."Monthly Interest":=InterestAmountDec;
            if not Suggested then NewSchedule."Monthly Repayment":=Repayment
            else
                NewSchedule."Monthly Repayment":="Suggested Repayment Amount";
            NewSchedule."Loan Category":="Loan Product Type";
            NewSchedule."Loan Amount":="Approved Amount";
            // Area to be looked at
            if LineNoInt = Installments then begin
                NewSchedule."Remaining Debt":=0;
                NewSchedule."Monthly Repayment":=RemainingPrincipalAmountDec + NewSchedule."Monthly Interest";
                NewSchedule."Principal Repayment":=NewSchedule."Monthly Repayment" - NewSchedule."Monthly Interest";
                LoopEndBool:=true;
            end;
            if(Repayment - InterestAmountDec) >= RemainingPrincipalAmountDec then begin
                NewSchedule."Principal Repayment":=RemainingPrincipalAmountDec;
                NewSchedule."Remaining Debt":=0;
                LoopEndBool:=true;
            end
            else
            begin
                NewSchedule."Principal Repayment":=Repayment - InterestAmountDec;
                RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - (Repayment - InterestAmountDec);
                NewSchedule."Remaining Debt":=RemainingPrincipalAmountDec;
            end;
            NewSchedule."Loan Deduction Code":="Deduction Code";
            NewSchedule."Loan Interest Code":="Interest Deduction Code";
            NewSchedule.Insert;
            RunningDate:=CalcDate('1M', RunningDate)until LoopEndBool;
        Message('Schedule Created');
    end;
    procedure FlatRateCalc(var FlatLoanAmount: Decimal; var FlatInterestRate: Decimal)FlatRateCalc: Decimal begin
        //FlatPeriodInterval:=
        //EVALUATE(FlatPeriodInterval,FORMAT("Instalment Period"));
        //1M
        //IF FlatPeriodInterval='1M' THEN
        FlatPeriodInterest:=FlatLoanAmount * FlatInterestRate / 100;
        FlatRateCalc:=FlatPeriodInterest;
    /*
         //1W
        
        IF FlatPeriodInterval='1W' THEN
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/52;
         //2W
        IF FlatPeriodInterval='2W' THEN
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/26;
         //1Q
        IF FlatPeriodInterval='1Q' THEN
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/4;
        */
    end;
    procedure CreateFlatRateSchedule()
    begin
        // Flat Rate
        LineNoInt:=1;
        Installments:=Instalment;
        if "Interest Calculation Method" = "Interest Calculation Method"::"Flat Rate" then begin
            RunningDate:="Issued Date";
            RemainingPrincipalAmountDec:="Approved Amount";
            if LineNoInt < Installments + 1 then begin
                repeat NewSchedule."Instalment No":=LineNoInt;
                    NewSchedule."Loan Customer Type":="Loan Customer Type";
                    NewSchedule."Employee No":="Employee No";
                    NewSchedule."Loan No":="Loan No";
                    NewSchedule."Repayment Date":=RunningDate;
                    NewSchedule."Monthly Interest":="Flat Rate Interest" / 12;
                    NewSchedule."Monthly Repayment":=Repayment;
                    NewSchedule."Loan Category":="Loan Product Type";
                    NewSchedule."Loan Amount":="Approved Amount";
                    if not Suggested then NewSchedule."Principal Repayment":="Flat Rate Principal"
                    else
                        NewSchedule."Principal Repayment":="Suggested Repayment Amount";
                    if not Suggested then begin
                        if LineNoInt = 1 then RemainingPrincipalAmountDec:="Approved Amount" - Repayment
                        else
                            RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - Repayment;
                    end
                    else
                    begin
                        if LineNoInt = 1 then RemainingPrincipalAmountDec:="Approved Amount" - "Suggested Repayment Amount"
                        else
                            RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - "Suggested Repayment Amount";
                    end;
                    NewSchedule."Remaining Debt":=RemainingPrincipalAmountDec;
                    NewSchedule."Instalment No":=LineNoInt;
                    NewSchedule."Loan Deduction Code":="Deduction Code";
                    NewSchedule."Loan Interest Code":="Interest Deduction Code";
                    NewSchedule.Insert;
                    LineNoInt:=LineNoInt + 1;
                    RunningDate:=CalcDate('CD+1M', RunningDate);
                until LineNoInt > Installments end;
        end;
        Message('Schedule Created');
    end;
    procedure CreateSaccoReducing()
    var
        LoanEntryRec: Record "Loan Application";
        LoanTypeRec: Record "Loan Product Type";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        //Loan Applic. No.,Group Code,Client Code,Loan no
        //Installments := Instalment;
        if Installments2 <= 0 then Error('Instalment Amount must be specified');
        LoopEndBool:=false;
        LineNoInt:=0;
        LoanTypeRec.Get("Loan Product Type");
        case LoanTypeRec.Rounding of LoanTypeRec.Rounding::Nearest: RoundDirectionCode:='=';
        LoanTypeRec.Rounding::Down: RoundDirectionCode:='<';
        LoanTypeRec.Rounding::Up: RoundDirectionCode:='>';
        end;
        RoundPrecisionDec:=LoanTypeRec."Rounding Precision";
        RemainingPrincipalAmountDec:="Approved Amount";
        RunningDate:="Issued Date";
        repeat InterestAmountDec:=Round(RemainingPrincipalAmountDec / 100 / 12 * "Interest Rate", RoundPrecisionDec, RoundDirectionCode);
            if InterestAmountDec >= Repayment then Error('This Loan is not possible because\the the instalment Amount must\be higher than %1', InterestAmountDec);
            //
            LineNoInt:=LineNoInt + 1;
            NewSchedule."Instalment No":=LineNoInt;
            NewSchedule."Loan Customer Type":="Loan Customer Type";
            NewSchedule."Employee No":="Employee No";
            NewSchedule."Loan No":="Loan No";
            NewSchedule."Repayment Date":=RunningDate;
            NewSchedule."Monthly Interest":=InterestAmountDec;
            if not Suggested then NewSchedule."Monthly Repayment":=Repayment + InterestAmountDec
            else
                NewSchedule."Monthly Repayment":="Suggested Repayment Amount" + InterestAmountDec;
            NewSchedule."Loan Category":="Loan Product Type";
            NewSchedule."Loan Amount":="Approved Amount";
            // Area to be looked at
            if LineNoInt = Installments then begin
                NewSchedule."Remaining Debt":=0;
                NewSchedule."Monthly Repayment":=RemainingPrincipalAmountDec + NewSchedule."Monthly Interest";
                if not Suggested then NewSchedule."Principal Repayment":=NewSchedule."Monthly Repayment" - NewSchedule."Monthly Interest"
                else
                    NewSchedule."Principal Repayment":="Suggested Repayment Amount" - NewSchedule."Monthly Interest";
                LoopEndBool:=true;
            end;
            if(Repayment - InterestAmountDec) >= RemainingPrincipalAmountDec then begin
                NewSchedule."Principal Repayment":=RemainingPrincipalAmountDec;
                NewSchedule."Remaining Debt":=0;
                LoopEndBool:=true;
            end
            else
            begin
                if not Suggested then NewSchedule."Principal Repayment":=Repayment
                else
                    NewSchedule."Principal Repayment":="Suggested Repayment Amount";
                if not Suggested then RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - Repayment
                else
                    RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - "Suggested Repayment Amount";
                NewSchedule."Remaining Debt":=RemainingPrincipalAmountDec;
            end;
            NewSchedule."Loan Deduction Code":="Deduction Code";
            NewSchedule."Loan Interest Code":="Interest Deduction Code";
            NewSchedule.Insert;
            RunningDate:=CalcDate('1M', RunningDate)until LoopEndBool;
        // Installments := Instalment;
        // if Installments <= 0 then
        //     Error('Instalment Amount must be specified');
        // LoopEndBool := false;
        // LineNoInt := 0;
        // LoanTypeRec.Get("Loan Product Type");
        // case LoanTypeRec.Rounding of
        //     LoanTypeRec.Rounding::Nearest:
        //         RoundDirectionCode := '=';
        //     LoanTypeRec.Rounding::Down:
        //         RoundDirectionCode := '<';
        //     LoanTypeRec.Rounding::Up:
        //         RoundDirectionCode := '>';
        // end;
        // RoundPrecisionDec := LoanTypeRec."Rounding Precision";
        // RemainingPrincipalAmountDec := "Approved Amount";
        // RunningDate := "Issued Date";
        // repeat
        //     InterestAmountDec := Round(RemainingPrincipalAmountDec / 100 / 12 * "Interest Rate", RoundPrecisionDec, RoundDirectionCode);
        //     if InterestAmountDec >= Repayment then
        //         Error('This Loan is not possible because\the the instalment Amount must\be higher than %1', InterestAmountDec);
        //     //
        //     LineNoInt := LineNoInt + 1;
        //     NewSchedule."Instalment No" := LineNoInt;
        //     NewSchedule."Loan Customer Type" := "Loan Customer Type";
        //     NewSchedule."Employee No" := "Employee No";
        //     NewSchedule."Loan No" := "Loan No";
        //     NewSchedule."Repayment Date" := RunningDate;
        //     NewSchedule."Monthly Interest" := InterestAmountDec;
        //     if not Suggested then
        //         NewSchedule."Monthly Repayment" := Repayment + InterestAmountDec
        //     else
        //         NewSchedule."Monthly Repayment" := "Suggested Repayment Amount" + InterestAmountDec;
        //     NewSchedule."Loan Category" := "Loan Product Type";
        //     NewSchedule."Loan Amount" := "Approved Amount";
        //     // Area to be looked at
        //     if LineNoInt = Installments then begin
        //         NewSchedule."Remaining Debt" := 0;
        //         NewSchedule."Monthly Repayment" := RemainingPrincipalAmountDec + NewSchedule."Monthly Interest";
        //         if not Suggested then
        //             NewSchedule."Principal Repayment" := NewSchedule."Monthly Repayment" - NewSchedule."Monthly Interest"
        //         else
        //             NewSchedule."Principal Repayment" := "Suggested Repayment Amount" - NewSchedule."Monthly Interest";
        //         LoopEndBool := true;
        //     end;
        //     if (Repayment - InterestAmountDec) >= RemainingPrincipalAmountDec then begin
        //         NewSchedule."Principal Repayment" := RemainingPrincipalAmountDec;
        //         NewSchedule."Remaining Debt" := 0;
        //         LoopEndBool := true;
        //     end else begin
        //         if not Suggested then
        //             NewSchedule."Principal Repayment" := Repayment
        //         else
        //             NewSchedule."Principal Repayment" := "Suggested Repayment Amount";
        //         if not Suggested then
        //             RemainingPrincipalAmountDec := RemainingPrincipalAmountDec - Repayment
        //         else
        //             RemainingPrincipalAmountDec := RemainingPrincipalAmountDec - "Suggested Repayment Amount";
        //         NewSchedule."Remaining Debt" := RemainingPrincipalAmountDec;
        //     end;
        //     NewSchedule."Loan Deduction Code" := "Deduction Code";
        //     NewSchedule."Loan Interest Code" := "Interest Deduction Code";
        //     NewSchedule.Insert;
        //     RunningDate := CalcDate('1M', RunningDate)
        // until LoopEndBool;
        Message('Schedule Created');
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    procedure CreateAmortizedLoan()
    var
        LoanEntryRec: Record "Loan Application";
        LoanTypeRec: Record "Loan Product Type";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        //Loan Applic. No.,Group Code,Client Code,Loan no
        Installments:=Instalment;
        if Installments <= 0 then Error('Instalment Amount must be specified');
        //IF  Repayment> "Approved Amount" THEN
        //  ERROR('Instalment Amount is higher than Principal');
        LoopEndBool:=false;
        LineNoInt:=0;
        LoanTypeRec.Get("Loan Product Type");
        case LoanTypeRec.Rounding of LoanTypeRec.Rounding::Nearest: RoundDirectionCode:='=';
        LoanTypeRec.Rounding::Down: RoundDirectionCode:='<';
        LoanTypeRec.Rounding::Up: RoundDirectionCode:='>';
        end;
        RoundPrecisionDec:=LoanTypeRec."Rounding Precision";
        //
        //EVALUATE(GP,FORMAT("Grace Period"));
        //
        RemainingPrincipalAmountDec:="Approved Amount";
        RunningDate:="Issued Date";
        repeat InterestAmountDec:=Round(RemainingPrincipalAmountDec / 100 / 12 * "Interest Rate", RoundPrecisionDec, RoundDirectionCode);
            if InterestAmountDec >= Repayment then Error('This Loan is not possible because\the the instalment Amount must\be higher than %1', InterestAmountDec);
            //
            LineNoInt:=LineNoInt + 1;
            NewSchedule."Instalment No":=LineNoInt;
            NewSchedule."Loan Customer Type":="Loan Customer Type";
            NewSchedule."Employee No":="Employee No";
            NewSchedule."Loan No":="Loan No";
            NewSchedule."Repayment Date":=RunningDate;
            NewSchedule."Monthly Interest":=InterestAmountDec;
            if not Suggested then NewSchedule."Monthly Repayment":=Repayment
            else
                NewSchedule."Monthly Repayment":="Suggested Repayment Amount";
            NewSchedule."Loan Category":="Loan Product Type";
            NewSchedule."Loan Amount":="Approved Amount";
            // Area to be looked at
            if LineNoInt = Installments then begin
                NewSchedule."Remaining Debt":=0;
                NewSchedule."Monthly Repayment":=RemainingPrincipalAmountDec + NewSchedule."Monthly Interest";
                NewSchedule."Principal Repayment":=NewSchedule."Monthly Repayment" - NewSchedule."Monthly Interest";
                LoopEndBool:=true;
            end;
            if(Repayment - InterestAmountDec) >= RemainingPrincipalAmountDec then begin
                NewSchedule."Principal Repayment":=RemainingPrincipalAmountDec;
                NewSchedule."Remaining Debt":=0;
                LoopEndBool:=true;
            end
            else
            begin
                NewSchedule."Principal Repayment":=Repayment - InterestAmountDec;
                RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - (Repayment - InterestAmountDec);
                NewSchedule."Remaining Debt":=RemainingPrincipalAmountDec;
            end;
            NewSchedule."Loan Deduction Code":="Deduction Code";
            NewSchedule."Loan Interest Code":="Interest Deduction Code";
            NewSchedule.Insert;
            RunningDate:=CalcDate('1M', RunningDate)//RunningDate:=CALCDATE("Instalment Period",RunningDate)
        //MODIFY;
        until LoopEndBool;
        Message('Schedule Created');
    end;
    procedure CalculateRepayment(Rate: Decimal; Principal: Decimal; Term: Decimal; RepaymentFrequency: Decimal)Repayment: Decimal var
        i: Decimal;
    begin
        i:=(Rate / 100 * RepaymentFrequency);
        Repayment:=i * Principal / (1 - Power((1 + i), -Term));
        case "Interest Calculation Method" of "Interest Calculation Method"::Amortised: Repayment:=Round(("Interest Rate" / 12 / 100) / (1 - Power((1 + ("Interest Rate" / 12 / 100)), -Instalment)) * "Approved Amount", 0.0001, '>');
        "Interest Calculation Method"::"Flat Rate": Repayment:=Round(("Approved Amount" / Installments) + FlatRateCalc("Approved Amount", Interest), LoanType."Rounding Precision", RoundingPrecision);
        "Interest Calculation Method"::"Reducing Balance": begin
            Repayment:=Round("Approved Amount" / Installments, 0.0001, '>');
            Repayment2:=Round("Approved Amount" / Installments, 0.0001, '>') + Round(("Interest Rate" / 12 / 100) * "Approved Amount", 0.0001, '>');
        end;
        end;
        exit(Repayment);
    end;
    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Application Date", "Loan No");
        NavigateForm.Run;
    end;
    local procedure InsertUserAccount()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId)then begin
            Error(NoUserAcc);
        end
        else
        begin
            UserSetup.TestField("Employee No.");
            "Employee No":=UserSetup."Employee No.";
            Validate("Employee No");
        end;
    end;
}

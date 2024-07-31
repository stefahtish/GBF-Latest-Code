report 50233 "Transfer to Journal"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employees; Employee)
        {
            trigger OnAfterGetRecord()
            begin
                /*IF Employees."Posting Group"<>EmpGroup THEN
                CurrReport.SKIP;*/
                Employees.TestField("Posting Group");
                TotalDebits := 0;
                TotalCredits := 0;
                TotalInterest := 0;
                PayrollPeriod.Reset;
                PayrollPeriod.SetRange("Starting Date", Datefilter);
                if PayrollPeriod.Find('-') then begin
                    //PayrollPeriod.TESTFIELD("Pay Date");
                    Payday := PayrollPeriod."Starting Date";
                end;
                Earn.Reset;
                Earn.SetRange("Reduces Tax", false);
                Earn.SetFilter("Account No.", '<>%1', '');
                Earn.SetRange("Non-Cash Benefit", false);
                if Earn.Find('-') then begin
                    repeat
                        if Earn."Basic Salary Code" = true then begin
                            PostingGroup.Reset;
                            PostingGroup.SetRange(PostingGroup.Code, Employees."Posting Group");
                            if PostingGroup.Find('-') then begin
                                AssignMatrix.Reset;
                                AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Payment);
                                AssignMatrix.SetRange(Code, Earn.Code);
                                AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                                AssignMatrix.SetRange("Payroll Period", Datefilter);
                                if AssignMatrix.Find('-') then begin
                                    AssignMatrix.CalcSums(Amount);
                                    GenJnline.Init;
                                    LineNumber := LineNumber + 10;
                                    //GenJnline."Journal Template Name":='GENERAL';
                                    GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                    GenJnline."Journal Batch Name" := JName;
                                    GenJnline."Line No." := GenJnline."Line No." + 10000;
                                    //IF PGMapping.GET("Employee Posting GroupX1".Code,EarningsX1.Code,0) THEN
                                    PostingGroup.TestField("Salary Account");
                                    GenJnline."Account No." := PostingGroup."Salary Account";
                                    //GenJnline.VALIDATE("Account No.");
                                    GenJnline."Posting Date" := Payday;
                                    GenJnline.Description := Earn.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                    GenJnline."Document No." := Noseries;
                                    GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                    GenJnline.Validate("Shortcut Dimension 1 Code");
                                    GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                    GenJnline.Validate("Shortcut Dimension 2 Code");
                                    GenJnline."Currency Code" := Employees."Currency Code";
                                    GenJnline.Validate("Currency Code");
                                    GenJnline.Amount := (AssignMatrix.Amount);
                                    GenJnline.Validate(Amount);
                                    GenJnline."Employee Code" := AssignMatrix."Employee No";
                                    TotalDebits := TotalDebits + AssignMatrix.Amount;
                                    GenJnline."Gen. Bus. Posting Group" := '';
                                    GenJnline."Gen. Prod. Posting Group" := '';
                                    GenJnline."VAT Bus. Posting Group" := '';
                                    GenJnline."Emp Payroll Period" := Payday;
                                    if GenJnline.Amount <> 0 then GenJnline.Insert;
                                end;
                            end;
                        end;
                        if Earn."Basic Salary Code" = false then begin
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(Code, Earn.Code);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                            AssignMatrix.SetRange("Payroll Period", Datefilter);
                            if AssignMatrix.Find('-') then begin
                                AssignMatrix.CalcSums(Amount);
                                GenJnline.Init;
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := Earn."Account Type";
                                Earn.TestField("Account No.");
                                GenJnline."Account No." := Earn."Account No.";
                                //GenJnline.VALIDATE("Account No.");
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Earn.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := (AssignMatrix.Amount);
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                TotalDebits := TotalDebits + AssignMatrix.Amount;
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                if GenJnline.Amount <> 0 then GenJnline.Insert;
                            end;
                        end;
                    until Earn.Next = 0;
                end;
                //Deductions
                Ded.Reset;
                Ded.SetFilter("Account No.", '<>%1', '');
                if Ded.Find('-') then begin
                    repeat
                        AssignMatrix.Reset;
                        AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Deduction);
                        AssignMatrix.SetRange(Code, Ded.Code);
                        //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                        AssignMatrix.SetRange("Payroll Period", Datefilter);
                        if AssignMatrix.Find('-') then begin
                            AssignMatrix.CalcSums(Amount);
                            if Ded."Customer Entry" = false then begin
                                GenJnline.Init;
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := Ded."Account Type";
                                GenJnline."Account No." := Ded."Account No.";
                                GenJnline.Validate("Account No.");
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := (AssignMatrix.Amount);
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then GenJnline.Insert;
                            end;
                            if Ded."Customer Entry" = true then begin
                                GenJnline.Init;
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := GenJnline."Account Type"::Customer;
                                Employees.TestField("Debtor Code");
                                GenJnline."Account No." := Employees."Debtor Code";
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries; //GenJnlBatch."Posting No. Series";//NoSeriesMgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT(Datefilter);
                                GenJnline.Amount := (AssignMatrix.Amount); //*(Allocation.Percentage/100));
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                //            IF Ded.Loan THEN BEGIN
                                //              GenJnline."Applies-to Doc. No.":=AssignMatrix."Reference No";
                                //              GenJnline.VALIDATE("Applies-to Doc. No.");
                                //            END;
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then GenJnline.Insert;
                                //Insert Interest Entry
                                if Ded.Loan then begin
                                    LoanProductType.Reset;
                                    LoanProductType.SetRange("Deduction Code", Ded.Code);
                                    if LoanProductType.FindFirst then begin
                                        LoanProductType.TestField("Interest Posting Group");
                                        if Ded2.Get(LoanProductType."Interest Deduction Code") then begin
                                            if AssignMatrix."Loan Interest" <> 0 then begin
                                                TotalInterest := TotalInterest + Abs(AssignMatrix."Loan Interest");
                                                GenJnline.Init;
                                                LineNumber := LineNumber + 10;
                                                //GenJnline."Journal Template Name":='GENERAL';
                                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                                GenJnline."Journal Batch Name" := JName;
                                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                                GenJnline."Account Type" := GenJnline."Account Type"::Customer;
                                                Employees.TestField("Debtor Code");
                                                GenJnline."Account No." := Employees."Debtor Code";
                                                GenJnline."Posting Date" := Payday;
                                                GenJnline.Description := Ded2.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                                GenJnline."Currency Code" := Employees."Currency Code";
                                                GenJnline.Validate("Currency Code");
                                                GenJnline."Document No." := Noseries; //GenJnlBatch."Posting No. Series";//NoSeriesMgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT(Datefilter);
                                                GenJnline.Amount := AssignMatrix."Loan Interest"; //*(Allocation.Percentage/100));
                                                GenJnline.Validate(Amount);
                                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                                GenJnline."Posting Group" := LoanProductType."Interest Posting Group";
                                                GenJnline."External Document No." := AssignMatrix."Reference No";
                                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                                GenJnline."Gen. Bus. Posting Group" := '';
                                                GenJnline."Gen. Prod. Posting Group" := '';
                                                GenJnline."VAT Bus. Posting Group" := '';
                                                GenJnline."Emp Payroll Period" := Payday;
                                                if GenJnline.Amount <> 0 then GenJnline.Insert;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                            if AssignMatrix."Employer Amount" <> 0 then begin
                                GenJnline.Init;
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := Ded."Account Type Employer";
                                GenJnline."Account No." := Ded."Account No. Employer";
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := (AssignMatrix."Employer Amount");
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                if GenJnline.Amount <> 0 then GenJnline.Insert;
                            end;
                            if AssignMatrix."Employer Amount" <> 0 then begin
                                GenJnline.Init;
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := Ded."Account Type";
                                GenJnline."Account No." := Ded."Account No.";
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := -(AssignMatrix."Employer Amount");
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then GenJnline.Insert;
                            end;
                        end;
                    until Ded.Next = 0;
                end;
                PostingGroup.Reset;
                PostingGroup.SetRange(PostingGroup.Code, Employees."Posting Group");
                if PostingGroup.Find('-') then begin
                    GenJnline.Init;
                    LineNumber := LineNumber + 10;
                    //GenJnline."Journal Template Name":='GENERAL';
                    GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                    GenJnline."Journal Batch Name" := JName;
                    GenJnline."Line No." := GenJnline."Line No." + 10000;
                    GenJnline."Account Type" := PostingGroup."Net Salary Account Type";
                    GenJnline."Account No." := PostingGroup."Net Salary Payable";
                    GenJnline."Posting Date" := Payday;
                    GenJnline.Description := 'Net Pay' + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                    GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                    GenJnline.Validate("Shortcut Dimension 1 Code");
                    GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                    GenJnline.Validate("Shortcut Dimension 2 Code");
                    GenJnline."Currency Code" := Employees."Currency Code";
                    GenJnline.Validate("Currency Code");
                    GenJnline."Document No." := Noseries;
                    EmpRec.Reset;
                    EmpRec.SetRange(EmpRec."No.", Employees."No.");
                    EmpRec.SetRange(EmpRec."Pay Period Filter", AssignMatrix."Payroll Period");
                    if EmpRec.Find('-') then EmpRec.CalcFields(EmpRec."Net Pay");
                    GenJnline.Amount := -(EmpRec."Net Pay" - TotalInterest); //Modified to include loan interest
                    GenJnline.Validate(Amount);
                    GenJnline."Employee Code" := AssignMatrix."Employee No";
                    GenJnline."Gen. Bus. Posting Group" := '';
                    GenJnline."Gen. Prod. Posting Group" := '';
                    GenJnline."VAT Bus. Posting Group" := '';
                    GenJnline."Emp Payroll Period" := Payday;
                    TotalCredits := TotalCredits + AssignMatrix.Amount;
                    if GenJnline.Amount <> 0 then GenJnline.Insert;
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
                field("Payroll Period"; Datefilter)
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PayrollPeriod.Reset;
                        if PAGE.RunModal(Page::"Pay Period", PayrollPeriod) = ACTION::LookupOK then Datefilter := PayrollPeriod."Starting Date";
                    end;
                }
                field(EmpGroup; EmpGroup)
                {
                    Caption = 'Posting Group';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                            PosingE.RESET;
                            IF PAGE.RUNMODAL(51519558,PosingE) = ACTION::LookupOK THEN
                              EmpGroup:=PosingE.Code;
                            */
                        //PAGE.RUNMODAL(51519558,PosingE);
                    end;
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
    trigger OnInitReport()
    begin
        //EVALUATE(Datefilter,'10012013');
    end;

    trigger OnPostReport()
    begin
        Message('Successfully transfered to %1 Journal %2 Batch', HRSetup."Payroll Journal Template", JName);
    end;

    trigger OnPreReport()
    begin
        HRSetup.Get;
        HRSetup.TestField("Payroll Journal Template");
        //HRSetup.TESTFIELD("Payroll Journal No.");
        //HRSetup.TESTFIELD("Payroll Journal Batch");
        //JName:=COPYSTR(EmpGroup,1,3);
        JName := 'PAY';
        MonDate := Format(Datefilter);
        JName := JName + CopyStr(MonDate, 3, 7);
        GenJnline.Reset;
        //GenJnline.SETRANGE("Journal Template Name",'GENERAL');
        GenJnline.SetRange("Journal Template Name", HRSetup."Payroll Journal Template");
        GenJnline.SetRange("Journal Batch Name", JName);
        GenJnline.DeleteAll;
        /*
        GenJnlBatch.RESET;
        GenJnlBatch.SETRANGE(Name,JName);
        IF NOT GenJnlBatch.FIND('-') THEN
          BEGIN
            GenJnlBatch.INIT;
            GenJnlBatch."Journal Template Name":=HRSetup."Payroll Journal Template";
            GenJnlBatch.Name:=JName;
            GenJnlBatch.Description:=EmpGroup+' '+FORMAT(Datefilter,0,'<month text> <year4>');
            GenJnlBatch.INSERT;
         END;
        */
        GenJnlBatch.Reset;
        GenJnlBatch.Init;
        GenJnlBatch."Journal Template Name" := HRSetup."Payroll Journal Template";
        GenJnlBatch.Name := JName;
        //GenJnlBatch.Description:=EmpGroup+' '+FORMAT(Datefilter,0,'<month text> <year4>');
        GenJnlBatch.Description := 'Payroll ' + Format(Datefilter, 0, '<month text> <year4>');
        if not GenJnlBatch.Get(HRSetup."Payroll Journal Template", JName) then GenJnlBatch.Insert;
        GenJnlBatch.Reset;
        GenJnlBatch.SetRange(Name, JName);
        if GenJnlBatch.Find('-') then //Noseries:=NoSeriesMgt.GetNextNo('JOURNAL',TODAY,TRUE);
            Noseries := NoSeriesMgt.GetNextNo(HRSetup."Payroll Journal No.", Today, true);
    end;

    var
        Earn: Record EarningsX;
        Datefilter: Date;
        GenJnline: Record "Gen. Journal Line";
        LineNumber: Integer;
        AmountRemaining: Decimal;
        Company: Record "Company Information";
        IncomeTax: Decimal;
        NetPay: Decimal;
        RightBracket: Boolean;
        Companyz: Code[10];
        "Posting Date": Date;
        BatchName: Text[30];
        DocumentNo: Code[10];
        Description: Text[30];
        Amount: Decimal;
        "G/LAccount": Code[10];
        TotalncomeTax: Decimal;
        GrossPay: Decimal;
        Totalgross: Decimal;
        TotalNetPay: Decimal;
        Payday: Date;
        TotalBasic: Decimal;
        PayrollPeriod: Record "Payroll PeriodX";
        PostingGroup: Record "Employee Posting GroupX";
        TaxAccount: Code[10];
        SalariesAcc: Code[10];
        PayablesAcc: Code[10];
        First: Code[10];
        Last: Code[10];
        EmployeeTemp: Record Employee temporary;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        AssignMatrix: Record "Assignment Matrix-X";
        JnlTemp: Record "Gen. Journal Batch";
        Found: Boolean;
        TotalSSF: Decimal;
        PeriodStartDate: Date;
        EmpRec: Record Employee;
        DateSpecified: Date;
        Payperiodtext: Text[30];
        TransferLoans: Boolean;
        TaxCode: Code[10];
        BasicSalary: Decimal;
        PAYE: Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        GetPeriodFilter: Date;
        ActivityRec: Record "Dimension Value";
        EarningsCopy: Record EarningsX;
        LoanApp: Record "Loan Application";
        PGMapping: Record "Employee Posting GroupX";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "General Ledger Setup";
        GenJnlBatch: Record "Gen. Journal Batch";
        Noseries: Code[50];
        Deduction: Record DeductionsX;
        Ded: Record DeductionsX;
        EmpGroup: Code[10];
        PosingE: Record "Employee Posting GroupX";
        JName: Text[10];
        MonDate: Text[10];
        PostingGrp: Code[30];
        HRSetup: Record "Human Resources Setup";
        Customer: Record Customer;
        LoanProductType: Record "Loan Product Type";
        Ded2: Record DeductionsX;
        TotalInterest: Decimal;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record BracketsX;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
        Employee: Record Employee;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := PayrollRounding(AmountRemaining);
        EndTax := false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-') then begin
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if (TaxableAmount) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax?" then IncomeTax := 0;
    end;

    procedure GetPayPeriod(var PayPeriods: Record "Payroll PeriodX")
    begin
        PayrollPeriod := PayPeriods;
    end;

    procedure GetCurrentPeriod()
    var
        PayPeriodRec: Record "Payroll PeriodX";
    begin
        PayPeriodRec.SetRange(PayPeriodRec.Closed, false);
        if PayPeriodRec.Find('-') then PeriodStartDate := PayPeriodRec."Starting Date";
    end;

    procedure AdjustPostingGr()
    begin
        if AssignMatrix.Find('-') then begin
            repeat
                if EmpRec.Get(AssignMatrix."Employee No") then AssignMatrix."Posting Group Filter" := EmpRec."Posting Group";
                AssignMatrix.Modify;
            until AssignMatrix.Next = 0;
        end;
    end;

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
}

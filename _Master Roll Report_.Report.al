report 50236 "Master Roll Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MasterRollReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") WHERE("Employee Job Type" = CONST("  "), "Employment Type" = filter(<> Trustee));
            RequestFilterFields = "Pay Period Filter";

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
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
            column(EarnDesc_1_; EarnDesc[1])
            {
            }
            column(EarnDesc_2_; EarnDesc[2])
            {
            }
            column(EarnDesc_3_; EarnDesc[3])
            {
            }
            column(DedDesc_1_; DedDesc[1])
            {
            }
            column(DedDesc_2_; DedDesc[2])
            {
            }
            column(DedDesc_3_; DedDesc[3])
            {
            }
            column(DedDesc_4_; DedDesc[4])
            {
            }
            column(Other_Deductions_; 'Other Deductions')
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
            column(EarnDesc_4_; EarnDesc[4])
            {
            }
            column(EarnDesc_5_; EarnDesc[5])
            {
            }
            column(EarnDesc_6_; EarnDesc[6])
            {
            }
            column(EarnDesc_7_; EarnDesc[7])
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(PIN_Number; Employee."PIN Number")
            {
            }
            column(Allowances_1_; Allowances[1])
            {
            }
            column(Allowances_2_; Allowances[2])
            {
            }
            column(Allowances_3_; Allowances[3])
            {
            }
            column(Deductions_1_; Deductions[1])
            {
            }
            column(Deductions_2_; Deductions[2])
            {
            }
            column(Deductions_3_; Deductions[3])
            {
            }
            column(Deductions_4_; Deductions[4])
            {
            }
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Allowances_5_; Allowances[5])
            {
            }
            column(Allowances_4_; Allowances[4])
            {
            }
            column(Allowances_6_; Allowances[6])
            {
            }
            column(Allowances_7_; Allowances[7])
            {
            }
            column(Employee_Company; Company)
            {
            }
            column(Employee__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Employee__Job_Title_; "Job Title")
            {
            }
            column(Allowances_1__Control1000000009; Allowances[1])
            {
            }
            column(Allowances_2__Control1000000018; Allowances[2])
            {
            }
            column(Allowances_3__Control1000000032; Allowances[3])
            {
            }
            column(Deductions_1__Control1000000034; Deductions[1])
            {
            }
            column(Deductions_2__Control1000000035; Deductions[2])
            {
            }
            column(Deductions_3__Control1000000036; Deductions[3])
            {
            }
            column(Deductions_4__Control1000000037; Deductions[4])
            {
            }
            column(OtherDeduct_Control1000000038; OtherDeduct)
            {
            }
            column(NetPay_Control1000000039; NetPay)
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; StrSubstNo('Employees=%1', counter))
            {
            }
            column(Prepared_By______________________________________________________; 'Prepared By.....................................................')
            {
            }
            column(Approved_By_____________________________________________________; 'Approved By....................................................')
            {
            }
            column(Approved_By_____________________________________________; 'Approved By............................................')
            {
            }
            column(Allowances_4__Control1000000054; Allowances[4])
            {
            }
            column(Allowances_5__Control1000000055; Allowances[5])
            {
            }
            column(Allowances_6__Control1000000056; Allowances[6])
            {
            }
            column(MASTER_ROLLCaption; MASTER_ROLLCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_CompanyCaption; FieldCaption(Company))
            {
            }
            column(Employee__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Employee__Job_Title_Caption; FieldCaption("Job Title"))
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);

                column(Allowances_Number_; Allowances[Number])
                {
                }
                column(EarnDesc_1__Control1000000060; EarnDesc[Number])
                {
                }
                column(Earncode_Number_; Earncode[Number])
                {
                }
                column(Integer_Number; Number)
                {
                }
                trigger OnPreDataItem()
                begin
                    Integer.SetRange(Number, 1, i);
                end;
            }
            trigger OnAfterGetRecord()
            var
                EmpRec: Record Employee;
            begin
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions", "Loan Interest", "Relief Amount", "Pension Contribution Benefit");
                if (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest") = 0 then CurrReport.Skip;
                counter := counter + 1;
                // Gratuity
                TotalGratuity := 0;
                // Gratuity
                Earn.Reset;
                Earn.SetRange("Pay Period Filter", DateSpecified);
                Earn.SetRange(Gratuity, true);
                Earn.SetRange("Employee Filter", Employee."No.");
                if Earn.FindFirst() then begin
                    Earn.Calcfields("Total Amount");
                    TotalGratuity := Earn."Total Amount";
                end;
                NetPay := Employee."Total Allowances" + Employee."Total Deductions" - TotalGratuity;
                //EVALUATE(EmployeeNo,"No.");
                EmpRec.Reset();
                If EmpRec.Get(Employee."No.") then EmpRec.CalcFields("Relief Amount");
                for i := 1 to NoOfDeductions do begin
                    Clear(Allowances[i]);
                    Clear(Deductions[i]);
                end;
                OtherEarn := 0;
                OtherDeduct := 0;
                Totallowances := 0;
                OtherDeduct := 0;
                TotalDeductions := 0;
                // // relief
                // TotalRelief := 0;
                // // Relief
                // Earn.Reset;
                // Earn.SetRange("Pay Period Filter", DateSpecified);
                // Earn.SetRange("Reduces Tax", true);
                // Earn.SetRange("Employee Filter", Employee."No.");
                // if Earn.Find('-') then begin
                //     repeat
                //         Earn.Calcfields("Total Amount");
                //         TotalRelief := TotalRelief + Earn."Total Amount";
                //     until Earn.Next() = 0;
                // end;
                for i := 1 to NoOfEarnings do begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Payment);
                    Assignmat.SetRange(Assignmat.Code, Earncode[i]);
                    Assignmat.SetRange(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.Find('-') then begin
                        Assignmat.CalcSums(Amount);
                        Allowances[i] := Assignmat.Amount;
                        Totallowances := Totallowances + Allowances[i];
                    end
                    else begin
                        if Earncode[i] = 'OTHER EARNINGS' then begin
                            Allowances[i] := Employee."Total Allowances" - Totallowances;
                        end
                        else if (Earncode[i] = 'GROSS PAY') then Allowances[i] := Employee."Total Allowances" - TotalRelief;
                    end;
                end;
                OtherEarn := Employee."Total Allowances" - Totallowances;
                for i := NoOfEarnings + 1 to NoOfEarnings + NoOfDeductions do begin
                    Clear(Allowances[i]);
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, Earncode[i]);
                    Assignmat.SetRange(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.Find('-') then begin
                        Assignmat.CalcSums(Amount, "Loan Interest");
                        Allowances[i] := Assignmat.Amount + Assignmat."Loan Interest" + Assignmat."Less Pension Contribution";
                        TotalDeductions := TotalDeductions + Allowances[i];
                    end
                    else begin
                        if Earncode[i] = 'OTHER DEDUCTIONS' then
                            Allowances[i] := Abs(Employee."Total Deductions" + Employee."Loan Interest") - Abs(TotalDeductions)
                        else if Earncode[i] = 'NET PAY' then Allowances[i] := Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest" - TotalGratuity;
                    end;
                end;
                OtherDeduct := Abs(Employee."Total Deductions" + TotalDeductions);
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Allowances, Deductions, OtherEarn, OtherDeduct, NetPay);
                HRSetup.Get;
                Employee.SetFilter("Employment Status", '%1', Employee."Employment Status"::Active);
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
        DateSpecified := Employee.GetRangeMin(Employee."Pay Period Filter");
        EarnRec.Reset;
        EarnRec.SetRange("Show on Master Roll", true);
        EarnRec.SetRange("Non-Cash Benefit", false);
        EarnRec.SetRange("Pay Period Filter", DateSpecified);
        if EarnRec.Find('-') then
            repeat
                EarnRec.CalcFields("Total Amount");
                if EarnRec."Total Amount" <> 0 then begin
                    i := i + 1;
                    Earncode[i] := EarnRec.Code;
                    EarnDesc[i] := EarnRec.Description;
                    NoOfEarnings := NoOfEarnings + 1;
                end;
            until EarnRec.Next = 0;
        //Add other earnings
        NoOfEarnings := NoOfEarnings + 1;
        i := i + 1;
        Earncode[i] := 'Other Earnings';
        EarnDesc[i] := 'Other Earnings';
        NoOfEarnings := NoOfEarnings + 1;
        i := i + 1;
        Earncode[i] := 'Gross Pay';
        EarnDesc[i] := 'Gross Pay';
        //
        DedRec.Reset;
        DedRec.SetRange(DedRec."Show on Master Roll", true);
        DedRec.SetRange("Pay Period Filter", DateSpecified);
        if DedRec.Find('-') then
            repeat
                DedRec.CalcFields("Total Amount");
                if DedRec."Total Amount" <> 0 then begin
                    i := i + 1;
                    Earncode[i] := DedRec.Code;
                    EarnDesc[i] := DedRec.Description;
                    NoOfDeductions := NoOfDeductions + 1;
                end;
            until DedRec.Next = 0;
        //Add other deductions and Net Pay
        NoOfDeductions := NoOfDeductions + 1;
        i := i + 1;
        Earncode[i] := 'OTHER DEDUCTIONS';
        EarnDesc[i] := 'OTHER DEDUCTIONS';
        NoOfDeductions := NoOfDeductions + 1;
        i := i + 1;
        Earncode[i] := 'NET PAY';
        EarnDesc[i] := 'NET PAY';
        //
    end;

    var
        Allowances: array[1000] of Decimal;
        Deductions: array[100] of Decimal;
        EarnRec: Record EarningsX;
        DedRec: Record DeductionsX;
        Earncode: array[1000] of Code[20];
        deductcode: array[100] of Code[20];
        EarnDesc: array[1000] of Text[150];
        DedDesc: array[100] of Text[150];
        i: Integer;
        j: Integer;
        TotalGratuity: Decimal;
        Assignmat: Record "Assignment Matrix-X";
        DateSpecified: Date;
        Totallowances: Decimal;
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
        Earn: Record EarningsX;
        TotalRelief: Decimal;
        PG: Code[20];
        Dpt: Code[20];
        Emp: Code[20];
        EmployeeNo: Integer;
        MASTER_ROLLCaptionLbl: Label 'MASTER ROLL';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CompanyInfo: Record "Company Information";
}

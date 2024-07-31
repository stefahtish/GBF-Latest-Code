table 50379 "Payroll Requests"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Applies; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'All,Group,Specific';
            OptionMembers = All, Group, Specific;

            trigger OnValidate()
            begin
                InsertLines;
            end;
        }
        field(3; Group; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract";

            trigger OnValidate()
            begin
                InsertLines;
            end;
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.")then begin
                    "Employee Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(5; "Employee Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Earning,Deduction';
            OptionMembers = " ", Earning, Deduction;
        }
        field(7; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(Earning))EarningsX
            ELSE IF(Type=CONST(Deduction))DeductionsX;

            trigger OnValidate()
            begin
                case Type of Type::Earning: begin
                    if Earning.Get(Code)then "Code Descripton":=Earning.Description;
                    "Calculation Method":=Earning."Calculation Method";
                    Percentage:=Earning.Percentage;
                    Formula:=Earning.Formula;
                end;
                Type::Deduction: begin
                    if Deduction.Get(Code)then "Code Descripton":=Deduction.Description;
                end;
                end;
            end;
        }
        field(8; "Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Flat amount,% of Basic pay,% of Gross pay,% of Insurance Amount,% of Taxable income,% of Basic after tax,Based on Hourly Rate,Based on Daily Rate,Formula';
            OptionMembers = "Flat amount", "% of Basic pay", "% of Gross pay", "% of Insurance Amount", "% of Taxable income", "% of Basic after tax", "Based on Hourly Rate", "Based on Daily Rate", Formula;
        }
        field(9; "Flat Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Formula; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Units; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX" WHERE(Closed=CONST(false));
        }
        field(16; Locum; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Principal Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.")then begin
                    "Principal Employee Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Principal Employee Basic":=PayrollMgt.GetCurrentBasicPay("Principal Employee Code", "Payroll Period");
                end;
            end;
        }
        field(18; "Principal Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Principal Employee Basic"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Hours; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:=("Principal Employee Basic" * Hours / 30)end;
        }
        field(21; Days; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Gratuity; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Months: Integer;
            begin
                if Gratuity then begin
                    if Employee.Get("Employee No.")then begin
                        "Months Worked":=PayrollMgt.CalculateMonths(Employee."Contract Start Date", Employee."Contract End Date");
                        Amount:="Months Worked" * PayrollMgt.GetCurrentBasicPay("Employee No.", "Payroll Period") * Percentage / 100;
                    end;
                end;
            end;
        }
        field(23; "Months Worked"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Code Descripton"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Special Condition"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Suspend, "Re-Instatement";
        }
        field(26; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Rejected,Approved,Acctioned';
            OptionMembers = Open, "Pending Approval", Rejected, Approved, Acctioned;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Payroll Req Nos");
            NoSeriesMgt.InitSeries(HRSetup."Payroll Req Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
    var Emp: Record Employee;
    PayrollMgt: Codeunit Payroll;
    Employee: Record Employee;
    AssingMatrix: Record "Assignment Matrix-X";
    HRSetup: Record "Human Resources Setup";
    Earning: Record EarningsX;
    Deduction: Record DeductionsX;
    procedure Calculate(EmpNo: Code[30])Amt: Decimal var
        Formula1: Code[50];
    begin
        case "Calculation Method" of "Calculation Method"::"Flat amount": Amt:="Flat Amount";
        // % Of Basic Pay
        "Calculation Method"::"% of Basic pay": begin
            if Employee.Get(EmpNo)then Employee.SetRange("Pay Period Filter", "Payroll Period");
            Employee.CalcFields("Basic Pay", "Basic Arrears");
            if Employee.FindFirst then begin
                Amt:=Percentage / 100 * (Employee."Basic Pay" - Employee."Basic Arrears");
                Amt:=AssingMatrix.PayrollRounding(Amt);
            end;
        end;
        // % Of Basic after Tax
        "Calculation Method"::"% of Basic after tax": begin
            if HRSetup."Company overtime hours" <> 0 then Amt:=AssingMatrix.PayrollRounding(Amt);
        end;
        // Based on Hourly Rate
        "Calculation Method"::"Based on Hourly Rate": begin
        /*
                     Amount:="No. of Units"*Employee."Driving Licence"*"Overtime Factor";
                     IF "Overtime Factor"<>0 THEN
                     Amount:="No. of Units"*Employee."Driving Licence"*"Overtime Factor";
                     Amount:=PayrollRounding(Amount);
                     */
        end;
        // Based on Daily Rate
        "Calculation Method"::"Based on Daily Rate": begin
        /*
                    Amount:=Employee."Driving Licence"*Employee."days worked";
                    Amount:=PayrollRounding(Amount);
                    */
        end;
        // % Of Insurance Amount
        "Calculation Method"::"% of Insurance Amount": begin
            Employee.SetRange("No.", EmpNo);
            Employee.SetRange("Pay Period Filter", "Payroll Period");
            Employee.CalcFields("Insurance Premium");
            Amt:=Abs((Percentage / 100) * (Employee."Insurance Premium"));
            Amt:=AssingMatrix.PayrollRounding(Amt);
        end;
        // % F Gross Pay
        "Calculation Method"::"% of Gross pay": begin
            Employee.SetRange("No.", "Employee No.");
            Employee.SetRange("Pay Period Filter", "Payroll Period");
            Employee.CalcFields("Basic Pay", "Total Allowances");
            Amt:=((Percentage / 100) * (Employee."Total Allowances"));
            Amt:=AssingMatrix.PayrollRounding(Amt);
        end;
        // % of Taxable Income
        "Calculation Method"::"% of Taxable income": begin
            Employee.SetRange("No.", EmpNo);
            Employee.SetRange("Pay Period Filter", "Payroll Period");
            Employee.CalcFields("Taxable Allowance");
            Amt:=((Percentage / 100) * (Employee."Taxable Allowance"));
            Amt:=AssingMatrix.PayrollRounding(Amt);
        end;
        //Formula
        "Calculation Method"::Formula: begin
            Employee.SetRange("No.", EmpNo);
            Employee.SetRange("Pay Period Filter", "Payroll Period");
            Formula1:=PayrollMgt.GetPureFormula(EmpNo, "Payroll Period", Formula);
            Amt:=PayrollMgt.GetResult(Formula1);
        end;
        end;
        exit(Amt)end;
    procedure InsertLines()
    var
        PayRequestLines: Record "Payroll Request Lines";
    begin
        PayRequestLines.Reset;
        PayRequestLines.SetRange("No.", "No.");
        PayRequestLines.DeleteAll();
        case Applies of Applies::All: begin
            Employee.Reset;
            Employee.SetRange(Status, Employee.Status::Active);
            if Employee.FindFirst then begin
                repeat PayRequestLines.Init;
                    PayRequestLines."No.":="No.";
                    PayRequestLines."Employee No.":=Employee."No.";
                    PayRequestLines."Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    PayRequestLines."Previous Value":=0;
                    PayRequestLines.Insert;
                until Employee.Next = 0;
            end;
        end;
        Applies::Group: begin
            Employee.Reset;
            Employee.SetRange(Status, Employee.Status::Active);
            Employee.SetRange("Nature of Employment", Group);
            if Employee.FindFirst then begin
                repeat PayRequestLines.Init;
                    PayRequestLines."No.":="No.";
                    PayRequestLines."Employee No.":=Employee."No.";
                    PayRequestLines."Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    PayRequestLines."Previous Value":=0;
                    PayRequestLines.Insert;
                until Employee.Next = 0;
            end;
        end end;
    end;
    procedure UpdateChange()
    var
        PayRequestLines: Record "Payroll Request Lines";
    begin
        if Applies = Applies::Specific then begin
            Amount:=Calculate("Employee No.");
        end
        else
        begin
            InsertLines;
            PayRequestLines.Reset;
            PayRequestLines.SetRange("No.", "No.");
            if PayRequestLines.FindFirst then repeat PayRequestLines."New Value":=Calculate(PayRequestLines."Employee No.");
                    PayRequestLines."Previous Value":=PayrollMgt.GetCurrentPay(PayRequestLines."Employee No.", "Payroll Period", Code);
                    PayRequestLines.Modify;
                until PayRequestLines.Next = 0;
        end;
    end;
}

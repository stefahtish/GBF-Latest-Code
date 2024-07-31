table 50548 "Payroll Approval"
{
    Caption = 'Payroll Approval';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Payroll Period" = 0D then begin
                    Description:='';
                    ClearPayrollApprovalLine("No.")end
                else
                begin
                    Description:=Format("Payroll Period", 0, '<Month Text> <Year4>');
                    CreatePayrollApprovalLine("No.", "Payroll Period");
                end;
                "Pay Period Filter":="Payroll Period";
            end;
        }
        field(3; "Payroll Type"; Option)
        {
            Caption = 'Payroll Type';
            OptionMembers = " ", Employee, Pension, IDD, Increment, "Pension Mini Payroll";
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        //TableRelation = User;
        // Editable = false;
        }
        field(6; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Last Modified By"; Text[50])
        {
            Caption = 'Last Modified By';
            DataClassification = ToBeClassified;
            //TableRelation = User;
            Editable = false;
        }
        field(8; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open, "Pending Approval", Approved, Rejected;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Total Earning"; Decimal)
        {
            Caption = 'Total Earning';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payroll Approval Lines"."Total Earning" where("Document No."=field("No.")));
        }
        field(12; "Total Arrears"; Decimal)
        {
            Caption = 'Total Arrears';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payroll Approval Lines"."Total Arrears" where("Document No."=field("No.")));
        }
        field(13; "Total Deduction"; Decimal)
        {
            Caption = 'Total Deduction';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payroll Approval Lines"."Total Deduction" where("Document No."=field("No.")));
        }
        field(14; "Total Net Amount"; Decimal)
        {
            Caption = 'Total Net Amount';
            DecimalPlaces = 2: 2;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payroll Approval Lines"."Net Amount" where("Document No."=field("No.")));
        }
        field(15; "Currency Code"; code[10])
        {
            TableRelation = Currency;
        }
        field(16; Posted; Boolean)
        {
            Editable = false;
        }
        field(17; "Pension Company"; Text[30])
        {
            TableRelation = Company.Name;
            DataClassification = ToBeClassified;
        }
        field(18; "Pension Contribution No."; code[20])
        {
            Editable = false;
        }
        field(19; "Contribution Transferred"; Boolean)
        {
            Editable = false;
        }
        field(29; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = if("Payroll Type"=const(Employee))"Payroll PeriodX"."Starting Date";
        }
        field(30; "Status Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Active,Suspended';
            OptionMembers = Active, Suspended;
        }
        field(33; "PV Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "PV Document No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Payments;
        }
        field(35; "Net Pay"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Non-Cash Benefit"=CONST(false), "Tax Relief"=CONST(false)));
            FieldClass = FlowField;
        }
        field(36; "Basic Pay"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Basic Salary Code"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Non-Cash Benefit"=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Taxable=CONST(true), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Tax Deductible Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Tax Deductible"=CONST(true), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Non-Cash Benefit"=CONST(false)));
            FieldClass = FlowField;
        }
        field(41; "SSF Employer to Date"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Employer Amount" WHERE("Tax Deductible"=CONST(true), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period")));
            FieldClass = FlowField;
        }
        field(42; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Paye=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Non-Cash Benefit"=CONST(true), Type=CONST(Payment), Taxable=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(44; "Home Savings"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Type=CONST(Deduction), "Tax Deductible"=CONST(true), Retirement=CONST(false)));
            FieldClass = FlowField;
        }
        field(45; "Retirement Contribution"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Tax Deductible"=CONST(true), Retirement=CONST(true)));
            FieldClass = FlowField;
        }
        field(46; "Owner Occupier"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Type=CONST(Payment), "Tax Deductible"=CONST(true)));
            FieldClass = FlowField;
        }
        field(47; "Total Savings"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), Type=CONST("Saving Scheme"), "Payroll Period"=FIELD("Payroll Period")));
            FieldClass = FlowField;
        }
        field(48; "Share Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), Shares=CONST(true)));
            FieldClass = FlowField;
        }
        field(49; "Other deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Paye=CONST(false)));
            FieldClass = FlowField;
        }
        field(50; Interest; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Interest Amount" WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Type=FILTER(Deduction)));
            FieldClass = FlowField;
        }
        field(51; "Taxable Income"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Taxable=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Insurance Premium"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Insurance Code"=CONST(true)));
            FieldClass = FlowField;
        }
        field(53; "Basic Arrears"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Basic Pay Arrears"=CONST(true)));
            FieldClass = FlowField;
        }
        field(54; "Relief Amount"; Decimal)
        {
            CalcFormula = -Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Non-Cash Benefit"=CONST(true), Type=CONST(Payment), "Tax Deductible"=CONST(true), "Tax Relief"=CONST(true)));
            FieldClass = FlowField;
        }
        field(55; "Loan Interest"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Loan Interest" WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period")));
            FieldClass = FlowField;
        }
        field(56; "House Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "House Allowance Code"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Commuter Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Commuter Allowance Code"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "Salary Arrears"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Salary Arrears Code"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Cumm. Secondary  PAYE"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Secondary PAYE"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Pension Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Retirement=CONST(true), Voluntary=field("Voluntary Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Employer Pension Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Employer Amount" WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), Retirement=CONST(true), Voluntary=field("Voluntary Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Employee No. Filter"; Code[20])
        {
            TableRelation = Employee;
            FieldClass = FlowFilter;
        }
        field(63; "Voluntary Filter"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(64; "Payroll Transferred"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(65; "Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Tax Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Estimated Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68; Preview; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69; Password; Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Payroll S2b generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Interbank S2b generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Total Employer Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Employer Amount" WHERE("Employee No"=FIELD("Employee No. Filter"), "Payroll Period"=FIELD("Payroll Period"), "Non-Cash Benefit"=CONST(false), "Tax Relief"=CONST(false)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            case "Payroll Type" of "Payroll Type"::employee: begin
                HRSetup.Get;
                HRSetup.TestField("Payroll Approval Nos");
                NoSeriesMgt.InitSeries(HRSetup."Payroll Approval Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            end;
        end;
        "Created By":=GetUserName(UserId);
        ;
        "Date Created":=CreateDateTime(Today, Time);
        "Last Modified Date":=CreateDateTime(Today, Time);
        "Last Modified By":=GetUserName(UserId);
    end;
    trigger OnModify()
    begin
        "Last Modified Date":=CreateDateTime(Today, Time);
        "Last Modified By":=GetUserName(UserId);
        ;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    HRSetup: record "Human Resources Setup";
    procedure CreatePayrollApprovalLine(DocumentNo: Code[20]; PayPeriod: Date)
    var
        Employee: Record Employee;
        PayApproval: Record "Payroll Approval";
        PayApprovalLine: Record "Payroll Approval Lines";
        PayrollPeriod: Record "Payroll PeriodX";
        NextPrd: Date;
        LineNo: Integer;
        NewFiscalYear: Boolean;
        Text001: Label 'Payroll Approval document %1 does not exist.';
    begin
        if PayApproval.Get(DocumentNo)then begin
            NewFiscalYear:=false;
            ClearPayrollApprovalLine(DocumentNo);
            case PayApproval."Payroll Type" of PayApproval."Payroll Type"::Employee: begin
                PayrollPeriod.Get(PayPeriod);
                UpdatePaymentLedger(PayPeriod);
                if PayrollPeriod."New Fiscal Year" then NewFiscalYear:=true;
                Employee.Reset();
                Employee.SetRange("Pay Period Filter", PayPeriod);
                Employee.SetRange("Employment Type", Employee."Employment Status"::Active);
                Employee.SetFilter("Net Pay", '>%1', 0);
                if Employee.Find('-')then repeat Employee.CalcFields("Total Allowances", "Total Deductions", "Salary Arrears", "Net Pay");
                        LineNo+=10000;
                        PayApprovalLine.Init();
                        PayApprovalLine."Document No.":=DocumentNo;
                        PayApprovalLine."Line No":=LineNo;
                        PayApprovalLine."Payee Type":=PayApprovalLine."Payee Type"::Employee;
                        PayApprovalLine.Validate("Payee No", Employee."No.");
                        PayApprovalLine."Total Earning":=Employee."Total Allowances";
                        PayApprovalLine."Total Arrears":=Employee."Salary Arrears";
                        PayApprovalLine."Total Deduction":=Employee."Total Deductions";
                        PayApprovalLine."Net Amount":=Employee."Net Pay";
                        PayApprovalLine.Insert();
                    until Employee.Next() = 0;
            end;
            end;
        end
        else
            Error(Text001, DocumentNo);
    end;
    procedure ClearPayrollApprovalLine(DocumentNo: Code[20])
    var
        PayApprovalLine: Record "Payroll Approval Lines";
    begin
        PayApprovalLine.Reset();
        PayApprovalLine.SetRange("Document No.", DocumentNo);
        if PayApprovalLine.Find('-')then PayApprovalLine.DeleteAll();
    end;
    procedure GetUserName(UserCode: Code[50]): Text Var
        Users: record User;
    begin
        Users.reset;
        Users.setrange("User Name", UserCode);
        if Users.FindFirst()then exit(Users."Full Name");
    end;
    procedure UpdatePaymentLedger(PayPeriod: date)
    var
        AssignMatrix: Record "Assignment Matrix-X";
        Deductions: Record DeductionsX;
        Payments: Record EarningsX;
    begin
        AssignMatrix.Reset();
        AssignMatrix.SetRange("Payroll Period", PayPeriod);
        if AssignMatrix.FindFirst()then repeat AssignMatrix.UpdateEmployeeDetails(AssignMatrix);
                case AssignMatrix.Type of AssignMatrix.Type::Deduction: begin
                    if Deductions.Get(AssignMatrix.Code)then begin
                        AssignMatrix."Tax Deductible":=Deductions."Tax deductible";
                        AssignMatrix.Retirement:=Deductions."Pension Scheme";
                        AssignMatrix.Shares:=Deductions.Shares;
                        AssignMatrix.Paye:=Deductions."PAYE Code";
                        AssignMatrix."Secondary PAYE":=Deductions."Secondary PAYE";
                        AssignMatrix."Insurance Code":=Deductions."Insurance Code";
                        AssignMatrix."Main Deduction Code":=Deductions."Main Deduction Code";
                        AssignMatrix.Voluntary:=Deductions.Voluntary;
                        AssignMatrix.Frequency:=Deductions.Type;
                        AssignMatrix."Sacco Deduction":=Deductions."Sacco Deduction";
                    end;
                end;
                AssignMatrix.Type::Payment: begin
                    if Payments.Get(AssignMatrix.Code)then begin
                        AssignMatrix."Time Sheet":=Payments."Time Sheet";
                        if Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" then AssignMatrix."Tax Relief":=true;
                        AssignMatrix."Non-Cash Benefit":=Payments."Non-Cash Benefit";
                        AssignMatrix.Quarters:=Payments.Quarters;
                        AssignMatrix.Taxable:=Payments.Taxable;
                        AssignMatrix."Tax Deductible":=Payments."Reduces Tax";
                        if Payments."Pay Type" = Payments."Pay Type"::Recurring then AssignMatrix."Next Period Entry":=true;
                        AssignMatrix."Basic Salary Code":=Payments."Basic Salary Code";
                        AssignMatrix."Basic Pay Arrears":=Payments."Basic Pay Arrears";
                        if Payments."Earning Type" = Payments."Earning Type"::"Normal Earning" then AssignMatrix."Normal Earnings":=true;
                    end;
                end;
                end;
                AssignMatrix.Modify();
            until AssignMatrix.Next() = 0;
    end;
    procedure GetApprovers(DocumentNo: Code[20]; var CheckedBy: Code[50]; var CounterCheckedBy: Code[50]; var ApprovedBy: Code[50])
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntries: Integer;
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetCurrentKey("Sequence No.");
        ApprovalEntry.SetRange("Table ID", Database::"Payroll Approval");
        ApprovalEntry.SetRange("Document No.", DocumentNo);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
        ApprovalEntries:=ApprovalEntry.Count;
        if ApprovalEntries > 1 then begin
            if ApprovalEntry.FindFirst()then CheckedBy:=ApprovalEntry."Approver ID";
            ApprovalEntry.Reset();
            ApprovalEntry.SetCurrentKey("Sequence No.");
            ApprovalEntry.SetRange("Table ID", Database::"Payroll Approval");
            ApprovalEntry.SetRange("Document No.", DocumentNo);
            ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
            ApprovalEntry.SetFilter("Sequence No.", '>%1', 1);
            ApprovalEntries:=ApprovalEntry.Count;
            if ApprovalEntries > 1 then begin
                if ApprovalEntry.FindFirst()then CounterCheckedBy:=ApprovalEntry."Approver ID";
                if ApprovalEntry.FindLast()then ApprovedBy:=ApprovalEntry."Approver ID";
            end
            else
            begin
                if ApprovalEntry.FindFirst()then ApprovedBy:=ApprovalEntry."Approver ID";
            end;
        end
        else
        begin
            if ApprovalEntry.FindFirst()then ApprovedBy:=ApprovalEntry."Approver ID";
        end;
    end;
}

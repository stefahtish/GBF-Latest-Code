table 50398 "Payroll Period Trustees"
{
    fields
    {
        field(1; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                Name:=Format("Starting Date", 0, '<Month Text>');
            end;
        }
        field(2; Name; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Date Locked", false);
            end;
        }
        field(4; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(5; "Date Locked"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50000; "Pay Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Close Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
            //TESTFIELD("Close Pay",FALSE);
            end;
        }
        field(50002; "P.A.Y.E"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Payroll Period"=FIELD("Starting Date"), Paye=CONST(true), "Employee Type"=const(Trustee)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Basic Pay"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Payroll Period"=FIELD("Starting Date"), "Basic Salary Code"=CONST(true), "Employee Type"=const(Trustee)));
            FieldClass = FlowField;
        }
        field(50004; "Market Interest Rate %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "CMS Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "CMS End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Earnings Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = EarningsX;
        }
        field(50008; "Deductions Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = DeductionsX;
        }
        field(50009; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll PeriodX";
        }
        field(50010; "Leave Payment Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Payroll Period"=FIELD("Starting Date"), Type=FILTER(Payment), "Non-Cash Benefit"=FILTER(false), "Employee Type"=const(Trustee)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Total Deductions"; Decimal)
        {
            CalcFormula = -Sum("Assignment Matrix-X".Amount WHERE("Payroll Period"=FIELD("Starting Date"), Type=FILTER(Deduction), "Non-Cash Benefit"=FILTER(false), "Employee Type"=const(Trustee)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Employee Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent, Partime, Locum, Casual, Contract, Trustee;
        }
    }
    keys
    {
        key(Key1; "Starting Date")
        {
            Clustered = true;
        }
        key(Key2; "New Fiscal Year", "Date Locked")
        {
        }
        key(Key3; Closed)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    // AccountingPeriod2.RESET;
    // AccountingPeriod2.SETRANGE("Close Pay",FALSE);
    // IF AccountingPeriod2.FINDFIRST THEN
    //  ERROR(Error0001);
    end;
    var AccountingPeriod2: Record "Payroll Period Trustees";
    Error0001: Label 'You cannot create a new period while another is open';
    procedure CreateLeaveEntitlment(var PayrollPeriod: Record "Payroll PeriodX")
    var
        AccPeriod: Record "Accounting Period";
        NextDate: Date;
        EndOfYear: Boolean;
        Empleave: Record "Employee Leave";
        LeaveType: Record "Leave Type";
        MaturityDate: Date;
        NextMaturityDate: Date;
        Emp: Record Employee;
        CarryForwardDays: Decimal;
        EmpleaveCpy: Record "Employee Leave";
    begin
        EndOfYear:=false;
        NextDate:=CalcDate('1M', "Starting Date");
        if AccPeriod.Get(NextDate)then if AccPeriod."New Fiscal Year" then EndOfYear:=true;
        if EndOfYear then begin
            MaturityDate:=CalcDate('1M', PayrollPeriod."Starting Date") - 1;
            NextMaturityDate:=CalcDate('1Y', MaturityDate);
            LeaveType.Reset;
            LeaveType.SetRange(LeaveType."Annual Leave", true);
            if LeaveType.Find('-')then begin
                Emp.Reset;
                Emp.SetRange(Emp.Status, Emp.Status::Inactive);
                if Emp.Find('-')then repeat if EmpleaveCpy.Get(Emp."No.", LeaveType.Code, MaturityDate)then begin
                            EmpleaveCpy.CalcFields(EmpleaveCpy."Total Days Taken", EmpleaveCpy.Adjustments);
                            CarryForwardDays:=(EmpleaveCpy.Entitlement + EmpleaveCpy."Balance Brought Forward" + EmpleaveCpy.Adjustments) - EmpleaveCpy."Total Days Taken";
                            if CarryForwardDays > LeaveType."Max Carry Forward Days" then CarryForwardDays:=LeaveType."Max Carry Forward Days";
                        end;
                        Empleave.Init;
                        Empleave."Employee No":=Emp."No.";
                        Empleave."Leave Code":=LeaveType.Code;
                        Empleave."Maturity Date":=NextMaturityDate;
                        Empleave.Entitlement:=LeaveType.Days;
                        Empleave."Balance Brought Forward":=CarryForwardDays;
                        if not Empleave.Get(Empleave."Employee No", Empleave."Leave Code", Empleave."Maturity Date")then Empleave.Insert;
                    until Emp.Next = 0;
            end;
        //ELSE
        //ERROR('You must select one leave type as annual on the leave setup');
        end;
    end;
}

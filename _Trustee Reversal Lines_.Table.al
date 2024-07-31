table 50400 "Trustee Reversal Lines"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Trustee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." WHERE("Employment Type"=FILTER(Trustee));

            trigger OnValidate()
            begin
                if Employee.Get("Trustee No")then "Trustee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(4; "Trustee Name"; Text[100])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(5; "Pay Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Period Trustees";
        }
        field(6; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("Trustee No"), "Payroll Period"=FIELD("Pay Period"), "Non-Cash Benefit"=CONST(false), "Normal Earnings"=CONST(true), "Insurance Code"=FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Taxable=CONST(true), "Employee No"=FIELD("Trustee No"), "Payroll Period"=FIELD("Pay Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("Trustee No"), "Payroll Period"=FIELD("Pay Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Net Pay"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("Trustee No"), "Payroll Period"=FIELD("Pay Period"), "Non-Cash Benefit"=CONST(false), "Tax Relief"=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
}

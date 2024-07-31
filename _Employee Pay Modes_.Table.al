table 50368 "Employee Pay Modes"
{
    DrillDownPageID = "Employee Pay Modes";
    LookupPageID = "Employee Pay Modes";

    fields
    {
        field(1; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(4; "Total Earnings"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Payroll Period"=FIELD("Pay Period Filter"), "Pay Mode"=FIELD("Pay Mode")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Deduction), "Payroll Period"=FIELD("Pay Period Filter"), "Pay Mode"=FIELD("Pay Mode")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(7; "Pay Mode Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(8; "Net Pay A/C"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; "Pay Mode")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

table 50375 "Employee Payroll Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "All Employees"; Integer)
        {
            CalcFormula = Count(Employee);
            FieldClass = FlowField;
        }
        field(3; "Board Employees"; Integer)
        {
            Caption = 'Board Members';
            CalcFormula = Count("Board of Director");
            FieldClass = FlowField;
        }
        field(4; "Active Employees"; Integer)
        {
            Caption = 'Active Employees';
            CalcFormula = Count(Employee WHERE(Status=CONST(Active), "Employment Type"=filter(<>Trustee)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

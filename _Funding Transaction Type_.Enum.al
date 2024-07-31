enum 50104 "Funding Transaction Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Principal")
    {
    Caption = 'Principal';
    }
    value(1; "Interest")
    {
    Caption = 'Interest';
    }
    value(2; "Accrued Interest")
    {
    Caption = 'Accrued Interest';
    }
    value(3; "Principal Repayment")
    {
    Caption = 'Principal Repayment';
    }
    value(4; "Interest Repayment")
    {
    Caption = 'Interest Repayment';
    }
    value(5; "Penalty")
    {
    Caption = 'Penalty';
    }
    value(6; "Penalty Repayment")
    {
    Caption = 'Penalty Repayment';
    }
}

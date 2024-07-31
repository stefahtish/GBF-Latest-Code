report 50234 "PAYE Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PAYEReport.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            trigger OnAfterGetRecord()
            begin
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                if AssignMatrix.Find('-') then begin
                    Earnings.Reset;
                    Earnings.SetRange(Code, Code);
                    if Earnings.Find('-') then begin
                        if Earnings."Basic Salary Code" then BasicSalary := AssignMatrix.Amount;
                    end;
                end;
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
    var
        Earnings: Record EarningsX;
        Deductions: Record DeductionsX;
        AssignMatrix: Record "Assignment Matrix-X";
        BasicSalary: Decimal;
}

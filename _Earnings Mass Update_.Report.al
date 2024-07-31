report 50218 "Earnings Mass Update"
{
    ApplicationArea = All;
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(Active));
            RequestFilterFields = "No.", "Global Dimension 1 Code";

            trigger OnAfterGetRecord()
            begin
                // PayrollRun.DefaultAssignment(Employee);
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
        Direction: Option " ",Increase,Decrease;
        UpdateType: Option " ",Percentage,FlatAmount;
        FlatAmount: Decimal;
        Percentage: Decimal;
        ActionType: Option " ",Add,Modify;
        Assignmat: Record "Assignment Matrix-X";
        EarningRec: Record EarningsX;
        PayPeriod: Record "Payroll PeriodX";
        BeginDate: Date;
        PayrollRun: Report "Payroll Run";

    procedure GetEarnings(var EarnRec: Record EarningsX)
    begin
        EarningRec := EarnRec;
    end;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            //PayPeriodtext:=PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
        end;
    end;
}

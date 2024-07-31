codeunit 50148 "Leave Accrual"
{
    var LeaveBalance: Decimal;
    AccrualRate: Decimal;
    DayCounter: Integer;
    procedure AccrueLeave()
    begin
        LeaveBalance:=0; // Initialize leave balance
        AccrualRate:=1.75; // Set accrual rate
        // Loop for 30 days
        for DayCounter:=1 to 30 do begin
            LeaveBalance+=AccrualRate; // Accrue leave
            Message('Day %1: Leave Balance = %2', DayCounter, LeaveBalance); // Display leave balance
        end;
    end;
}

tableextension 50111 EmployeeAbsenceTableExt extends "Employee Absence"
{
    fields
    {
        modify("From Date")
        {
        trigger OnAfterValidate()
        var
            Absence: Record "Employee Absence";
        begin
            if("From Date" <> 0D) and ("To Date" <> 0D)then begin
                Absence.RESET;
                Absence.SETRANGE("Employee No.", "Employee No.");
                IF Absence.FindFirst THEN repeat IF("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date")THEN ERROR('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                        IF("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date")THEN ERROR('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                    until Absence.Next = 0;
            end;
        end;
        }
        modify("To Date")
        {
        trigger OnAfterValidate()
        var
            NoOfDaysOff: Decimal;
            CalendarMgmt: Codeunit "Calendar Management";
            GeneralOptions: Record "Company Information";
            Description: Text[30];
            HRmgt: Codeunit "HR Management";
            NoofDays: Integer;
            d: Date;
            Error000: Label 'You to date must be greater than from date';
            NonworkingDaysAbsent: Decimal;
            LeaveTypes: Record "Leave Type";
            BaseCalendar: Record "Base Calendar Change";
            BaseCalender: Record "Date";
            Absence: Record "Employee Absence";
        begin
            if("From Date" <> 0D) and ("To Date" <> 0D)then begin
                if "To Date" < "From Date" then Error(Error000);
                Absence.RESET;
                Absence.SETRANGE("Employee No.", "Employee No.");
                IF Absence.FindFirst THEN repeat IF("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date")THEN ERROR('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                        IF("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date")THEN ERROR('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                    until Absence.Next = 0;
            end;
            GeneralOptions.GET;
            NonworkingDaysAbsent:=0;
            //"No. of Off Days" := ("Recalled To" - "Recalled From");
            IF "To Date" <> 0D THEN BEGIN
                IF "From Date" <> 0D THEN BEGIN
                    d:="From Date";
                    REPEAT IF HrMgt.CheckDateStatusCustom(GeneralOptions."Base Calendar Code", d, Description)THEN BEGIN
                            NonworkingDaysAbsent:=NonworkingDaysAbsent + 1;
                        // MESSAGE('%1', NonworkingDaysRecall);
                        END;
                        IF LeaveTypes.GET THEN BEGIN
                            IF NOT LeaveTypes."Inclusive of Holidays" THEN BEGIN
                                BaseCalendar.RESET;
                                BaseCalendar.SETRANGE(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code");
                                BaseCalendar.SETRANGE(BaseCalendar.Date, d);
                                BaseCalendar.SETRANGE(BaseCalendar.Nonworking, TRUE);
                                BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                IF BaseCalendar.FIND('-')THEN BEGIN
                                    NonworkingDaysAbsent:=NonworkingDaysAbsent + 1;
                                END;
                            END;
                            IF NOT LeaveTypes."Inclusive of Saturday" THEN BEGIN
                                BaseCalender.RESET;
                                BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                BaseCalender.SETRANGE(BaseCalender."Period No.", 6);
                                IF BaseCalender.FIND('-')THEN BEGIN
                                    BEGIN
                                        NonworkingDaysAbsent:=NonworkingDaysAbsent + 1;
                                    END;
                                END;
                            END;
                            IF NOT LeaveTypes."Inclusive of Sunday" THEN BEGIN
                                BaseCalender.RESET;
                                BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                BaseCalender.SETRANGE(BaseCalender."Period No.", 7);
                                IF BaseCalender.FIND('-')THEN BEGIN
                                    NonworkingDaysAbsent:=NonworkingDaysAbsent + 1;
                                END;
                            END;
                            IF LeaveTypes."Off/Holidays Days Leave" THEN;
                        END;
                        d:=CALCDATE('1D', d);
                    UNTIL d = "To Date";
                    Quantity:=("To Date" - "From Date");
                    Quantity:=Quantity - NonworkingDaysAbsent + 1;
                END;
            end;
        end;
        }
        modify("Cause of Absence Code")
        {
        trigger OnAfterValidate()
        var
            HRSetup: Record "Human Resources Setup";
            EmployeeAbsence: Record "Employee Absence";
        begin
            HRSetup.GET;
            "Unit of Measure Code":=HRSetup."Base Unit of Measure";
            EmployeeAbsence.Reset;
            EmployeeAbsence.SetRange(EmployeeAbsence."Cause of Absence Code", "Cause of Absence Code");
            if EmployeeAbsence.Find('-')then Description:=EmployeeAbsence.Description;
        end;
        }
        field(50000; "Company Leave"; Boolean)
        {
        }
        field(50001; Weight; Integer)
        {
        }
        field(50002; Approved; Boolean)
        {
        }
        field(50003; "Transfered to Payroll"; Boolean)
        {
        }
        field(50004; "Maturity Date"; Date)
        {
        }
        field(50005; "Affects Leave"; Boolean)
        {
        }
    }
}

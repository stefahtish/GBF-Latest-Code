report 50466 "Leave Plan Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LeavePlanner.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(No_; "No.")
            {
            }
            column(First_Name; "First Name")
            {
            }
            column(Last_Name; "Last Name")
            {
            }
            column(Month; Month)
            {
            }
            column(Year; Year)
            {
            }
            dataitem(Integer; Integer)
            {
                column(Date; ArrayDate[Integer.Number])
                {
                }
                column(DayOfTheWeek; ArrayDayOfTheWeek[Integer.Number])
                {
                }
                column(Value; ArrayValue[Integer.Number])
                {
                }
                trigger OnPreDataItem()
                begin
                    Setrange(Number, 1, i);
                end;
            }
            trigger OnAfterGetRecord()
            var
                LeavePlannerLines: Record "Leave Planner Lines";
                BaseCalendar: Record "Customized Calendar Change";
                EmployeeOff: Record "Employee Absence";
            begin
                EndDate := CalcDate('CM', StartDateCopy);
                Month := Format(StartDateCopy, 0, '<Month Text>');
                Year := Format(StartDateCopy, 0, '<Year4>');
                i := 1;
                while StartDateCopy <= EndDate do begin
                    ArrayDate[i] := format(StartDateCopy, 0, 1);
                    ArrayDayOfTheWeek[i] := FORMAT(StartDateCopy, 0, '<Weekday Text>');
                    LeavePlannerLines.Reset();
                    LeavePlannerLines.SetRange("Employee No.", "No.");
                    LeavePlannerLines.SetFilter("Start Date", '>=%1', StartDateCopy);
                    LeavePlannerLines.SetFilter("End Date", '<=%1', StartDateCopy);
                    if LeavePlannerLines.FindFirst() then ArrayValue[i] := OffType::Leave;
                    BaseCalendar.Reset();
                    BaseCalendar.SetRange(Date, StartDateCopy);
                    BaseCalendar.SetRange(Nonworking, true);
                    if BaseCalendar.FindFirst() then ArrayValue[i] := OffType::Holiday;
                    StartDateCopy += 1;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field("Start Date"; "Start Date")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        // StartDate := GetRangeMin("Date Filter");
        // EndDate := GetRangeMax("Date Filter");
        if "Start Date" = 0D then Error('Please insert start date');
        StartDateCopy := "Start Date";
    end;

    var
        i: Integer;
        j: Integer;
        OffType: Option "",Leave,"Sick Leave","Holiday",Off;
        ArrayDate: array[10000] of Text;
        ArrayDayOfTheWeek: array[10000] of Text;
        ArrayValue: array[10000] of Option;
        "Start Date": Date;
        EndDate: Date;
        StartDateCopy: Date;
        Month: Text[100];
        Year: Text;
}

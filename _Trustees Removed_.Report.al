report 50285 "Trustees Removed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TrusteesRemoved.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Payroll PeriodX"; "Payroll PeriodX")
        {
            RequestFilterFields = "Pay Period Filter";

            column(STRSUBSTNO__PERIOD___1__UPPERCASE_FORMAT_Thismonth_0___month_text___year4_____; StrSubstNo('PERIOD: %1', UpperCase(Format(Thismonth, 0, '<month text> <year4>'))))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(Payroll_PeriodX__Starting_Date_; UpperCase(Format("Starting Date", 0, '<month text> <year4>')))
            {
            }
            column(Payroll_PeriodX_Name; Name)
            {
            }
            column(EMPLOYEES_REMOVED_FROM_PAYROLLCaption; EMPLOYEES_REMOVED_FROM_PAYROLLCaptionLbl)
            {
            }
            column(Control1000000021Caption; Control1000000021CaptionLbl)
            {
            }
            column(Payroll_PeriodX_Starting_Date; "Starting Date")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.") WHERE("Employee Job Type" = CONST("  "), "Employment Type" = FILTER(Trustee));

                column(Employee__No__; "No.")
                {
                }
                column(First_Name_______Middle_Name________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
                {
                }
                column(Counter; Counter)
                {
                }
                column(Employee__No__Caption; FieldCaption("No."))
                {
                }
                column(NameCaption; NameCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    FoundThismonth := false;
                    FoundLastmonth := false;
                    AssignMat.Reset;
                    AssignMat.SetRange(AssignMat."Employee No", Employee."No.");
                    AssignMat.SetRange(AssignMat."Payroll Period", Thismonth);
                    if AssignMat.Find('+') then FoundThismonth := true;
                    AssignMat.Reset;
                    AssignMat.SetRange(AssignMat."Employee No", Employee."No.");
                    AssignMat.SetRange(AssignMat."Payroll Period", LastMonth);
                    if AssignMat.Find('+') then FoundLastmonth := true;
                    if FoundThismonth and FoundLastmonth then CurrReport.Skip;
                    if not FoundThismonth and not FoundLastmonth then CurrReport.Skip;
                    if not FoundLastmonth and FoundThismonth then CurrReport.Skip;
                    Counter := Counter + 1;
                end;

                trigger OnPreDataItem()
                begin
                    Thismonth := "Payroll PeriodX"."Starting Date";
                    LastMonth := CalcDate('-1M', "Payroll PeriodX"."Starting Date");
                    Counter := 0;
                    Employee.SetRange("Pay Period Filter", "Payroll PeriodX"."Starting Date");
                end;
            }
            trigger OnPreDataItem()
            begin
                "Payroll PeriodX".SetFilter("Starting Date", "Payroll PeriodX".GetFilter("Pay Period Filter"));
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
        AssignMat: Record "Assignment Matrix-X";
        LastMonth: Date;
        Thismonth: Date;
        FoundThismonth: Boolean;
        FoundLastmonth: Boolean;
        Counter: Integer;
        EMPLOYEES_REMOVED_FROM_PAYROLLCaptionLbl: Label 'EMPLOYEES REMOVED FROM PAYROLL';
        Control1000000021CaptionLbl: Label 'Label1000000021';
        NameCaptionLbl: Label 'Name';
}

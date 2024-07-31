table 50702 "Leave Planner Lines"
{
    Caption = 'Leave Planner Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PlannerLines: Record "Leave Planner Lines";
            begin
                PlannerLines.Reset();
                PlannerLines.SetRange("Leave Period", "Leave Period");
                PlannerLines.SetFilter("Line No.", '<>%1', "Line No.");
                if PlannerLines.FindFirst()then begin
                    if("Start Date" >= PlannerLines."Start Date") and ("Start Date" <= PlannerLines."End Date")then Error('Some days in this range are already planned for in this leave period');
                end;
                Validate("End Date");
            end;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PlannerLines: Record "Leave Planner Lines";
            begin
                if "End Date" <> 0D then if "End Date" < "Start Date" then Error(Error001);
                PlannerLines.Reset();
                PlannerLines.SetRange("Leave Period", "Leave Period");
                PlannerLines.SetFilter("Line No.", '<>%1', "Line No.");
                if PlannerLines.FindFirst()then begin
                    if("End Date" >= PlannerLines."Start Date") and ("Start Date" <= PlannerLines."End Date")then Error('Some days in this range are already planned for in this period');
                end;
                NonworkingDays:=0;
                LeaveTypes.Reset();
                LeaveTypes.SetRange("Annual Leave", true);
                if LeaveTypes.FindFirst()then begin
                    IF "End Date" <> 0D THEN BEGIN
                        IF "Start Date" <> 0D THEN BEGIN
                            d:="Start Date";
                            dEndDate:=CalcDate('1D', "End Date");
                            REPEAT // IF HrMgt.CheckDateStatusCustom(GeneralOptions."Base Calendar Code", d, Description) THEN BEGIN
                                //     NonworkingDays := NonworkingDays + 1;
                                // END;
                                IF NOT LeaveTypes."Inclusive of Holidays" THEN BEGIN
                                    BaseCalendar.RESET;
                                    BaseCalendar.SETRANGE(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code");
                                    BaseCalendar.SETRANGE(BaseCalendar.Date, d);
                                    BaseCalendar.SETRANGE(BaseCalendar.Nonworking, TRUE);
                                    BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    IF BaseCalendar.FIND('-')THEN BEGIN
                                        NonworkingDays:=NonworkingDays + 1;
                                    END;
                                END;
                                IF NOT LeaveTypes."Inclusive of Saturday" THEN BEGIN
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 6);
                                    IF BaseCalender.FIND('-')THEN BEGIN
                                        BEGIN
                                            NonworkingDays:=NonworkingDays + 1;
                                        END;
                                    END;
                                END;
                                IF NOT LeaveTypes."Inclusive of Sunday" THEN BEGIN
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 7);
                                    IF BaseCalender.FIND('-')THEN BEGIN
                                        NonworkingDays:=NonworkingDays + 1;
                                    END;
                                END;
                                d:=CALCDATE('1D', d);
                            UNTIL d = dEndDate;
                            Days:=("End Date" - "Start Date");
                            Days:=Days - NonworkingDays + 1;
                        END;
                    end;
                end;
            end;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Days; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
            end;
        }
        field(7; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
    }
    keys
    {
        key(PK; "Document No.", "Leave Period", "Start Date", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Getheader();
    end;
    var GeneralOptions: Record "Company Information";
    Description: Text[30];
    HRSetup: Record "Human Resources Setup";
    HRmgt: Codeunit "HR Management";
    NoofDays: Integer;
    Error001: Label 'End date must be later than start date';
    d: Date;
    dEndDate: Date;
    NonworkingDays: Decimal;
    LeaveTypes: Record "Leave Type";
    BaseCalendar: Record "Base Calendar Change";
    BaseCalender: Record "Date";
    procedure Getheader()
    var
        LeavePlanner: Record "Leave Planner Header";
    begin
        LeavePlanner.SetRange("No.", "Document No.");
        if LeavePlanner.FindFirst()then "Employee No.":=LeavePlanner."Employee No.";
    end;
}

table 50217 "Employee Off/Holiday"
{
    DrillDownPageID = "Leave Recall List";
    LookupPageID = "Leave Recall List";

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No")then begin
                    "Employee Name":=Emp."First Name" + '' + Emp."Middle Name" + '' + Emp."Last Name";
                end;
            end;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Approved; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Leave Types".Reset;
                "Leave Types".SetRange("Leave Types"."Off/Holidays Days Leave", true);
                if "Leave Types".Find('-')then;
                "Employee Leave".Reset;
                "Employee Leave".SetRange("Employee Leave"."Employee No", "Employee No");
                "Employee Leave".SetRange("Employee Leave"."Leave Code", "Leave Types".Code);
                if "Employee Leave".Find('-')then;
                if Approved = true then begin
                    "Employee Leave".Balance:="Employee Leave".Balance + 1;
                    "Employee Leave".Modify;
                end
                else
                begin
                    "Employee Leave".Balance:="Employee Leave".Balance - 1;
                    "Employee Leave".Modify;
                end;
            end;
        }
        field(5; "Leave Application"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Application"."Application No" WHERE(Status=CONST(Released));

            trigger OnValidate()
            begin
                /*GeneralOptions.GET;
                 IF LeaveApplication.GET("Leave Application") THEN
                 BEGIN
                   NoOfDaysOff:=0;
                     "Leave Ending Date":=LeaveApplication."End Date";
                     "Employee No":=LeaveApplication."Employee No";
                     "Employee Name":=LeaveApplication."Employee Name";
                   IF LeaveApplication."End Date"<>0D THEN
                   BEGIN
                   NextDate:="Recall Date";
                   REPEAT
                   IF NOT CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code",NextDate,Description) THEN
                   NoOfDaysOff:=NoOfDaysOff+1;
                
                   NextDate:=CALCDATE('1D',NextDate);
                   UNTIL NextDate=LeaveApplication."End Date";
                   END;
                
                 END;
                
                  "No. of Off Days":=NoOfDaysOff;
                */
                LeaveApplication.Reset;
                LeaveApplication.SetRange(LeaveApplication."Application No", "Leave Application");
                if LeaveApplication.FindFirst then begin
                    "Employee No":=LeaveApplication."Employee No";
                    "Employee Name":=LeaveApplication."Employee Name";
                    "Leave Start Date":=LeaveApplication."Start Date";
                    "Leave Ending Date":=LeaveApplication."End Date";
                end;
            end;
        }
        field(6; "Recall Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Leave Application");
            end;
        }
        field(7; "No. of Off Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Leave Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment";
        }
        field(14; "Fiscal Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Recalled By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Recalled By")then Name:=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(16; Name; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Reason for Recall"; Text[130])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Recalled From"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Recalled From" < "Recall Date" then Error(Error000);
                if "Recalled From" < "Leave Start Date" then Error(Error001);
                if "Recalled From" > "Leave Ending Date" then Error(Error001);
                ERecalls.Reset();
                ERecalls.SetFilter("No.", '<>%1', "No.");
                ERecalls.SetRange("Leave Application", "Leave Application");
                if ERecalls.FindFirst()then begin
                    if("Recalled From" >= ERecalls."Recalled From") and ("Recalled From" <= ERecalls."Recalled To")then Error('Some days in this range are already recalled for this leave, recall no %1', ERecalls."No.");
                end;
            end;
        }
        field(21; "Recalled To"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Recalled To" <> 0D then if "Recalled To" < "Recall Date" then Error(Error003);
                if "Recalled To" > "Leave Ending Date" then Error(Error002);
                ERecalls.Reset();
                ERecalls.SetFilter("No.", '<>%1', "No.");
                ERecalls.SetRange("Leave Application", "Leave Application");
                if ERecalls.FindFirst()then begin
                    if("Recalled To" >= ERecalls."Recalled From") and ("Recalled To" <= ERecalls."Recalled To")then Error('Some days in this range are already recalled for this leave, recall no %1', ERecalls."No.");
                end;
                GeneralOptions.GET;
                NonworkingDaysRecall:=0;
                //"No. of Off Days" := ("Recalled To" - "Recalled From");
                IF "Recalled To" <> 0D THEN BEGIN
                    IF "Recalled From" <> 0D THEN BEGIN
                        d:="Recalled From";
                        REPEAT IF HrMgt.CheckDateStatusCustom(GeneralOptions."Base Calendar Code", d, Description)THEN BEGIN
                                NonworkingDaysRecall:=NonworkingDaysRecall + 1;
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
                                        NonworkingDaysRecall:=NonworkingDaysRecall + 1;
                                    //MESSAGE('%1', NonworkingDaysRecall);
                                    END;
                                END;
                                IF NOT LeaveTypes."Inclusive of Saturday" THEN BEGIN
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 6);
                                    IF BaseCalender.FIND('-')THEN BEGIN
                                        BEGIN
                                            NonworkingDaysRecall:=NonworkingDaysRecall + 1;
                                        //MESSAGE('%1', NonworkingDaysRecall);
                                        END;
                                    END;
                                END;
                                IF NOT LeaveTypes."Inclusive of Sunday" THEN BEGIN
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 7);
                                    IF BaseCalender.FIND('-')THEN BEGIN
                                        NonworkingDaysRecall:=NonworkingDaysRecall + 1;
                                    END;
                                END;
                            // IF LeaveTypes."Off/Holidays Days Leave" THEN
                            //     ;
                            END;
                            d:=CALCDATE('1D', d);
                        UNTIL d = "Recalled To";
                        "No. of Off Days":=("Recalled To" - "Recalled From");
                        "No. of Off Days":="No. of Off Days" - NonworkingDaysRecall + 1;
                    END;
                // if ("Recalled To" = "Recalled From") then
                //     "No. of Off Days" := 1
                // else begin
                //     GeneralOptions.Get;
                //     //IF  "Recalled To">"Recall Date" THEN
                //     //ERROR('Recall end date is greater than recall start date');
                //     if LeaveApplication.Get("Leave Application") then begin
                //         NoOfDaysOff := 1;
                //         "Leave Ending Date" := LeaveApplication."End Date";
                //         if LeaveApplication."End Date" <> 0D then begin
                //             NextDate := "Recalled From";
                //             repeat
                //                 /*    if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code", NextDate, Description) then
                //                        NoOfDaysOff := NoOfDaysOff + 1; */
                //                 NextDate := CalcDate('1D', NextDate);
                //             //  UNTIL NextDate=LeaveApplication."End Date";
                //             until NextDate = "Recalled To"; //By Isaac
                //         end;
                //     end;
                //     "No. of Off Days" := NoOfDaysOff;
                // end;
                end;
            END;
        }
        field(22; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Contract No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Leave Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Leave Recall Nos", HRSetup."Leave Recall Nos");
            NoSeriesMgt.InitSeries(HRSetup."Leave Recall Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date:=Today;
        "Recall Date":=Today;
    end;
    var Holidays: Record "Holiday_Off Days";
    "Employee Leave": Record "Employee Leave";
    "Leave Types": Record "Leave Type";
    HumanResSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    ERecalls: Record "Employee Off/Holiday";
    FiscalStart: Date;
    MaturityDate: Date;
    Emp: Record Employee;
    LeaveApplication: Record "Leave Application";
    NextDate: Date;
    NoOfDaysOff: Decimal;
    CalendarMgmt: Codeunit "Calendar Management";
    GeneralOptions: Record "Company Information";
    Description: Text[30];
    HRSetup: Record "Human Resources Setup";
    HRmgt: Codeunit "HR Management";
    NoofDays: Integer;
    Error000: Label 'You cannot Recall Someone earlier than Today';
    Error001: Label 'Recall start date must be later than leave start date and earlier than leave end date';
    Error002: Label 'Recall end date must be later than leave start date and earlier than leave end date';
    Error003: Label 'Recall end date must be later than recall start date';
    d: Date;
    NonworkingDaysRecall: Decimal;
    LeaveTypes: Record "Leave Type";
    BaseCalendar: Record "Base Calendar Change";
    BaseCalender: Record "Date";
}

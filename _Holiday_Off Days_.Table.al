table 50218 "Holiday_Off Days"
{
    fields
    {
        field(1; Date; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                GeneralOptions.Get;
            // IF NOT CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code",Date,Description) THEN
            // ERROR('You can only enter a holiday or weekend');
            end;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.")then begin
                    "Employee Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Reason for Off"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Approved to Work"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Emp: Record Employee;
    FiscalStart: Date;
    Maturitydate: Date;
    CalendarMgmt: Codeunit "Calendar Management";
    GeneralOptions: Record "Company Information";
    HRSetup: Record "Human Resources Setup";
}

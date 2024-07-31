table 50224 "Employee Acting Position"
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Position; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job"."Job ID";

            trigger OnValidate()
            begin
                Jobs.Reset;
                Jobs.SetRange("Job ID", Position);
                if Jobs.Find('-')then begin
                    "Job Description":=Jobs."Job Description";
                end;
            end;
        }
        field(3; "Relieved Employee"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Relieved Employee");
                if Employee.Find('-')then begin
                    "Relieved Name":=(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
                end;
            end;
        }
        field(4; "Relieved Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "End Date" <> 0D then Validate("End Date");
            end;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Promotion Type" = "Promotion Type"::"Acting Position" then begin
                    Acting.Reset;
                    Acting.SetRange("Employee No.", "Employee No.");
                    Acting.SetRange(Status, Acting.Status::Approved);
                    if Acting.Find('-')then repeat if(Acting."Start Date" <= "Start Date") and (Acting."End Date" >= "End Date")then Error('This Employee is on an acting capacity in this period');
                            if(Acting."Start Date" >= "Start Date") and (Acting."Start Date" <= "End Date")then Error('This Employee is on an acting capacity in this period');
                            if(Acting."End Date" >= "Start Date") and (Acting."End Date" <= "End Date")then Error('This Employee is on an acting capacity in this period');
                        until Acting.Next = 0;
                end;
            end;
        }
        field(8; Name; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New, "Pending Approval", Approved, Rejected;
        }
        field(10; "No Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Reason; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Promoted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Job Description"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Employee No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if "Promotion Type" = "Promotion Type"::"Acting Position" then begin
                    if Employee.Get("Employee No.")then;
                    Name:=(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
                    PayPeriod.RESET;
                    PayPeriod.SETRANGE(Closed, FALSE);
                    IF PayPeriod.FINDFIRST THEN BEGIN
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE("Payroll Period", PayPeriod."Starting Date");
                        AssignMatrix.SETRANGE("Employee No", "Employee No.");
                        AssignMatrix.SETRANGE("Basic Salary Code", TRUE);
                        IF AssignMatrix.FIND('-')THEN BEGIN
                            "Basic Pay":=AssignMatrix.Amount;
                        END;
                    end;
                end;
                if "Promotion Type" = "Promotion Type"::Promotion then begin
                    Employee.Reset;
                    Employee.SetRange("No.", "Employee No.");
                    if Employee.Find('-')then begin
                        Name:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        "Current Scale":=Employee."Salary Scale";
                        "Current Pointer":=Employee.Present;
                    end;
                end;
            end;
        }
        field(15; "Promotion Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Acting Position,Promotion';
            OptionMembers = " ", "Acting Position", Promotion;
        }
        field(16; "Requested By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Request Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Desired Position"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                Jobs.Reset;
                Jobs.SetRange("Job ID", "Desired Position");
                if Jobs.Find('-')then begin
                    "Position Name":=Jobs."Job Description";
                end;
            end;
        }
        field(20; "Position Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Acting Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(24; "Current Scale"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(25; "Current Pointer"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer";
        }
        field(26; "Current Benefits"; Decimal)
        {
            CalcFormula = Sum("Scale Benefits".Amount WHERE("Salary Scale"=FIELD("Current Scale"), "Salary Pointer"=FIELD("Current Pointer")));
            FieldClass = FlowField;
        }
        field(27; "New Scale"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(28; "New Pointer"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer"."Salary Pointer";
        }
        field(29; "New Benefits"; Decimal)
        {
            CalcFormula = Sum("Scale Benefits".Amount WHERE("Salary Scale"=FIELD("New Scale"), "Salary Pointer"=FIELD("New Pointer")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                Employee."Salary Scale":="New Scale";
                Employee."Basic Pay":="New Benefits";
                Employee."Job Position Title":="Desired Position";
            end;
        }
        field(30; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Qualified for position"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Acting Nos");
            NoSeriesMgt.InitSeries(HRSetup."Acting Nos", xRec."No Series", 0D, No, "No Series");
        end;
        "Request Date":=Today;
        "User ID":=UserId;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", "User ID");
        if UserSetup.Find('-')then begin
            Employee.Reset;
            Employee.SetRange("User ID", "User ID");
            if Employee.Find('-')then begin
                "Requested By":=Employee."No.";
                "Request Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;
    end;
    var Jobs: Record "Company Job";
    Employee: Record Employee;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    HRSetup: Record "Human Resources Setup";
    Acting: Record "Employee Acting Position";
    UserSetup: Record "User Setup";
    User: Code[60];
    AssignMatrix: Record "Assignment Matrix-X";
    PayPeriod: Record "Payroll PeriodX";
    Earnings: Record EarningsX;
    BasicPayReliever: Decimal;
}

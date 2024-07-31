table 50349 "Fuel Allocations"
{
    Caption = 'Fuel Allocation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Period; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fuel Allocation Periods";

            trigger OnValidate()
            var
                Periods: Record "Fuel Allocation Periods";
                Periods2: Record "Fuel Allocation Periods";
                PrevPeriod: Date;
                HRManagement: Codeunit "HR Management";
            begin
                if Periods.Get(Period)then begin
                    "Start date":=Periods."Start Date";
                    "End date":=Periods."End Date";
                    PrevPeriod:=CalcDate('-1M', "Start date");
                    Periods2.SetRange("Start Date", PrevPeriod);
                    if Periods2.FindFirst()then if Periods2.closed = false then Error('Please close previous period %1 before allocating fuel for this period', Periods2.Period);
                end;
                HRManagement.InsertFuelAllocLines(Rec);
            end;
        }
        field(2; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Fuel Allocation Lines"."Minimum Amount" WHERE(Period=field(Period)));
        }
        field(3; "Allocated by"; Code[20])
        {
            Caption = 'Allocated by';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Allocated by")then "Employee name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(4; "Employee name"; Text[100])
        {
            Caption = 'Employee name';
            DataClassification = ToBeClassified;
        }
        field(5; "Start date"; Date)
        {
            Caption = 'Start date';
            DataClassification = ToBeClassified;
        }
        field(6; "End date"; Date)
        {
            Caption = 'End date';
            DataClassification = ToBeClassified;
        }
        field(7; "Total Usage"; Decimal)
        {
            CalcFormula = Sum("Driver Logging"."Car Fuel Intakes" where(Period=field(Period)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Total Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Fuel Allocation Lines".Balance WHERE(Period=field(Period)));
        }
        field(9; Allocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Period)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "Allocated by":=Employee."No.";
                "Employee name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            END;
        END;
    end;
    var UserSetup: Record "User Setup";
    Employee: Record Employee;
}

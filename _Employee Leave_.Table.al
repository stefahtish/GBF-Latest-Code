table 50216 "Employee Leave"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = Employee."No.";
        }
        field(2; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Leave Type".Code;

            trigger OnValidate()
            begin
                "Leave Types".Reset;
                "Leave Types".SetRange("Leave Types".Code, "Leave Code");
                if "Leave Types".Find('-')then begin
                    ;
                    if "Leave Types".Gender <> "Leave Types".Gender::" " then begin
                        EmployeeRec.Reset;
                        EmployeeRec.SetRange(EmployeeRec."No.", "Employee No");
                        if "Leave Types".Gender = "Leave Types".Gender::Male then begin
                            if EmployeeRec.Gender <> EmployeeRec.Gender::" " then begin
                                "Leave Code":='';
                                Balance:=0;
                                Error('%1', 'You cannot assign this employee this leave.');
                            end;
                        end
                        else
                            Balance:="Leave Types".Days;
                    end
                    else
                        Balance:="Leave Types".Days;
                end;
                Balance:="Leave Types".Days;
            end;
        }
        field(3; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Acrued Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Total Days Taken"; Decimal)
        {
            CalcFormula = Sum("Leave Application"."Days Applied" WHERE("Employee No"=FIELD("Employee No"), "Leave Code"=FIELD("Leave Code"), "Maturity Date"=FIELD("Maturity Date"), Status=CONST(Released)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Entitlement; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("Total Days Taken");
                Balance:=(Entitlement + "Balance Brought Forward" + "Recalled Days") - "Total Days Taken";
            end;
        }
        field(8; "Balance Brought Forward"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Recalled Days"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(10; "First Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No."=FIELD("Employee No")));
            Caption = 'First Name';
            FieldClass = FlowField;
        }
        field(11; "Middle Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."Middle Name" WHERE("No."=FIELD("Employee No")));
            Caption = 'Middle Name';
            FieldClass = FlowField;
        }
        field(12; "Last Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE("No."=FIELD("Employee No")));
            Caption = 'Last Name';
            FieldClass = FlowField;
        }
        field(13; Adjustments; Decimal)
        {
            CalcFormula = Sum("Leave Bal Adjustment Lines"."New Entitlement" WHERE("Staff No."=FIELD("Employee No"), "Leave Code"=FIELD("Leave Code"), "Maturity Date"=FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(60001; "Employment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Inactive,Permanently Inactive';
            OptionMembers = Active, Inactive, "Permanently Inactive";

            trigger OnValidate()
            begin
            /* HumanResSetup.GET;
                 HumanResSetup.TESTFIELD("Maximum Probation Period");
                  IF "Employment Status"="Employment Status"::"Extended Probation" THEN
                  "End Of Probation Date":=CALCDATE(HumanResSetup."Maximum Probation Period","Date Of Join");
                 */
            end;
        }
    }
    keys
    {
        key(Key1; "Employee No", "Leave Code", "Maturity Date")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var "Leave Types": Record "Leave Type";
    EmployeeRec: Record Employee;
    "-----------------Cheruiyot----------------": Integer;
    LeaveType: Record "Leave Type";
    Employee: Record Employee;
    Period: Record "Accounting Period";
    StartDate: Date;
}

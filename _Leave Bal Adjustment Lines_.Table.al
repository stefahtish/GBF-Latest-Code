table 50228 "Leave Bal Adjustment Lines"
{
    fields
    {
        field(1; "Staff No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Staff No.");
                if Employees.Find('-')then begin
                    "Employee Name":=Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
                    "Employment Type":=Employees."Employment Type";
                end;
                LeavePeriods.Reset;
                LeavePeriods.SetRange(closed, false);
                CalcFields("Employment Type");
                if("Employment Type" = "Employment Type"::Permanent)then begin
                    LeavePeriods.SetRange("Employment Type", "Employment Type"::Permanent);
                    if LeavePeriods.FindFirst then "Leave Period":=LeavePeriods."Leave Period";
                end
                else if("Employment Type" = "Employment Type"::Contract)then begin
                        LeavePeriods.SetRange("Employment Type", "Employment Type"::Contract);
                        if LeavePeriods.FindFirst then "Leave Period":=LeavePeriods."Leave Period";
                    end;
            end;
        }
        field(2; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "New Bal. Brought Forward"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "New Entitlement"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "New Entitlement" <> 0 then Validate("Leave Adj Entry Type");
            end;
        }
        field(6; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Leave Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Type".Code;

            trigger OnValidate()
            begin
                //    EmpLeaves.RESET;
                //    EmpLeaves.SETRANGE(EmpLeaves."Employee No","Staff No.");
                //    EmpLeaves.SETRANGE(EmpLeaves."Leave Code","Leave Code");
                //    IF EmpLeaves.FIND('-') THEN BEGIN
                LeaveLedger.Reset;
                LeaveLedger.SetRange(LeaveLedger."Staff No.", "Staff No.");
                LeaveLedger.SetRange(LeaveLedger."Leave Type", "Leave Code");
                LeaveLedger.SetRange(LeaveLedger."Leave Period Code", "Leave Period");
                if LeaveLedger.Find('-')then begin
                    LeaveLedger.CalcSums("No. of days", "Balance Brought Forward");
                    CurrentEntitlement:=LeaveLedger."No. of days";
                    CurrentBalFoward:=LeaveLedger."Balance Brought Forward";
                end;
                AccPeriod.Reset;
                AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
                AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
                if AccPeriod.Find('+')then begin
                    MaturityDate:=CalcDate('1Y', AccPeriod."Starting Date") - 1;
                end;
                "Maturity Date":=MaturityDate;
            end;
        }
        field(8; CurrentEntitlement; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; CurrentBalFoward; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Employment Type"; Option)
        {
            CalcFormula = Lookup(Employee."Employment Type" WHERE("No."=FIELD("Staff No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Permanent,Partime,Casual,Contract,Board member,Attachee,Intern';
            OptionMembers = Permanent, Partime, Casual, Contract, Trustee, Attachee, Intern;
        }
        field(11; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Employment Type"=CONST(Permanent))"Leave Periods" WHERE(closed=CONST(false), "Employment Type"=CONST(Permanent))
            ELSE IF("Employment Type"=CONST(Contract))"Leave Periods" WHERE(closed=CONST(false), "Employment Type"=CONST(Contract))
            ELSE IF("Employment Type"=CONST(Attachee))"Leave Periods" WHERE(closed=CONST(false), "Employment Type"=CONST(Attachee))
            ELSE IF("Employment Type"=CONST(Intern))"Leave Periods" WHERE(closed=CONST(false), "Employment Type"=CONST(Intern))
            ELSE IF("Employment Type"=CONST(Casual))"Leave Periods" WHERE(closed=CONST(false), "Employment Type"=CONST(Casual))
            ELSE IF("Employment Type"=CONST(Trustee))"Leave Periods" WHERE(closed=CONST(false), "Employment Type"=CONST(Trustee))
            ELSE IF("Employment Type"=CONST(Partime))"Leave Periods" WHERE(closed=CONST(false), "Employment Type"=CONST(Partime));
        }
        field(12; "Leave Adj Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive, Negative;

            trigger OnValidate()
            begin
                if "Leave Adj Entry Type" = "Leave Adj Entry Type"::Negative then "New Entitlement":=-"New Entitlement"
                else
                    "New Entitlement":="New Entitlement";
            end;
        }
        field(13; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Leave Allocation,Leave Recall,OverTime,Leave Application,Leave Adjustment,Leave B/F,Absent';
            OptionMembers = " ", "Leave Allocation", "Leave Recall", OverTime, "Leave Application", "Leave Adjustment", "Leave B/F", Absent;

            trigger OnValidate()
            begin
                case "Transaction Type" of "Transaction Type"::Absent, "Transaction Type"::"Leave Application": "Leave Adj Entry Type":="Leave Adj Entry Type"::Negative;
                "Transaction Type"::"Leave Adjustment", "Transaction Type"::"Leave Allocation", "Transaction Type"::"Leave B/F", "Transaction Type"::"Leave Recall": "Leave Adj Entry Type":="Leave Adj Entry Type"::Positive;
                else
                    "Leave Adj Entry Type":="Leave Adj Entry Type"::Negative;
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "Header No.", "Staff No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employees: Record Employee;
    EmpLeaves: Record "Employee Leave";
    AdjustHeader: Record "Leave Bal Adjustment Header";
    AccPeriod: Record "Accounting Period";
    LeaveLedger: Record "HR Leave Ledger Entries";
    LeavePeriods: Record "Leave Periods";
    MaturityDate: Date;
}

table 50356 "Employee Account History"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Payroll PeriodX";
        }
        field(3; "Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;
        }
        field(4; "Bank Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code"=FIELD("Bank Code"));
        }
        field(5; "Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Payroll Period")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    procedure UpdateAccountDetails(EmpRec: Record Employee; PayPeriod: Date)
    var
        EmpAccHistory: Record "Employee Account History";
    begin
        EmpAccHistory.Reset;
        EmpAccHistory.SetRange("Employee No.", EmpRec."No.");
        EmpAccHistory.SetRange("Payroll Period", PayPeriod);
        if EmpAccHistory.Find('-')then begin
            EmpAccHistory."Bank Code":=EmpRec."Employee's Bank";
            EmpAccHistory."Bank Branch":=EmpRec."Bank Branch";
            EmpAccHistory."Account No":=EmpRec."Bank Account Number";
            EmpAccHistory.Modify;
        end
        else
        begin
            EmpAccHistory.Init;
            EmpAccHistory."Employee No.":=EmpRec."No.";
            EmpAccHistory."Payroll Period":=PayPeriod;
            EmpAccHistory."Bank Code":=EmpRec."Employee's Bank";
            EmpAccHistory."Bank Branch":=EmpRec."Bank Branch";
            EmpAccHistory."Account No":=EmpRec."Bank Account Number";
            if not EmpAccHistory.Get("Employee No.", "Payroll Period")then EmpAccHistory.Insert;
        end;
    end;
}

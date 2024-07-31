table 50700 "Employee Salary Increment"
{
    Caption = 'Employee Salary Increment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            DataClassification = ToBeClassified;
        }
        field(3; "Previous Salary Scale"; Code[10])
        {
            Caption = 'Previous Salary Scale';
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale".Scale;
        }
        field(4; "Previous Salary Pointer"; Code[10])
        {
            Caption = 'Previous Salary Pointer';
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer"."Salary Pointer" WHERE("Salary Scale"=FIELD("Previous Salary Scale"));
        }
        field(5; "Previous Salary"; Decimal)
        {
            Caption = 'Previous Salary';
            DataClassification = ToBeClassified;
        }
        field(6; "Current Salary Scale"; Code[10])
        {
            Caption = 'Current Salary Scale';
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale".Scale;
        }
        field(7; "Current Salary Pointer"; Code[10])
        {
            Caption = 'Current Salary Pointer';
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer"."Salary Pointer" WHERE("Salary Scale"=FIELD("Current Salary Scale"));
        }
        field(8; "Current Salary"; Decimal)
        {
            Caption = 'Current Salary';
            DataClassification = ToBeClassified;
        }
        field(9; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
    }
    keys
    {
        key(PK; "Employee No.", "Payroll Period")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        Payroll: Codeunit Payroll;
        PayPeriod: date;
        Text001: Label 'You can only delete entries of the current Payroll Period %1.';
    begin
        PayPeriod:=Payroll.GetPayPeriod();
        if PayPeriod <> "Payroll Period" then error(Text001, Format(PayPeriod));
    end;
}

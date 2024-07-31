table 50395 "Loan Interest Lines"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Application"."Loan No" WHERE("Loan Status"=FILTER(Issued));
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.")then begin
                    Employee.TestField(Employee."Debtor Code");
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Debtor Code":=Employee."Debtor Code";
                end;
            end;
        }
        field(5; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Period Reference"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX"."Starting Date";

            trigger OnValidate()
            var
                PeriodRec: Record "Accounting Period";
            begin
            end;
        }
        field(7; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Interest Due"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Debtor Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
}

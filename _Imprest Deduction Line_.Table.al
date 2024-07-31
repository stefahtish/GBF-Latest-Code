table 50402 "Imprest Deduction Line"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Imprest Deduction";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                "Employee Name":='';
                if Employee.Get("Employee No.")then begin
                    "Employee Name":=Employee."First Name";
                    if Employee."Middle Name" <> '' then if "Employee Name" <> '' then "Employee Name"+=' ' + Employee."Middle Name"
                        else
                            "Employee Name":=Employee."Middle Name";
                    if Employee."Last Name" <> '' then if "Employee Name" <> '' then "Employee Name"+=' ' + Employee."Last Name"
                        else
                            "Employee Name":=Employee."Last Name";
                end;
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Imprest No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Payments WHERE("Payment Type"=CONST(Imprest), Posted=CONST(true), Surrendered=CONST(false), "Staff No."=FIELD("Employee No."));
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX";
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

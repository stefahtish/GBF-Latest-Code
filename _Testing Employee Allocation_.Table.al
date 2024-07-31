table 50570 "Testing Employee Allocation"
{
    Caption = 'Testimg Employee Allocation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Allocation No"; Code[20])
        {
            Caption = 'Allocation No';
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee No")then "Employee name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(3; "Employee name"; Text[100])
        {
            Caption = 'Employee name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Allocation No", "Employee No")
        {
            Clustered = true;
        }
    }
}

table 50563 "Laboratory Setup Type"
{
    fields
    {
        field(1; Name; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type;Enum LabSetupTypes)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Lab Section"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Lab section to test"));
        }
        field(5; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.get("Employee No.")then "Employee Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(6; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Options; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Is Retention Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Has Unit of Measure"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Unit of Measure"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
    }
    keys
    {
        key(PK; Name)
        {
            clustered = true;
        }
    }
}

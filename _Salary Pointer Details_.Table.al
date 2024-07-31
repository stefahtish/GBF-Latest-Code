table 50374 "Salary Pointer Details"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Present; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Previous; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

table 50315 "Training Participant"
{
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Training Need"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Need" where(Status=filter(Open|Application));
        }
        field(3; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No")then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation:=Employee."Job Title";
                    "Salary Scale":=Employee."Salary Scale";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Salary Scale"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale".Scale;
        }
    }
    keys
    {
        key(Key1; "Training Need", Code, "Employee No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
}

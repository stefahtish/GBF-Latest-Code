table 50219 "Appointment Checklist"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            /*
                  OK:= Employee.GET(Date);
                  IF OK THEN BEGIN
                   "Maturity Date":= Employee."First Name";
                   "No. of Days":= Employee."Last Name";
                  END;
                */
            end;
        }
        field(3; Item; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Signed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Employee First Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Employee Last Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.", Item)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    OK: Boolean;
}

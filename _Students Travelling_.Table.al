table 50238 "Students Travelling"
{
    DrillDownPageID = "Students Travelling";
    LookupPageID = "Students Travelling";

    fields
    {
        field(1; "Request No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Student No"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                Customer.RESET;
                Customer.SETRANGE("No.","Student No");
                IF Customer.FIND('-') THEN
                  BEGIN
                    MESSAGE("Student No");
                    "Student Name":=Customer.Name;
                  END;
                */
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Student Programme"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Student Programme Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Request No", "Student No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Customer: Record Customer;
}

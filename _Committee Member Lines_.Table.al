table 50721 "Committee Member Lines"
{
    Caption = 'Commitee Member Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[50])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Employee No.");
                if Employee.Find('-')then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Employee Email":=Employee."Company E-Mail";
                end;
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Email"; Code[50])
        {
            Caption = 'Employee Email';
            DataClassification = ToBeClassified;
        }
        field(4; "Batch No."; Code[50])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Employee No.", "Batch No.")
        {
            Clustered = true;
        }
    }
    var Employee: Record Employee;
}

table 50704 "Interview Panelist"
{
    Caption = 'Interview Panelist';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[100])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EmpRec: Record Employee;
            begin
                If EmpRec.Get("Employee No.")then begin
                    "Employee Name":=EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                end;
            end;
        }
        field(4; "Employee Name"; Text[300])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
}

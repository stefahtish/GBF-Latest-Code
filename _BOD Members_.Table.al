table 50410 "BOD Members"
{
    Caption = 'Committee Members';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Empl.GET("Employee No")THEN BEGIN
                    Name:=Empl."First Name" + ' ' + Empl."Last Name";
                END;
            end;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(4; Role; Text[50])
        {
            Caption = 'Chair';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var Empl: Record Employee;
    Appointment: Record "Tender Committee Appointment";
}

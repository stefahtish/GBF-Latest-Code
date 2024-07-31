table 50162 "Committee Members"
{
    Caption = 'Committee Members';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ref No"; Code[20])
        {
            Caption = 'Ref No';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";
        }
        field(2; Committee; Code[20])
        {
            Caption = 'Committee';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Committees";
        }
        field(3; "Employee No"; Code[20])
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
        field(4; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Appointment No"; Code[20])
        {
            Caption = 'Appointement No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Appointment.GET("Appointment No")THEN BEGIN
                    "Appointment No":=Appointment."Appointment No";
                    Committee:=Appointment."Committee ID";
                END;
            end;
        }
        field(6; Chair; Boolean)
        {
            Caption = 'Chair';
            DataClassification = ToBeClassified;
        }
        field(7; Secretary; Boolean)
        {
            Caption = 'Secretary';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Ref No")
        {
            Clustered = true;
        }
    }
    var Empl: Record Employee;
    Appointment: Record "Tender Committee Appointment";
}

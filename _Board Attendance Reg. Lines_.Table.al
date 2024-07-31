table 50404 "Board Attendance Reg. Lines"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Employment Type"=filter(Trustee));

            trigger OnValidate()
            begin
                "Employee Name":='';
                if Employee.Get("Employee No.")then begin
                    "Employee Name":=Employee."First Name";
                    if Employee."Middle Name" <> '' then if "Employee Name" <> '' then "Employee Name"+=' ' + Employee."Middle Name"
                        else
                            "Employee Name":=Employee."Middle Name";
                    if Employee."Last Name" <> '' then if "Employee Name" <> '' then "Employee Name"+=' ' + Employee."Last Name"
                        else
                            "Employee Name":=Employee."Last Name";
                end;
                EarningX.Reset();
                EarningX.SetRange(BoardSittingAllowance, true);
                if EarningX.FindFirst()then begin
                    EarningX.TestField("Flat Amount");
                    "Sitting allowance":=EarningX."Flat Amount";
                end
                else
                    Error(SittingAllError);
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No of sittings"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:="No of sittings" * "Sitting allowance";
            end;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX";
        }
        field(7; "Sitting allowance"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:="No of sittings" * "Sitting allowance";
            end;
        }
        field(8; Mileage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Per Diem"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Employee No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    EarningX: Record EarningsX;
    SittingAllError: Label 'Please setup board sitting allowance';
}

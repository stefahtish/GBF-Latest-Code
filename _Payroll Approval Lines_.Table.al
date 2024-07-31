table 50549 "Payroll Approval Lines"
{
    Caption = 'Payroll Approval Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; "Payee Type"; Option)
        {
            Caption = 'Payee Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Employee, Pensioner, Beneficiary;
        }
        field(4; "Payee No"; Code[20])
        {
            Caption = 'Payee No';
            DataClassification = ToBeClassified;
            TableRelation = if("Payee Type"=const(Employee))Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
                FullName: Text;
            begin
                FullName:='';
                case "Payee Type" of "Payee Type"::Employee: begin
                    if Employee.Get("Payee No")then FullName:=HrManagement.GetFullName(Employee."First Name", Employee."Middle Name", Employee."Last Name");
                end;
                end;
                "Payee Name":=FullName;
            end;
        }
        field(5; "Payee Name"; Text[150])
        {
            Caption = 'Payee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Previous Earning"; Decimal)
        {
            Caption = 'Previous Earning';
            DataClassification = ToBeClassified;
        }
        field(7; "Increament Amount"; Decimal)
        {
            Caption = 'Increament Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Total Earning"; Decimal)
        {
            Caption = 'Total Earning';
            DataClassification = ToBeClassified;
        }
        field(9; "Total Deduction"; Decimal)
        {
            Caption = 'Total Deduction';
            DataClassification = ToBeClassified;
        }
        field(10; "Total Arrears"; Decimal)
        {
            Caption = 'Total Arrears';
            DataClassification = ToBeClassified;
        }
        field(11; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2: 2;
        }
        field(12; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            FieldClass = FlowField;
            CalcFormula = lookup("Payroll Approval"."Payroll Period" where("No."=field("Document No.")));
        }
        field(13; Generated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }
    var HrManagement: Codeunit "HR Management";
}

table 50701 "Leave Planner Header"
{
    Caption = 'Leave Planner Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                emp: Record Employee;
            begin
                if emp.Get("Employee No.")then "Employee Name":=emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                CalcFields("Employment Type");
                "Leave Period":=HRmgt.GetCurrentLeavePeriod("Employment Type");
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Days Planned"; Decimal)
        {
            Caption = 'Days Planned';
            FieldClass = FlowField;
            CalcFormula = sum("Leave Planner Lines".Days where("Document No."=field("No.")));
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Employment Type"; Option)
        {
            CalcFormula = Lookup(Employee."Employment Type" WHERE("No."=FIELD("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Contract,Permanent,Trustee,Attachee,Intern';
            OptionMembers = Contract, Permanent, Trustee, Attachee, Intern;
        }
        field(8; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Used; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "User ID Filter"; Code[100])
        {
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
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Leave Plan Nos");
            NoSeriesMgt.InitSeries(HRSetup."Leave Plan Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    HRmgt: Codeunit "HR Management";
}

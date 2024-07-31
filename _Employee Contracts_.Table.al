table 50273 "Employee Contracts"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Contract Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract";

            trigger OnValidate()
            begin
                if Contract.Get("Contract Type")then begin
                    Tenure:=Contract.Tenure;
                end;
            end;
        }
        field(3; Tenure; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Start Date" > Today then Error('You cannot enter a date Later than today');
                "End Date":=CalcDate(Tenure, "Start Date");
            end;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee WHERE("Employment Type"=FILTER(Contract));

            trigger OnValidate()
            begin
                if Employee.Get("Employee No")then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(7; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released';
            OptionMembers = Open, "Pending Approval", Released;
        }
        field(11; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Contract Nos");
            NoSeriesMgt.InitSeries(HRSetup."Contract Nos", xRec."Employee Name", 0D, "No.", "No Series");
        end;
        Date:=Today;
        "User ID":=CopyStr(UserId, 1, 20);
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Employee: Record Employee;
    Contract: Record "Employment Contract";
}

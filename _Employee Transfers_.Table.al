table 50233 "Employee Transfers"
{
    fields
    {
        field(1; "Transfer No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if Employee.Get("Employee No")then begin
                    "Employee No":=Employee."No.";
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Job Group":=Employee."Salary Scale";
                    "Mobile No":=Employee."Mobile Phone No.";
                    "Employment Type":=Employee."Employment Type";
                    "Shortcut Dimension 1":=Employee."Global Dimension 1 Code";
                    "Shortcut Dimension 2":=Employee."Global Dimension 2 Code";
                    "Length of Stay":=Dates.DetermineAge(Employee."Date Of Join", Today);
                end;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Mobile No"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Job Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(6; "Current Station"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(7; "Sub County"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; County; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Length of Stay"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Station To Transfer"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(11; "Reason of Transfer"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "HOD Recommendations"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "HOD Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "HOD Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "HOD Employee No");
                if Employee.Find('-')then begin
                    "HOD Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(15; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Transfer Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Transfer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Department,Branch,Branch and Department';
            OptionMembers = " ", Department, Branch, "Branch and Department";
        }
        field(18; "No Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Shortcut Dimension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(20; "Shortcut Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(21; "Department Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(22; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Released';
            OptionMembers = New, "Pending Approval", Released;
        }
        field(23; "Transfer Department Name"; Text[60])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code=FIELD("Station To Transfer")));
            FieldClass = FlowField;
        }
        field(24; Company; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(25; "Employment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Contract,Permanent,Trustee,Attachee,Intern';
            OptionMembers = Contract, Permanent, Trustee, Attachee, Intern;
        }
        field(26; Transferred; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Exceed 50 km"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Transfer No", "Employee No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Transfer No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Transfer Nos");
            NoSeriesMgt.InitSeries(HRSetup."Transfer Nos", xRec."No Series", 0D, "Transfer No", "No Series");
        end;
        Date:=Today;
    end;
    var Employee: Record Employee;
    HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Dimensions: Record "Dimension Value";
    Dates: Codeunit "Dates ManagementHR";
    procedure GetAge(var StartDate: Date)AgeText: Text[200]var
        HRDate: Codeunit "Dates ManagementHR";
    begin
        AgeText:='';
        if StartDate = 0D then begin
            StartDate:=Today end;
        AgeText:=HRDate.DetermineAge(StartDate, Today);
    end;
}

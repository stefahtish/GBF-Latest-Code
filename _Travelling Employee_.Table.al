table 50242 "Travelling Employee"
{
    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.")then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Shortcut Dimension 1":=Employee."Global Dimension 1 Code";
                    Validate("Shortcut Dimension 1");
                    "Department Code":=Employee."Global Dimension 1 Code";
                    Validate("Department Code");
                    //DimVal.Reset;
                    //DimVal.SetRange(Code, "Department Code");
                    //if DimVal.Find('-') then begin
                    //"Department Name" := DimVal.Name;
                    //end;
                    GetJobGroup;
                end;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Source; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Destination; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Travel Insurance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(Code, "Shortcut Dimension 1");
                if DimVal.Find('-')then begin
                    "Department Name":=DimVal.Name;
                end;
            end;
        }
        field(10; "Department Name"; Text[50])
        {
            FieldClass = Normal;
        }
        field(11; "Directorate Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(12; "Directorate name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Per Diem"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Itinerary; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Ticket Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Economy,Business';
            OptionMembers = , Economy, Business;
        }
        field(17; "Cost Centre"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "FSC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Shortcut Dimension 1"; Code[30])
        {
            CaptionClass = '1,2,1';
        //TableRelation = "Dimension Value" WHERE("Global Dimension No." = CONST(1));
        }
        field(20; "Shortcut Dimension 2"; Code[30])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
        //TableRelation = "Dimension Value" WHERE("Global Dimension No." = CONST(2));
        }
    }
    keys
    {
        key(Key1; "Request No.", "Employee No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    Dimensions: Record "Dimension Value";
    DimVal: Record "Dimension Value";
    procedure GetJobGroup()
    var
        Employee: Record Employee;
        Travel: Record "Travelling Employee";
        TransReq: Record "Travel Requests";
        DestinationRate: Record "Destination Rate Entry";
        JobGrade: Code[30];
    begin
        Employee.Reset;
        Employee.SetRange("No.", "Employee No.");
        if Employee.FindFirst then begin
            Employee.TestField("Salary Scale");
            //EXIT(Employee."Salary Scale");
            JobGrade:=Employee."Salary Scale";
            TransReq.Reset;
            TransReq.SetRange("Request No.", "Request No.");
            if TransReq.Find('-')then begin
                DestinationRate.Reset;
                DestinationRate.SetRange("Employee Job Group", JobGrade);
                DestinationRate.SetRange("Destination Code", TransReq.Destinations);
                if DestinationRate.Find('-')then begin
                    "Per Diem":=DestinationRate."Daily Rate (Amount)";
                end;
            end;
        end;
    end;
}

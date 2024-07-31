table 50260 "Employees Travelling"
{
    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(2; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No")then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            //Transp.GetJobGroup;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Tuition Fee"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Cost":="Tuition Fee" + "Per Diem" + "Air Ticket";
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(5; "Per Diem"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Cost":="Tuition Fee" + "Per Diem" + "Air Ticket";
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(6; "Air Ticket"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Cost":="Tuition Fee" + "Per Diem" + "Air Ticket";
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(7; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if Status <> Status::Open then Error('Once document has been released it cannot be edited!');
            end;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected;
        }
    }
    keys
    {
        key(Key1; "Request No.", "Employee No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    Destination: Record Destination;
    Training: Record "Training Request";
    TravelEmp: Record "Employees Travelling";
    DestinationRate: Record "Destination Rate Entry";
    Transp: Record "Travelling Employee";
    local procedure GetJobGroup(): Code[20]var
        Employee: Record Employee;
    begin
        if TravelEmp.Get("Request No.")then begin
            TravelEmp.TestField("Employee No");
            Employee.Reset;
            Employee.SetRange("No.", TravelEmp."Employee No");
            if Employee.FindFirst then exit(Employee."Salary Scale");
        end;
    end;
    local procedure GetDestinationRate(): Decimal begin
        Destination.Reset;
        Destination.SetRange("Destination Code", Training.Venue);
        if Destination.FindFirst then begin
            DestinationRate.Reset;
            DestinationRate.SetRange("Destination Code", Destination."Destination Code");
            DestinationRate.SetRange("Employee Job Group", GetJobGroup);
            //DestinationRate.SETFILTER()
            if DestinationRate.FindFirst then begin
                "Per Diem":=DestinationRate."Daily Rate (Amount)";
            end;
        end;
    end;
}

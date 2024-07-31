table 50264 "House Units"
{
    DrillDownPageID = "Houses List";
    LookupPageID = "Houses List";

    fields
    {
        field(1; "Quaters Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No." WHERE("FA Subclass Code"=FILTER('BUILDING'));
        }
        field(2; "House No"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF "House No">Quaters."No of Units" THEN
                //  ERROR('This Staff Quaters Clock is Fully Occupied');
                GetUnits;
            end;
        }
        field(3; "Allocated Employee"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Allocated Employee");
                if Employee.Find('-')then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
                Status:=Status::Occupied;
            end;
        }
        field(4; "Employee Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vacant,Occupied';
            OptionMembers = " ", Vacant, Occupied;
        }
        field(6; "Occupation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Vacation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Quaters Code", "House No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    Quaters: Record "Employee Quaters";
    local procedure GetUnits()
    var
        Units: Integer;
        UnitsCount: Integer;
        EmployeeQuaters: Record "Employee Quaters";
        HouseUnits: Record "House Units";
    begin
        if Quaters.Get("Quaters Code")then begin
            Units:=Quaters."No of Units";
            HouseUnits.Reset;
            HouseUnits.SetRange(HouseUnits."Quaters Code", "Quaters Code");
            HouseUnits.SetRange(Status, HouseUnits.Status::Occupied);
            if HouseUnits.Find('-')then UnitsCount:=HouseUnits.Count
            else
                UnitsCount:=0;
            if UnitsCount > Units then Error('This Quaters Block is Fully Occupied');
        end;
    end;
}

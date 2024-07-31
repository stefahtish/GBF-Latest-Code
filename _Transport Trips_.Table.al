table 50266 "Transport Trips"
{
    fields
    {
        field(1; "Request No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vehicle No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Vehicle Type"=FILTER("Company Vehicle"))"Fixed Asset"."No." WHERE("Fixed Asset Type"=FILTER(Fleet), "On Trip"=CONST(false), "Vehicle Type"=const(company), "Under Maintenance"=CONST(false))
            ELSE IF("Vehicle Type"=FILTER("Company Vehicle"))"Fixed Asset"."No." WHERE("Fixed Asset Type"=FILTER(Fleet), "On Trip"=CONST(false), "Vehicle Type"=const(Personal), "Under Maintenance"=CONST(false));

            trigger OnValidate()
            begin
                FA.Reset;
                FA.SetRange("No.", "Vehicle No");
                if FA.Find('-')then begin
                    FA.TestField("Seating/carrying capacity");
                    FA.TestField("Current Odometer Reading");
                    "Vehicle Description":=FA."Registration No";
                    "Vehicle Capacity":=FA."Seating/carrying capacity";
                    "Previous KM":=FA."Current Odometer Reading";
                    Driver:=FA."Responsible Employee";
                    Validate(Driver);
                end;
            /*Trip.RESET;
                Trip.SETRANGE("Vehicle No",Trip."Vehicle No");
                IF Trip.FINDLAST THEN
                  BEGIN
                    "Previous KM":=Trip."End of Journey KM";
                  END;*/
            end;
        }
        field(4; "Vehicle Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Vehicle Capacity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Driver; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange("No.", Driver);
                if Employee.Find('-')then begin
                    Employee.TestField("E-Mail");
                    "Drivers Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(7; "Drivers Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Previous KM"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "KM Driven":="End of Journey KM" - "Previous KM";
            end;
        }
        field(9; "Time Out"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Time In"; Time)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Time Out" > "Time In" then Error('Time-In cannot be before the Time-Out');
            end;
        }
        field(11; "End of Journey KM"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "KM Driven":="End of Journey KM" - "Previous KM";
                if FA.Get("Vehicle No")then;
            //"Litres of Fuel":=("KM Driven"/FA."Average Km/L");
            end;
        }
        field(12; "KM Driven"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Litres of Oil"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Litres of Fuel"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Order/Invoice/Cash/Voucher No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Vehicle Type"; Option)
        {
            OptionMembers = " ", "Company Vehicle", "Personal Vehicle";
            OptionCaption = ' ,Company Vehicle, Personal Vehicle';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Request No", "Vehicle No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var FA: Record "Fixed Asset";
    Employee: Record Employee;
    Trip: Record "Transport Trips";
}

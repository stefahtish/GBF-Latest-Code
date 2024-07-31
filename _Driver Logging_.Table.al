table 50572 "Driver Logging"
{
    Caption = 'Driver Logging';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Log No."; Code[10])
        {
            Caption = 'Log No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Log No." <> '' THEN NoSeriesMgt.TestManual(HRSetup."Driver Log Nos");
            end;
        }
        field(2; Driver; Code[10])
        {
            Caption = 'Driver';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Employee.GET(Driver)THEN "Driver Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                FixedAsset.Reset();
                FixedAsset.SetRange("Fixed Asset Type", FixedAsset."Fixed Asset Type"::Fleet);
                FixedAsset.SetRange("Responsible Employee", Employee."No.");
                if FixedAsset.FindFirst()then begin
                    "FA No.":=FixedAsset."No.";
                    "Car Registration Number":=FixedAsset."Registration No";
                    "Car Mileage":=FixedAsset."Current Odometer Reading";
                    "Inspection Due Date":=format(FixedAsset."Inspection Due Date");
                end;
            end;
        }
        field(3; "Driver Name"; Text[100])
        {
            Caption = 'Driver Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Car Registration Number"; Code[15])
        {
            Caption = 'Car Registration Number';
            DataClassification = ToBeClassified;
        }
        field(5; "Log time"; Time)
        {
            Caption = 'Log time';
            DataClassification = ToBeClassified;
        }
        field(6; "Time of Travel"; Time)
        {
            Caption = 'Time of Travel';
            DataClassification = ToBeClassified;
        }
        field(7; "Time of Arrival"; Time)
        {
            Caption = 'Time of Arrival';
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Travel"; Date)
        {
            Caption = 'Date of Travel';
            DataClassification = ToBeClassified;
        }
        field(9; "Date of Arrival"; Date)
        {
            Caption = 'Date of Arrival';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Periods: Record "Fuel Allocation Periods";
            begin
                Periods.Reset();
                Periods.SetFilter("Start Date", '<=%1', "Date of Arrival");
                Periods.SetFilter("End Date", '>=%1', "Date of Arrival");
                IF Periods.FindFirst()then Period:=Periods.Period;
            end;
        }
        field(10; "Location From"; Code[50])
        {
            Caption = 'Location From';
            DataClassification = ToBeClassified;
        }
        field(11; "Location To"; Code[50])
        {
            Caption = 'Location To';
            DataClassification = ToBeClassified;
        }
        field(12; "Car Mileage"; Decimal)
        {
            Caption = 'Car Mileage';
            DataClassification = ToBeClassified;
        }
        field(13; "Car Status"; Text[200])
        {
            Caption = 'Car Status';
            DataClassification = ToBeClassified;
        }
        field(14; "Car Fuel Intakes"; Decimal)
        {
            Caption = 'Car Fuel Intakes';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                FuelAlloc: Record "Fuel Allocations";
            begin
            // FuelAlloc.SetRange(FuelAlloc.Period, Period);
            // FuelAlloc.SetRange(FuelAlloc."Vehicle ", "Car Registration Number");
            // if FuelAlloc.FindFirst() then begin
            //     FuelAlloc.CalcFields(Usage);
            //     FuelAlloc.Balance := FuelAlloc."Minimum Amount" - FuelAlloc.Usage;
            //     FuelAlloc.Modify();
            // end;
            end;
        }
        field(15; "Travel Request"; Code[20])
        {
            Caption = 'Travel Request';
            DataClassification = ToBeClassified;
            TableRelation = "Travel Requests" where("Transport Status"=const("On Trip"));
        }
        field(16; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Period; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fuel Allocation Periods";
        }
        field(19; "Insurance Policy"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Insurance Company"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Inspection Due Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Insurance Expiry Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Insurance Commencement Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Hotline Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "FA No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Mileage reading after travel"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status;Enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
        field(28; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Log No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if not HRSetup.Get()then begin
            HRSetup.Init();
            HRSetup.Insert();
        end;
        "Log time":=Time;
        HRSetup.TESTFIELD("Driver Log Nos");
        NoSeriesMgt.InitSeries(HRSetup."Driver Log Nos", xRec."No. Series", TODAY, "Log No.", "No. Series");
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "User ID":=UserId;
                Driver:=Employee."No.";
                Validate(Driver);
            END;
        END;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    FixedAsset: Record "Fixed Asset";
}

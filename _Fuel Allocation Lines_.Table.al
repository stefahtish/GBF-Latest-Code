table 50351 "Fuel Allocation Lines"
{
    Caption = 'Fuel Allocation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vehicle"; Code[50])
        {
            Caption = 'Vehicle ';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where("Fixed Asset Type"=FILTER(Fleet));

            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
                FuelAlloc: Record "Fuel Allocation Lines";
                HrMgmt: Codeunit "HR Management";
            begin
                FA.Reset();
                FA.SetRange("No.", Vehicle);
                if FA.FindFirst()then begin
                    "Card No":=FA."Card No";
                    "Registration Number":=FA."Registration No";
                end;
                FuelAlloc.Reset();
                FuelAlloc.SetRange(FuelAlloc.Vehicle, Vehicle);
                FuelAlloc.SetFilter(Period, '<>%1', Period);
                FuelAlloc.CalcFields(Usage);
                if FuelAlloc.FindLast()then begin
                    HrMgmt.GetFuelBalance(FuelAlloc);
                    "Previous Balance":=FuelAlloc.Balance;
                    "Minimum Amount":=FuelAlloc."Minimum Amount";
                    "Topup Amount":="Minimum Amount" - "Previous Balance";
                    if "Topup Amount" < 0 then "Topup Amount":=0;
                end;
            end;
        }
        field(2; "Minimum Amount"; Decimal)
        {
            Caption = 'Minimum Amount';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            begin
                "Topup Amount":="Minimum Amount" - "Previous Balance";
            end;
        }
        field(3; "Allocated by"; Code[20])
        {
            Caption = 'Allocated by';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(4; Usage; Decimal)
        {
            Caption = 'Usage';
            CalcFormula = Sum("Driver Logging"."Car Fuel Intakes" where(Period=field(Period), "FA No."=field(Vehicle)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Balance; Decimal)
        {
            Caption = 'Balance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Allocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Period; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Previous Balance"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            begin
                "Topup Amount":="Minimum Amount" - "Previous Balance";
            end;
        }
        field(12; "Topup Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Card No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Registration Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Period, "Vehicle")
        {
            Clustered = true;
        }
    }
    var UserSetup: Record "User Setup";
    Employee: Record Employee;
}

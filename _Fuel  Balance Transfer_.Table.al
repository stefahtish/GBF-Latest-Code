table 50187 "Fuel  Balance Transfer"
{
    Caption = 'Fuel  Transfer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; "FA No."; Code[20])
        {
            Caption = 'FA No.';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where("Fixed Asset Type"=filter(Fleet), Disposed=const(true), "Card balance"=filter(>0));

            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if FA.Get("FA No.")then "Card No":=FA."Card No";
            end;
        }
        field(3; "Card No"; Code[50])
        {
            Caption = 'Card No';
            DataClassification = ToBeClassified;
        }
        field(4; "New Fixed Asset"; Code[50])
        {
            Caption = 'New Fixed Asset';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where("Fixed Asset Type"=filter(Fleet), Disposed=const(false));

            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if FA.Get("New Fixed Asset")then "New Card No":=FA."Card No";
            end;
        }
        field(5; "New Card No"; Code[50])
        {
            Caption = 'New Card No';
            DataClassification = ToBeClassified;
        }
        field(6; "Document Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(8; Transferred; Boolean)
        {
            Caption = 'Transferred';
            DataClassification = ToBeClassified;
        }
        field(9; Status;Enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
        field(10; Period; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if not PayablesSetup.Get()then begin
            PayablesSetup.Init();
            PayablesSetup.Insert();
        end;
        "Document Date":=Today;
        PayablesSetup.TESTFIELD("Fuel Balance Transfer Nos");
        NoSeriesMgt.InitSeries(PayablesSetup."Fuel Balance Transfer Nos", xRec."No. Series", TODAY, No, "No. Series");
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "Created By":=Employee."No.";
            END;
        END;
        FuelAlloc.Reset();
        FuelAlloc.SetRange(Allocated, true);
        if FuelAlloc.FindLast()then Period:=FuelAlloc.Period;
    end;
    var PayablesSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    FixedAsset: Record "Fixed Asset";
    FuelAlloc: Record "Fuel Allocations";
}

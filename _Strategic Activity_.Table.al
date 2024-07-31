table 50646 "Strategic Activity"
{
    Caption = 'Strategic Activity';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Activity; Code[2048])
        {
            Caption = 'Activity';
            DataClassification = ToBeClassified;
        }
        field(2; Output; Text[2048])
        {
            Caption = 'Output';
            DataClassification = ToBeClassified;
        }
        field(3; "Perfomance indicator"; Text[2048])
        {
            Caption = 'Perfomance Indicator';
            DataClassification = ToBeClassified;
        }
        field(4; "Strategy Code"; Code[2048])
        {
            Caption = 'Strategy No.';
            DataClassification = ToBeClassified;
        }
        field(5; KRA; Code[20])
        {
            Caption = 'KRA';
            DataClassification = ToBeClassified;
        }
        field(6; "Strategy Objective No."; Code[20])
        {
            Caption = 'Strategy Objective No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Strategic Issue No."; Code[20])
        {
            Caption = 'Strategic Issue No.';
            DataClassification = ToBeClassified;
        }
        field(8; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            FieldClass = FlowField;
            CalcFormula = sum("Strategic Activity TimeFrame".Cost where("Activity Code"=field("Activity Code"), KRA=field(KRA), "Strategic Issue No."=field("Strategic Issue No."), "Strategy Objective No."=field("Strategy Objective No."), "Strategy Code"=field("Strategy Code")));
        }
        field(9; "Responsible person"; Text[2048])
        {
            Caption = 'Responsible Person';
            DataClassification = ToBeClassified;
        }
        field(10; "Activity Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Activity2; Text[2048])
        {
            Caption = 'Activity';
            DataClassification = ToBeClassified;
        }
        field(12; "Percentage Done"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Strategic Activity TimeFrame"."Percentage Done" where("Activity Code"=field("Activity Code")));
        }
    }
    keys
    {
        key(PK; KRA, "Strategic Issue No.", "Strategy Objective No.", "Strategy Code", "Activity Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Activity Code", Activity)
        {
        }
    }
}

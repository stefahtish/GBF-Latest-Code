table 50658 "Perfomance Target SubIndicator"
{
    Caption = 'Perfomance SubIndicators';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Indicator Code"; Code[20])
        {
        }
        field(2; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Unit; Code[20])
        {
            Caption = 'Unit';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(5; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = ToBeClassified;
        }
        field(6; "Annual  Target"; Decimal)
        {
            Caption = 'Annual  Target';
            Editable = false;
        }
        field(7; "Q1 Target"; Decimal)
        {
            Caption = 'Q1 Target';

            trigger OnValidate()
            begin
                Modify();
                UpdateTotalTargets();
            end;
        }
        field(8; "Q2 Target"; Decimal)
        {
            Caption = 'Q2 Target';

            trigger OnValidate()
            begin
                Modify();
                UpdateTotalTargets end;
        }
        field(9; "Q3 Target"; Decimal)
        {
            Caption = 'Q3 Target';

            trigger OnValidate()
            begin
                Modify();
                UpdateTotalTargets end;
        }
        field(10; "Q4 Target"; Decimal)
        {
            Caption = 'Q4 Target';

            trigger OnValidate()
            begin
                Modify();
                UpdateTotalTargets end;
        }
        field(11; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Criteria Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; TimeFrame; Code[20])
        {
            Caption = 'TimeFrame';
            DataClassification = ToBeClassified;
            TableRelation = "Time Frames"."Time Frame" where(Closed=const(false));
        }
    }
    keys
    {
        key(PK; "Criteria Code", "Indicator Code", Code, TimeFrame)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Indicator Code", "Code", Description)
        {
        }
    }
    local procedure UpdateTotalTargets()
    var
        Criteria: Record "Perfomance SubCriteria";
        Indicators: Record "Perfomance Target SubIndicator";
        Q1Target: Decimal;
        Q2Target: Decimal;
        Q3Target: Decimal;
        Q4Target: Decimal;
        AnnualTarget: Decimal;
    begin
        Q1Target:=0;
        Q2Target:=0;
        Q3Target:=0;
        Q4Target:=0;
        AnnualTarget:=0;
        "Annual  Target":=0;
        "Annual  Target":="Q1 Target" + "Q2 Target" + "Q3 Target" + "Q4 Target";
        Modify();
        Criteria.Reset();
        Criteria.SetRange("Criteria Code", "Criteria Code");
        Criteria.SetRange(Code, "Indicator Code");
        Criteria.SetRange(TimeFrame, TimeFrame);
        if Criteria.FindFirst()then begin
            Indicators.Reset();
            Indicators.SetRange("Criteria Code", "Criteria Code");
            Indicators.SetRange("Indicator Code", "Indicator Code");
            Indicators.SetRange(TimeFrame, TimeFrame);
            if Indicators.Find('-')then repeat Q1Target:=Q1Target + Indicators."Q1 Target";
                    Q2Target:=Q2Target + Indicators."Q2 Target";
                    Q3Target:=Q3Target + Indicators."Q3 Target";
                    Q4Target:=Q4Target + Indicators."Q4 Target";
                    AnnualTarget:=AnnualTarget + Indicators."Annual  Target";
                until Indicators.Next() = 0;
            Criteria."Q1 Target":=Q1Target;
            Criteria."Q2 Target":=Q2Target;
            Criteria."Q3 Target":=Q3Target;
            Criteria."Q4 Target":=Q4Target;
            Criteria."Annual  Target":=AnnualTarget;
            Criteria.Modify();
        end;
    end;
}

table 50654 "Perfomance Contract Actuals"
{
    Caption = 'Perfomance Actuals';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Document No." <> "Document No." THEN NoSeriesMgt.TestManual(PlanningSetup."Perfomance Actuals Nos");
            end;
        }
        field(2; Activity; Text[200])
        {
            Caption = 'Activity';
            DataClassification = ToBeClassified;
        }
        field(3; TimeFrame; Code[20])
        {
            Caption = 'TimeFrame';
            DataClassification = ToBeClassified;
            TableRelation = "Time Frames"."Time Frame" where(Closed=const(false));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CheckExisting();
            end;
        }
        field(4; Unit; Code[20])
        {
            Caption = 'Unit';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(5; Weight; Code[100])
        {
            Caption = 'Weight';
            DataClassification = ToBeClassified;
        }
        field(6; "Q1 Target"; Decimal)
        {
            Caption = 'Q1 Target';
            FieldClass = FlowField;
            CalcFormula = sum("Perfomance Targets Lines"."Q1 Target" where("Document No."=field("Document No.")));
        }
        field(7; "Criteria Code"; Code[20])
        {
            Caption = 'Criteria Code';
            DataClassification = ToBeClassified;
            TableRelation = "Criteria Category";

            trigger OnValidate()
            var
                Categories: record "Criteria Category";
            begin
                CheckExisting();
                Categories.Reset();
                Categories.SetRange(Categories.Code, "Criteria Code");
                if Categories.FindFirst()then "Criteria Description":=Categories.Description;
            end;
        }
        field(8; "Criteria Description"; Text[200])
        {
            Caption = 'Criteria Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Activity Code"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Targets" where("Criteria Code"=field("Criteria Code"));
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Date Captured"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Quarter; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Q1, Q2, Q3, Q4;
            OptionCaption = ' ,Q1,Q2,Q3,Q4';

            trigger OnValidate()
            var
                Subcriteria: Record "Perfomance Target SubIndicator";
                PTargets: record "Perfomance Targets";
                PTargetLines: Record "Perfomance Targets Lines";
                PActualsLines: Record "Perfomance Actual Lines";
            begin
                CheckExisting();
                PActualsLines.Reset();
                PActualsLines.SetRange("Document No.", "Document No.");
                if PActualsLines.find('-')then PActualsLines.DeleteAll();
                Subcriteria.Reset();
                Subcriteria.SetRange("Indicator Code", "SubCriteria Code");
                Subcriteria.SetRange("Criteria Code", "Criteria Code");
                if Subcriteria.Find('-')then begin
                    repeat PActualsLines.Init();
                        PActualsLines."Document No.":="Document No.";
                        PActualsLines.Description:=Subcriteria.Description;
                        PActualsLines."SubIndicator Code":=Subcriteria.Code;
                        if Quarter = Quarter::Q1 then PActualsLines."Quarter Target":=Subcriteria."Q1 Target"
                        else if Quarter = Quarter::Q2 then PActualsLines."Quarter Target":=Subcriteria."Q2 Target"
                            else if Quarter = Quarter::Q3 then PActualsLines."Quarter Target":=Subcriteria."Q3 Target"
                                else
                                    PActualsLines."Quarter Target":=Subcriteria."Q4 Target";
                        PActualsLines.TimeFrame:=TimeFrame;
                        PActualsLines."Annual  Target":=Subcriteria."Annual  Target";
                        PActualsLines.Insert(true);
                    until Subcriteria.Next() = 0;
                end;
            end;
        //end;
        }
        field(15; "Quarter Target"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = SUM("Perfomance Actual Lines"."Quarter Target" where("Document No."=field("Document No.")));
        }
        field(16; "Quarter Actuals"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = SUM("Perfomance Actual Lines"."Quarter Actual" where("Document No."=field("Document No.")));
        }
        field(17; "SubCriteria Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance SubCriteria".Code where("Criteria Code"=field("Criteria Code"));

            trigger OnValidate()
            var
                SubCriteria: Record "Perfomance SubCriteria";
                SubIndicator: Record "Perfomance Target SubIndicator";
                PActualsLines: Record "Perfomance Actual Lines";
            begin
                CheckExisting();
                SubCriteria.Reset();
                SubCriteria.SetRange(Code, "SubCriteria Code");
                if SubCriteria.FindFirst()then begin
                    "SubCriteria Description":=SubCriteria.Description;
                end;
                PActualsLines.Reset();
                PActualsLines.SetRange("Document No.", "Document No.");
                if PActualsLines.find('-')then PActualsLines.DeleteAll();
                SubIndicator.Reset();
                SubIndicator.SetRange("Indicator Code", "SubCriteria Code");
                SubIndicator.SetRange("Criteria Code", "Criteria Code");
                if SubIndicator.Find('-')then begin
                    repeat PActualsLines.Init();
                        PActualsLines."Document No.":="Document No.";
                        PActualsLines.Description:=SubIndicator.Description;
                        PActualsLines."SubIndicator Code":=SubIndicator.Code;
                        if Quarter = Quarter::Q1 then PActualsLines."Quarter Target":=SubIndicator."Q1 Target"
                        else if Quarter = Quarter::Q2 then PActualsLines."Quarter Target":=SubIndicator."Q2 Target"
                            else if Quarter = Quarter::Q3 then PActualsLines."Quarter Target":=SubIndicator."Q3 Target"
                                else
                                    PActualsLines."Quarter Target":=SubIndicator."Q4 Target";
                        PActualsLines.TimeFrame:=TimeFrame;
                        PActualsLines."Annual  Target":=SubIndicator."Annual  Target";
                        PActualsLines.Insert(true);
                    until SubIndicator.Next() = 0;
                end;
            end;
        }
        field(18; "SubCriteria Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if not PlanningSetup.Get()then begin
            PlanningSetup.Init();
            PlanningSetup.Insert();
        end;
        "Date Captured":=Today;
        "User ID":=UserId;
        PlanningSetup.TESTFIELD("Perfomance Contract Nos");
        NoSeriesMgt.InitSeries(PlanningSetup."Perfomance Actuals Nos", xRec."No. Series", TODAY, "Document No.", "No. Series");
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    PlanningSetup: Record "Strategic Planning Setups";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure CheckExisting()
    var
        Actuals: Record "Perfomance Contract Actuals";
    begin
        if(TimeFrame <> '') and (Quarter <> Quarter::" ") and ("SubCriteria Code" <> '') and ("Criteria Code" <> '')then begin
            Actuals.Reset();
            Actuals.SetFilter("Document No.", '<>%1', Rec."Document No.");
            Actuals.SetRange("Criteria Code", "Criteria Code");
            Actuals.SetRange("SubCriteria Code", "SubCriteria Code");
            Actuals.SetRange(TimeFrame, TimeFrame);
            Actuals.SetRange(Quarter, Quarter);
            if Actuals.FindFirst()then Error('Actuals for Subcriteria %1, Criteria %2 timeframe %3 and quarter %4 have been input in another document %5', Actuals."Criteria Code", Actuals."SubCriteria Description", Actuals.TimeFrame, Actuals.Quarter, Actuals."Document No.");
        end;
    end;
}

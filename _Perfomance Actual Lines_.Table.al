table 50655 "Perfomance Actual Lines"
{
    Caption = 'Perfomance Actuals Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; TimeFrame; Code[20])
        {
            Caption = 'TimeFrame';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Annual  Target"; Decimal)
        {
            Caption = 'Annual  Target';
            DataClassification = ToBeClassified;
        }
        field(6; "Quarter Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Quarter Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                GetStrategyPercentage();
            end;
        }
        field(8; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Date of Completion"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Quarter Remarks"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "SubIndicator Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Quarter; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Q1, Q2, Q3, Q4;
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.", TimeFrame)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        GetNextLineNo();
        GetQuarter();
    end;
    procedure GetNextLineNo()
    var
        ActualsRec: Record "Perfomance Actual Lines";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        ActualsRec.SetRange("Document No.", "Document No.");
        if ActualsRec.FindLast then "Line No.":=ActualsRec."Line No." + 1
        else
            "Line No.":=1;
    end;
    procedure GetQuarter()
    var
        PActal: Record "Perfomance Contract Actuals";
    begin
        if PActal.Get("Document No.")then Quarter:=PActal.Quarter;
    end;
    procedure GetStrategyPercentage()
    var
        StratActivities: Record "Strategic Activity TimeFrame";
        PerfActualsHeader: Record "Perfomance Contract Actuals";
        PerfActualsHeader2: Record "Perfomance Contract Actuals";
        PerfActualLines: Record "Perfomance Actual Lines";
        PerfTarget: Record "Perfomance Targets";
        PerfOtherTarget: Record "Perfomance Targets";
        PerfomanceToDate: Decimal;
        OtherTargets: Decimal;
    begin
        PerfomanceToDate:=0;
        PerfActualsHeader.Reset();
        PerfActualsHeader.SetRange("Document No.", "Document No.");
        if PerfActualsHeader.FindFirst()then begin
            PerfActualsHeader2.Reset();
            PerfActualsHeader2.SetRange("Criteria Code", PerfActualsHeader."Criteria Code");
            PerfActualsHeader2.SetRange("SubCriteria Code", PerfActualsHeader."SubCriteria Code");
            PerfActualsHeader2.SetRange(TimeFrame, PerfActualsHeader.TimeFrame);
            if PerfActualsHeader2.find('-')then repeat PerfActualLines.Reset();
                    PerfActualLines.SetRange("Document No.", PerfActualsHeader2."Document No.");
                    if PerfActualLines.Find('-')then repeat PerfomanceToDate+=PerfActualLines."Quarter Actual";
                        until PerfActualLines.next = 0;
                until PerfActualsHeader2.Next() = 0;
            PerfTarget.Reset();
            PerfTarget.SetRange("Criteria Code", PerfActualsHeader."Criteria Code");
            PerfTarget.SetRange("Pefomance Indicator Code", PerfActualsHeader."SubCriteria Code");
            PerfTarget.SetRange(TimeFrame, PerfActualsHeader.TimeFrame);
            if PerfTarget.Find('-')then repeat Message(PerfTarget."Activity Code");
                    StratActivities.Reset();
                    StratActivities.SetRange(KRA, PerfTarget.KRA);
                    StratActivities.SetRange("Strategic Issue No.", PerfTarget."Strategic Issue");
                    StratActivities.SetRange(TimeFrame, PerfActualsHeader.TimeFrame);
                    StratActivities.SetRange("Strategy Objective No.", PerfTarget."Strategic Objective Code");
                    StratActivities.SetRange("Strategy Code", PerfTarget."Strategy Code");
                    StratActivities.SetRange("Activity Code", PerfTarget."Activity Code");
                    if StratActivities.Find('-')then begin
                        OtherTargets:=0;
                        //Get from other criterias
                        PerfOtherTarget.Reset();
                        //PerfOtherTarget.SetFilter("Criteria Code", '<>%1', PerfActualsHeader."Criteria Code");
                        PerfOtherTarget.SetFilter("Pefomance Indicator Code", '<>%1', PerfActualsHeader."SubCriteria Code");
                        PerfOtherTarget.SetRange(KRA, PerfTarget.KRA);
                        PerfOtherTarget.SetRange("Strategic Issue", PerfTarget."Strategic Issue");
                        PerfOtherTarget.SetRange("Strategic Objective Code", PerfTarget."Strategic Objective Code");
                        PerfOtherTarget.SetRange("Strategy Code", PerfTarget."Strategy Code");
                        PerfOtherTarget.SetRange("Activity Code", PerfTarget."Activity Code");
                        PerfOtherTarget.SetRange(TimeFrame, PerfActualsHeader.TimeFrame);
                        if PerfOtherTarget.Find('-')then repeat PerfActualsHeader2.Reset();
                                PerfActualsHeader2.SetRange("Criteria Code", PerfOtherTarget."Criteria Code");
                                PerfActualsHeader2.SetRange("SubCriteria Code", PerfOtherTarget."Pefomance Indicator Code");
                                PerfActualsHeader2.SetRange(TimeFrame, PerfActualsHeader.TimeFrame);
                                if PerfActualsHeader2.find('-')then repeat PerfActualLines.Reset();
                                        PerfActualLines.SetRange("Document No.", PerfActualsHeader2."Document No.");
                                        if PerfActualLines.Find('-')then repeat OtherTargets+=PerfActualLines."Quarter Actual";
                                            until PerfActualLines.next = 0;
                                    until PerfActualsHeader2.Next() = 0;
                            until PerfOtherTarget.Next() = 0;
                        StratActivities."Percentage Done":=PerfomanceToDate + OtherTargets;
                        StratActivities.Modify();
                    end;
                until PerfTarget.Next() = 0;
        end;
    end;
}

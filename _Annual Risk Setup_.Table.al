table 50493 "Annual Risk Setup"
{
    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Code <> xRec.Code then NoSeriesMgt.TestManual(AuditSetup."Risk Reporting Nos.");
            end;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Likelihood Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Probability; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
                RiskLikelihood: Record "Risk Likelihood";
            begin
                if("Probability" < 0) or ("Probability" > 100)then Error(ValueError);
                RiskLikelihood.Reset();
                RiskLikelihood.SetFilter("Probability Start Range", '<=%1', "Probability");
                RiskLikelihood.SetFilter(Probability, '>=%1', "Probability");
                IF RiskLikelihood.FindFirst()then begin
                    "Likelihood code":=RiskLikelihood.Code;
                    "Likelihood score":=RiskLikelihood."Likelihood Score";
                end;
            end;
        }
        field(8; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Likelihood code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Impact code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";

            trigger OnValidate()
            var
                RiskImpact: Record "Risk Impacts";
            begin
                RiskImpact.Reset();
                RiskImpact.SetRange(Code, "Impact code");
                IF RiskImpact.FindFirst()then begin
                    "Impact Score":=RiskImpact."Impact Score";
                end;
            end;
        }
        field(12; "Impact Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Value At risk"; Decimal)
        {
            DataClassification = ToBeClassified;
        // trigger OnValidate()
        // var
        //     RiskImpact: Record "Risk Impacts";
        // begin
        //     RiskImpact.Reset();
        //     RiskImpact.SetFilter("Financial start", '<=%1', "Value at Risk");
        //     RiskImpact.SetFilter("Financial End", '>=%1', "Value at Risk");
        //     IF RiskImpact.FindFirst() then begin
        //         "Impact code" := RiskImpact.Code;
        //         "Impact score" := RiskImpact."Impact Score";
        //     end;
        // end;
        }
        field(14; "Control Likelihood code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Control Impact code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";

            trigger OnValidate()
            var
                RiskImpact: Record "Risk Impacts";
            begin
                RiskImpact.Reset();
                RiskImpact.SetRange(Code, "Control Impact code");
                IF RiskImpact.FindFirst()then begin
                    "Control Impact Score":=RiskImpact."Impact Score";
                end;
            end;
        }
        field(16; "Control Impact Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Control Likelihood Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Value After Control"; Decimal)
        {
            DataClassification = ToBeClassified;
        // trigger OnValidate()
        // var
        //     RiskImpact: Record "Risk Impacts";
        // begin
        //     RiskImpact.Reset();
        //     RiskImpact.SetFilter("Financial start", '<=%1', "Value at Risk");
        //     RiskImpact.SetFilter("Financial End", '>=%1', "Value at Risk");
        //     IF RiskImpact.FindFirst() then begin
        //         "Control Impact code" := RiskImpact.Code;
        //         "Control Impact score" := RiskImpact."Impact Score";
        //     end;
        // end;
        }
        field(19; "Control Probability"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
                RiskLikelihood: Record "Risk Likelihood";
            begin
                if("Probability" < 0) or ("Probability" > 100)then Error(ValueError);
                RiskLikelihood.Reset();
                RiskLikelihood.SetFilter("Probability Start Range", '<=%1', "Probability");
                RiskLikelihood.SetFilter(Probability, '>=%1', "Probability");
                IF RiskLikelihood.FindFirst()then begin
                    "Control Likelihood code":=RiskLikelihood.Code;
                    "Control Likelihood score":=RiskLikelihood."Likelihood Score";
                end;
            end;
        }
        field(20; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Quantifiable; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Yes, No;
            OptionCaption = ' ,Yes,No';
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Likelihood Score")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Likelihood Score")
        {
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
        AccPeriod: Record "Accounting Period";
    begin
        if not AuditSetup.Get then begin
            AuditSetup.Init();
            AuditSetup.Insert();
        end;
        AuditSetup.TestField("Risk Reporting Nos.");
        NoSeriesMgt.InitSeries(AuditSetup."Risk Reporting Nos.", xRec."No. Series", Today, Code, "No. Series");
        AccPeriod.SetRange("New fiscal year", true);
        if AccPeriod.FindLast()then "Start Date":=AccPeriod."Starting Date";
        "End Date":=CalcDate('1Y', "Start Date");
        if "End Date" <> 0D then "End Date":=CalcDate('-1D', "End Date");
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    AuditSetup: Record "Audit Setup";
    ValueError: Label 'Probability should be between 0 and 100';
}

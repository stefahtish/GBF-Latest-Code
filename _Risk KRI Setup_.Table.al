table 50520 "Risk KRI Setup"
{
    fields
    {
        field(1; "Family of KRI Ref"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(3; Indicator; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Frequency; Option)
        {
            OptionMembers = , Quarterly, "Half Yearly", Annually;
            OptionCaption = ' ,Quarterly,Half Yearly, Annually';
            DataClassification = ToBeClassified;
        }
        field(5; "BASIS"; Text[2000])
        {
            Caption = 'BASIS FOR COMPILATION OF KRI DATA';
            DataClassification = ToBeClassified;
        }
        field(6; TriggerValue; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if(TriggerValue > 0) and (TriggerValue <= 3)then TriggerStatus:=TriggerStatus::Green;
                if(TriggerValue > 3) and (TriggerValue <= 5)then TriggerStatus:=TriggerStatus::Amber;
                if(TriggerValue > 5) and (TriggerValue <= 7)then TriggerStatus:=TriggerStatus::Red;
                if(TriggerValue > 7) and (TriggerValue <= 0)then Error(TriggerError);
            end;
        }
        field(7; TriggerStatus; Option)
        {
            OptionMembers = , Green, Amber, Red;
            OptionCaption = ' ,Green,Amber,Red';
            DataClassification = ToBeClassified;
        }
        field(8; IndicativeUnits; Text[2000])
        {
            Caption = 'INDICATIVE UNITS TO RESPOND';
            DataClassification = ToBeClassified;
        }
        field(9; TriggerOption; Option)
        {
            OptionMembers = "", Quantitative, Qualitative;
            OptionCaption = ' ,Quantitative,Qualitative';
            DataClassification = ToBeClassified;
        }
        field(10; Qualitative; Option)
        {
            OptionMembers = "", Yes, No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Qualitative = Qualitative::Yes then TriggerStatus:=TriggerStatus::Red;
                if Qualitative = Qualitative::No then TriggerStatus:=TriggerStatus::Green;
            end;
        }
        field(11; "No. Series"; code[10])
        {
        }
    }
    keys
    {
        key(Key1; "Employee No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        RiskSetup.get;
        RiskSetup.testfield("Risk KRI Guideline Nos");
        if "Employee No" = '' then NoSeriesMgt.InitSeries(RiskSetup."Risk KRI Guideline Nos", xRec."No. Series", 0D, "Employee No", "No. Series");
    end;
    var TriggerError: Label 'The range should be between 1 and 7';
    RiskSetup: Record "Audit Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}

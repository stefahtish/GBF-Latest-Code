table 50649 "Strategic Activity TimeFrame"
{
    Caption = 'Strategic Activity TimeFrames';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; TimeFrame; Code[20])
        {
            Caption = 'TimeFrame';
            DataClassification = ToBeClassified;
            TableRelation = "Time Frames"."Time Frame" where(Closed=const(false));
        }
        field(2; Cost; Decimal)
        {
            Caption = 'Cost';
            DataClassification = ToBeClassified;
        }
        field(3; "Activity Code"; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(4; KRA; Code[20])
        {
            Caption = 'KRA';
            DataClassification = ToBeClassified;
        }
        field(5; "Strategy Objective No."; Code[20])
        {
            Caption = 'Strategy Objective No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Strategic Issue No."; Code[20])
        {
            Caption = 'Strategic Issue No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Strategy Code"; Code[2048])
        {
            Caption = 'Strategy No.';
            DataClassification = ToBeClassified;
        }
        field(8; "Percentage Done"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; KRA, "Strategic Issue No.", "Strategy Objective No.", "Strategy Code", "Activity Code", TimeFrame)
        {
        //SumIndexFields = Cost;
        }
    }
}

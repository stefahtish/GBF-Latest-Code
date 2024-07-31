table 50645 Strategy
{
    Caption = 'Strategy';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Strategy Code"; Code[2048])
        {
            Caption = 'Strategy No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Strategy"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; KRA; Code[20])
        {
            Caption = 'KRA';
            DataClassification = ToBeClassified;
        }
        field(4; "Strategy Objective No."; Code[20])
        {
            Caption = 'Strategy Objective No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Strategic Issue No."; Code[20])
        {
            Caption = 'Strategic Issue No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; KRA, "Strategic Issue No.", "Strategy Objective No.", "Strategy Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Strategy Code", Strategy)
        {
        }
    }
}

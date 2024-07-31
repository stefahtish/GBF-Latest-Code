table 50641 "Research Management Cue"
{
    Caption = 'Research Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Open Export Promotions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Research Activity Plan" WHERE(Submitted=const(false), "Research Type"=CONST(Export)));
        }
        field(3; "Submitted Export Promotions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Research Activity Plan" WHERE(Submitted=const(true), "Research Type"=CONST(Export)));
        }
        field(4; "Open Stakeholder Support"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Research Activity Plan" WHERE(Submitted=const(false), "Research Type"=CONST(Support)));
        }
        field(5; "Submitted Stakeholder Support"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Research Activity Plan" WHERE(Submitted=const(true), "Research Type"=CONST(Support)));
        }
        field(7; "Open Dairy Standards"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Research Activity Plan" WHERE(Submitted=const(false), "Research Type"=CONST(Dairystds)));
        }
        field(8; "Submitted Dairy Standards"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Research Activity Plan" WHERE(Submitted=const(true), "Research Type"=CONST(Dairystds)));
        }
        field(13; "Open Partnership Activity Plan"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Partnerships Activity Plan" WHERE(Submitted=const(false)));
        }
        field(14; "Partnership Activity Plans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Partnerships Activity Plan" WHERE(Submitted=const(false)));
        }
        field(15; "Open Research Survey workplans"; Integer)
        {
            Caption = 'Open Research n Survey workplans';
            FieldClass = FlowField;
            CalcFormula = count("Research and survey Workplan" where(Submitted=const(false)));
        }
        field(16; "Research and Survey Workplans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Research and survey Workplan" where(Submitted=const(true)));
        }
        field(25; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}

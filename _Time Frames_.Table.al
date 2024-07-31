table 50648 "Time Frames"
{
    Caption = 'Time Frames';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Time Frame"; Code[20])
        {
            Caption = 'Time Frame';
            DataClassification = ToBeClassified;
        }
        field(2; "Plan Name"; Code[20])
        {
            Caption = 'Plan Name';
            DataClassification = ToBeClassified;
        }
        field(3; Closed; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Strategic Period".Closed where("Plan Name"=field("Plan Name")));
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Plan Name", "Time Frame")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Time Frame", "Start Date", "End Date")
        {
        }
    }
}

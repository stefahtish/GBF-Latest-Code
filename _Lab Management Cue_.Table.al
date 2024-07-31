table 50625 "Lab Management Cue"
{
    Caption = 'Lab Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Open lab schedules"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Lab Annual Testing Schedule" WHERE(Scheduled=const(false)));
        }
        field(3; "Submitted Lab Schedules"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Lab Annual Testing Schedule" WHERE(Scheduled=const(true)));
        }
        field(4; "Open Testing Resource Alloc"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Testing Resorce Allocation" where(Allocated=const(false)));
        }
        field(5; "Testing Allocations Done"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Testing Resorce Allocation" where(Allocated=const(true)));
        }
        field(7; "Samples received"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample Reception Header" where("Sent to Lab"=const(false)));
        }
        field(8; "Samples received sent to lab"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample Reception Header" where("Sent to Lab"=const(true)));
        }
        field(13; "Open Sample Analysis"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample analysis and reporting" WHERE("Submit results"=const(false)));
        }
        field(14; "Sample Analysis submitted"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample analysis and reporting" WHERE("Submit results"=const(false)));
        }
        field(15; "Open Sample Tests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample Test Header" where(Submitted=const(false)));
        }
        field(16; "Submitted Tests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample Test Header" where(Submitted=const(true)));
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

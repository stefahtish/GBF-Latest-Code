table 50616 "Compliance Cues"
{
    Caption = 'Compliance Cues';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Overdue Compliances"; Integer)
        {
            Caption = 'Overdue Compliances';
            FieldClass = FlowField;
            CalcFormula = count("Enforcement NonCompliance" where(Complied=const(false), Overdue=const(true)));
        }
        field(3; "Open enforcements"; Integer)
        {
            Caption = 'Open enforcements';
            FieldClass = FlowField;
            CalcFormula = count("Enforcement Header" where(Submitted=const(false)));
        }
        field(4; "Submitted enforcements"; Integer)
        {
            Caption = 'Submitted enforcements';
            FieldClass = FlowField;
            CalcFormula = count("Enforcement Header" where(Submitted=const(true)));
        }
        field(5; "Current Date"; Date)
        {
            DataClassification = ToBeClassified;
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

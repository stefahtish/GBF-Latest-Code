table 50624 "Compliance Management Cue"
{
    Caption = 'Compliance Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Open enforcements"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Enforcement Header" WHERE(Submitted=const(false)));
        }
        field(3; "Submitted enforcements"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Enforcement Header" WHERE(Submitted=const(true)));
        }
        field(4; "Means of Handling"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Means of Handling Setup");
        }
        field(5; "Licenses"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("License and Permit Category" where("License/Permit"=const(License)));
        }
        field(6; "Permits"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("License and Permit Category" where("License/Permit"=const(Permit)));
        }
        field(8; "Permit Applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Licensing dairy Enterprise");
        }
        field(9; "Overdue Compliances"; Integer)
        {
            Caption = 'Overdue Compliances';
            FieldClass = FlowField;
            CalcFormula = count("Enforcement NonCompliance" where(Complied=const(false), Overdue=const(true)));
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

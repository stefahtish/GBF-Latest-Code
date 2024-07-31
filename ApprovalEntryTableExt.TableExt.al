tableextension 50109 ApprovalEntryTableExt extends "Approval Entry"
{
    fields
    {
        field(50000; "Approval Stage"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Workflow User Group Code"; Code[20])
        {
            TableRelation = "Workflow User Group".Code;
        }
        field(50003; "Delegated From"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(50004; "Posting Date"; Date)
        {
        }
        field(50005; "Staff No."; code[50])
        {
        }
        field(50006; "Approver Staff No."; code[50])
        {
        }
        field(50007; "Payroll period start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Finance; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow - Table Relation".Finance where("Table ID"=field("Table ID")));
        }
        field(50009; Audit; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow - Table Relation".Audit where("Table ID"=field("Table ID")));
        }
        field(50010; HR; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow - Table Relation".HR where("Table ID"=field("Table ID")));
        }
        field(50011; Procurement; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow - Table Relation".Procurement where("Table ID"=field("Table ID")));
        }
        field(50012; ICT; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow - Table Relation".ICT where("Table ID"=field("Table ID")));
        }
        field(650013; Compliance; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow - Table Relation".Finance where("Table ID"=field("Table ID")));
        }
    }
}

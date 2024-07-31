table 50169 "Risk Management Cue"
{
    Caption = 'Risk Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Risk Identification"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Header" WHERE("Document Status"=FILTER(New)));
        }
        field(3; "Risk Assessment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Header" where("Document Status"=FILTER(HOD)));
        }
        field(4; "Escalated risks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Header" where("Document Status"=FILTER("Board Review")));
        }
        field(5; "Closed risks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Header" where("Document Status"=FILTER(Closed)));
        }
        field(6; "Corporate risks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Register" WHERE(Type=FILTER(Corporate), Archive=FILTER(false)));
        }
        field(7; "Department risks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Register" WHERE(Type=FILTER(Department), Archive=FILTER(false)));
        }
        field(8; "Project risks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Register" where(Type=FILTER(Project), Archive=FILTER(false)));
        }
        field(13; "Closed risks from registers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Risk Register" WHERE(Archive=FILTER(true)));
        }
        field(14; "Open incidences"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("User Support Incident" where(Status=filter(Open)));
        }
        field(15; "Pending incidences"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("User Support Incident" where(Status=filter(Pending)));
        }
        field(16; "Incidences under review"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("User Support Incident" where(Status=filter(Solved)));
        }
        field(17; "Escalated incidences"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("User Support Incident" where(Status=filter(Escalated)));
        }
        field(18; "Solved incidences"; Integer)
        {
            Caption = 'Closed incidences';
            FieldClass = FlowField;
            CalcFormula = count("User Support Incident" where(Status=filter(Closed)));
        }
        field(19; "Reported incidences"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("User Support Incident" where(Sent=filter(true)));
        }
        field(20; "Compliances"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Audit Header" WHERE(Type=FILTER(Compliance)));
        }
        field(21; "Risk surveys"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Audit Header" WHERE(Type=FILTER("Risk Survey"), "Notification Sent"=FILTER(false)));
        }
        field(22; "Reported risk surveys"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Audit Header" WHERE(Type=FILTER("Risk Survey"), "Notification Sent"=FILTER(true)));
        }
        field(23; "Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(24; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
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

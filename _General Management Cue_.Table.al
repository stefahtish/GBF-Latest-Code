table 50175 "General Management Cue"
{
    Caption = 'General Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Approved Imprest"; Integer)
        {
            Caption = 'Approved Imprests';
            CalcFormula = Count(Payments WHERE("Payment Type"=filter(Imprest), Status=filter(Released), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(4; "Imprest Surrenders"; Integer)
        {
            Caption = 'Open Imprest Surrenders';
            CalcFormula = Count(Payments WHERE("Payment Type"=filter("Imprest Surrender"), Status=filter(Open), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(5; "Pending Staff Claim List"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER("Staff Claim"), Status=FILTER("Pending Approval"), Posted=CONST(false), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(6; Imprests; Integer)
        {
            Caption = 'Open Imprests';
            CalcFormula = Count(Payments WHERE("Payment Type"=filter(Imprest), Status=filter(Open), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(7; "Pending Imprests"; Integer)
        {
            Caption = 'Pending Imprests';
            CalcFormula = Count(Payments WHERE("Payment Type"=filter(Imprest), Status=filter("Pending Approval"), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(8; "Approved Imprest Surrenders"; Integer)
        {
            Caption = 'Approved Imprest Surrenders';
            CalcFormula = Count(Payments WHERE("Payment Type"=filter("Imprest Surrender"), Status=filter(Released), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(9; "Staff Claims List"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=CONST("Staff Claim"), Status=FILTER(Open), Posted=CONST(false), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(10; "Approved Staff Claim"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=CONST("Staff Claim"), Status=CONST(Released), Posted=CONST(false), "Created By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(11; "Purchase Request List"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Purchase), "Fully Ordered"=FILTER(false), Status=FILTER(<>Released), "Requested By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(12; "Purchase Request Approved"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Purchase), "Fully Ordered"=FILTER(false), Status=FILTER(Fulfilled|Released), Uncommitted=CONST(false), "Requested By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(13; "Store Request List"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Stock), Status=FILTER(Open), "Requested By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(14; "Approved Store Request"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Stock), Status=FILTER(Released), Posted=FILTER(false), "Requested By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(15; "Leave Application List"; Integer)
        {
            CalcFormula = Count("Leave Application" WHERE(Status=FILTER(Open), "User ID"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(16; "Transport Requests"; Integer)
        {
            CalcFormula = Count("Travel Requests" WHERE(Status=FILTER(<>Released), "User ID"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(17; "Approved Travel Requests"; Integer)
        {
            CalcFormula = Count("Travel Requests" WHERE(Status=CONST(Released), "User ID"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(18; "Training Request List"; Integer)
        {
            CalcFormula = Count("Training Request" WHERE(Status=FILTER(Open), "User ID"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(19; "Approved Training Request List"; Integer)
        {
            CalcFormula = Count("Training Request" WHERE(Status=FILTER(Released), "User ID"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(20; "Approval request entries"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status=CONST(Created), "Approver ID"=field("User ID Filter")));
            FieldClass = FlowField;
            TableRelation = "Approval Entry";
        }
        field(21; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status=FILTER(Open), "Approver ID"=field("User ID Filter")));
            FieldClass = FlowField;
            TableRelation = "Approval Entry";
        }
        field(22; "User ID Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
        field(23; "Pending Leave Applications"; Integer)
        {
            CalcFormula = Count("Leave Application" WHERE(Status=FILTER("Pending Approval"), "User ID"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(24; "Approved Leave Applications"; Integer)
        {
            CalcFormula = Count("Leave Application" WHERE(Status=FILTER(Released), "User ID"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(25; Risk; Integer)
        {
            CalcFormula = count("Risk Header" where("Created By"=field("User ID Filter"), Status=filter(New)));
            FieldClass = FlowField;
        }
        field(26; RiskSurvey; Integer)
        {
            CalcFormula = count("Audit Header" where("Created By"=field("User ID Filter"), Status=filter(Open), Type=FILTER("Risk Survey")));
            FieldClass = FlowField;
        }
        field(27; Incidents; Integer)
        {
            CalcFormula = count("User Support Incident" where(User=field("User ID Filter"), Status=filter(Open)));
            FieldClass = FlowField;
        }
        field(28; "Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(29; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(31; "Open Contracts"; Integer)
        {
            CalcFormula = Count("project Header" WHERE("user id"=FIELD("User ID Filter"), "Status"=FILTER(Open)));
            Caption = 'Open Contracts';
            FieldClass = FlowField;
        }
        field(33; "Running Contracts"; Integer)
        {
            CalcFormula = Count("project Header" WHERE("user id"=FIELD("User ID Filter"), "Status"=FILTER(Approved)));
            Caption = 'Running Contracts';
            FieldClass = FlowField;
        }
        field(34; "Completed Contracts"; Integer)
        {
            CalcFormula = Count("project Header" WHERE("user id"=FIELD("User ID Filter"), "Status"=FILTER(finished)));
            Caption = 'Completed Contracts';
            FieldClass = FlowField;
        }
        field(35; "Suspended Contracts"; Integer)
        {
            CalcFormula = Count("project Header" WHERE("user id"=FIELD("User ID Filter"), "Status"=FILTER(Suspended)));
            Caption = 'Suspended Contracts';
            FieldClass = FlowField;
        }
        field(36; "Contracts Pending Verification"; Integer)
        {
            CalcFormula = Count("project Header" WHERE("user id"=FIELD("User ID Filter"), "Status"=FILTER("Pending Verification")));
            Caption = 'Contracts Pending Verification';
            FieldClass = FlowField;
        }
        field(37; "Verified Contracts"; Integer)
        {
            CalcFormula = Count("project Header" WHERE("user id"=FIELD("User ID Filter"), "Status"=FILTER(Verified)));
            Caption = 'Verified Contracts';
            FieldClass = FlowField;
        }
        field(30; "Open Projects"; Integer)
        {
            CalcFormula = Count("projectman" WHERE("user id"=FIELD("User ID Filter"), "Project Status"=FILTER(Open), "Project Approval Status"=filter(open)));
            Caption = 'Open Projects';
            FieldClass = FlowField;
        }
        field(32; "Approved Projects"; Integer)
        {
            CalcFormula = Count("projectman" WHERE("user id"=FIELD("User ID Filter"), "Project Approval Status"=FILTER(Approved)));
            Caption = 'Approved Projects';
            FieldClass = FlowField;
        }
        field(38; "Projects in Progress"; Integer)
        {
            CalcFormula = Count("ProjectMan" WHERE("user id"=FIELD("User ID Filter"), "Project Status"=FILTER("Work in Progress")));
            FieldClass = FlowField;
        }
        field(39; "Projects in Progress(Overdue)"; Integer)
        {
            CalcFormula = Count("ProjectMan" WHERE("user id"=FIELD("User ID Filter"), "Project Status"=FILTER("Work in Progress (Overdue)")));
            FieldClass = FlowField;
        }
        field(40; "Closed Projects"; Integer)
        {
            CalcFormula = Count("ProjectMan" WHERE("user id"=FIELD("User ID Filter"), "Project Status"=FILTER(Closed), "Project Approval Status"=filter(approved)));
            FieldClass = FlowField;
        }
        field(41; "Projects Pending Approval"; Integer)
        {
            CalcFormula = Count("ProjectMan" WHERE("user id"=FIELD("User ID Filter"), "Project approval Status"=FILTER("Pending Approval")));
            FieldClass = FlowField;
        }
        field(42; "Open Leave"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Application" where(Status=filter(Open), "User ID"=field("User ID Filter")));
        }
        field(43; "Leave Reliever Open"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Application" where(Status=filter("Reliever Open"), "User ID"=field("User ID Filter")));
        }
        field(44; "Leave Reliever Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Application" where(Status=filter("Reliever Approved"), "User ID"=field("User ID Filter")));
        }
        field(45; "Pending Imprest Surrenders"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=filter("Imprest Surrender"), Status=filter("Pending Approval"), "User Id"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(46; "Pending Store Request"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Stock), Status=FILTER("Pending Approval"), Posted=FILTER(false), "Requested By"=field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(47; "Purchase request list Approved"; Integer)
        {
            Caption = 'Approved Purchase requests';
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type"=CONST(Purchase), "Fully Ordered"=CONST(false), Status=FILTER(Released)));
        }
        field(48; "Pending Approval Request list"; Integer)
        {
            Caption = 'Pending Purchase requests';
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type"=CONST(Purchase), "Fully Ordered"=CONST(false), Status=FILTER("Pending Approval")));
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

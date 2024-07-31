table 50271 "Approval Cues"
{
    fields
    {
        field(1; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "All Employees"; Integer)
        {
            CalcFormula = Count(Employee);
            FieldClass = FlowField;
        }
        field(3; "Inactive Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Status=CONST(Active)));
            FieldClass = FlowField;
        }
        field(4; "Active Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Status=CONST(Inactive)));
            FieldClass = FlowField;
        }
        field(5; "Loan Application List"; Integer)
        {
            CalcFormula = Count("Loan Application" WHERE("Loan No"=CONST('')));
            FieldClass = FlowField;
        }
        field(6; "Retired Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Status=FILTER(Inactive)));
            FieldClass = FlowField;
        }
        field(7; "Resigned Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Status=CONST(Terminated)));
            FieldClass = FlowField;
        }
        field(8; "Probation Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Status=CONST(Inactive)));
            FieldClass = FlowField;
        }
        field(9; "Laundry Drop-Off List"; Integer)
        {
            FieldClass = FlowField;
        }
        field(10; "Laundry Received List"; Integer)
        {
            FieldClass = FlowField;
        }
        field(11; "Laundry Delivered List"; Integer)
        {
            FieldClass = FlowField;
        }
        field(12; "Approved Imprest"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER(Imprest), Status=FILTER(Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(13; "Imprest Surrenders"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER("Imprest Surrender"), Status=FILTER(<>Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(14; "Staff Claim List"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER("Staff Claim"), Status=FILTER(<>Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(15; Imprests; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER(Imprest), Status=FILTER(<>Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(16; "Approved Imprests"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER(Imprest), Status=FILTER(<>Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(18; "Approved Imprest Surrenders"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=CONST("Imprest Surrender"), Status=CONST(Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(19; "Staff Claims List"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=CONST("Staff Claim"), Status=FILTER(<>Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(20; "Approved Staff Claim"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=CONST("Staff Claim"), Status=CONST(Released), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(21; "Purchase Request List"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Purchase), "Fully Ordered"=FILTER(false), Status=FILTER(<>Released)));
            FieldClass = FlowField;
        }
        field(22; "Purchase Request Approved"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Purchase), "Fully Ordered"=FILTER(false), Status=FILTER(Fulfilled|Released), Uncommitted=CONST(false)));
            FieldClass = FlowField;
        }
        field(23; "Store Request List"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Stock), Status=FILTER(<>Released)));
            FieldClass = FlowField;
        }
        field(24; "Approved Store Request"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Stock), Status=FILTER(Released), Posted=FILTER(false)));
            FieldClass = FlowField;
        }
        field(25; "Leave Application List"; Integer)
        {
            CalcFormula = Count("Leave Application" WHERE(Status=FILTER(<>Released)));
            FieldClass = FlowField;
        }
        field(26; "Transport Requests"; Integer)
        {
            CalcFormula = Count("Travel Requests" WHERE(Status=FILTER(<>Released)));
            FieldClass = FlowField;
        }
        field(27; "Approved Travel Requests"; Integer)
        {
            CalcFormula = Count("Travel Requests" WHERE(Status=CONST(Released)));
            FieldClass = FlowField;
        }
        field(28; "Training Request List"; Integer)
        {
            CalcFormula = Count("Training Request" WHERE(Status=FILTER(Open)));
            FieldClass = FlowField;
        }
        field(29; "Approved Training Request List"; Integer)
        {
            CalcFormula = Count("Training Request" WHERE(Status=FILTER(Released)));
            FieldClass = FlowField;
        }
        field(30; "All students"; Integer)
        {
            FieldClass = FlowField;
        }
        field(31; "Active Students"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Pending Admissions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Failed Students"; Integer)
        {
            FieldClass = FlowField;
        }
        field(34; "Passed Students"; Integer)
        {
            FieldClass = FlowField;
        }
        field(35; "Allumni students"; Integer)
        {
            FieldClass = FlowField;
        }
        field(36; "Treatment list"; Integer)
        {
            FieldClass = FlowField;
        }
        field(37; "Pharmacy patient list"; Integer)
        {
            FieldClass = FlowField;
        }
        field(38; "Approval request entries"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status=CONST(Created)));
            FieldClass = FlowField;
            TableRelation = "Approval Entry";
        }
        field(39; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status=FILTER(Open)));
            FieldClass = FlowField;
            TableRelation = "Approval Entry";
        }
        field(40; "Approved LPO"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status=FILTER(Approved)));
            FieldClass = FlowField;
            TableRelation = "Approval Entry";
        }
        field(41; "Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'All Requests to Approve';
            FieldClass = FlowField;
        }
        field(42; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID"=FIELD("User ID Filter"), Status=const(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(43; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(44; "Imprest Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter(Imprest)));
            Caption = 'Imprest Requests to Approve';
            FieldClass = FlowField;
        }
        field(45; "Leave Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter(LeaveApplication)));
            Caption = 'Leave Requests to Approve';
            FieldClass = FlowField;
        }
        field(46; "Purchase Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter("Purchase Requisitions")));
            Caption = 'Purchase Requests to Approve';
            FieldClass = FlowField;
        }
        field(47; "Imprest Surr to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter("Imprest Surrender")));
            Caption = 'Imprest Surr to Approve';
            FieldClass = FlowField;
        }
        field(48; "General Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter("Audit Plan"|LeaveAdjustment|"Employee Appraisal"|"Payment Voucher"|"Staff Claim"|"Store Requisitions")));
            Caption = 'General Requests to Approve';
            FieldClass = FlowField;
        }
        field(49; "Leave Recall to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter("Leave Recall")));
            Caption = 'Leave Recall Requests to Approve';
            FieldClass = FlowField;
        }
        field(50; "Leave Adj to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter(LeaveAdjustment)));
            Caption = 'Leave Adjustment Requests to Approve';
            FieldClass = FlowField;
        }
        field(51; "Store Requisitions to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter("Store Requisitions")));
            Caption = 'Store Requisitions Requests to Approve';
            FieldClass = FlowField;
        }
        field(52; "Orders to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter(Order)));
            Caption = 'Orders to Approve';
            FieldClass = FlowField;
        }
        field(53; "Employee Appraisal to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open), "Document Type"=filter("Employee Appraisal")));
            Caption = 'Employee Appraisal to Approve';
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

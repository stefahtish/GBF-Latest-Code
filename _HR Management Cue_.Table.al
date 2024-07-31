table 50168 "HR Management Cue"
{
    Caption = 'Human Resource Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Employees Active"; Integer)
        {
            Caption = 'Active Employees';
            FieldClass = FlowField;
            CalcFormula = count(Employee where(Status=filter(Active)));
        }
        field(3; "Employees Inactive"; Integer)
        {
            Caption = 'Inactive Employees';
            FieldClass = FlowField;
            CalcFormula = count(Employee where(Status=filter(Inactive)));
        }
        field(4; "Vacant Positions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Company Job" where(Vacancy=FILTER(>0)));
        }
        field(5; "Recruitment Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Recruitment Needs" where(Status=FILTER(<>Released), Approved=CONST(false)));
        }
        field(6; Applicants; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Applicants2 WHERE(Applied=FILTER(false)));
        }
        field(7; "Recruitment Shortlist"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Recruitment Needs" WHERE("Shortlisting Closed"=FILTER(false)));
        }
        field(8; "Interview List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Applicants2 where(Employ=CONST(true), Interviewed=FILTER(false)));
        }
        field(13; "Leave Applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Application" where(Status=FILTER(<>Released)));
        }
        field(14; "Leave Adjustments"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Bal Adjustment Header" where(Posted=filter(false)));
        }
        field(15; "Leave Recalls"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Off/Holiday" where(Status=filter(Open)));
        }
        field(16; "Employee Discilinary cases"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Discplinary" where(Posted=FILTER(false)));
        }
        field(17; "Closed Disciplinary Cases"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Discplinary" where(Posted=FILTER(true)));
        }
        field(18; "Open Appraisals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status=CONST(Open)));
        }
        field(19; "Appraisals Under Review"; Integer)
        {
            Caption = 'Rolleover/Repayments Due';
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status=FILTER("Mid-Year Approved"|"Pending Approval"|Released), "Appraisal Status"=FILTER(Review|Set)));
        }
        field(20; "Completed Appraisals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status=FILTER("Mid-Year Approved"|"Pending Approval"|Released), "Appraisal Status"=FILTER(Completed)));
        }
        field(21; "Appraisals Further Review"; Integer)
        {
            Caption = 'Appraisals Under Further Review';
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status=FILTER("Mid-Year Approved"|"Pending Approval"|Released), "Appraisal Status"=FILTER("Further review")));
        }
        field(22; "Training Needs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Need" where(Status=FILTER(Open)));
        }
        field(23; "Training Needs Applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Need" where(Status=FILTER(Application)));
        }
        field(24; "Training Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Request" where(Status=FILTER(<>Released)));
        }
        field(25; "Approved Training requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Request" where(Status=FILTER(Released)));
        }
        field(26; "Acting Duties"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Promotion Type"=CONST("Acting Position"), Status=FILTER(<>Approved|Rejected)));
        }
        field(27; "Acting Duties Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Promotion Type"=CONST("Acting Position"), Status=FILTER(Approved)));
        }
        field(28; "Promotions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Promotion Type"=CONST(Promotion), Status=FILTER(<>Approved|Rejected)));
        }
        field(29; "Promotions Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Promotion Type"=CONST(Promotion), Status=FILTER(Approved)));
        }
        field(30; "Fleet List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset" where("Fixed Asset Type"=FILTER(Fleet)));
        }
        field(31; "Travel Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where(Status=FILTER(<>Released)));
        }
        field(32; "Travel Requests Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where(Status=FILTER(Released)));
        }
        field(33; "Ongoing Trips"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where("Transport Status"=filter("On Trip")));
        }
        field(34; "Completed Trips"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where("Transport Status"=filter(Completed)));
        }
        field(35; "Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(36; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(37; "User ID Filter"; Code[50])
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

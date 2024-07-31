tableextension 50162 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50000; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50001; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50002; HOD; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50003; "Immediate Supervisor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50004; "HR ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50006; Signature; Blob)
        {
            Subtype = Bitmap;
        }
        field(50007; "HOD User"; Boolean)
        {
        }
        field(50005; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(50008; "HOD Imprest Approver"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(50009; "Show All"; Boolean)
        {
        }
        field(50011; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No."=const(1));
            CaptionClass = '1,1,1';
        }
        field(50012; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No."=const(2));
            CaptionClass = '1,2,1';
        }
        field(50013; "Delegated From"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(50014; "Post JV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Post Item JV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "Send Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "CRM Users"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Employee Position"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "Case Handler"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "User Responsibility Center"; Code[10])
        {
            AccessByPermission = TableData "Responsibility Center"=RIMD;
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(60006; "Active Assigned Cases"; Integer)
        {
            CalcFormula = Count("Client Interaction Header" WHERE(Status=CONST("Pending for Action"), "Assigned to User"=FIELD("User ID")));
            FieldClass = FlowField;
        }
        field(60007; "Temp Active Cases"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60008; "Registry Handler"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Active Registry Cases"; Integer)
        {
            CalcFormula = Count("Client Interaction Header" WHERE(Status=CONST("Pending for Action"), "Assigned to User"=FIELD("User ID")));
            FieldClass = FlowField;
        }
        field(60010; "Interactions Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60012; "Risk Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60013; "Closed Cases"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Client Interaction Header" WHERE(Status=CONST(Complete), "Assigned to User"=FIELD("User ID")));
        }
        field(60014; "Assets Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60015; Department; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Global Dimension 2 Code" where("No."=field("Employee No.")));
        }
        field(60016; "Station Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60017; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60018; Director; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    var procedure GetUserFullName(UserId: code[40])FullName: Text var
        User: Record User;
    begin
        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindFirst()then FullName:=User."Full Name";
    end;
}

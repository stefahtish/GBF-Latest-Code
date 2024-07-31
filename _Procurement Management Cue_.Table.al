table 50167 "Procurement Management Cue"
{
    Caption = 'Procurement Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; Vendors; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Vendor);
        }
        field(3; "Purchase Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=CONST(Order)));
        }
        field(4; "Purchase Quotes"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=CONST(Quote)));
        }
        field(5; "Blanket Purchase order"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=CONST("Blanket Order")));
        }
        field(6; "Purchase Invoice"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type"=CONST(Invoice)));
        }
        field(7; "Purchase return order"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type"=CONST("Return Order")));
        }
        field(8; "Purchase Credit Memo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=CONST("Credit Memo")));
        }
        field(13; "Procurement Plans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("G/L Budget Name" where(Blocked=filter(false)));
        }
        field(14; "Purchase request list"; Integer)
        {
            Caption = 'Purchase requests';
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type"=CONST(Purchase), "Fully Ordered"=CONST(false), Status=FILTER(Open|"Pending Approval")));
        }
        field(15; "Purchase request list Approved"; Integer)
        {
            Caption = 'Approved Purchase requests';
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type"=CONST(Purchase), "Fully Ordered"=CONST(false), Status=FILTER(Released)));
        }
        field(16; "Store Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type"=CONST(Stock), Status=FILTER("Pending Approval"), Posted=CONST(false)));
        }
        field(17; "Approved Store Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type"=CONST(Stock), Status=FILTER(Released), Posted=CONST(false)));
        }
        field(18; "Open Store Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type"=CONST(Stock), Status=FILTER(Open), Posted=CONST(false)));
        }
        field(19; "Request for Quote & Order"; Integer)
        {
            Caption = 'Request for Quote and Order';
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Line" where("Header Status"=FILTER(Released), "RFQ Created"=CONST(false), "Document Type"=FILTER(Purchase), "Cleared For Rfq"=CONST(true)));
        }
        field(20; "Open Tenders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type"=CONST(Tender), Status=CONST(New), "Tender Type"=const(Open)));
        }
        field(21; "Restricted Tenders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type"=CONST(Tender), Status=CONST(New), "Tender Type"=const(Restricted)));
        }
        field(22; "Prospective Suppliers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Prospective Suppliers");
        }
        field(23; "Prequalified Suppliers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Prequalified Suppliers" where("Pre Qualified"=CONST(true)));
        }
        field(24; "Request For Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type"=CONST(RFP), Status=CONST(New)));
        }
        field(25; "RFP Evaluation List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("RFP Evaluation Header" where("RFP Generated"=CONST(false)));
        }
        field(26; "EOI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type"=CONST(EOI), Status=CONST(New)));
        }
        field(27; "EOI under Evaluation"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("EOI Evaluation Header" where("EOI Generated"=CONST(false)));
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
        field(30; "User ID Filter"; Code[50])
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

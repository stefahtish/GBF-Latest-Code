table 50153 "Budget Approval Header"
{
    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                    GeneralLedgerSetup.Get;
                    NoSeriesManagement.TestManual(GeneralLedgerSetup."Budget Approval Nos");
                    "No Series":='';
                end;
            end;
        }
        field(2; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Time Created"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Budget Name"; Code[10])
        {
            Caption = 'Budget Name';
            DataClassification = ToBeClassified;
            TableRelation = IF("Budget Option"=FILTER(Budgeting))"G/L Budget Name" WHERE("Budget Status"=FILTER(Open))
            ELSE IF("Budget Option"=FILTER(ReAllocation))"G/L Budget Name" WHERE("Budget Status"=FILTER(Approved));
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open, "Pending Approval", Approved, Rejected;
        }
        field(6; "User ID"; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Budget Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Budgeting,ReAllocation';
            OptionMembers = " ", Budgeting, ReAllocation;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(11; Approvals; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Document No."=FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            GeneralLedgerSetup.Get;
            GeneralLedgerSetup.TestField("Proposed Budget Approval Nos");
            NoSeriesManagement.InitSeries(GeneralLedgerSetup."Budget Approval Nos", xRec."No Series", 0D, "Document No.", "No Series");
        end;
        "Date Created":=Today;
        "Time Created":=Time;
        "User ID":=UserId;
    end;
    var NoSeriesManagement: Codeunit NoSeriesManagement;
    GeneralLedgerSetup: Record "Cash Management Setups";
}

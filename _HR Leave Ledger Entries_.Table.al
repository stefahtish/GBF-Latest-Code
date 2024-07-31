table 50259 "HR Leave Ledger Entries"
{
    DrillDownPageId = "HR Leave Ledger Entries";
    LookupPageId = "HR Leave Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Leave Period"; Date)
        {
            Caption = 'Leave Period';
            DataClassification = ToBeClassified;
        }
        field(3; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = ToBeClassified;
        }
        field(4; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if Employee.Get("Staff No.")then begin
                    "Staff Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Global Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
                end;
            end;
        }
        field(5; "Staff Name"; Text[70])
        {
            Caption = 'Staff Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Leave Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Leave Entry Type"; Option)
        {
            Caption = 'Leave Entry Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive, Negative;

            trigger OnValidate()
            begin
                if "Leave Entry Type" = "Leave Entry Type"::Negative then begin
                    "No. of days":=-"No. of days" end
                else
                    "No. of days":="No. of days";
            end;
        }
        field(8; "Leave Approval Date"; Date)
        {
            Caption = 'Leave Approval Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(10; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Job ID"; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Job Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Contract Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "No. of days"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'No. of days';
            DataClassification = ToBeClassified;
        }
        field(15; "Leave Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Leave Posting Description"; Text[50])
        {
            Caption = 'Leave Posting Description';
            DataClassification = ToBeClassified;
        }
        field(17; "Leave End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Leave Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(22; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));
        }
        field(23; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User;

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(24; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(25; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(27; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
            DataClassification = ToBeClassified;
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "Leave Recalled No."; Code[20])
        {
            Caption = 'Leave Application No.';
            DataClassification = ToBeClassified;
            TableRelation = "Leave Application"."Employee No" WHERE("Employee No"=FIELD("Staff No."), Status=CONST(Released));
        }
        field(30; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Type".Code;

            trigger OnValidate()
            begin
                if LeaveType.Get("Leave Type")then begin
                end;
            end;
        }
        field(31; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Leave Allocation,Leave Recall,OverTime,Leave Application,Leave Adjustment,Leave B/F,Absent';
            OptionMembers = " ", "Leave Allocation", "Leave Recall", OverTime, "Leave Application", "Leave Adjustment", "Leave B/F", Absent;
        }
        field(33; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';
            DataClassification = ToBeClassified;
            TableRelation = "Leave Application"."Application No";

            trigger OnValidate()
            begin
            /*
                
                IF "Leave Application No." = '' THEN BEGIN
                  CreateDim(DATABASE::Insurance,"Leave Application No.");
                  EXIT;
                END;
                LeaveApplic.RESET;
                LeaveApplic.SETRANGE(LeaveApplic."Application No","Leave Application No.");
                IF LeaveApplic.FIND('-')THEN BEGIN
                //LeaveApplic.GET("Leave Application No.");
                //LeaveApplic.TESTFIELD(Blocked,FALSE);
                "Leave Posting Description":= LeaveApplic.Comments;
                "Leave Approval Date":=LeaveApplic."Start Date";
                "No. of days":=LeaveApplic."Approved Days";
                "Leave Type":=LeaveApplic."Leave Code";
                END;
                CreateDim(DATABASE::"Leave Application","Leave Application No.");
                
                */
            end;
        }
        field(34; Entitlement; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Balance Brought Forward"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Leave Assignment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Leave Period Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Periods";
        }
        field(38; AnnualLeave; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Leave Type"."Annual Leave" where(Code=field("Leave Type")));
        }
        field(19; Accrued; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Document No.", "Staff No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var LeaveApplic: Record "Leave Application";
    Employee: Record Employee;
    LeaveType: Record "Leave Type";
    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        TableID: array[10]of Integer;
        No: array[10]of Code[20];
    begin
    /*TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        DimMgt.GetDefaultDim(
          TableID,No,"Source Code",
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        IF "Line No." <> 0 THEN
          DimMgt.UpdateJnlLineDefaultDim(
            DATABASE::Table5635,
            "Journal Template Name","Journal Batch Name","Line No.",0,
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
          */
    end;
}

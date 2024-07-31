table 50419 "Tender Evaluation Header"
{
    Caption = 'Tender Evaluation Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Procurement Request";
        }
        field(2; Title; Text[70])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;
        }
        field(3; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Internal Request Header";
        }
        field(4; "Tender Generated"; Boolean)
        {
            Caption = 'Tender Generated';
            DataClassification = ToBeClassified;
        }
        field(5; Minutes; Boolean)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Committees";
        }
        field(6; "Awarding Committee"; Code[20])
        {
            Caption = 'Awarding Committee';
            DataClassification = ToBeClassified;
        }
        field(7; "Date of Award"; Date)
        {
            Caption = 'Date of Award';
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New, "Pending Approval", Approved, Rejected;
        }
        field(9; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(12; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(13; Comments; Blob)
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(14; Suggested; Boolean)
        {
            Caption = 'Suggested';
            DataClassification = ToBeClassified;
        }
        field(15; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
            DataClassification = ToBeClassified;
        }
        field(16; "Payment Terms"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(17; "Contact Job Position"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                if Jobs.Get("Contact Job Position")then begin
                    "Contact Job Position Title":=Jobs."Job Description";
                end;
            end;
        }
        field(18; "Contact Job Position Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Ref No."; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Sign-Off Employee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.get("Sign-Off Employee")then begin
                    "Sign-Off Employee Name":=EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    "Sign-Off Employee Title":=EmpRec."Job Position Title";
                end;
            end;
        }
        field(21; "Sign-Off Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Sign-Off Employee Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Lowest Bid Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min("Tender Evaluation Line".Amount where("Quote No"=field("Quote No"), Amount=filter(>0)));
            Editable = false;
        }
        field(24; Stage; Option)
        {
            OptionMembers = Evaluation, Negotiation, Specialized;
            DataClassification = ToBeClassified;
        }
        field(25; Terminated; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request".Terminated where("No."=field("Quote No")));
        }
    }
    keys
    {
        key(PK; "Quote No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Quote No", Title)
        {
        }
    }
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    var Jobs: Record "Company Job";
    EmpRec: Record Employee;
}

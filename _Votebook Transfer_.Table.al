table 50152 "Votebook Transfer"
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    CashManagementSetup.Get;
                    CashManagementSetup.TestField("Proposed Budget Approval Nos");
                    NoSeriesManagement.TestManual(CashManagementSetup."Proposed Budget Approval Nos");
                    "No. Series":='';
                end;
            end;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Source Vote"; Code[20])
        {
            Caption = 'Source G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Destination Vote"; Code[20])
        {
            Caption = 'Destination G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Budget Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name WHERE(Blocked=CONST(false));
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Source Dimension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(8; "Destination Dimension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
            //IF (("Destination Dimension 1"<>'') AND ("Destination Dimension 1"<>"Source Dimension 1")) THEN
            // ERROR(DimError,FIELDCAPTION("Destination Dimension 1"),"Destination Dimension 1",FIELDCAPTION("Source Dimension 1"),"Source Dimension 1");
            end;
        }
        field(10; "Source Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(11; "Destination Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
            //IF (("Destination Dimension 2"<>'') AND ("Destination Dimension 2"<>"Source Dimension 2")) THEN
            // ERROR(DimError,FIELDCAPTION("Destination Dimension 2"),"Destination Dimension 2",FIELDCAPTION("Source Dimension 2"),"Source Dimension 2");
            end;
        }
        field(12; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Raised By"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Raised Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Approved By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Posted By"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Approved,Pending Approval,Closed,Archived';
            OptionMembers = Open, Approved, "Pending Approval", Closed, Archived;
        }
        field(24; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(25; "Source Vote Name"; Text[50])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE("No."=FIELD("Source Vote")));
            Caption = 'Source G/L Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Destination Vote Name"; Text[50])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE("No."=FIELD("Destination Vote")));
            Caption = 'Destination G/L Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Balance As At"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Today,End of Financial Year';
            OptionMembers = " ", Today, "End of Financial Year";
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            CashManagementSetup.Get;
            CashManagementSetup.TestField("Proposed Budget Approval Nos");
            NoSeriesManagement.InitSeries(CashManagementSetup."Proposed Budget Approval Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
        "Raised By":=UserId;
        "Raised Date":=Today;
    end;
    var CashManagementSetup: Record "Cash Management Setups";
    NoSeriesManagement: Codeunit NoSeriesManagement;
    DimError: Label 'Destination %1 %2 must be same as Source %3 %4';
}

table 50199 "Activity Work Programme"
{
    Caption = 'Work Programme';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Workplan No."; Code[20])
        {
            Caption = 'Workplan No.';
            DataClassification = ToBeClassified;
            TableRelation = "ICT Workplan";

            trigger OnValidate()
            var
                ICTWorkplan: Record "ICT Workplan";
            begin
                if ICTWorkplan.get("Workplan No.")then;
                "Workplan Description":=ICTWorkplan.Description;
                "Criteria Code":=ICTWorkplan."Criteria Code";
                Validate("Criteria Code");
            end;
        }
        field(3; "Workplan Description"; Text[100])
        {
            Caption = 'Workplan Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Activity Start Date"; Date)
        {
            Caption = 'Activity Start Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Activity End Date"; Date)
        {
            Caption = 'Activity End Date';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; Objective; Text[2000])
        {
            Caption = 'Objective';
            DataClassification = ToBeClassified;
        }
        field(8; Status;Enum "Approval Status-custom")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(9; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(10; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Indicator Description"; Text[500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(14; "Perfomance Indicator Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance SubCriteria".Code; // where("Criteria Code" = field("Criteria Code"));

            trigger OnValidate()
            var
                Indicators: Record "Perfomance SubCriteria";
            begin
                Indicators.SetRange(Code, "Perfomance Indicator Code");
                if Indicators.FindFirst()then "Indicator Description":=Indicators.Description;
            end;
        }
        field(15; "Criteria Code"; Code[20])
        {
            Caption = 'Criteria Code';
            DataClassification = ToBeClassified;
            TableRelation = "Criteria Category";

            trigger OnValidate()
            var
                Categories: record "Criteria Category";
            begin
                Categories.Reset();
                Categories.SetRange(Categories.Code, "Criteria Code");
                if Categories.FindFirst()then begin
                    "Criteria Description":=Categories.Description;
                end;
            end;
        }
        field(16; "Criteria Description"; Text[200])
        {
            Caption = 'Criteria Description';
            DataClassification = ToBeClassified;
        }
        field(17; "Activity Code"; Code[20])
        {
            Caption = 'Activity Code';
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Activity"."Activity Code";

            trigger OnValidate()
            var
                Activity: Record "Strategic Activity";
            begin
                Activity.Reset();
                Activity.SetRange("Activity Code", "Activity Code");
                if Activity.FindFirst()then "Activity Description":=Activity.Activity2;
            end;
        }
        field(18; "Activity Description"; Text[200])
        {
            Caption = 'Activity Description';
            DataClassification = ToBeClassified;
        }
        field(19; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Activity Work Programme Lines".Amount where("No."=field("No.")));
        }
        field(20; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(21; "ParticipantLineExist"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Activity Work Programme Lines" where("Employee No."=field("Employee Filter"), Type=filter(Participants), "No."=field("No.")));
        }
        field(22; "Shortcut Dimension 3 Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Activity Budget Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(23; "Requisition Made"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Purchase Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Mileage Claimed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Activity Work Programme Lines"."Mileage claimed" where("Employee No."=field("Employee Filter"), Type=filter(Participants), "No."=field("No.")));
        }
        field(26; "Total Purchase Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Activity Work Programme Lines".Amount where("No."=field("No."), "Purchase Type"=filter("Procurement Process")));
        }
        field(27; "Account Type";enum "Gen. Journal Account Type")
        {
        }
        field(28; "Account No"; Code[20])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST(Item))Item;

            trigger OnValidate()
            begin
                case "Account Type" of "Account Type"::"G/L Account": begin
                    if GLAccount.Get("Account No")then;
                    GLAccount.TestField("Direct Posting", true);
                    "Account Name":=GLAccount.Name;
                end;
                "Account Type"::Vendor: begin
                    if Vendor.Get("Account No")then;
                    "Account Name":=Vendor.Name;
                end;
                "Account Type"::Customer: begin
                    Customer.Get("Account No");
                    "Account Name":=Customer.Name;
                end;
                "Account Type"::"Bank Account": begin
                    Bank.Get("Account No");
                    "Account Name":=Bank.Name;
                end;
                "Account Type"::"Fixed Asset": begin
                    FixedAsset.Get("Account No");
                    "Account Name":=FixedAsset.Description;
                end;
                end;
            end;
        }
        field(29; "Account Name"; Text[100])
        {
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(31; "Committed"; Boolean)
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if not ICTSetup.Get then begin
            ICTSetup.Init();
            ICTSetup.Insert();
        end;
        ICTSetup.TestField("Activity Workplan Nos");
        NoSeriesMgt.InitSeries(ICTSetup."Activity Workplan Nos", xRec."No. Series", Today, "No.", "No. Series");
        "Created By":=UserId;
        "Document Date":=Today;
        if GuiAllowed then begin
            IF UserSetup.GET(USERID)THEN BEGIN
                UserSetup.TESTFIELD("Employee No.");
                IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                    "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                END;
            END;
        end;
    end;
    var ICTSetup: Record "ICT Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    DimMgt: Codeunit DimensionManagement;
    GLSetup: Record "General Ledger Setup";
    GLAccount: Record "G/L Account";
    Customer: Record Customer;
    Vendor: Record Vendor;
    FixedAsset: Record "Fixed Asset";
    Bank: Record "Bank Account";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        if FieldNumber = 3 then "Shortcut Dimension 3 Code":=ShortcutDimCode;
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF("No." <> '')THEN MODIFY;
        IF(OldDimSetID <> "Dimension Set ID") AND (("No." <> ''))THEN BEGIN
            MODIFY;
        //IF SalesLinesExist THEN
        //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
        //G/L Account
        if FieldNumber = 3 then begin
            GLSetup.Get;
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 3 Code", ShortcutDimCode);
            if GLBudget.Find('-')then begin
                if "Account Type" <> "Account Type"::"G/L Account" then begin
                    "Account Type":="Account Type"::"G/L Account";
                end;
                if "Account No" <> GLBudget."G/L Account No." then begin
                    "Account No":=GLBudget."G/L Account No.";
                    Validate("Account No");
                end;
            end;
        end;
    end;
    procedure ShowDimensions()
    begin
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1', "No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        PaymentRec: Record Payments;
    begin
    /*if PaymentRec.Get(No) then;
        if FieldNumber = 5 then
            if PaymentRec."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, PaymentRec."Dimension Set ID");

        if FieldNumber = 6 then
            if PaymentRec."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, PaymentRec."Dimension Set ID");

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);*/
    end;
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8]of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
}

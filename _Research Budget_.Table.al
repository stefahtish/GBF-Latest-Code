table 50635 "Research Budget"
{
    Caption = 'Research Budget';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(3));
        }
        field(2; "Source of Funds"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                GLSetup.Get;
                GLSetup.TestField("Current Budget");
                GLSetup.TestField("Current Budget Start Date");
                GLSetup.TestField("Current Budget End Date");
                GLBudget.SetCurrentKey("Budget Name", "G/L Account No.", Date, "Global Dimension 1 Code");
                GLBudget.SetRange(GLBudget."Budget Name", GLSetup."Current Budget");
                GLBudget.SetRange(GLBudget."G/L Account No.", "Source of Funds");
                if GLSetup."Use Dimensions For Budget" then GLBudget.SetRange(GLBudget."Dimension Set ID", "Dimension Set ID");
                GLBudget.SetRange(GLBudget.Date, GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date");
                GLBudget.CalcSums(Amount);
                BudgetAmount:=GLBudget.Amount;
                "Approved Budget":=BudgetAmount;
            end;
        }
        field(3; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Source of Funds");
                if "Estimated Cost" > ("Approved Budget")then Error('Overall budget amount for A/C no %1 has been exceeded by %2. Total Budgeted amount = %3', "Source of Funds", ("Estimated Cost" - ("Approved Budget")), "Approved Budget");
            end;
        }
        field(4; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Budget Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Open, Approved, Rejected;
        }
        field(7; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if GLAcc.Get("No.")then begin
                    "Source of Funds":="No.";
                    "Description":=GLAcc.Name;
                end;
            end;
        }
        field(8; Actual; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("Source of Funds"), "Posting Date"=FIELD("Date Filter"), "Dimension Set ID"=FIELD("Dimension Set ID")));
            Caption = 'Actuals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Commitment; Decimal)
        {
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(No=FIELD("Source of Funds"), "Commitment Date"=FIELD("Date Filter"), "Dimension Set ID"=FIELD("Dimension Set ID")));
            Caption = 'Commitments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Date; Date)
        {
        }
        field(11; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(14; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(15; "Activity"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Promotion, Partnership, Dairy, Research, Stakeholders;
            OptionCaption = ' ,Promotion,Partnership,Dairy,Research,Stakeholders';
        }
    }
    keys
    {
        key(Key1; "Expense Code", Activity)
        {
            Clustered = true;
            SumIndexFields = "Estimated Cost";
        }
        key(Key2; "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
        key(Key3; "No.")
        {
            SumIndexFields = "Estimated Cost";
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Expense Code", Description)
        {
        }
    }
    trigger OnInsert()
    begin
    /* PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Procurement Plan Item Nos");
        if "Plan Item No" = '' then begin
            NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Procurement Plan Item Nos", xRec."No. Series", 0D, "Plan Item No", "No. Series");
        end; */
    end;
    var DimMgt: Codeunit DimensionManagement;
    BudgetAmount: Decimal;
    TrainingPlanAmount: Decimal;
    VATAmount: Decimal;
    CurrencyRec: Record Currency;
    CurrencyExchangeRate: Record "Currency Exchange Rate";
    GLAcc: Record "G/L Account";
    ItemRec: Record Item;
    InventorySetup: Record "Inventory Posting Setup";
    GLBudget: Record "G/L Budget Entry";
    GLSetup: Record "General Ledger Setup";
    TrainingPlan: Record "Training budget";
    HRSetup: Record "Human Resources Setup";
    PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    VATSetup: Record "VAT Posting Setup";
    Direction: Text[30];
    NoSeriesMgt: Codeunit NoSeriesManagement;
    FixedAsset: Record "Fixed Asset";
    FAPostingGrp: Record "FA Posting Group";
    procedure CheckAttachment(var ProcurementPlan: Record "Procurement Plan")LinkExists: Boolean var
        RecLink: Record "Record Link";
        SearchString: Text[50];
        ProcPlanRef: RecordRef;
        RecLinkRef: RecordRef;
    begin
        ProcPlanRef.GetTable(ProcurementPlan);
        SearchString:=Format(ProcPlanRef.RecordId);
        RecLink.SetFilter(RecLink."Record ID", SearchString);
        if RecLink.Find('-')then begin
            LinkExists:=true;
            repeat //MESSAGE('%1 %2',RecLink."Link ID",RecLink.Description);
            until RecLink.Next = 0;
        end
        else
            LinkExists:=false;
    end;
    procedure GetQuarters()
    var
        AccPeriod: Record "Accounting Period";
        NewYear: Date;
        "1stQuarter": Decimal;
        "2ndQuarter": Decimal;
        "3rdQuarter": Decimal;
        "4thQuarter": Decimal;
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-')then NewYear:=AccPeriod."Starting Date";
    // //Get 1st Quarter Budget
    // SetRange("Budget Item No", "Budget Item No");
    // SetRange(Date, NewYear, CalcDate('1Q', NewYear));
    // if Find('-') then begin
    //     CalcSums("Estimated Cost");
    //     "1stQuarter" := "Estimated Cost";
    // end;
    // //Get 2nd Quarter Budget
    // SetRange("Budget Item No", "Budget Item No");
    // SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
    // if Find('-') then begin
    //     CalcSums("Estimated Cost");
    //     "2ndQuarter" := "Estimated Cost";
    // end;
    // //Get 3rd Quarter Budget
    // SetRange("Budget Item No", "Budget Item No");
    // SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
    // if Find('-') then begin
    //     CalcSums("Estimated Cost");
    //     "3rdQuarter" := "Estimated Cost";
    // end;
    // //Get 4th Quarter Budget
    // SetRange("Budget Item No", "Budget Item No");
    // SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
    // if Find('-') then begin
    //     CalcSums("Estimated Cost");
    //     "4thQuarter" := "Estimated Cost";
    // end;
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

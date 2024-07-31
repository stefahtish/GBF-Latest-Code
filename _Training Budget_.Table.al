table 50321 "Training Budget"
{
    fields
    {
        field(1; "Training Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Budget Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Source of Funds"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(4; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GLSetup.Get;
                GLSetup.TestField("Current Budget");
                GLSetup.TestField("Current Budget Start Date");
                GLSetup.TestField("Current Budget End Date");
                GLBudget.SetCurrentKey("Budget Name", "G/L Account No.", Date, "Global Dimension 1 Code");
                GLBudget.SetRange(GLBudget."Budget Name", "Training Year");
                GLBudget.SetRange(GLBudget."G/L Account No.", "Source of Funds");
                if GLSetup."Use Dimensions For Budget" then GLBudget.SetRange(GLBudget."Dimension Set ID", "Dimension Set ID");
                GLBudget.SetRange(GLBudget.Date, GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date");
                GLBudget.CalcSums(Amount);
                BudgetAmount:=GLBudget.Amount;
                "Approved Budget":=BudgetAmount;
                TrainingPlan.SetCurrentKey("Training Year", "Source of Funds");
                TrainingPlan.SetRange(TrainingPlan."Training Year", "Training Year");
                TrainingPlan.SetRange(TrainingPlan."Source of Funds", "Source of Funds");
                TrainingPlan.CalcSums("Estimated Cost");
                TrainingPlanAmount:=TrainingPlan."Estimated Cost";
                if "Estimated Cost" > (BudgetAmount - TrainingPlanAmount)then Error('Overall budget amount for A/C no %1 has been exceeded by %2. Total Budgeted amount = %3', "Source of Funds", ("Estimated Cost" - (BudgetAmount - TrainingPlanAmount)), BudgetAmount);
            end;
        }
        field(5; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Budget Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Open, Approved, Rejected;
        }
        field(8; "No."; Code[20])
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
        field(9; Actual; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("Source of Funds"), "Posting Date"=FIELD("Date Filter"), "Dimension Set ID"=FIELD("Dimension Set ID")));
            Caption = 'Actuals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Commitment; Decimal)
        {
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(No=FIELD("Source of Funds"), "Commitment Date"=FIELD("Date Filter"), "Dimension Set ID"=FIELD("Dimension Set ID")));
            Caption = 'Commitments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Date; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                HRSetup.Get();
                HRSetup.TestField("Training Budget Item Nos");
                if "Budget Item No" = '' then begin
                    NoSeriesMgt.InitSeries(HRSetup."Training Budget Item Nos", xRec."No. Series", 0D, "Budget Item No", "No. Series");
                end;
            end;
        }
        field(12; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(15; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(16; "No. Series"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Training Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Code";

            trigger OnValidate()
            var
                ExpenseCode: record "Expense Code";
            begin
                "No.":='';
                "Training Expence Name":='';
                "Source of Funds":='';
                if ExpenseCode.Get("Training Expense Code")then begin
                    "Training Expence Name":=ExpenseCode.Name;
                    "Source of Funds":=ExpenseCode."G/L Account";
                    "No.":=ExpenseCode."G/L Account";
                end;
            end;
        }
        field(17; "Training Expence Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Training Year", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Budget Item No")
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
        key(Key4; "Training Year", "Shortcut Dimension 2 Code", "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Budget Item No", Description)
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
    procedure FindManagersEmail(var ProcurePlan: Record "Procurement Plan")Memailaddress: Text[50]var
        Jobs: Record "Company Job";
        Emp: Record Employee;
    begin
    /*Jobs.RESET;
        Jobs.SETRANGE(Jobs.Management,TRUE);
        Jobs.SETRANGE(Jobs."Dimension 1",ProcurePlan."Department Code");
        IF Jobs.FIND('-') THEN
        BEGIN
        //MESSAGE('%1',Jobs."Job ID");
        Emp.RESET;
        Emp.SETRANGE(Emp.Position,Jobs."Job ID");
        IF Emp.FIND('-') THEN
        Memailaddress:=Emp."Company E-Mail";
        IF Memailaddress='' THEN
        ERROR('set company address for employee %1',Emp."No.");
        END
        ELSE
        ERROR('Manager for Department %1 has not been defined in the system',ProcurePlan."Department Code");
        */
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
        //Get 1st Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Find('-')then begin
            CalcSums("Estimated Cost");
            "1stQuarter":="Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Find('-')then begin
            CalcSums("Estimated Cost");
            "2ndQuarter":="Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Find('-')then begin
            CalcSums("Estimated Cost");
            "3rdQuarter":="Estimated Cost";
        end;
        //Get 4th Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Find('-')then begin
            CalcSums("Estimated Cost");
            "4thQuarter":="Estimated Cost";
        end;
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

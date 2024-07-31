table 50131 "Procurement Plan"
{
    fields
    {
        field(1; "Plan Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Plan Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Procurement Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Service, Goods, Works, "Fixed Asset", Consultancy;

            trigger OnValidate()
            begin
                case "Procurement Type" of "Procurement Type"::Service, "Procurement Type"::Works, "Procurement Type"::Consultancy: Type:=Type::"G/L Account";
                "Procurement Type"::Goods: Type:=Type::Item;
                "Procurement Type"::"Fixed Asset": Type:=Type::"Fixed Asset";
                end;
            end;
        }
        field(4; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(5; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Estimated Cost":=Quantity * "Unit Price";
                Validate("Estimated Cost");
            end;
        }
        field(6; "Procurement Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Method";
        }
        field(7; "Source of Funds"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                validate("Estimated Cost");
            end;
        // TableRelation = "G/L Account";
        // trigger Onvalidate()
        // begin
        //     GLSetup.Get;
        //     GLSetup.TestField("Current Budget");
        //     GLSetup.TestField("Current Budget Start Date");
        //     GLSetup.TestField("Current Budget End Date");
        //     GLBudget.SetCurrentKey("Budget Name", "G/L Account No.", Date, "Global Dimension 1 Code");
        //     GLBudget.SetRange(GLBudget."Budget Name", "Plan Year");
        //     GLBudget.SetRange(GLBudget."G/L Account No.", "Source of Funds");
        //     if GLSetup."Use Dimensions For Budget" then
        //         GLBudget.SetRange(GLBudget."Dimension Set ID", "Dimension Set ID");
        //     //GLBudget.SetRange(GLBudget.Date, GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date");
        //     GLBudget.CalcSums(Amount);
        //     BudgetAmount := GLBudget.Amount;
        //     "Approved Budget" := BudgetAmount;
        // end;
        }
        field(8; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ProcPlanAmount:=0;
                BudgetAmount:=0;
                GLSetup.Get;
                GLSetup.TestField("Current Budget");
                GLSetup.TestField("Current Budget Start Date");
                GLSetup.TestField("Current Budget End Date");
                GLBudget.SetCurrentKey("Budget Name", "G/L Account No.", Date, "Global Dimension 1 Code");
                GLBudget.SetRange(GLBudget."Budget Name", "Plan Year");
                GLBudget.SetRange(GLBudget."G/L Account No.", "Source of Funds");
                GLBudget.SetRange("Dimension Set ID", "Dimension Set ID");
                GLBudget.SetRange(GLBudget.Date, GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date");
                GLBudget.CalcSums(Amount);
                BudgetAmount:=GLBudget.Amount;
                "Approved Budget":=BudgetAmount;
                ProcPlan.Reset();
                ProcPlan.SetCurrentKey("Plan Year", "Department Code", "Source of Funds");
                ProcPlan.SetRange(ProcPlan."Plan Year", "Plan Year");
                ProcPlan.SetRange(ProcPlan."Department Code", "Department Code");
                ProcPlan.setfilter("Plan Item No", '<>%1', "Plan Item No");
                ProcPlan.SetRange(ProcPlan."Source of Funds", "Source of Funds");
                ProcPlan.CalcSums("Estimated Cost");
                ProcPlanAmount:=ProcPlan."Estimated Cost";
                if "Estimated Cost" > (BudgetAmount - ProcPlanAmount)then Error('Overall budget amount for A/C no %1 has been exceeded by %2. Total Budgeted amount = %3', "Source of Funds", (BudgetAmount - ProcPlanAmount - "Estimated Cost"), BudgetAmount);
            end;
        // trigger OnValidate()
        // begin
        //     Validate("Source of Funds");
        //     ProcPlan.SetCurrentKey("Plan Year", "Department Code", "Source of Funds");
        //     ProcPlan.SetRange(ProcPlan."Plan Year", "Plan Year");
        //     // ProcPlan.SetRange(ProcPlan."Department Code", "Department Code");
        //     ProcPlan.SetRange(ProcPlan."Source of Funds", "Source of Funds");
        //     ProcPlan.CalcSums("Estimated Cost");
        //     ProcPlanAmount := ProcPlan."Estimated Cost";
        //     if "Estimated Cost" > (BudgetAmount - ProcPlanAmount) then
        //         Error('Overall budget amount for A/C no %1 has been exceeded by %2. Total Budgeted amount = %3', "Source of Funds",
        //         ("Estimated Cost" - (BudgetAmount - ProcPlanAmount)), BudgetAmount);
        // end;
        }
        field(9; "Advertisement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Bid/Quotation Opening Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Proposal Evaluation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Financial Opening date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Negotiation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Notification of award date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Contract Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Contract End Date (Planned)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(18; "TOR/Technical specs due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Item Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(21; Category; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";
        }
        field(22; "Process Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender;
        }
        field(23; "Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Plan Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Open, Approved, Rejected;
        }
        field(25; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "G/L Account", Item, , "Fixed Asset", "Charge (Item)";
        }
        field(26; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(" "))"Standard Text"
            ELSE IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF(Type=CONST("Charge (Item)"))"Item Charge";

            trigger OnValidate()
            begin
                if GLAcc.Get("No.")then begin
                    "Source of Funds":="No.";
                    "Item Description":=GLAcc.Name;
                end;
                if ItemRec.Get("No.")then begin
                    "Item Description":=ItemRec.Description;
                    "Unit of Measure":=ItemRec."Base Unit of Measure";
                    "Unit Price":=ItemRec."Last Direct Cost";
                    ItemRec.TestField("Item G/L Budget Account");
                    "Source of Funds":=ItemRec."Item G/L Budget Account";
                end;
            end;
        // DataClassification = ToBeClassified;
        // TableRelation = IF (Type = CONST(" ")) "Standard Text"
        // ELSE
        // IF (Type = CONST("G/L Account")) "G/L Account"
        // ELSE
        // IF (Type = CONST(Item)) Item
        // ELSE
        // IF (Type = CONST("Fixed Asset")) "Fixed Asset"
        // ELSE
        // IF (Type = CONST("Charge (Item)")) "Item Charge";
        // trigger OnValidate()
        // begin
        //     if GLAcc.Get("No.") then begin
        //         "Source of Funds" := "No.";
        //         "Item Description" := GLAcc.Name;
        //     end;
        //     if ItemRec.Get("No.") then begin
        //         "Item Description" := ItemRec.Description;
        //         "Unit of Measure" := ItemRec."Base Unit of Measure";
        //         "Unit Price" := ItemRec."Last Direct Cost";
        //         //InventorySetup.GET('',ItemRec."Inventory Posting Group");
        //         ItemRec.TestField("Item G/L Budget Account");
        //         "Source of Funds" := ItemRec."Item G/L Budget Account";
        //     end;
        //     if FixedAsset.Get("No.") then begin
        //         "Item Description" := FixedAsset.Description;
        //         FixedAsset.TestField("FA Posting Group");
        //         FAPostingGrp.get(FixedAsset."FA Posting Group");
        //         "Source of Funds" := FAPostingGrp."Acquisition Cost Account";
        //     end;
        //     Validate("Source of Funds");
        // end;
        }
        field(27; Actual; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("Source of Funds"), "Posting Date"=FIELD("Date Filter"), "Dimension Set ID"=FIELD("Dimension Set ID")));
            Caption = 'Actuals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; Commitment; Decimal)
        {
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(No=FIELD("Source of Funds"), "Commitment Date"=FIELD("Date Filter"), "Dimension Set ID"=FIELD("Dimension Set ID")));
            Caption = 'Commitments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; Date; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PurchasesPayablesSetup.Get();
                PurchasesPayablesSetup.TestField("Procurement Plan Item Nos");
                if "Plan Item No" = '' then begin
                    NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Procurement Plan Item Nos", xRec."No. Series", 0D, "Plan Item No", "No. Series");
                end;
            end;
        }
        field(30; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(33; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(34; "VAT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                CalcVATAmount;
            end;
        }
        field(35; "Withholding Tax Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(36; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "VAT Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(39; "Amount To Post"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Amount To Post (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "VAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "No. Series"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Youth"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Women"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; PWDS; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Citizen contractors"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(146; "General"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Margin of pref local contr"; Decimal)
        {
            Caption = 'Margin of preference on local contractors';
            DataClassification = ToBeClassified;
        }
        field(48; "Funds Provider"; Text[100])
        {
            Caption = 'Funds Provider';
            DataClassification = ToBeClassified;
        }
        field(49; "Shortcut Dimension 3 Code"; Code[20])
        {
            //CaptionClass = '1,1,3';
            Caption = 'Activity Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));

            trigger OnValidate()
            var
                DimValues: Record "Dimension Value";
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                DimValues.Reset();
                DimValues.SetRange(Code, "Shortcut Dimension 3 Code");
                DimValues.SetRange("Global Dimension No.", 3);
                if DimValues.FindFirst()then "Activity Name":=DimValues.Name;
            end;
        }
        field(50; "Activity Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51; Quarter1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; Quarter2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; Quarter3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; Quarter4; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Pre-Qualifications"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Timing Of Activities"; Option)
        {
            //DataClassification = ToBeClassified;
            optionmembers = "1st Quater", "2nd Quarter", "3rd Quater", "4th Quater";
            OptionCaption = '1st Quarter,2nd Quarter,3rd Quarter,4th Quarter';
        }
        field(57; "AGPO/General"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", AGPO, General;
        }
        field(58; "Procurement Plan Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Plan Year", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Plan Item No")
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
        key(Key4; "Plan Year", "Shortcut Dimension 2 Code", "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
    }
    fieldgroups
    {
        // fieldgroup(DropDown; "Plan Item No", "Procurement Type", "Item Description")
        // {
        // }
        fieldgroup(DropDown; "Plan Item No", "Procurement Plan Description")
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
    ProcPlanAmount: Decimal;
    VATAmount: Decimal;
    CurrencyRec: Record Currency;
    CurrencyExchangeRate: Record "Currency Exchange Rate";
    GLAcc: Record "G/L Account";
    ItemRec: Record Item;
    InventorySetup: Record "Inventory Posting Setup";
    GLBudget: Record "G/L Budget Entry";
    GLSetup: Record "General Ledger Setup";
    ProcPlan: Record "Procurement Plan";
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
        SetRange("Plan Item No", "Plan Item No");
        SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Find('-')then begin
            CalcSums("Estimated Cost");
            "1stQuarter":="Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        SetRange("Plan Item No", "Plan Item No");
        SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Find('-')then begin
            CalcSums("Estimated Cost");
            "2ndQuarter":="Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        SetRange("Plan Item No", "Plan Item No");
        SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Find('-')then begin
            CalcSums("Estimated Cost");
            "3rdQuarter":="Estimated Cost";
        end;
        //Get 4th Quarter Budget
        SetRange("Plan Item No", "Plan Item No");
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
    local procedure CalcVATAmount()
    begin
        PurchasesPayablesSetup.Get;
        PurchasesPayablesSetup.TestField("Rounding Precision");
        if PurchasesPayablesSetup."Rounding Type" = PurchasesPayablesSetup."Rounding Type"::Up then Direction:='>'
        else if PurchasesPayablesSetup."Rounding Type" = PurchasesPayablesSetup."Rounding Type"::Nearest then Direction:='='
            else if PurchasesPayablesSetup."Rounding Type" = PurchasesPayablesSetup."Rounding Type"::Down then Direction:='<';
        if "VAT Code" <> '' then begin
            case Type of Type::"G/L Account": begin
                if GLAcc.Get("No.")then begin
                    //GLAcc.TESTFIELD("VAT Bus. Posting Group");
                    if VATSetup.Get(GLAcc."VAT Bus. Posting Group", "VAT Code")then begin
                        "VAT %":=VATSetup."VAT %";
                        if PurchasesPayablesSetup."Proc Plan Inclusive VAT" then begin
                            VATAmount:=Round((("Estimated Cost") / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":="Estimated Cost" - VATAmount;
                        end
                        else
                        begin
                            VATAmount:=Round(((("Estimated Cost") * (1 + VATSetup."VAT %" / 100)) - "Estimated Cost"), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":="Estimated Cost" + VATAmount;
                        end;
                        "VAT Amount":=VATAmount;
                        //Currency
                        if "Currency Code" = '' then begin
                            "VAT Amount (LCY)":=Round(VATAmount, CurrencyRec."Amount Rounding Precision");
                            "Amount To Post (LCY)":=Round("Amount To Post", CurrencyRec."Amount Rounding Precision");
                        end
                        else
                        begin
                            if CurrencyRec.Get("Currency Code")then begin
                                "VAT Amount (LCY)":=Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code", VATAmount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")), CurrencyRec."Amount Rounding Precision");
                                "Amount To Post (LCY)":=Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Amount To Post", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")), CurrencyRec."Amount Rounding Precision");
                            end;
                        end;
                    end;
                end;
            end;
            Type::Item: begin
                begin
                    //ItemRec.TESTFIELD("VAT Bus. Posting Gr. (Price)");
                    if VATSetup.Get(ItemRec."VAT Bus. Posting Gr. (Price)", "VAT Code")then begin
                        "VAT %":=VATSetup."VAT %";
                        if PurchasesPayablesSetup."Proc Plan Inclusive VAT" then begin
                            VATAmount:=Round((("Estimated Cost") / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":="Estimated Cost" - VATAmount;
                        end
                        else
                        begin
                            VATAmount:=Round(((("Estimated Cost") * (1 + VATSetup."VAT %" / 100)) - "Estimated Cost"), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":="Estimated Cost" + VATAmount;
                        end;
                        "VAT Amount":=VATAmount;
                        //Currency
                        if "Currency Code" = '' then begin
                            "VAT Amount (LCY)":=Round(VATAmount, CurrencyRec."Amount Rounding Precision");
                            "Amount To Post (LCY)":=Round("Amount To Post", CurrencyRec."Amount Rounding Precision");
                        end
                        else
                        begin
                            if CurrencyRec.Get("Currency Code")then begin
                                "VAT Amount (LCY)":=Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code", VATAmount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")), CurrencyRec."Amount Rounding Precision");
                                "Amount To Post (LCY)":=Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Amount To Post", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")), CurrencyRec."Amount Rounding Precision");
                            end;
                        end;
                    end;
                end;
            end;
            end;
        end;
    end;
}

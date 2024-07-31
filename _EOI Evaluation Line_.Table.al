table 50428 "EOI Evaluation Line"
{
    fields
    {
        field(1; "Quote No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";
        }
        field(2; "Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Vendor;
            TableRelation = "Prospective Suppliers";

            trigger OnValidate()
            var
                ProsSupp: Record "Prospective Suppliers";
            begin
                if ProsSupp.Get("Vendor No")then "Vendor Name":=ProsSupp.Name;
                "Supplier E-mail":=ProsSupp."E-mail";
            end;
        }
        field(3; Type;enum "Purchase Line Type")
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST("G/L Account"))"G/L Account";
        }
        field(5; Description; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Amount";
            end;
        }
        field(7; "Unit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Amount";
            //
            // CALCFIELDS("Committed Amount");
            // IF Amount>"Committed Amount" THEN
            //  ERROR('Total Amount %1 should not be greater than Committed Amount %2',Amount,"Committed Amount");
            end;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            // CALCFIELDS("Committed Amount");
            //
            // IF Amount>"Committed Amount" THEN
            //  ERROR('Total Amount should not be greater than Committed Amount');
            end;
        }
        field(9; Awarded; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Quote Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Vendor Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Title; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Quantity Received"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Procurement Plan"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(21; "Procurement Plan Item"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan"."Plan Item No" WHERE("Plan Year"=FIELD("Procurement Plan"), "Department Code"=FIELD("Shortcut Dimension 1 Code"));

            trigger OnValidate()
            begin
                if ProcurementPlan.Get("Procurement Plan", "Shortcut Dimension 1 Code", "Procurement Plan Item")then begin
                    if ProcurementPlan."Procurement Type" = ProcurementPlan."Procurement Type"::Goods then begin
                        Type:=Type::Item;
                    end;
                    if ProcurementPlan."Procurement Type" <> ProcurementPlan."Procurement Type"::Goods then begin
                        Type:=Type::"G/L Account";
                        "No.":=ProcurementPlan."Source of Funds";
                    end;
                    "Budget Line":=ProcurementPlan."Source of Funds";
                    Description:=ProcurementPlan."Item Description";
                end;
            end;
        }
        field(22; "Budget Line"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Expected Receipt Date"; Date)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header"=R;
            Caption = 'Expected Receipt Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            // CheckReservationDateConflict(FIELDNO("Expected Receipt Date"));
            //
            // IF "Expected Receipt Date" <> 0D THEN
            //  VALIDATE(
            //    "Planned Receipt Date",
            //    CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
            //      CalChange."Source Type"::Location,"Location Code",'',
            //      CalChange."Source Type"::Location,"Location Code",'',FALSE))
            // ELSE
            //  VALIDATE("Planned Receipt Date","Expected Receipt Date");
            end;
        }
        field(25; Suggested; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Committed Amount"; Decimal)
        {
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE("Commitment No"=FIELD("Requisition No"), Account=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Min Value"; Decimal)
        {
            CalcFormula = Min("EOI Evaluation Line".Amount WHERE("Quote No"=FIELD("Quote No"), Type=FIELD(Type), "No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "VAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Amount Inclusive VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "VAT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                CalcVATAmount;
            end;
        }
        field(33; "Withholding Tax Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(34; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(36; "VAT Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Amount To Post"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Amount To Post (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(40; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(41; "Supplier E-mail"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Prospective Suppliers"."E-mail" where("No."=field("Vendor No")));
        }
    }
    keys
    {
        key(Key1; "Quote No", "Vendor No", "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var DimMgt: Codeunit DimensionManagement;
    VATAmount: Decimal;
    AmountToPost: Decimal;
    GLSetup: Record "General Ledger Setup";
    Vendor: Record Vendor;
    ProcurementPlan: Record "Procurement Plan";
    PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    VATSetup: Record "VAT Posting Setup";
    GLAcc: Record "G/L Account";
    ItemRec: Record Item;
    CurrencyRec: Record Currency;
    CurrencyExchangeRate: Record "Currency Exchange Rate";
    Direction: Text[30];
    procedure CreateQuote(var QuoteEvaluation: Record "Tender Evaluation Line")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        QuoteEvaluationHeader: Record "Tender Evaluation Header";
    begin
        if QuoteEvaluation.Awarded then begin
            //Purchase Header
            PurchaseHeader.Init;
            PurchaseHeader."Document Type":=PurchaseHeader."Document Type"::Quote;
            PurchaseHeader."No.":='';
            PurchaseHeader."Buy-from Vendor No.":=QuoteEvaluation."Vendor No";
            PurchaseHeader.Validate(PurchaseHeader."Buy-from Vendor No.");
            PurchaseHeader."Quote No.":=QuoteEvaluation."Quote No";
            PurchaseHeader."Tender/Quotation ref no":=QuoteEvaluation."Quote No";
            QuoteEvaluationHeader.Get(QuoteEvaluation."Quote No");
            PurchaseHeader.Minutes:=QuoteEvaluationHeader.Minutes;
            PurchaseLine.Reset;
            PurchaseHeader.SetRange(PurchaseHeader."Quote No.", QuoteEvaluation."Quote No");
            PurchaseHeader.SetRange(PurchaseHeader."Buy-from Vendor No.", QuoteEvaluation."Vendor No");
            if not PurchaseHeader.FindFirst then PurchaseHeader.Insert(true);
            //Purchase Lines
            PurchaseLine.Reset;
            PurchaseLine.SetRange(PurchaseLine."Document Type", PurchaseLine."Document Type"::Quote);
            PurchaseLine.SetRange(PurchaseLine."Document No.", PurchaseHeader."No.");
            PurchaseLine.SetRange(PurchaseLine."Line No.", QuoteEvaluation."Line No");
            PurchaseLine.SetRange(PurchaseLine."Buy-from Vendor No.", QuoteEvaluation."Vendor No");
            if not PurchaseLine.FindFirst then begin
                PurchaseLine.Init;
                PurchaseLine."Document Type":=PurchaseLine."Document Type"::Quote;
                PurchaseLine."Document No.":=PurchaseHeader."No.";
                PurchaseLine."Buy-from Vendor No.":=QuoteEvaluation."Vendor No";
                PurchaseLine.Type:=QuoteEvaluation.Type;
                PurchaseLine."No.":=QuoteEvaluation."No.";
                PurchaseLine."Line No.":=QuoteEvaluation."Line No";
                PurchaseLine.Validate(PurchaseLine."No.");
                PurchaseLine.Description:=QuoteEvaluation.Description;
                PurchaseLine."Unit of Measure":=QuoteEvaluation."Unit of Measure";
                PurchaseLine.Quantity:=QuoteEvaluation.Quantity;
                PurchaseLine."Direct Unit Cost":=QuoteEvaluation."Unit Amount";
                PurchaseLine.Validate(PurchaseLine."Direct Unit Cost");
                if not PurchaseLine.Get(PurchaseLine."Document Type"::Quote, PurchaseHeader."No.", QuoteEvaluation."Line No")then PurchaseLine.Insert;
            end;
            CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order", PurchaseHeader);
        end;
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        RequestHeader: Record "Internal Request Header";
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
    begin
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
                            VATAmount:=Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":=Amount - VATAmount;
                        end
                        else
                        begin
                            VATAmount:=Round((((Amount) * (1 + VATSetup."VAT %" / 100)) - Amount), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":=Amount + VATAmount;
                            "Amount Inclusive VAT":=Amount + VATAmount;
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
                            VATAmount:=Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":=Amount - VATAmount;
                        end
                        else
                        begin
                            VATAmount:=Round((((Amount) * (1 + VATSetup."VAT %" / 100)) - Amount), PurchasesPayablesSetup."Rounding Precision", Direction);
                            "Amount To Post":=Amount + VATAmount;
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

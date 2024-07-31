table 50126 "Internal Request Header"
{
    Caption = 'Internal Request Header';
    DataCaptionFields = "No.", "Buy-from Vendor Name";

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Stock,Purchase,CAPEX,Return Order,RFQ';
            OptionMembers = Stock, Purchase, CAPEX, "Return Order", RFQ;
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                InitRecOnVendUpdate;
                TestField(Status, Status::Open);
                /*IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
                   (xRec."Buy-from Vendor No." <> '')
                THEN BEGIN
                  IF HideValidationDialog THEN
                    Confirmed := TRUE
                  ELSE
                    Confirmed := CONFIRM(ConfirmChangeQst,FALSE,BuyFromVendorTxt);
                  IF Confirmed THEN BEGIN
                    IF InitFromVendor("Buy-from Vendor No.",FIELDCAPTION("Buy-from Vendor No.")) THEN
                      EXIT;
                
                
                
                    PurchLine.RESET;
                  END ELSE BEGIN
                    Rec := xRec;
                    EXIT;
                  END;
                END;*/
                GetVend("Buy-from Vendor No.");
                Vend.CheckBlockedVendOnDocs(Vend, false);
                Vend.TestField("Gen. Bus. Posting Group");
                "Buy-from Vendor Name":=Vend.Name;
                "Buy-from Vendor Name 2":=Vend."Name 2";
                CopyBuyFromVendorAddressFieldsFromVendor(Vend);
                if not SkipBuyFromContact then "Buy-from Contact":=Vend.Contact;
                "Gen. Bus. Posting Group":=Vend."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group":=Vend."VAT Bus. Posting Group";
                "Tax Area Code":=Vend."Tax Area Code";
                "Tax Liable":=Vend."Tax Liable";
                "VAT Country/Region Code":=Vend."Country/Region Code";
                "VAT Registration No.":=Vend."VAT Registration No.";
                Validate("Lead Time Calculation", Vend."Lead Time Calculation");
                /*"Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
                VALIDATE("Sell-to Customer No.",'');
                VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
                
                IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN
                  IF ReceivedPurchLinesExist OR ReturnShipmentExist THEN BEGIN
                    TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
                    TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
                  END;
                  */
                "Buy-from IC Partner Code":=Vend."IC Partner Code";
                "Send IC Document":=("Buy-from IC Partner Code" <> '') and ("IC Direction" = "IC Direction"::Outgoing);
            /*
                IF Vend."Pay-to Vendor No." <> '' THEN
                  VALIDATE("Pay-to Vendor No.",Vend."Pay-to Vendor No.")
                ELSE BEGIN
                  IF "Buy-from Vendor No." = "Pay-to Vendor No." THEN
                    SkipPayToContact := TRUE;
                  VALIDATE("Pay-to Vendor No.","Buy-from Vendor No.");
                  SkipPayToContact := FALSE;
                END;*/
            /*
                "Order Address Code" := '';
                
                VALIDATE("Order Address Code");
                
                IF (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") OR
                   (xRec."Currency Code" <> "Currency Code") OR
                   (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") OR
                   (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
                THEN
                  RecreatePurchLines(BuyFromVendorTxt);
                
                IF NOT SkipBuyFromContact THEN
                  UpdateBuyFromCont("Buy-from Vendor No.");*/
            end;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series":='';
                end;
            end;
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if(xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") and (xRec."Pay-to Vendor No." <> '')then begin
                    if HideValidationDialog then Confirmed:=true
                    else
                        Confirmed:=Confirm(ConfirmChangeQst, false, PayToVendorTxt);
                    if Confirmed then begin
                        PurchLine.SetRange("Document Type", "Document Type");
                        PurchLine.SetRange("Document No.", "No.");
                        PurchLine.Reset;
                    end
                    else
                        "Pay-to Vendor No.":=xRec."Pay-to Vendor No.";
                end;
                GetVend("Pay-to Vendor No.");
                Vend.CheckBlockedVendOnDocs(Vend, false);
                Vend.TestField("Vendor Posting Group");
                "Pay-to Name":=Vend.Name;
                "Pay-to Name 2":=Vend."Name 2";
                CopyPayToVendorAddressFieldsFromVendor(Vend);
                if not SkipPayToContact then "Pay-to Contact":=Vend.Contact;
                "Payment Terms Code":=Vend."Payment Terms Code";
                "Prepmt. Payment Terms Code":=Vend."Payment Terms Code";
                if "Document Type" = "Document Type"::"Return Order" then begin
                    "Payment Method Code":='';
                    if PaymentTerms.Get("Payment Terms Code")then if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then "Payment Method Code":=Vend."Payment Method Code" end
                else
                    "Payment Method Code":=Vend."Payment Method Code";
                "Shipment Method Code":=Vend."Shipment Method Code";
                "Vendor Posting Group":=Vend."Vendor Posting Group";
                GLSetup.Get;
                if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then begin
                    "VAT Bus. Posting Group":=Vend."VAT Bus. Posting Group";
                    "VAT Country/Region Code":=Vend."Country/Region Code";
                    "VAT Registration No.":=Vend."VAT Registration No.";
                    "Gen. Bus. Posting Group":=Vend."Gen. Bus. Posting Group";
                end;
                "Prices Including VAT":=Vend."Prices Including VAT";
                "Currency Code":=Vend."Currency Code";
                "Invoice Disc. Code":=Vend."Invoice Disc. Code";
                "Language Code":=Vend."Language Code";
                "Purchaser Code":=Vend."Purchaser Code";
                Validate("Payment Terms Code");
                Validate("Prepmt. Payment Terms Code");
                Validate("Payment Method Code");
                Validate("Currency Code");
                Validate("Creditor No.", Vend."Creditor No.");
                if "Document Type" = "Document Type"::Purchase then Validate("Prepayment %", Vend."Prepayment %");
                if "Pay-to Vendor No." = xRec."Pay-to Vendor No." then begin
                    if ReceivedPurchLinesExist then TestField("Currency Code", xRec."Currency Code");
                end;
                CreateDim(DATABASE::Vendor, "Pay-to Vendor No.", DATABASE::"Salesperson/Purchaser", "Purchaser Code", DATABASE::Campaign, "Campaign No.", DATABASE::"Responsibility Center", "Responsibility Center");
                if(xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.")then RecreatePurchLines(PayToVendorTxt);
                if not SkipPayToContact then UpdatePayToCont("Pay-to Vendor No.");
                "Pay-to IC Partner Code":=Vend."IC Partner Code";
            end;
        }
        field(5; "Pay-to Name"; Text[50])
        {
            Caption = 'Pay-to Name';
            TableRelation = Vendor;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Validate("Pay-to Vendor No.", Vendor.GetVendorNo("Pay-to Name"));
            end;
        }
        field(6; "Pay-to Name 2"; Text[50])
        {
            Caption = 'Pay-to Name 2';
        }
        field(7; "Pay-to Address"; Text[50])
        {
            Caption = 'Pay-to Address';
        }
        field(8; "Pay-to Address 2"; Text[50])
        {
            Caption = 'Pay-to Address 2';
        }
        field(9; "Pay-to City"; Text[30])
        {
            Caption = 'Pay-to City';
            TableRelation = IF("Pay-to Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Pay-to Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Pay-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(10; "Pay-to Contact"; Text[50])
        {
            Caption = 'Pay-to Contact';

            trigger OnLookup()
            var
                Contact: Record Contact;
            begin
                LookupContact("Pay-to Vendor No.", "Pay-to Contact No.", Contact);
                if PAGE.RunModal(0, Contact) = ACTION::LookupOK then Validate("Pay-to Contact No.", Contact."No.");
            end;
        }
        field(11; "Collected By ID No."; Code[20])
        {
            Caption = 'To be Collected By ID No.';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No."=FIELD("Sell-to Customer No."));

            trigger OnValidate()
            var
                ShipToAddr: Record "Ship-to Address";
            begin
                if("Document Type" = "Document Type"::Purchase) and (xRec."Ship-to Code" <> "Ship-to Code")then begin
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Purchase);
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter("Sales Order Line No.", '<>0');
                    if not PurchLine.IsEmpty then Error(Text006, FieldCaption("Ship-to Code"));
                end;
                if "Ship-to Code" <> '' then begin
                    ShipToAddr.Get("Sell-to Customer No.", "Ship-to Code");
                    SetShipToAddress(ShipToAddr.Name, ShipToAddr."Name 2", ShipToAddr.Address, ShipToAddr."Address 2", ShipToAddr.City, ShipToAddr."Post Code", ShipToAddr.County, ShipToAddr."Country/Region Code");
                    "Collected By":=ShipToAddr.Contact;
                    "Shipment Method Code":=ShipToAddr."Shipment Method Code";
                    if ShipToAddr."Location Code" <> '' then Validate("Location Code", ShipToAddr."Location Code");
                end
                else
                begin
                    TestField("Sell-to Customer No.");
                    Cust.Get("Sell-to Customer No.");
                    SetShipToAddress(Cust.Name, Cust."Name 2", Cust.Address, Cust."Address 2", Cust.City, Cust."Post Code", Cust.County, Cust."Country/Region Code");
                    "Collected By":=Cust.Contact;
                    "Shipment Method Code":=Cust."Shipment Method Code";
                    if Cust."Location Code" <> '' then Validate("Location Code", Cust."Location Code");
                end;
            end;
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = IF("Ship-to Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Ship-to Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(18; "Collected By"; Code[10])
        {
            Caption = 'To be Collected By';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Collected By")then begin
                    "Collected Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
                if(Rec."Collected By" <> xRec."Collected By") and (Rec."Collected By" = '')then "Collected Name":='';
            end;
        }
        field(19; "Order Date"; Date)
        {
            //  AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Order Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if("Document Type" in["Document Type"::Stock, "Document Type"::Purchase]) and not("Order Date" = xRec."Order Date")then PriceMessageIfPurchLinesExist(FieldCaption("Order Date"));
            end;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            var
                SkipJobCurrFactorUpdate: Boolean;
            begin
            /*TestNoSeriesDate(
                  "Posting No.","Posting No. Series",
                  FIELDCAPTION("Posting No."),FIELDCAPTION("Posting No. Series"));
                TestNoSeriesDate(
                  "Prepayment No.","Prepayment No. Series",
                  FIELDCAPTION("Prepayment No."),FIELDCAPTION("Prepayment No. Series"));
                TestNoSeriesDate(
                  "Prepmt. Cr. Memo No.","Prepmt. Cr. Memo No. Series",
                  FIELDCAPTION("Prepmt. Cr. Memo No."),FIELDCAPTION("Prepmt. Cr. Memo No. Series"));
                
                IF "Incoming Document Entry No." = 0 THEN
                  VALIDATE("Document Date","Posting Date");
                
                IF ("Document Type" IN ["Document Type"::"2","Document Type"::"3"]) AND
                   NOT ("Posting Date" = xRec."Posting Date")
                THEN
                  PriceMessageIfPurchLinesExist(FIELDCAPTION("Posting Date"));
                
                IF "Currency Code" <> '' THEN BEGIN
                  UpdateCurrencyFactor;
                  IF "Currency Factor" <> xRec."Currency Factor" THEN
                    SkipJobCurrFactorUpdate := NOT ConfirmUpdateCurrencyFactor;
                END;
                
                IF "Posting Date" <> xRec."Posting Date" THEN
                  IF DeferralHeadersExist THEN
                    ConfirmUpdateDeferralDate;
                
                IF PurchLinesExist THEN
                  JobUpdatePurchLines(SkipJobCurrFactorUpdate);
                  */
            end;
        }
        field(21; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';

            trigger OnValidate()
            begin
                UpdatePurchLines(FieldCaption("Expected Receipt Date"), CurrFieldNo <> 0);
            end;
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate()
            begin
                if("Payment Terms Code" <> '') and ("Document Date" <> 0D)then begin
                    PaymentTerms.Get("Payment Terms Code");
                    if IsCreditDocType and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
                        Validate("Due Date", "Document Date");
                        Validate("Pmt. Discount Date", 0D);
                        Validate("Payment Discount %", 0);
                    end
                    else
                    begin
                        "Due Date":=CalcDate(PaymentTerms."Due Date Calculation", "Document Date");
                        "Pmt. Discount Date":=CalcDate(PaymentTerms."Discount Date Calculation", "Document Date");
                        if not UpdateDocumentDate then Validate("Payment Discount %", PaymentTerms."Discount %")end;
                end
                else
                begin
                    Validate("Due Date", "Document Date");
                    if not UpdateDocumentDate then begin
                        Validate("Pmt. Discount Date", 0D);
                        Validate("Payment Discount %", 0);
                    end;
                end;
                if xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" then Validate("Prepmt. Payment Terms Code", "Payment Terms Code");
            end;
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0: 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if not(CurrFieldNo in[0, FieldNo("Posting Date"), FieldNo("Document Date")])then TestField(Status, Status::Open);
                GLSetup.Get;
                if "Payment Discount %" < GLSetup."VAT Tolerance %" then "VAT Base Discount %":="Payment Discount %"
                else
                    "VAT Base Discount %":=GLSetup."VAT Tolerance %";
                Validate("VAT Base Discount %");
            end;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(28; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code WHERE("Use As In-Transit"=CONST(false));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if("Location Code" <> xRec."Location Code") and (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")then MessageIfPurchLinesExist(FieldCaption("Location Code"));
                UpdateShipToAddress;
                if "Location Code" = '' then begin
                    if InvtSetup.Get then "Inbound Whse. Handling Time":=InvtSetup."Inbound Whse. Handling Time";
                end
                else
                begin
                    if Location.Get("Location Code")then;
                    "Inbound Whse. Handling Time":=Location."Inbound Whse. Handling Time";
                end;
            end;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=FILTER(false));

            trigger OnValidate()
            begin
            //  ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=FILTER(false));

            trigger OnValidate()
            begin
            // ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(31; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if not(CurrFieldNo in[0, FieldNo("Posting Date")]) or ("Currency Code" <> xRec."Currency Code")then TestField(Status, Status::Open);
                if(CurrFieldNo <> FieldNo("Currency Code")) and ("Currency Code" = xRec."Currency Code")then UpdateCurrencyFactor
                else if "Currency Code" <> xRec."Currency Code" then begin
                        UpdateCurrencyFactor;
                        if PurchLinesExist then if Confirm(ChangeCurrencyQst, false, FieldCaption("Currency Code"))then begin
                                SetHideValidationDialog(true);
                                RecreatePurchLines(FieldCaption("Currency Code"));
                                SetHideValidationDialog(false);
                            end
                            else
                                Error(Text018, FieldCaption("Currency Code"));
                    end
                    else if "Currency Code" <> '' then begin
                            UpdateCurrencyFactor;
                            if "Currency Factor" <> xRec."Currency Factor" then ConfirmUpdateCurrencyFactor;
                        end;
            end;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0: 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Currency Factor" <> xRec."Currency Factor" then UpdatePurchLines(FieldCaption("Currency Factor"), CurrFieldNo <> 0);
            end;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
                Currency: Record Currency;
                RecalculatePrice: Boolean;
            begin
                TestField(Status, Status::Open);
                if "Prices Including VAT" <> xRec."Prices Including VAT" then begin
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter("Direct Unit Cost", '<>%1', 0);
                    PurchLine.SetFilter("VAT %", '<>%1', 0);
                    if PurchLine.Find('-')then begin
                        RecalculatePrice:=Confirm(StrSubstNo(Text025 + Text027, FieldCaption("Prices Including VAT"), PurchLine.FieldCaption("Direct Unit Cost")), true);
                        if RecalculatePrice and "Prices Including VAT" then PurchLine.ModifyAll(Amount, 0, true);
                        if "Currency Code" = '' then Currency.InitRoundingPrecision
                        else
                            Currency.Get("Currency Code");
                        PurchLine.FindSet;
                        repeat PurchLine.TestField("Quantity Invoiced", 0);
                            PurchLine.TestField("Prepmt. Amt. Inv.", 0);
                            if not RecalculatePrice then begin
                                PurchLine."VAT Difference":=0;
                                PurchLine.UpdateAmounts;
                            end
                            else if "Prices Including VAT" then begin
                                    PurchLine."Direct Unit Cost":=Round(PurchLine."Direct Unit Cost" * (1 + PurchLine."VAT %" / 100), Currency."Unit-Amount Rounding Precision");
                                    if PurchLine.Quantity <> 0 then begin
                                        PurchLine."Line Discount Amount":=Round(PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100, Currency."Amount Rounding Precision");
                                        PurchLine.Validate("Inv. Discount Amount", Round(PurchLine."Inv. Discount Amount" * (1 + PurchLine."VAT %" / 100), Currency."Amount Rounding Precision"));
                                    end;
                                end
                                else
                                begin
                                    PurchLine."Direct Unit Cost":=Round(PurchLine."Direct Unit Cost" / (1 + PurchLine."VAT %" / 100), Currency."Unit-Amount Rounding Precision");
                                    if PurchLine.Quantity <> 0 then begin
                                        PurchLine."Line Discount Amount":=Round(PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100, Currency."Amount Rounding Precision");
                                        PurchLine.Validate("Inv. Discount Amount", Round(PurchLine."Inv. Discount Amount" / (1 + PurchLine."VAT %" / 100), Currency."Amount Rounding Precision"));
                                    end;
                                end;
                            PurchLine.Modify;
                        until PurchLine.Next = 0;
                    end;
                end;
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                MessageIfPurchLinesExist(FieldCaption("Invoice Disc. Code"));
            end;
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;

            trigger OnValidate()
            begin
                MessageIfPurchLinesExist(FieldCaption("Language Code"));
            end;
        }
        field(43; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
                ApprovalEntry.SetRange("Table ID", DATABASE::"Purchase Header");
                ApprovalEntry.SetRange("Document Type", "Document Type");
                ApprovalEntry.SetRange("Document No.", "No.");
                ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
                if not ApprovalEntry.IsEmpty then Error(Text042, FieldCaption("Purchaser Code"));
                CreateDim(DATABASE::"Salesperson/Purchaser", "Purchaser Code", DATABASE::Vendor, "Pay-to Vendor No.", DATABASE::Campaign, "Campaign No.", DATABASE::"Responsibility Center", "Responsibility Center");
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Purch. Comment Line" WHERE("Document Type"=FIELD("Document Type"), "No."=FIELD("No."), "Document Line No."=CONST(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = 'Internal,Contract,Job';
            OptionMembers = Internal, Contract, Job;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            TableRelation = IF("Applies-to Doc. Type"=CONST(Contract))"Service Contract Header"."Contract No."
            ELSE IF("Applies-to Doc. Type"=CONST(Job))Job."No.";
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF("Bal. Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Bal. Account Type"=CONST("Bank Account"))"Bank Account";

            trigger OnValidate()
            begin
                if "Bal. Account No." <> '' then case "Bal. Account Type" of "Bal. Account Type"::"G/L Account": begin
                        GLAcc.Get("Bal. Account No.");
                        GLAcc.CheckGLAcc;
                        GLAcc.TestField("Direct Posting", true);
                    end;
                    "Bal. Account Type"::"Bank Account": begin
                        BankAcc.Get("Bal. Account No.");
                        BankAcc.TestField(Blocked, false);
                        BankAcc.TestField("Currency Code", "Currency Code");
                    end;
                    end;
            end;
        }
        field(56; "Recalculate Invoice Disc."; Boolean)
        {
            CalcFormula = Exist("Purchase Line" WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No."), "Recalculate Invoice Disc."=CONST(true)));
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Partially Posted"; Boolean)
        {
            Caption = 'Partially Posted';
        }
        field(58; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(59; "Combine Order"; Boolean)
        {
            Caption = 'Combine Order';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Internal Request Line".Amount WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Internal Request Line"."Amount Including VAT" WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(66; "Internal Document No"; Code[35])
        {
            Caption = 'Internal Document No';
        }
        field(67; "Vendor Shipment No."; Code[35])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(68; "Vendor Invoice No."; Code[35])
        {
            Caption = 'Vendor Invoice No.';
        }
        field(69; "Vendor Cr. Memo No."; Code[35])
        {
            Caption = 'Vendor Cr. Memo No.';
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(72; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if("Document Type" = "Document Type"::Purchase) and (xRec."Sell-to Customer No." <> "Sell-to Customer No.")then begin
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Purchase);
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter("Sales Order Line No.", '<>0');
                    if not PurchLine.IsEmpty then Error(Text006, FieldCaption("Sell-to Customer No."));
                    PurchLine.SetRange("Sales Order Line No.");
                    PurchLine.SetFilter("Service Item Line No.", '<>0');
                    if not PurchLine.IsEmpty then Error(Text006, FieldCaption("Sell-to Customer No."));
                end;
                if "Sell-to Customer No." = '' then Validate("Location Code", UserSetupMgt.GetLocation(1, '', "Responsibility Center"))
                else
                    Validate("Ship-to Code", '');
            end;
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';

            trigger OnValidate()
            begin
                if Reason.Get("Reason Code")then "Reason Description":=Reason.Description;
            end;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if(xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group")then begin
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group")then "VAT Bus. Posting Group":=GenBusPostingGrp."Def. VAT Bus. Posting Group";
                    RecreatePurchLines(FieldCaption("Gen. Bus. Posting Group"));
                end;
            end;
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";

            trigger OnValidate()
            begin
                UpdatePurchLines(FieldCaption("Transaction Type"), CurrFieldNo <> 0);
            end;
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";

            trigger OnValidate()
            begin
                UpdatePurchLines(FieldCaption("Transport Method"), CurrFieldNo <> 0);
            end;
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(79; "Buy-from Vendor Name"; Text[50])
        {
            Caption = 'Buy-from Vendor Name';
            TableRelation = Vendor;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Validate("Buy-from Vendor No.", Vendor.GetVendorNo("Buy-from Vendor Name"));
            end;
        }
        field(80; "Buy-from Vendor Name 2"; Text[50])
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        field(81; "Buy-from Address"; Text[50])
        {
            Caption = 'Buy-from Address';

            trigger OnValidate()
            begin
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Address"));
            end;
        }
        field(82; "Buy-from Address 2"; Text[50])
        {
            Caption = 'Buy-from Address 2';

            trigger OnValidate()
            begin
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Address 2"));
            end;
        }
        field(83; "Buy-from City"; Text[30])
        {
            Caption = 'Buy-from City';
            TableRelation = IF("Buy-from Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Buy-from Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Buy-from Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to City"));
            end;
        }
        field(84; "Buy-from Contact"; Text[50])
        {
            Caption = 'Buy-from Contact';

            trigger OnLookup()
            var
                Contact: Record Contact;
            begin
                LookupContact("Buy-from Vendor No.", "Buy-from Contact No.", Contact);
                if PAGE.RunModal(0, Contact) = ACTION::LookupOK then Validate("Buy-from Contact No.", Contact."No.");
            end;
        }
        field(85; "Pay-to Post Code"; Code[20])
        {
            Caption = 'Pay-to Post Code';
            TableRelation = IF("Pay-to Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Pay-to Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Pay-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(86; "Pay-to County"; Text[30])
        {
            Caption = 'Pay-to County';
        }
        field(87; "Pay-to Country/Region Code"; Code[10])
        {
            Caption = 'Pay-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(88; "Buy-from Post Code"; Code[20])
        {
            Caption = 'Buy-from Post Code';
            TableRelation = IF("Buy-from Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Buy-from Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Buy-from Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Post Code"));
            end;
        }
        field(89; "Buy-from County"; Text[30])
        {
            Caption = 'Buy-from County';

            trigger OnValidate()
            begin
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to County"));
            end;
        }
        field(90; "Buy-from Country/Region Code"; Code[10])
        {
            Caption = 'Buy-from Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Country/Region Code"));
            end;
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = IF("Ship-to Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Ship-to Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type";enum "Payment Balance Account Type")
        {
            Caption = 'Bal. Account Type';
        }
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code WHERE("Vendor No."=FIELD("Buy-from Vendor No."));

            trigger OnValidate()
            begin
                if "Order Address Code" <> '' then begin
                    OrderAddr.Get("Buy-from Vendor No.", "Order Address Code");
                    "Buy-from Vendor Name":=OrderAddr.Name;
                    "Buy-from Vendor Name 2":=OrderAddr."Name 2";
                    "Buy-from Address":=OrderAddr.Address;
                    "Buy-from Address 2":=OrderAddr."Address 2";
                    "Buy-from City":=OrderAddr.City;
                    "Buy-from Contact":=OrderAddr.Contact;
                    "Buy-from Post Code":=OrderAddr."Post Code";
                    "Buy-from County":=OrderAddr.County;
                    "Buy-from Country/Region Code":=OrderAddr."Country/Region Code";
                    if IsCreditDocType then begin
                        SetShipToAddress(OrderAddr.Name, OrderAddr."Name 2", OrderAddr.Address, OrderAddr."Address 2", OrderAddr.City, OrderAddr."Post Code", OrderAddr.County, OrderAddr."Country/Region Code");
                        "Collected By":=OrderAddr.Contact;
                    end end
                else
                begin
                    GetVend("Buy-from Vendor No.");
                    "Buy-from Vendor Name":=Vend.Name;
                    "Buy-from Vendor Name 2":=Vend."Name 2";
                    CopyPayToVendorAddressFieldsFromVendor(Vend);
                    if IsCreditDocType then begin
                        "Ship-to Name":=Vend.Name;
                        "Ship-to Name 2":=Vend."Name 2";
                        CopyShipToVendorAddressFieldsFromVendor(Vend);
                        "Collected By":=Vend.Contact;
                        "Shipment Method Code":=Vend."Shipment Method Code";
                        if Vend."Location Code" <> '' then Validate("Location Code", Vend."Location Code");
                    end end;
            end;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";

            trigger OnValidate()
            begin
                UpdatePurchLines(FieldCaption("Entry Point"), CurrFieldNo <> 0);
            end;
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';

            trigger OnValidate()
            begin
                if xRec."Document Date" <> "Document Date" then UpdateDocumentDate:=true;
                Validate("Payment Terms Code");
                Validate("Prepmt. Payment Terms Code");
            end;
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;

            trigger OnValidate()
            begin
                UpdatePurchLines(FieldCaption(Area), CurrFieldNo <> 0);
            end;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";

            trigger OnValidate()
            begin
                UpdatePurchLines(FieldCaption("Transaction Specification"), CurrFieldNo <> 0);
            end;
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            begin
                PaymentMethod.Init;
                if "Payment Method Code" <> '' then PaymentMethod.Get("Payment Method Code");
                "Bal. Account Type":=PaymentMethod."Bal. Account Type";
                "Bal. Account No.":=PaymentMethod."Bal. Account No.";
                if "Bal. Account No." <> '' then begin
                    TestField("Applies-to Doc. No.", '');
                    TestField("Applies-to ID", '');
                end;
            end;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                PurchHeader:=Rec;
                PurchSetup.Get;
                TestNoSeries;
                if NoSeriesMgt.LookupSeries(GetPostingNoSeriesCode, PurchHeader."Posting No. Series")then PurchHeader.Validate("Posting No. Series");
                Rec:=PurchHeader;
            end;
            trigger OnValidate()
            begin
                if "Posting No. Series" <> '' then begin
                    PurchSetup.Get;
                    TestNoSeries;
                    NoSeriesMgt.TestSeries(GetPostingNoSeriesCode, "Posting No. Series");
                end;
                TestField("Posting No.", '');
            end;
        }
        field(109; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                PurchHeader:=Rec;
                PurchSetup.Get;
                PurchSetup.TestField("Posted Receipt Nos.");
                if NoSeriesMgt.LookupSeries(PurchSetup."Posted Receipt Nos.", PurchHeader."Receiving No. Series")then PurchHeader.Validate("Receiving No. Series");
                Rec:=PurchHeader;
            end;
            trigger OnValidate()
            begin
                if "Receiving No. Series" <> '' then begin
                    PurchSetup.Get;
                    PurchSetup.TestField("Posted Receipt Nos.");
                    NoSeriesMgt.TestSeries(PurchSetup."Posted Receipt Nos.", "Receiving No. Series");
                end;
                TestField("Receiving No.", '');
            end;
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                MessageIfPurchLinesExist(FieldCaption("Tax Area Code"));
            end;
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                MessageIfPurchLinesExist(FieldCaption("Tax Liable"));
            end;
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if(xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")then RecreatePurchLines(FieldCaption("VAT Bus. Posting Group"));
            end;
        }
        field(118; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry" temporary;
                VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
            begin
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0: 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                GLSetup.Get;
                if "VAT Base Discount %" > GLSetup."VAT Tolerance %" then begin
                    if HideValidationDialog then Confirmed:=true
                    else
                        Confirmed:=Confirm(Text007 + Text008, false, FieldCaption("VAT Base Discount %"), GLSetup.FieldCaption("VAT Tolerance %"), GLSetup.TableCaption);
                    if not Confirmed then "VAT Base Discount %":=xRec."VAT Base Discount %";
                end;
                if("VAT Base Discount %" = xRec."VAT Base Discount %") and (CurrFieldNo <> 0)then exit;
                PurchLine.SetRange("Document Type", "Document Type");
                PurchLine.SetRange("Document No.", "No.");
                PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");
                PurchLine.SetFilter(Quantity, '<>0');
                PurchLine.LockTable;
                if PurchLine.FindSet then begin
                    Modify;
                    repeat PurchLine.UpdateAmounts;
                        PurchLine.Modify;
                    until PurchLine.Next = 0;
                end;
                PurchLine.Reset;
            end;
        }
        field(120; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Canceled,Disapproved,Committed,Fulfilled,Reversed,Archived';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Canceled, Disapproved, Committed, Fulfilled, Reversed, Archived;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None", "%", Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';

            trigger OnValidate()
            begin
                if "Send IC Document" then begin
                    TestField("Buy-from IC Partner Code");
                    TestField("IC Direction", "IC Direction"::Outgoing);
                end;
            end;
        }
        field(124; "IC Status"; Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New, Pending, Sent;
        }
        field(125; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(129; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing, Incoming;

            trigger OnValidate()
            begin
                if "IC Direction" = "IC Direction"::Incoming then "Send IC Document":=false;
            end;
        }
        field(130; "Prepayment No."; Code[20])
        {
            Caption = 'Prepayment No.';
        }
        field(131; "Last Prepayment No."; Code[20])
        {
            Caption = 'Last Prepayment No.';
            TableRelation = "Purch. Inv. Header";
        }
        field(132; "Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No.';
        }
        field(133; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Purch. Cr. Memo Hdr.";
        }
        field(134; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0: 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Prepayment %" <> "Prepayment %" then UpdatePurchLines(FieldCaption("Prepayment %"), CurrFieldNo <> 0);
            end;
        }
        field(135; "Prepayment No. Series"; Code[10])
        {
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                PurchHeader:=Rec;
                PurchSetup.Get;
                PurchSetup.TestField("Posted Prepmt. Inv. Nos.");
                if NoSeriesMgt.LookupSeries(GetPostingPrepaymentNoSeriesCode, PurchHeader."Prepayment No. Series")then PurchHeader.Validate("Prepayment No. Series");
                Rec:=PurchHeader;
            end;
            trigger OnValidate()
            begin
                if "Prepayment No. Series" <> '' then begin
                    PurchSetup.Get;
                    PurchSetup.TestField("Posted Prepmt. Inv. Nos.");
                    NoSeriesMgt.TestSeries(GetPostingPrepaymentNoSeriesCode, "Prepayment No. Series");
                end;
                TestField("Prepayment No.", '');
            end;
        }
        field(136; "Compress Prepayment"; Boolean)
        {
            Caption = 'Compress Prepayment';
            InitValue = true;
        }
        field(137; "Date Posted"; Date)
        {
            Caption = 'Prepayment Due Date';
        }
        field(138; "Prepmt. Cr. Memo No. Series"; Code[10])
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                PurchHeader:=Rec;
                PurchSetup.Get;
                PurchSetup.TestField("Posted Prepmt. Cr. Memo Nos.");
                if NoSeriesMgt.LookupSeries(GetPostingPrepaymentNoSeriesCode, PurchHeader."Prepmt. Cr. Memo No. Series")then PurchHeader.Validate("Prepmt. Cr. Memo No. Series");
                Rec:=PurchHeader;
            end;
            trigger OnValidate()
            begin
                if "Prepmt. Cr. Memo No. Series" <> '' then begin
                    PurchSetup.Get;
                    PurchSetup.TestField("Posted Prepmt. Cr. Memo Nos.");
                    NoSeriesMgt.TestSeries(GetPostingPrepaymentNoSeriesCode, "Prepmt. Cr. Memo No. Series");
                end;
                TestField("Prepmt. Cr. Memo No.", '');
            end;
        }
        field(139; "Reason Description"; Text[70])
        {
            Caption = 'Reason Description';
        }
        field(142; "Prepmt. Pmt. Discount Date"; Date)
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        field(143; "Prepmt. Payment Terms Code"; Code[10])
        {
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate()
            var
                PaymentTerms: Record "Payment Terms";
            begin
                if("Prepmt. Payment Terms Code" <> '') and ("Document Date" <> 0D)then begin
                    PaymentTerms.Get("Prepmt. Payment Terms Code");
                    if IsCreditDocType and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
                        Validate("Date Posted", "Document Date");
                        Validate("Prepmt. Pmt. Discount Date", 0D);
                        Validate("Prepmt. Payment Discount %", 0);
                    end
                    else
                    begin
                        "Date Posted":=CalcDate(PaymentTerms."Due Date Calculation", "Document Date");
                        "Prepmt. Pmt. Discount Date":=CalcDate(PaymentTerms."Discount Date Calculation", "Document Date");
                        if not UpdateDocumentDate then Validate("Prepmt. Payment Discount %", PaymentTerms."Discount %")end;
                end
                else
                begin
                    Validate("Date Posted", "Document Date");
                    if not UpdateDocumentDate then begin
                        Validate("Prepmt. Pmt. Discount Date", 0D);
                        Validate("Prepmt. Payment Discount %", 0);
                    end;
                end;
            end;
        }
        field(144; "Prepmt. Payment Discount %"; Decimal)
        {
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0: 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if not(CurrFieldNo in[0, FieldNo("Posting Date"), FieldNo("Document Date")])then TestField(Status, Status::Open);
                GLSetup.Get;
                if "Payment Discount %" < GLSetup."VAT Tolerance %" then "VAT Base Discount %":="Payment Discount %"
                else
                    "VAT Base Discount %":=GLSetup."VAT Tolerance %";
                Validate("VAT Base Discount %");
            end;
        }
        field(151; "Original Request No."; Code[20])
        {
            Caption = 'Original Request No.';
            Editable = false;
        }
        field(160; "Job Queue Status"; Option)
        {
            Caption = 'Job Queue Status';
            Editable = false;
            OptionCaption = ' ,Scheduled for Posting,Error,Posting';
            OptionMembers = " ", "Scheduled for Posting", Error, Posting;

            trigger OnLookup()
            var
                JobQueueEntry: Record "Job Queue Entry";
            begin
                if "Job Queue Status" = "Job Queue Status"::" " then exit;
                JobQueueEntry.ShowStatusMsg("Job Queue Entry ID");
            end;
        }
        field(161; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
            Editable = false;
        }
        field(165; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            TableRelation = "Incoming Document";

            trigger OnValidate()
            var
                IncomingDocument: Record "Incoming Document";
            begin
            end;
        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
            Numeric = true;
        }
        field(171; "Posted By"; Code[50])
        {
            Caption = 'Payment Reference';
            Numeric = true;

            trigger OnValidate()
            begin
                if "Posted By" <> '' then TestField("Creditor No.");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
        field(1305; "Invoice Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Inv. Discount Amount" WHERE("Document No."=FIELD("No."), "Document Type"=FIELD("Document Type")));
            Caption = 'Invoice Discount Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = Max("Purchase Header Archive"."Version No." WHERE("Document Type"=FIELD("Document Type"), "No."=FIELD("No."), "Doc. No. Occurrence"=FIELD("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;

            trigger OnValidate()
            begin
                CreateDim(DATABASE::Campaign, "Campaign No.", DATABASE::Vendor, "Pay-to Vendor No.", DATABASE::"Salesperson/Purchaser", "Purchaser Code", DATABASE::"Responsibility Center", "Responsibility Center");
            end;
        }
        field(5052; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                if "Buy-from Vendor No." <> '' then if Cont.Get("Buy-from Contact No.")then Cont.SetRange("Company No.", Cont."Company No.")
                    else
                    begin
                        ContBusinessRelation.Reset;
                        ContBusinessRelation.SetCurrentKey("Link to Table", "No.");
                        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                        ContBusinessRelation.SetRange("No.", "Buy-from Vendor No.");
                        if ContBusinessRelation.FindFirst then Cont.SetRange("Company No.", ContBusinessRelation."Contact No.")
                        else
                            Cont.SetRange("No.", '');
                    end;
                if "Buy-from Contact No." <> '' then if Cont.Get("Buy-from Contact No.")then;
                if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
                    xRec:=Rec;
                    Validate("Buy-from Contact No.", Cont."No.");
                end;
            end;
            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
                TestField(Status, Status::Open);
                if("Buy-from Contact No." <> xRec."Buy-from Contact No.") and (xRec."Buy-from Contact No." <> '')then begin
                    if HideValidationDialog then Confirmed:=true
                    else
                        Confirmed:=Confirm(ConfirmChangeQst, false, FieldCaption("Buy-from Contact No."));
                    if Confirmed then begin
                        if InitFromContact("Buy-from Contact No.", "Buy-from Vendor No.", FieldCaption("Buy-from Contact No."))then exit end
                    else
                    begin
                        Rec:=xRec;
                        exit;
                    end;
                end;
                if("Buy-from Vendor No." <> '') and ("Buy-from Contact No." <> '')then begin
                    Cont.Get("Buy-from Contact No.");
                    ContBusinessRelation.Reset;
                    ContBusinessRelation.SetCurrentKey("Link to Table", "No.");
                    ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                    ContBusinessRelation.SetRange("No.", "Buy-from Vendor No.");
                    if ContBusinessRelation.FindFirst then if ContBusinessRelation."Contact No." <> Cont."Company No." then Error(Text038, Cont."No.", Cont.Name, "Buy-from Vendor No.");
                end;
                UpdateBuyFromVend("Buy-from Contact No.");
            end;
        }
        field(5053; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                if "Pay-to Vendor No." <> '' then if Cont.Get("Pay-to Contact No.")then Cont.SetRange("Company No.", Cont."Company No.")
                    else
                    begin
                        ContBusinessRelation.Reset;
                        ContBusinessRelation.SetCurrentKey("Link to Table", "No.");
                        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                        ContBusinessRelation.SetRange("No.", "Pay-to Vendor No.");
                        if ContBusinessRelation.FindFirst then Cont.SetRange("Company No.", ContBusinessRelation."Contact No.")
                        else
                            Cont.SetRange("No.", '');
                    end;
                if "Pay-to Contact No." <> '' then if Cont.Get("Pay-to Contact No.")then;
                if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
                    xRec:=Rec;
                    Validate("Pay-to Contact No.", Cont."No.");
                end;
            end;
            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
                TestField(Status, Status::Open);
                if("Pay-to Contact No." <> xRec."Pay-to Contact No.") and (xRec."Pay-to Contact No." <> '')then begin
                    if HideValidationDialog then Confirmed:=true
                    else
                        Confirmed:=Confirm(ConfirmChangeQst, false, FieldCaption("Pay-to Contact No."));
                    if Confirmed then begin
                        if InitFromContact("Pay-to Contact No.", "Pay-to Vendor No.", FieldCaption("Pay-to Contact No."))then exit end
                    else
                    begin
                        "Pay-to Contact No.":=xRec."Pay-to Contact No.";
                        exit;
                    end;
                end;
                if("Pay-to Vendor No." <> '') and ("Pay-to Contact No." <> '')then begin
                    Cont.Get("Pay-to Contact No.");
                    ContBusinessRelation.Reset;
                    ContBusinessRelation.SetCurrentKey("Link to Table", "No.");
                    ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                    ContBusinessRelation.SetRange("No.", "Pay-to Vendor No.");
                    if ContBusinessRelation.FindFirst then if ContBusinessRelation."Contact No." <> Cont."Company No." then Error(Text038, Cont."No.", Cont.Name, "Pay-to Vendor No.");
                end;
                UpdatePayToVend("Pay-to Contact No.");
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if not UserSetupMgt.CheckRespCenter(1, "Responsibility Center")then Error(Text028, RespCenter.TableCaption, UserSetupMgt.GetPurchasesFilter);
                "Location Code":=UserSetupMgt.GetLocation(1, '', "Responsibility Center");
                if "Location Code" = '' then begin
                    if InvtSetup.Get then "Inbound Whse. Handling Time":=InvtSetup."Inbound Whse. Handling Time";
                end
                else
                begin
                    if Location.Get("Location Code")then;
                    "Inbound Whse. Handling Time":=Location."Inbound Whse. Handling Time";
                end;
                UpdateShipToAddress;
                CreateDim(DATABASE::"Responsibility Center", "Responsibility Center", DATABASE::Vendor, "Pay-to Vendor No.", DATABASE::"Salesperson/Purchaser", "Purchaser Code", DATABASE::Campaign, "Campaign No.");
                if xRec."Responsibility Center" <> "Responsibility Center" then begin
                    RecreatePurchLines(FieldCaption("Responsibility Center"));
                    "Requested By":='';
                end;
            end;
        }
        field(5752; "Completely Received"; Boolean)
        {
            CalcFormula = Min("Purchase Line"."Completely Received" WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No."), Type=FILTER(<>" "), "Location Code"=FIELD("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            AccessByPermission = TableData Location=R;
            Caption = 'Posting from Whse. Ref.';
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line"=R;
            Caption = 'Requested Receipt Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Promised Receipt Date" <> 0D then Error(Text034, FieldCaption("Requested Receipt Date"), FieldCaption("Promised Receipt Date"));
                if "Requested Receipt Date" <> xRec."Requested Receipt Date" then UpdatePurchLines(FieldCaption("Requested Receipt Date"), CurrFieldNo <> 0);
            end;
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Promised Receipt Date" <> xRec."Promised Receipt Date" then UpdatePurchLines(FieldCaption("Promised Receipt Date"), CurrFieldNo <> 0);
            end;
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header"=R;
            Caption = 'Lead Time Calculation';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Lead Time Calculation" <> xRec."Lead Time Calculation" then UpdatePurchLines(FieldCaption("Lead Time Calculation"), CurrFieldNo <> 0);
            end;
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location=R;
            Caption = 'Inbound Whse. Handling Time';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" then UpdatePurchLines(FieldCaption("Inbound Whse. Handling Time"), CurrFieldNo <> 0);
            end;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; "Vendor Authorization No."; Code[35])
        {
            Caption = 'Vendor Authorization No.';
        }
        field(5801; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(5802; "Return Shipment No. Series"; Code[10])
        {
            Caption = 'Return Shipment No. Series';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                PurchHeader:=Rec;
                PurchSetup.Get;
                PurchSetup.TestField("Posted Return Shpt. Nos.");
                if NoSeriesMgt.LookupSeries(PurchSetup."Posted Return Shpt. Nos.", PurchHeader."Return Shipment No. Series")then PurchHeader.Validate("Return Shipment No. Series");
                Rec:=PurchHeader;
            end;
            trigger OnValidate()
            begin
                if "Return Shipment No. Series" <> '' then begin
                    PurchSetup.Get;
                    PurchSetup.TestField("Posted Return Shpt. Nos.");
                    NoSeriesMgt.TestSeries(PurchSetup."Posted Return Shpt. Nos.", "Return Shipment No. Series");
                end;
                TestField("Return Shipment No.", '');
            end;
        }
        field(5803; Ship; Boolean)
        {
            Caption = 'Ship';
        }
        field(5804; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(9000; "Requested By"; Code[50])
        {
            Caption = 'Requested By';
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                if not UserSetupMgt.CheckRespCenter(1, "Responsibility Center", "Requested By")then Error(Text049, "Requested By", RespCenter.TableCaption, UserSetupMgt.GetPurchasesFilter("Requested By"));
            end;
        }
        field(9001; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(38), "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(9002; "Time Posted"; Time)
        {
        }
        field(54001; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3), "Dimension Value Type"=CONST(Standard), Blocked=CONST(false));
        }
        field(54002; "Multi-Donor"; Boolean)
        {
        }
        field(54003; "Committed Amount"; Decimal)
        {
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE("Commitment No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(54004; "Original Committed Amount"; Decimal)
        {
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE("Commitment No"=FIELD("No."), "Commitment Type"=CONST(Commitment)));
            FieldClass = FlowField;
        }
        field(54005; "Fully Ordered"; Boolean)
        {
        }
        field(54008; Uncommitted; Boolean)
        {
        }
        field(54009; Selected; Boolean)
        {
        }
        field(54010; "Procurement Plan"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan";
        }
        field(54011; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(54012; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.")then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Employee.TestField("Global Dimension 1 Code");
                    //Employee.TestField("Global Dimension 2 Code");
                    "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                // "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                // Validate("Shortcut Dimension 2 Code");
                end
                else
                    Error('Employee can not be found in HR Employees');
            end;
        }
        field(54013; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(54014; "LPO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Consumables,Cost of Sales,Fixed Asset';
            OptionMembers = Consumables, "Cost of Sales", "Fixed Asset";
        }
        field(54015; "SRN Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Consumables,Cost of Sales,Fixed Asset,Common Use Items';
            OptionMembers = Consumables, "Cost of Sales", "Fixed Asset", "Common Use Items";
        }
        field(54016; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54017; "Collected Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54018; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Internal Request Line"."Line Amount" WHERE("Document No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(54019; "Rejection Comment"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(54020; "Cleared For RFQ"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54021; "PRF on GPR"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54022; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54023; "GPR Created For All Lines"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54024; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54025; "Reversed By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(54026; "Requisition Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Ammend;
        }
        field(54027; "Ammend Requisition No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Internal Request Header" where("Document Type"=const(Purchase));
        }
        field(54028; Activity; Option)
        {
            OptionMembers = " ", Support, Export, Dairystds, Partnership;
            OptionCaption = ' ,Stakeholder support activities, Export and Import, Dairy Standards,Partnership';
            DataClassification = ToBeClassified;
        }
        field(54029; "Activity No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if(Activity=const(Support))"Research Activity Plan".Code where("Research type"=const(Support))
            else if(Activity=const(Export))"Research Activity Plan".Code where("Research type"=const(Export))
            else if(Activity=const(Dairystds))"Research Activity Plan".Code where("Research type"=const(Dairystds))
            else if(Activity=const(Partnership))"Partnerships Activity Plan".Code;

            trigger OnValidate()
            var
                Research: Record "Research Activity Plan";
                Partnership: Record "Partnerships Activity Plan";
            begin
                if Activity = Activity::Partnership then begin
                    Partnership.SetRange(Code, "Activity No.");
                    if Partnership.FindFirst()then "Activity Description":=Partnership."Name of partnership";
                end;
                if Activity <> Activity::Partnership then begin
                    Research.SetRange(Code, "Activity No.");
                    if Research.FindFirst()then "Activity Description":=Research."Description of activity";
                end;
            end;
        }
        field(54030; "Supplier category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";

            trigger Onvalidate()
            var
                SupplierCat: Record "Supplier Category";
            begin
                if SupplierCat.get("Supplier category")then "Supplier category Description":=SupplierCat.Description;
            end;
        }
        field(54031; "Supplier Subcategory"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Sub Category2".Code where("Category Code"=field("Supplier category"));

            trigger Onvalidate()
            var
                SupplierSubCat: Record "Supplier Sub Category2";
            begin
                SupplierSubCat.SetRange(Code, "Supplier Subcategory");
                if SupplierSubCat.FindFirst()then "Supplier Subcategory Desc":=SupplierSubCat.Description;
            end;
        }
        field(54032; "Supplier category Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";
        }
        field(54033; "Supplier Subcategory Desc"; Text[200])
        {
            Caption = 'Supplier Subcategory Description';
            DataClassification = ToBeClassified;
        }
        field(54034; "Activity Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54035; "Type of Supplier"; Code[50])
        {
            TableRelation = "Supplier Type";
            DataClassification = ToBeClassified;
        }
        field(54036; Locality; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "", Local, Foreign;
            OptionCaption = ' ,Local,Foreign';
        }
        field(54037; "Activity Programme"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Activity Work Programme";

            trigger OnValidate()
            var
                InternalReqLines: Record "Internal Request Line";
                WPItems: Record "Activity Work Programme Lines";
                WPHeader: Record "Activity Work Programme";
            begin
                WPItems.reset;
                WPItems.SetRange("No.", "Activity Programme");
                WPItems.SetRange(Type, WPItems.Type::Items);
                WPItems.SetRange("Purchase Type", WPItems."Purchase Type"::"Procurement Process");
                if WPItems.FindSet()then repeat InternalReqLines.init;
                        InternalReqLines.Type:=InternalReqLines.Type::Item;
                        InternalReqLines.init;
                        InternalReqLines."Document No.":="No.";
                        InternalReqLines."No.":=WPItems."Item No.";
                        InternalReqLines.Quantity:=WPItems.Quantity;
                        InternalReqLines."Unit Cost":=WPItems."Unit Cost";
                        InternalReqLines.insert;
                        InternalReqLines.Validate("Unit Cost");
                        InternalReqLines.Validate("No.");
                        InternalReqLines.Modify();
                    until WPItems.Next() = 0;
            end;
        }
        field(54038; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Imprest, Procurement;
            OptionCaption = ' ,Imprest,Procurement';
        }
        field(54039; "Activity Workplan No."; Code[50])
        {
        }
        field(54040; "Apply On Behalf Of Committee"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Committees: Record "Procurement Committee";
                CommitteesMembers: Record "Committee Members";
            begin
                CommitteesMembers.Reset();
                CommitteesMembers.SetRange("Employee No", "Employee No.");
                If CommitteesMembers.Find()then begin
                    Committees.Reset();
                    Committees.SetRange(Code, CommitteesMembers."Ref No");
                    If Committees.FindFirst()then Committee:=Committees.Description;
                end
                else
                    Error('The Employee No. %1 is not in any Committee', "Employee No.");
                ;
            end;
        }
        field(54041; "Committee"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54042; "Insert Other Items"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Insert Other Items';
        }
        field(54043; "Tender No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34; Completed; boolean)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = max("Internal Request Line".completed where("Document No."=field("No."), Completed=const(false)));
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type")
        {
        }
        key(Key3; "Document Type", "Buy-from Vendor No.")
        {
        }
        key(Key4; "Document Type", "Pay-to Vendor No.")
        {
        }
        key(Key5; "Buy-from Vendor No.")
        {
        }
        key(Key6; "Incoming Document Entry No.")
        {
        }
        key(Key7; "Document Date")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Order Date", "Reason Description", Amount)
        {
        }
    }
    trigger OnDelete()
    var
        PostPurchDelete: Codeunit "PostPurch-Delete";
    begin
        if not UserSetupMgt.CheckRespCenter(1, "Responsibility Center")then Error(Text023, RespCenter.TableCaption, UserSetupMgt.GetPurchasesFilter);
        //ApprovalsMgmt.DeleteApprovalEntry(Rec);
        PurchLine.LockTable;
        WhseRequest.SetRange("Source Type", DATABASE::"Purchase Line");
        WhseRequest.SetRange("Source Subtype", "Document Type");
        WhseRequest.SetRange("Source No.", "No.");
        WhseRequest.DeleteAll(true);
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetRange(Type, PurchLine.Type::"Charge (Item)");
        DeletePurchaseLines;
        PurchLine.SetRange(Type);
        DeletePurchaseLines;
        PurchCommentLine.SetRange("Document Type", "Document Type");
        PurchCommentLine.SetRange("No.", "No.");
        PurchCommentLine.DeleteAll;
        if(PurchRcptHeader."No." <> '') or (PurchInvHeader."No." <> '') or (PurchCrMemoHeader."No." <> '') or (ReturnShptHeader."No." <> '') or (PurchInvHeaderPrepmt."No." <> '') or (PurchCrMemoHeaderPrepmt."No." <> '')then Message(PostedDocsToPrintCreatedMsg);
    end;
    trigger OnInsert()
    begin
        if not SkipInitialization then InitInsert;
        if GetFilter("Buy-from Vendor No.") <> '' then if GetRangeMin("Buy-from Vendor No.") = GetRangeMax("Buy-from Vendor No.")then Validate("Buy-from Vendor No.", GetRangeMin("Buy-from Vendor No."));
        "Doc. No. Occurrence":=ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Purchase Header", "Document Type", "No.");
        "Requested By":=UserId;
        PurchSetup.Get;
        CheckOpenDocs("Document Type", PurchSetup."Max Open Documents");
        if "User Setup".Get("Requested By")then begin
            // "User Setup".TestField("Customer No.");
            "Customer No.":="User Setup"."Customer No.";
        // Validate("Customer No.");
        /// "User Setup".TestField("Employee No.");
         // "Employee No." := "User Setup"."Employee No.";
        // GetEmpDetails("Employee No.");
        end;
    end;
    trigger OnModify()
    begin
        UpdateVendorAddress;
    end;
    trigger OnRename()
    begin
    //ERROR(Text003,TABLECAPTION);
    end;
    var Text003: Label 'You cannot rename a %1.';
    ConfirmChangeQst: Label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';
    Text005: Label 'You cannot reset %1 because the document still has one or more lines.';
    Text006: Label 'You cannot change %1 because the order is associated with one or more sales orders.';
    Text007: Label '%1 is greater than %2 in the %3 table.\';
    Text008: Label 'Confirm change?';
    Text009: Label 'Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
    Text012: Label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
    Text014: Label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
    Text016: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\';
    Text018: Label 'You must delete the existing purchase lines before you can change %1.';
    Text019: Label 'You have changed %1 on the Internal Request Header, but it has not been changed on the existing purchase lines.\';
    Text020: Label 'You must update the existing Request lines manually.';
    Text021: Label 'The change may affect the exchange rate used on the price calculation of the purchase lines.';
    Text022: Label 'Do you want to update the exchange rate?';
    Text023: Label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
    Text025: Label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
    Text027: Label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
    Text028: Label 'Your identification is set up to process from %1 %2 only.';
    Text029: Label 'Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
    Text032: Label 'You have modified %1.\\';
    Text033: Label 'Do you want to update the lines?';
    PurchSetup: Record "Purchases & Payables Setup";
    GLSetup: Record "General Ledger Setup";
    GLAcc: Record "G/L Account";
    PurchLine: Record "Internal Request Line";
    xPurchLine: Record "Internal Request Line";
    VendLedgEntry: Record "Vendor Ledger Entry";
    Vend: Record Vendor;
    PaymentTerms: Record "Payment Terms";
    PaymentMethod: Record "Payment Method";
    CurrExchRate: Record "Currency Exchange Rate";
    PurchHeader: Record "Internal Request Header";
    PurchCommentLine: Record "Purch. Comment Line";
    Cust: Record Customer;
    CompanyInfo: Record "Company Information";
    PostCode: Record "Post Code";
    OrderAddr: Record "Order Address";
    BankAcc: Record "Bank Account";
    PurchRcptHeader: Record "Purch. Rcpt. Header";
    PurchInvHeader: Record "Purch. Inv. Header";
    PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
    ReturnShptHeader: Record "Return Shipment Header";
    PurchInvHeaderPrepmt: Record "Purch. Inv. Header";
    PurchCrMemoHeaderPrepmt: Record "Purch. Cr. Memo Hdr.";
    GenBusPostingGrp: Record "Gen. Business Posting Group";
    RespCenter: Record "Responsibility Center";
    Location: Record Location;
    WhseRequest: Record "Warehouse Request";
    InvtSetup: Record "Inventory Setup";
    Reason: Record "Reason Code";
    Employee: Record Employee;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    UserSetupMgt: Codeunit "User Setup Management";
    ArchiveManagement: Codeunit ArchiveManagement;
    CurrencyDate: Date;
    HideValidationDialog: Boolean;
    Confirmed: Boolean;
    Text034: Label 'You cannot change the %1 when the %2 has been filled in.';
    Text037: Label 'Contact %1 %2 is not related to vendor %3.';
    Text038: Label 'Contact %1 %2 is related to a different company than vendor %3.';
    Text039: Label 'Contact %1 %2 is not related to a vendor.';
    SkipBuyFromContact: Boolean;
    SkipPayToContact: Boolean;
    Text040: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
    Text042: Label 'You must cancel the approval process if you wish to change the %1.';
    Text045: Label 'Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
    Text046: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
    Text049: Label '%1 is set up to process from %2 %3 only.';
    Text050: Label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?';
    Text051: Label 'You may have changed a dimension.\\Do you want to update the lines?';
    Text052: Label 'The %1 field on the purchase order %2 must be the same as on sales order %3.';
    NameAddressDetails: Text[512];
    DropShptNameAddressDetails: Text[512];
    SpecOrderNameAddressDetails: Text[512];
    UpdateDocumentDate: Boolean;
    Text053: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
    Text054: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
    DeferralLineQst: Label 'You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?', Comment = '%1=The posting date on the document.';
    ChangeCurrencyQst: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created. You may need to update the price information manually.\\Do you want to change %1?';
    PostedDocsToPrintCreatedMsg: Label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
    BuyFromVendorTxt: Label 'Buy-from Vendor';
    PayToVendorTxt: Label 'Pay-to Vendor';
    DocumentNotPostedClosePageQst: Label 'The document has not been posted.\Are you sure you want to exit?';
    DocTxt: Label 'Purchase Order';
    Dim: Record "Dimension Value";
    "User Setup": Record "User Setup";
    local procedure InitInsert()
    begin
        if "No." = '' then begin
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
        InitRecord;
    end;
    local procedure SkipInitialization(): Boolean begin
        if "No." = '' then exit(false);
        if "Buy-from Vendor No." = '' then exit(false);
        if xRec."Document Type" <> "Document Type" then exit(false);
        if GetFilter("Buy-from Vendor No.") <> '' then if GetRangeMin("Buy-from Vendor No.") = GetRangeMax("Buy-from Vendor No.")then if "Buy-from Vendor No." = GetRangeMin("Buy-from Vendor No.")then exit(false);
        exit(true);
    end;
    procedure InitRecord()
    begin
        PurchSetup.Get;
        case "Document Type" of "Document Type"::Stock, "Document Type"::Purchase: begin
            NoSeriesMgt.SetDefaultSeries("Posting No. Series", PurchSetup."Posted Invoice Nos.");
            NoSeriesMgt.SetDefaultSeries("Receiving No. Series", PurchSetup."Posted Receipt Nos.");
            if "Document Type" = "Document Type"::Purchase then begin
                NoSeriesMgt.SetDefaultSeries("Prepayment No. Series", PurchSetup."Posted Prepmt. Inv. Nos.");
                NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series", PurchSetup."Posted Prepmt. Cr. Memo Nos.");
                //insert user and procurement plan
                //InsertUserAccount(USERID);
                //PurchSetup.TestField("Effective Procurement Plan");
                "Procurement Plan":=PurchSetup."Effective Procurement Plan";
            end;
        end;
        "Document Type"::CAPEX: begin
            if("No. Series" <> '') and (PurchSetup."Invoice Nos." = PurchSetup."Posted Invoice Nos.")then "Posting No. Series":="No. Series"
            else
                NoSeriesMgt.SetDefaultSeries("Posting No. Series", PurchSetup."Posted Invoice Nos.");
            if PurchSetup."Receipt on Invoice" then NoSeriesMgt.SetDefaultSeries("Receiving No. Series", PurchSetup."Posted Receipt Nos.");
        end;
        /*             "Document Type"::"Return Order":
                            begin
                                NoSeriesMgt.SetDefaultSeries("Posting No. Series", PurchSetup."Posted Credit Memo Nos.");
                                NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series", PurchSetup."Posted Return Shpt. Nos.");
                            end; */
        "Document Type"::"Return Order": begin
            if("No. Series" <> '') and (PurchSetup."Credit Memo Nos." = PurchSetup."Posted Credit Memo Nos.")then "Posting No. Series":="No. Series"
            else
                NoSeriesMgt.SetDefaultSeries("Posting No. Series", PurchSetup."Posted Credit Memo Nos.");
            if PurchSetup."Return Shipment on Credit Memo" then NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series", PurchSetup."Posted Return Shpt. Nos.");
        end;
        end;
        // if "Document Type" in ["Document Type"::Purchase, "Document Type"::CAPEX] then
        //     "Order Date" := WorkDate;
        if "Document Type" = "Document Type"::CAPEX then "Expected Receipt Date":=WorkDate;
        if not("Document Type" in["Document Type"::RFQ, "Document Type"::Stock]) and ("Posting Date" = 0D)then "Posting Date":=WorkDate;
        if PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" then "Posting Date":=0D;
        "Document Date":=WorkDate;
        validate("Document Date");
        Validate("Sell-to Customer No.", '');
        if IsCreditDocType then begin
            GLSetup.Get;
            Correction:=GLSetup."Mark Cr. Memos as Corrections";
        end;
        "Posting Description":=Format("Document Type") + ' ' + "No.";
        if InvtSetup.Get then "Inbound Whse. Handling Time":=InvtSetup."Inbound Whse. Handling Time";
        "Responsibility Center":=UserSetupMgt.GetRespCenter(1, "Responsibility Center");
        Validate("Requested By", UserId);
    end;
    local procedure InitNoSeries()
    begin
        if xRec."Receiving No." <> '' then begin
            "Receiving No. Series":=xRec."Receiving No. Series";
            "Receiving No.":=xRec."Receiving No.";
        end;
        if xRec."Posting No." <> '' then begin
            "Posting No. Series":=xRec."Posting No. Series";
            "Posting No.":=xRec."Posting No.";
        end;
        if xRec."Return Shipment No." <> '' then begin
            "Return Shipment No. Series":=xRec."Return Shipment No. Series";
            "Return Shipment No.":=xRec."Return Shipment No.";
        end;
        if xRec."Prepayment No." <> '' then begin
            "Prepayment No. Series":=xRec."Prepayment No. Series";
            "Prepayment No.":=xRec."Prepayment No.";
        end;
        if xRec."Prepmt. Cr. Memo No." <> '' then begin
            "Prepmt. Cr. Memo No. Series":=xRec."Prepmt. Cr. Memo No. Series";
            "Prepmt. Cr. Memo No.":=xRec."Prepmt. Cr. Memo No.";
        end;
    end;
    procedure AssistEdit(OldPurchHeader: Record "Purchase Header"): Boolean begin
        PurchSetup.Get;
        TestNoSeries;
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldPurchHeader."No. Series", "No. Series")then begin
            PurchSetup.Get;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
    local procedure TestNoSeries()
    begin
        PurchSetup.Get;
        case "Document Type" of "Document Type"::Stock: PurchSetup.TestField("Store Req. Nos.");
        "Document Type"::Purchase: PurchSetup.TestField("Purchase Req. Nos");
        "Document Type"::CAPEX: PurchSetup.TestField("Purchase Req. Nos");
        "Document Type"::"Return Order": PurchSetup.TestField("Store Return Order Nos.");
        "Document Type"::RFQ: PurchSetup.TestField("RFQ Nos.");
        end;
    end;
    local procedure GetNoSeriesCode(): Code[10]begin
        case "Document Type" of "Document Type"::Stock: exit(PurchSetup."Store Req. Nos.");
        "Document Type"::Purchase: exit(PurchSetup."Purchase Req. Nos");
        "Document Type"::CAPEX: exit(PurchSetup."Purchase Req. Nos");
        "Document Type"::"Return Order": exit(PurchSetup."Store Return Order Nos.");
        "Document Type"::RFQ: exit(PurchSetup."RFQ Nos.");
        end;
    end;
    local procedure GetPostingNoSeriesCode(): Code[10]begin
        if IsCreditDocType then exit(PurchSetup."Posted Credit Memo Nos.");
        exit(PurchSetup."Posted Invoice Nos.");
    end;
    local procedure GetPostingPrepaymentNoSeriesCode(): Code[10]begin
        if IsCreditDocType then exit(PurchSetup."Posted Prepmt. Cr. Memo Nos.");
        exit(PurchSetup."Posted Prepmt. Inv. Nos.");
    end;
    local procedure TestNoSeriesDate(No: Code[20]; NoSeriesCode: Code[10]; NoCapt: Text[1024]; NoSeriesCapt: Text[1024])
    var
        NoSeries: Record "No. Series";
    begin
        if(No <> '') and (NoSeriesCode <> '')then begin
            NoSeries.Get(NoSeriesCode);
            if NoSeries."Date Order" then Error(Text040, FieldCaption("Posting Date"), NoSeriesCapt, NoSeriesCode, NoSeries.FieldCaption("Date Order"), NoSeries."Date Order", "Document Type", NoCapt, No);
        end;
    end;
    procedure ConfirmDeletion(): Boolean begin
        if PurchRcptHeader."No." <> '' then if not Confirm(Text009, true, PurchRcptHeader."No.")then exit;
        if PurchInvHeader."No." <> '' then if not Confirm(Text012, true, PurchInvHeader."No.")then exit;
        if PurchCrMemoHeader."No." <> '' then if not Confirm(Text014, true, PurchCrMemoHeader."No.")then exit;
        if ReturnShptHeader."No." <> '' then if not Confirm(Text029, true, ReturnShptHeader."No.")then exit;
        if "Prepayment No." <> '' then if not Confirm(Text045, true, PurchInvHeaderPrepmt."No.")then exit;
        if "Prepmt. Cr. Memo No." <> '' then if not Confirm(Text046, true, PurchCrMemoHeaderPrepmt."No.")then exit;
        exit(true);
    end;
    local procedure GetVend(VendNo: Code[20])
    begin
        if VendNo <> Vend."No." then Vend.Get(VendNo);
    end;
    procedure PurchLinesExist(): Boolean begin
        PurchLine.Reset;
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        exit(PurchLine.FindFirst);
    end;
    local procedure RecreatePurchLines(ChangedFieldName: Text[100])
    var
        TempPurchLine: Record "Internal Request Line" temporary;
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TempInteger: Record "Integer" temporary;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ExtendedTextAdded: Boolean;
    begin
        if PurchLinesExist then begin
            if HideValidationDialog then Confirmed:=true
            else
                Confirmed:=Confirm(Text016 + ConfirmChangeQst, false, ChangedFieldName);
            if Confirmed then begin
                PurchLine.LockTable;
                ItemChargeAssgntPurch.LockTable;
                Modify;
                PurchLine.Reset;
                PurchLine.SetRange("Document Type", "Document Type");
                PurchLine.SetRange("Document No.", "No.");
                if PurchLine.FindSet then begin
                    repeat PurchLine.TestField("Quantity Received", 0);
                        PurchLine.TestField("Quantity Issued", 0);
                        PurchLine.TestField("Return Qty. Shipped", 0);
                        PurchLine.CalcFields("Reserved Qty. (Base)");
                        PurchLine.TestField("Reserved Qty. (Base)", 0);
                        PurchLine.TestField("Receipt No.", '');
                        PurchLine.TestField("Return Shipment No.", '');
                        PurchLine.TestField("Blanket Order No.", '');
                        if PurchLine."Drop Shipment" or PurchLine."Special Order" then begin
                            case true of PurchLine."Drop Shipment": SalesHeader.Get(SalesHeader."Document Type"::Order, PurchLine."Sales Order No.");
                            PurchLine."Special Order": SalesHeader.Get(SalesHeader."Document Type"::Order, PurchLine."Contract No.");
                            end;
                            TestField("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                            TestField("Ship-to Code", SalesHeader."Ship-to Code");
                        end;
                        PurchLine.TestField("Prepmt. Amt. Inv.", 0);
                        TempPurchLine:=PurchLine;
                        if PurchLine.Nonstock then begin
                            PurchLine.Nonstock:=false;
                            PurchLine.Modify;
                        end;
                        TempPurchLine.Insert;
                    until PurchLine.Next = 0;
                    ItemChargeAssgntPurch.SetRange("Document Type", "Document Type");
                    ItemChargeAssgntPurch.SetRange("Document No.", "No.");
                    if ItemChargeAssgntPurch.FindSet then begin
                        repeat TempItemChargeAssgntPurch.Init;
                            TempItemChargeAssgntPurch:=ItemChargeAssgntPurch;
                            TempItemChargeAssgntPurch.Insert;
                        until ItemChargeAssgntPurch.Next = 0;
                        ItemChargeAssgntPurch.DeleteAll;
                    end;
                    PurchLine.DeleteAll(true);
                    PurchLine.Init;
                    PurchLine."Line No.":=0;
                    TempPurchLine.FindSet;
                    ExtendedTextAdded:=false;
                    repeat if TempPurchLine."Attached to Line No." = 0 then begin
                            PurchLine.Init;
                            PurchLine."Line No.":=PurchLine."Line No." + 10000;
                            PurchLine.Validate(Type, TempPurchLine.Type);
                            if TempPurchLine."No." = '' then begin
                                PurchLine.Validate(Description, TempPurchLine.Description);
                                PurchLine.Validate("Description 2", TempPurchLine."Description 2");
                            end
                            else
                            begin
                                PurchLine.Validate("No.", TempPurchLine."No.");
                                if PurchLine.Type <> PurchLine.Type::" " then case true of TempPurchLine."Drop Shipment": begin
                                        SalesLine.Get(SalesLine."Document Type"::Order, TempPurchLine."Sales Order No.", TempPurchLine."Sales Order Line No.");
                                        PurchLine."Drop Shipment":=TempPurchLine."Drop Shipment";
                                        PurchLine."Purchasing Code":=SalesLine."Purchasing Code";
                                        PurchLine."Sales Order No.":=TempPurchLine."Sales Order No.";
                                        PurchLine."Sales Order Line No.":=TempPurchLine."Sales Order Line No.";
                                        Evaluate(PurchLine."Inbound Whse. Handling Time", '<0D>');
                                        PurchLine.Validate("Inbound Whse. Handling Time");
                                        SalesLine.Validate("Unit Cost (LCY)", PurchLine."Unit Cost (LCY)");
                                        SalesLine."Purchase Order No.":=PurchLine."Document No.";
                                        SalesLine."Purch. Order Line No.":=PurchLine."Line No.";
                                        SalesLine.Modify;
                                    end;
                                    TempPurchLine."Special Order": begin
                                        SalesLine.Get(SalesLine."Document Type"::Order, TempPurchLine."Contract No.", TempPurchLine."Service Item Line No.");
                                        PurchLine."Special Order":=TempPurchLine."Special Order";
                                        PurchLine."Purchasing Code":=SalesLine."Purchasing Code";
                                        PurchLine."Contract No.":=TempPurchLine."Contract No.";
                                        PurchLine."Service Item Line No.":=TempPurchLine."Service Item Line No.";
                                        SalesLine.Validate("Unit Cost (LCY)", PurchLine."Unit Cost (LCY)");
                                        SalesLine."Special Order Purchase No.":=PurchLine."Document No.";
                                        SalesLine."Special Order Purch. Line No.":=PurchLine."Line No.";
                                        SalesLine.Modify;
                                    end;
                                    else
                                    begin
                                        PurchLine.Validate("Unit of Measure Code", TempPurchLine."Unit of Measure Code");
                                        PurchLine.Validate("Variant Code", TempPurchLine."Variant Code");
                                        PurchLine."Prod. Order No.":=TempPurchLine."Prod. Order No.";
                                        if PurchLine."Prod. Order No." <> '' then begin
                                            PurchLine.Description:=TempPurchLine.Description;
                                            PurchLine.Validate("VAT Prod. Posting Group", TempPurchLine."VAT Prod. Posting Group");
                                            PurchLine.Validate("Gen. Prod. Posting Group", TempPurchLine."Gen. Prod. Posting Group");
                                            PurchLine.Validate("Expected Receipt Date", TempPurchLine."Expected Receipt Date");
                                            PurchLine.Validate("Requested Receipt Date", TempPurchLine."Requested Receipt Date");
                                            PurchLine.Validate("Qty. per Unit of Measure", TempPurchLine."Qty. per Unit of Measure");
                                        end;
                                        if(TempPurchLine."Job No." <> '') and (TempPurchLine."Job Task No." <> '')then begin
                                            PurchLine.Validate("Job No.", TempPurchLine."Job No.");
                                            PurchLine.Validate("Job Task No.", TempPurchLine."Job Task No.");
                                            PurchLine."Job Line Type":=TempPurchLine."Job Line Type";
                                        end;
                                        if TempPurchLine.Quantity <> 0 then PurchLine.Validate(Quantity, TempPurchLine.Quantity);
                                        if("Currency Code" = xRec."Currency Code") and (PurchLine."Direct Unit Cost" = 0)then PurchLine.Validate("Direct Unit Cost", TempPurchLine."Direct Unit Cost");
                                        PurchLine."Routing No.":=TempPurchLine."Routing No.";
                                        PurchLine."Routing Reference No.":=TempPurchLine."Routing Reference No.";
                                        PurchLine."Operation No.":=TempPurchLine."Operation No.";
                                        PurchLine."Work Center No.":=TempPurchLine."Work Center No.";
                                        PurchLine."Prod. Order Line No.":=TempPurchLine."Prod. Order Line No.";
                                        PurchLine."Overhead Rate":=TempPurchLine."Overhead Rate";
                                    end;
                                    end;
                            end;
                            PurchLine.Insert;
                            ExtendedTextAdded:=false;
                            if PurchLine.Type = PurchLine.Type::Item then begin
                                ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                                TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Type", TempPurchLine."Document Type");
                                TempItemChargeAssgntPurch.SetRange("Applies-to Doc. No.", TempPurchLine."Document No.");
                                TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Line No.", TempPurchLine."Line No.");
                                if TempItemChargeAssgntPurch.FindSet then repeat if not TempItemChargeAssgntPurch.Mark then begin
                                            TempItemChargeAssgntPurch."Applies-to Doc. Line No.":=PurchLine."Line No.";
                                            TempItemChargeAssgntPurch.Description:=PurchLine.Description;
                                            TempItemChargeAssgntPurch.Modify;
                                            TempItemChargeAssgntPurch.Mark(true);
                                        end;
                                    until TempItemChargeAssgntPurch.Next = 0;
                            end;
                            if PurchLine.Type = PurchLine.Type::"Charge (Item)" then begin
                                TempInteger.Init;
                                TempInteger.Number:=PurchLine."Line No.";
                                TempInteger.Insert;
                            end;
                        end
                        else if not ExtendedTextAdded then begin
                                PurchLine.FindLast;
                                ExtendedTextAdded:=true;
                            end;
                    until TempPurchLine.Next = 0;
                    ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                    TempPurchLine.SetRange(Type, PurchLine.Type::"Charge (Item)");
                    if TempPurchLine.FindSet then repeat TempItemChargeAssgntPurch.SetRange("Document Line No.", TempPurchLine."Line No.");
                            if TempItemChargeAssgntPurch.FindSet then begin
                                repeat TempInteger.FindFirst;
                                    ItemChargeAssgntPurch.Init;
                                    ItemChargeAssgntPurch:=TempItemChargeAssgntPurch;
                                    ItemChargeAssgntPurch."Document Line No.":=TempInteger.Number;
                                    ItemChargeAssgntPurch.Validate("Unit Cost", 0);
                                    ItemChargeAssgntPurch.Insert;
                                until TempItemChargeAssgntPurch.Next = 0;
                                TempInteger.Delete;
                            end;
                        until TempPurchLine.Next = 0;
                    TempPurchLine.SetRange(Type);
                    TempPurchLine.DeleteAll;
                    ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                    TempItemChargeAssgntPurch.DeleteAll;
                end;
            end
            else
                Error(Text018, ChangedFieldName);
        end;
    end;
    local procedure MessageIfPurchLinesExist(ChangedFieldName: Text[100])
    begin
        if PurchLinesExist and not HideValidationDialog then Message(Text019 + Text020, ChangedFieldName);
    end;
    local procedure PriceMessageIfPurchLinesExist(ChangedFieldName: Text[100])
    begin
        if PurchLinesExist and not HideValidationDialog then Message(Text019 + Text021, ChangedFieldName);
    end;
    local procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
            if "Posting Date" <> 0D then CurrencyDate:="Posting Date"
            else
                CurrencyDate:=WorkDate;
            "Currency Factor":=CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end
        else
            "Currency Factor":=0;
    end;
    local procedure ConfirmUpdateCurrencyFactor(): Boolean begin
        if HideValidationDialog then Confirmed:=true
        else
            Confirmed:=Confirm(Text022, false);
        if Confirmed then Validate("Currency Factor")
        else
            "Currency Factor":=xRec."Currency Factor";
        exit(Confirmed);
    end;
    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog:=NewHideValidationDialog;
    end;
    local procedure UpdatePurchLines(ChangedFieldName: Text[100]; AskQuestion: Boolean)
    var
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        Question: Text[250];
    begin
        if not PurchLinesExist then exit;
        if AskQuestion then begin
            Question:=StrSubstNo(Text032 + Text033, ChangedFieldName);
            if GuiAllowed then if DIALOG.Confirm(Question, true)then case ChangedFieldName of FieldCaption("Expected Receipt Date"), FieldCaption("Requested Receipt Date"), FieldCaption("Promised Receipt Date"), FieldCaption("Lead Time Calculation"), FieldCaption("Inbound Whse. Handling Time"): ConfirmResvDateConflict;
                    end
                else
                    exit;
        end;
        PurchLine.LockTable;
        Modify;
        PurchLine.Reset;
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        if PurchLine.FindSet then repeat xPurchLine:=PurchLine;
                case ChangedFieldName of FieldCaption("Expected Receipt Date"): if PurchLine."No." <> '' then PurchLine.Validate("Expected Receipt Date", "Expected Receipt Date");
                FieldCaption("Currency Factor"): if PurchLine.Type <> PurchLine.Type::" " then PurchLine.Validate("Direct Unit Cost");
                FieldCaption("Transaction Type"): PurchLine.Validate("Transaction Type", "Transaction Type");
                FieldCaption("Transport Method"): PurchLine.Validate("Transport Method", "Transport Method");
                FieldCaption("Entry Point"): PurchLine.Validate("Entry Point", "Entry Point");
                FieldCaption(Area): PurchLine.Validate(Area, Area);
                FieldCaption("Transaction Specification"): PurchLine.Validate("Transaction Specification", "Transaction Specification");
                FieldCaption("Requested Receipt Date"): if PurchLine."No." <> '' then PurchLine.Validate("Requested Receipt Date", "Requested Receipt Date");
                FieldCaption("Prepayment %"): if PurchLine."No." <> '' then PurchLine.Validate("Prepayment %", "Prepayment %");
                FieldCaption("Promised Receipt Date"): if PurchLine."No." <> '' then PurchLine.Validate("Promised Receipt Date", "Promised Receipt Date");
                FieldCaption("Lead Time Calculation"): if PurchLine."No." <> '' then PurchLine.Validate("Lead Time Calculation", "Lead Time Calculation");
                FieldCaption("Inbound Whse. Handling Time"): if PurchLine."No." <> '' then PurchLine.Validate("Inbound Whse. Handling Time", "Inbound Whse. Handling Time");
                PurchLine.FieldCaption("Deferral Code"): if PurchLine."No." <> '' then PurchLine.Validate("Deferral Code");
                end;
                PurchLine.Modify(true);
            until PurchLine.Next = 0;
    end;
    local procedure ConfirmResvDateConflict()
    var
        ResvEngMgt: Codeunit "Reservation Engine Mgt.";
    begin
    end;
    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10]of Integer;
        No: array[10]of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.Get;
        TableID[1]:=Type1;
        No[1]:=No1;
        TableID[2]:=Type2;
        No[2]:=No2;
        TableID[3]:=Type3;
        No[3]:=No3;
        TableID[4]:=Type4;
        No[4]:=No4;
        "Shortcut Dimension 1 Code":='';
        "Shortcut Dimension 2 Code":='';
        OldDimSetID:="Dimension Set ID";
    // "Dimension Set ID" :=
    //   DimMgt.GetDefaultDimID(TableID, No, SourceCodeSetup.Purchases, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
    // if (OldDimSetID <> "Dimension Set ID") and PurchLinesExist then begin
    //     Modify;
    //     UpdateAllLineDim("Dimension Set ID", OldDimSetID);
    // end;
    end;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then Modify;
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if PurchLinesExist then UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;
    local procedure ReceivedPurchLinesExist(): Boolean begin
        PurchLine.Reset;
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetFilter("Quantity Received", '<>0');
        exit(PurchLine.FindFirst);
    end;
    local procedure ReturnShipmentExist(): Boolean begin
        PurchLine.Reset;
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetFilter("Return Qty. Shipped", '<>0');
        exit(PurchLine.FindFirst);
    end;
    local procedure UpdateShipToAddress()
    begin
        if IsCreditDocType then exit;
        if("Location Code" <> '') and Location.Get("Location Code") and ("Sell-to Customer No." = '')then begin
            SetShipToAddress(Location.Name, Location."Name 2", Location.Address, Location."Address 2", Location.City, Location."Post Code", Location.County, Location."Country/Region Code");
            "Collected By":=Location.Contact;
        end;
        if("Location Code" = '') and ("Sell-to Customer No." = '')then begin
            CompanyInfo.Get;
            "Ship-to Code":='';
            SetShipToAddress(CompanyInfo."Ship-to Name", CompanyInfo."Ship-to Name 2", CompanyInfo."Ship-to Address", CompanyInfo."Ship-to Address 2", CompanyInfo."Ship-to City", CompanyInfo."Ship-to Post Code", CompanyInfo."Ship-to County", CompanyInfo."Ship-to Country/Region Code");
            "Collected By":=CompanyInfo."Ship-to Contact";
        end;
    end;
    local procedure DeletePurchaseLines()
    var
        ReservMgt: Codeunit "Reservation Management";
    begin
        if PurchLine.FindSet then begin
            ReservMgt.DeleteDocumentReservation(DATABASE::"Purchase Line", "Document Type", "No.", HideValidationDialog);
            repeat PurchLine.SuspendStatusCheck(true);
                PurchLine.Delete(true);
            until PurchLine.Next = 0;
        end;
    end;
    local procedure ClearItemAssgntPurchFilter(var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary)
    begin
        TempItemChargeAssgntPurch.SetRange("Document Line No.");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Type");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. No.");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Line No.");
    end;
    local procedure CheckReceiptInfo(var PurchLine: Record "Purchase Line"; PayTo: Boolean)
    begin
        if "Document Type" = "Document Type"::Purchase then PurchLine.SetFilter("Quantity Received", '<>0')
        else if "Document Type" = "Document Type"::CAPEX then begin
                if not PayTo then PurchLine.SetRange("Buy-from Vendor No.", xRec."Buy-from Vendor No.");
                PurchLine.SetFilter("Receipt No.", '<>%1', '');
            end;
        if PurchLine.FindFirst then if "Document Type" = "Document Type"::Purchase then PurchLine.TestField("Quantity Received", 0)
            else
                PurchLine.TestField("Receipt No.", '');
        PurchLine.SetRange("Receipt No.");
        PurchLine.SetRange("Quantity Received");
        if not PayTo then PurchLine.SetRange("Buy-from Vendor No.");
    end;
    local procedure CheckPrepmtInfo(var PurchLine: Record "Purchase Line")
    begin
        if "Document Type" = "Document Type"::Purchase then begin
            PurchLine.SetFilter("Prepmt. Amt. Inv.", '<>0');
            if PurchLine.Find('-')then PurchLine.TestField("Prepmt. Amt. Inv.", 0);
            PurchLine.SetRange("Prepmt. Amt. Inv.");
        end;
    end;
    local procedure CheckReturnInfo(var PurchLine: Record "Purchase Line"; PayTo: Boolean)
    begin
        /* if "Document Type" = "Document Type"::"5" then
            PurchLine.SetFilter("Return Qty. Shipped", '<>0')
        else */
        if "Document Type" = "Document Type"::"Return Order" then begin
            if not PayTo then PurchLine.SetRange("Buy-from Vendor No.", xRec."Buy-from Vendor No.");
            PurchLine.SetFilter("Return Shipment No.", '<>%1', '');
        end;
        if PurchLine.FindFirst then PurchLine.TestField("Return Shipment No.", '');
    end;
    local procedure UpdateBuyFromCont(VendorNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Vend: Record Vendor;
        OfficeContact: Record Contact;
        OfficeMgt: Codeunit "Office Management";
    begin
        if OfficeMgt.GetContact(OfficeContact, VendorNo)then begin
            SetHideValidationDialog(true);
            UpdateBuyFromVend(OfficeContact."No.");
            SetHideValidationDialog(false);
        end
        else if Vend.Get(VendorNo)then begin
                if Vend."Primary Contact No." <> '' then "Buy-from Contact No.":=Vend."Primary Contact No."
                else
                begin
                    ContBusRel.Reset;
                    ContBusRel.SetCurrentKey("Link to Table", "No.");
                    ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Vendor);
                    ContBusRel.SetRange("No.", "Buy-from Vendor No.");
                    if ContBusRel.FindFirst then "Buy-from Contact No.":=ContBusRel."Contact No."
                    else
                        "Buy-from Contact No.":='';
                end;
                "Buy-from Contact":=Vend.Contact;
            end;
    end;
    local procedure UpdatePayToCont(VendorNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Vend: Record Vendor;
    begin
        if Vend.Get(VendorNo)then begin
            if Vend."Primary Contact No." <> '' then "Pay-to Contact No.":=Vend."Primary Contact No."
            else
            begin
                ContBusRel.Reset;
                ContBusRel.SetCurrentKey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Vendor);
                ContBusRel.SetRange("No.", "Pay-to Vendor No.");
                if ContBusRel.FindFirst then "Pay-to Contact No.":=ContBusRel."Contact No."
                else
                    "Pay-to Contact No.":='';
            end;
            "Pay-to Contact":=Vend.Contact;
        end;
    end;
    local procedure UpdateBuyFromVend(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Vend: Record Vendor;
        Cont: Record Contact;
    begin
        if Cont.Get(ContactNo)then begin
            "Buy-from Contact No.":=Cont."No.";
            if Cont.Type = Cont.Type::Person then "Buy-from Contact":=Cont.Name
            else if Vend.Get("Buy-from Vendor No.")then "Buy-from Contact":=Vend.Contact
                else
                    "Buy-from Contact":='' end
        else
        begin
            "Buy-from Contact":='';
            exit;
        end;
        ContBusinessRelation.Reset;
        ContBusinessRelation.SetCurrentKey("Link to Table", "Contact No.");
        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
        ContBusinessRelation.SetRange("Contact No.", Cont."Company No.");
        if ContBusinessRelation.FindFirst then begin
            if("Buy-from Vendor No." <> '') and ("Buy-from Vendor No." <> ContBusinessRelation."No.")then Error(Text037, Cont."No.", Cont.Name, "Buy-from Vendor No.");
            if "Buy-from Vendor No." = '' then begin
                SkipBuyFromContact:=true;
                Validate("Buy-from Vendor No.", ContBusinessRelation."No.");
                SkipBuyFromContact:=false;
            end;
        end
        else
            Error(Text039, Cont."No.", Cont.Name);
        if("Buy-from Vendor No." = "Pay-to Vendor No.") or ("Pay-to Vendor No." = '')then Validate("Pay-to Contact No.", "Buy-from Contact No.");
    end;
    local procedure UpdatePayToVend(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Vend: Record Vendor;
        Cont: Record Contact;
    begin
        if Cont.Get(ContactNo)then begin
            "Pay-to Contact No.":=Cont."No.";
            if Cont.Type = Cont.Type::Person then "Pay-to Contact":=Cont.Name
            else if Vend.Get("Pay-to Vendor No.")then "Pay-to Contact":=Vend.Contact
                else
                    "Pay-to Contact":='';
        end
        else
        begin
            "Pay-to Contact":='';
            exit;
        end;
        ContBusinessRelation.Reset;
        ContBusinessRelation.SetCurrentKey("Link to Table", "Contact No.");
        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
        ContBusinessRelation.SetRange("Contact No.", Cont."Company No.");
        if ContBusinessRelation.FindFirst then begin
            if "Pay-to Vendor No." = '' then begin
                SkipPayToContact:=true;
                Validate("Pay-to Vendor No.", ContBusinessRelation."No.");
                SkipPayToContact:=false;
            end
            else if "Pay-to Vendor No." <> ContBusinessRelation."No." then Error(Text037, Cont."No.", Cont.Name, "Pay-to Vendor No.");
        end
        else
            Error(Text039, Cont."No.", Cont.Name);
    end;
    procedure CreateInvtPutAwayPick()
    var
        WhseRequest: Record "Warehouse Request";
    begin
        TestField(Status, Status::Released);
        WhseRequest.Reset;
        WhseRequest.SetCurrentKey("Source Document", "Source No.");
        case "Document Type" of "Document Type"::Purchase: WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Purchase Order");
        end;
        WhseRequest.SetRange("Source No.", "No.");
        REPORT.RunModal(REPORT::"Create Invt Put-away/Pick/Mvmt", true, false, WhseRequest);
    end;
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID:="Dimension Set ID";
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', "Document Type", "No."), "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if PurchLinesExist then UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;
    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
    begin
        // Update all lines with changed dimensions.
        if NewParentDimSetID = OldParentDimSetID then exit;
        if not Confirm(Text051)then exit;
        PurchLine.Reset;
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.LockTable;
        if PurchLine.Find('-')then repeat NewDimSetID:=DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PurchLine."Dimension Set ID" <> NewDimSetID then begin
                    PurchLine."Dimension Set ID":=NewDimSetID;
                    if not HideValidationDialog and GuiAllowed then VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);
                    DimMgt.UpdateGlobalDimFromDimSetID(PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
                    PurchLine.Modify;
                end;
            until PurchLine.Next = 0;
    end;
    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean)
    begin
        if PurchLine.IsReceivedShippedItemDimChanged then if not ReceivedShippedItemLineDimChangeConfirmed then ReceivedShippedItemLineDimChangeConfirmed:=PurchLine.ConfirmReceivedShippedItemDimChange;
    end;
    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20])
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetCurrentKey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliesToDocNo);
        VendLedgEntry.SetRange("Vendor No.", VendorNo);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst then begin
            if VendLedgEntry."Amount to Apply" = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");
                VendLedgEntry."Amount to Apply":=VendLedgEntry."Remaining Amount";
            end
            else
                VendLedgEntry."Amount to Apply":=0;
            VendLedgEntry."Accepted Payment Tolerance":=0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance":=false;
            CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
        end;
    end;
    procedure SetShipToForSpecOrder()
    begin
        if Location.Get("Location Code")then begin
            "Ship-to Code":='';
            SetShipToAddress(Location.Name, Location."Name 2", Location.Address, Location."Address 2", Location.City, Location."Post Code", Location.County, Location."Country/Region Code");
            "Collected By":=Location.Contact;
            "Location Code":=Location.Code;
        end
        else
        begin
            CompanyInfo.Get;
            "Ship-to Code":='';
            SetShipToAddress(CompanyInfo."Ship-to Name", CompanyInfo."Ship-to Name 2", CompanyInfo."Ship-to Address", CompanyInfo."Ship-to Address 2", CompanyInfo."Ship-to City", CompanyInfo."Ship-to Post Code", CompanyInfo."Ship-to County", CompanyInfo."Ship-to Country/Region Code");
            "Collected By":=CompanyInfo."Ship-to Contact";
            "Location Code":='';
        end;
    end;
    local procedure JobUpdatePurchLines(SkipJobCurrFactorUpdate: Boolean)
    begin
    end;
    procedure GetPstdDocLinesToRevere()
    var
        PurchPostedDocLines: Page "Posted Purchase Document Lines";
    begin
    end;
    procedure SetSecurityFilterOnRespCenter()
    begin
        if UserSetupMgt.GetPurchasesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserSetupMgt.GetPurchasesFilter);
            FilterGroup(0);
        end;
        SetRange("Date Filter", 0D, WorkDate - 1);
    end;
    procedure CalcInvDiscForHeader()
    var
        PurchaseInvDisc: Codeunit "Purch.-Calc.Discount";
    begin
    end;
    procedure AddShipToAddress(SalesHeader: Record "Sales Header"; ShowError: Boolean)
    var
        PurchLine2: Record "Purchase Line";
    begin
        if ShowError then begin
            PurchLine2.Reset;
            PurchLine2.SetRange("Document Type", "Document Type"::Purchase);
            PurchLine2.SetRange("Document No.", "No.");
            if not PurchLine2.IsEmpty then begin
                if "Ship-to Name" <> SalesHeader."Ship-to Name" then Error(Text052, FieldCaption("Ship-to Name"), "No.", SalesHeader."No.");
                if "Ship-to Name 2" <> SalesHeader."Ship-to Name 2" then Error(Text052, FieldCaption("Ship-to Name 2"), "No.", SalesHeader."No.");
                if "Ship-to Address" <> SalesHeader."Ship-to Address" then Error(Text052, FieldCaption("Ship-to Address"), "No.", SalesHeader."No.");
                if "Ship-to Address 2" <> SalesHeader."Ship-to Address 2" then Error(Text052, FieldCaption("Ship-to Address 2"), "No.", SalesHeader."No.");
                if "Ship-to Post Code" <> SalesHeader."Ship-to Post Code" then Error(Text052, FieldCaption("Ship-to Post Code"), "No.", SalesHeader."No.");
                if "Ship-to City" <> SalesHeader."Ship-to City" then Error(Text052, FieldCaption("Ship-to City"), "No.", SalesHeader."No.");
                if "Collected By" <> SalesHeader."Ship-to Contact" then Error(Text052, FieldCaption("Collected By"), "No.", SalesHeader."No.");
            end
            else
            begin
                // no purchase line exists
                "Ship-to Name":=SalesHeader."Ship-to Name";
                "Ship-to Name 2":=SalesHeader."Ship-to Name 2";
                "Ship-to Address":=SalesHeader."Ship-to Address";
                "Ship-to Address 2":=SalesHeader."Ship-to Address 2";
                "Ship-to Post Code":=SalesHeader."Ship-to Post Code";
                "Ship-to City":=SalesHeader."Ship-to City";
                "Collected By":=SalesHeader."Ship-to Contact";
            end;
        end;
    end;
    procedure DropShptOrderExists(SalesHeader: Record "Sales Header"): Boolean var
        SalesLine2: Record "Sales Line";
    begin
        // returns TRUE if sales is either Drop Shipment of Special Order
        SalesLine2.Reset;
        SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
        SalesLine2.SetRange("Document No.", SalesHeader."No.");
        SalesLine2.SetRange("Drop Shipment", true);
        exit(not SalesLine2.IsEmpty);
    end;
    procedure SpecialOrderExists(SalesHeader: Record "Sales Header"): Boolean var
        SalesLine3: Record "Sales Line";
    begin
        SalesLine3.Reset;
        SalesLine3.SetRange("Document Type", SalesLine3."Document Type"::Order);
        SalesLine3.SetRange("Document No.", SalesHeader."No.");
        SalesLine3.SetRange("Special Order", true);
        exit(not SalesLine3.IsEmpty);
    end;
    procedure QtyToReceiveIsZero(): Boolean begin
        PurchLine.Reset;
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetFilter("Qty. to Receive", '<>0');
        exit(PurchLine.IsEmpty);
    end;
    local procedure IsApprovedForPosting(): Boolean var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin
    end;
    procedure IsApprovedForPostingBatch(): Boolean var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin
    end;
    procedure IsTotalValid(): Boolean var
        IncomingDocument: Record "Incoming Document";
        PurchaseLine: Record "Purchase Line";
        TempTotalPurchaseLine: Record "Purchase Line" temporary;
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
    begin
        if not IncomingDocument.Get("Incoming Document Entry No.")then exit(true);
        if IncomingDocument."Amount Incl. VAT" = 0 then exit(true);
        PurchaseLine.SetRange("Document Type", "Document Type");
        PurchaseLine.SetRange("Document No.", "No.");
        if not PurchaseLine.FindFirst then exit(true);
        if IncomingDocument."Currency Code" <> PurchaseLine."Currency Code" then exit(true);
        TempTotalPurchaseLine.Init;
        DocumentTotals.PurchaseCalculateTotalsWithInvoiceRounding(PurchaseLine, VATAmount, TempTotalPurchaseLine);
        exit(IncomingDocument."Amount Incl. VAT" = TempTotalPurchaseLine."Amount Including VAT");
    end;
    procedure SendToPosting(PostingCodeunitID: Integer)
    begin
        if not IsApprovedForPosting then exit;
        CODEUNIT.Run(PostingCodeunitID, Rec);
    end;
    procedure CancelBackgroundPosting()
    var
        PurchasePostViaJobQueue: Codeunit "Purchase Post via Job Queue";
    begin
    end;
    procedure CheckDropShptAddressDetails(SalesHeader: Record "Sales Header"): Boolean begin
        NameAddressDetails:=DropShptNameAddressDetails;
        DropShptNameAddressDetails:=SalesHeader."Ship-to Name" + SalesHeader."Ship-to Name 2" + SalesHeader."Ship-to Address" + SalesHeader."Ship-to Address 2" + SalesHeader."Ship-to Post Code" + SalesHeader."Ship-to City" + SalesHeader."Ship-to Contact";
        if NameAddressDetails = '' then NameAddressDetails:=DropShptNameAddressDetails;
        exit(NameAddressDetails = DropShptNameAddressDetails);
    end;
    procedure AddSpecialOrderToAddress(SalesHeader: Record "Sales Header"; ShowError: Boolean)
    var
        PurchLine3: Record "Purchase Line";
        LocationCode: Record Location;
    begin
        if ShowError then begin
            PurchLine3.Reset;
            PurchLine3.SetRange("Document Type", "Document Type"::Purchase);
            PurchLine3.SetRange("Document No.", "No.");
            if not PurchLine3.IsEmpty then begin
                LocationCode.Get("Location Code");
                if "Ship-to Name" <> LocationCode.Name then Error(Text052, FieldCaption("Ship-to Name"), "No.", SalesHeader."No.");
                if "Ship-to Name 2" <> LocationCode."Name 2" then Error(Text052, FieldCaption("Ship-to Name 2"), "No.", SalesHeader."No.");
                if "Ship-to Address" <> LocationCode.Address then Error(Text052, FieldCaption("Ship-to Address"), "No.", SalesHeader."No.");
                if "Ship-to Address 2" <> LocationCode."Address 2" then Error(Text052, FieldCaption("Ship-to Address 2"), "No.", SalesHeader."No.");
                if "Ship-to Post Code" <> LocationCode."Post Code" then Error(Text052, FieldCaption("Ship-to Post Code"), "No.", SalesHeader."No.");
                if "Ship-to City" <> LocationCode.City then Error(Text052, FieldCaption("Ship-to City"), "No.", SalesHeader."No.");
                if "Collected By" <> LocationCode.Contact then Error(Text052, FieldCaption("Collected By"), "No.", SalesHeader."No.");
            end
            else
                SetShipToForSpecOrder;
        end;
    end;
    procedure CheckSpecOrderAddressDetails(SalesHeader: Record "Sales Header"): Boolean var
        LocationCode: Record Location;
    begin
        NameAddressDetails:=SpecOrderNameAddressDetails;
        if LocationCode.Get(SalesHeader."Location Code")then SpecOrderNameAddressDetails:=LocationCode.Name + LocationCode."Name 2" + LocationCode.Address + LocationCode."Address 2" + LocationCode."Post Code" + LocationCode.City + LocationCode.Contact
        else
        begin
            CompanyInfo.Get;
            SpecOrderNameAddressDetails:=CompanyInfo."Ship-to Name" + CompanyInfo."Ship-to Name 2" + CompanyInfo."Ship-to Address" + CompanyInfo."Ship-to Address 2" + CompanyInfo."Ship-to Post Code" + CompanyInfo."Ship-to City" + CompanyInfo."Ship-to Contact";
        end;
        if NameAddressDetails = '' then NameAddressDetails:=SpecOrderNameAddressDetails;
        exit(NameAddressDetails = SpecOrderNameAddressDetails);
    end;
    local procedure InitRecOnVendUpdate()
    begin
        if not SkipInitialization then InitInsert;
    end;
    procedure InvoicedLineExists(): Boolean var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");
        PurchLine.SetFilter("Quantity Invoiced", '<>%1', 0);
        exit(not PurchLine.IsEmpty);
    end;
    procedure CreateDimSetForPrepmtAccDefaultDim()
    var
        PurchaseLine: Record "Purchase Line";
        TempPurchaseLine: Record "Purchase Line" temporary;
    begin
        PurchaseLine.SetRange("Document Type", "Document Type");
        PurchaseLine.SetRange("Document No.", "No.");
        PurchaseLine.SetFilter("Prepmt. Amt. Inv.", '<>%1', 0);
        if PurchaseLine.FindSet then repeat CollectParamsInBufferForCreateDimSet(TempPurchaseLine, PurchaseLine);
            until PurchaseLine.Next = 0;
        TempPurchaseLine.Reset;
        TempPurchaseLine.MarkedOnly(false);
    //eddie if TempPurchaseLine.FindSet then
    // repeat
    //     PurchaseLine.CreateDim(DATABASE::"G/L Account", TempPurchaseLine."No.",
    //       DATABASE::Job, TempPurchaseLine."Job No.",
    //       DATABASE::"Responsibility Center", TempPurchaseLine."Responsibility Center",
    //       DATABASE::"Work Center", TempPurchaseLine."Work Center No.");
    // until TempPurchaseLine.Next = 0;
    end;
    local procedure CollectParamsInBufferForCreateDimSet(var TempPurchaseLine: Record "Purchase Line" temporary; PurchaseLine: Record "Purchase Line")
    var
        GenPostingSetup: Record "General Posting Setup";
        DefaultDimension: Record "Default Dimension";
    begin
        TempPurchaseLine.SetRange("Gen. Bus. Posting Group", PurchaseLine."Gen. Bus. Posting Group");
        TempPurchaseLine.SetRange("Gen. Prod. Posting Group", PurchaseLine."Gen. Prod. Posting Group");
        if not TempPurchaseLine.FindFirst then begin
            GenPostingSetup.Get(PurchaseLine."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group");
            GenPostingSetup.TestField("Purch. Prepayments Account");
            DefaultDimension.SetRange("Table ID", DATABASE::"G/L Account");
            DefaultDimension.SetRange("No.", GenPostingSetup."Purch. Prepayments Account");
            InsertTempPurchaseLineInBuffer(TempPurchaseLine, PurchaseLine, GenPostingSetup."Purch. Prepayments Account", DefaultDimension.IsEmpty);
        end
        else if not TempPurchaseLine.Mark then begin
                TempPurchaseLine.SetRange("Job No.", PurchaseLine."Job No.");
                TempPurchaseLine.SetRange("Responsibility Center", PurchaseLine."Responsibility Center");
                TempPurchaseLine.SetRange("Work Center No.", PurchaseLine."Work Center No.");
                if TempPurchaseLine.IsEmpty then InsertTempPurchaseLineInBuffer(TempPurchaseLine, PurchaseLine, TempPurchaseLine."No.", false)end;
    end;
    local procedure InsertTempPurchaseLineInBuffer(var TempPurchaseLine: Record "Purchase Line" temporary; PurchaseLine: Record "Purchase Line"; AccountNo: Code[20]; DefaultDimenstionsNotExist: Boolean)
    begin
        TempPurchaseLine.Init;
        TempPurchaseLine."Line No.":=PurchaseLine."Line No.";
        TempPurchaseLine."No.":=AccountNo;
        TempPurchaseLine."Job No.":=PurchaseLine."Job No.";
        TempPurchaseLine."Responsibility Center":=PurchaseLine."Responsibility Center";
        TempPurchaseLine."Work Center No.":=PurchaseLine."Work Center No.";
        TempPurchaseLine."Gen. Bus. Posting Group":=PurchaseLine."Gen. Bus. Posting Group";
        TempPurchaseLine."Gen. Prod. Posting Group":=PurchaseLine."Gen. Prod. Posting Group";
        TempPurchaseLine.Mark:=DefaultDimenstionsNotExist;
        TempPurchaseLine.Insert;
    end;
    procedure OpenPurchaseOrderStatistics()
    begin
        CalcInvDiscForHeader;
        CreateDimSetForPrepmtAccDefaultDim;
        Commit;
        PAGE.RunModal(PAGE::"Purchase Order Statistics", Rec);
    end;
    procedure GetCardpageID(): Integer begin
        case "Document Type" of "Document Type"::Stock: exit(PAGE::"Purchase Quote");
        "Document Type"::Purchase: exit(PAGE::"Purchase Order");
        "Document Type"::CAPEX: exit(PAGE::"Purchase Invoice");
        "Document Type"::"Return Order": exit(PAGE::"Purchase Credit Memo");
        "Document Type"::RFQ: exit(PAGE::"Blanket Purchase Order");
        /* "Document Type"::"5":
            exit(PAGE::"Purchase Return Order"); */
        end;
    end;
    [IntegrationEvent(TRUE, false)]
    procedure OnCheckPurchasePostRestrictions()
    begin
    end;
    [IntegrationEvent(TRUE, false)]
    procedure OnCheckPurchaseReleaseRestrictions()
    begin
    end;
    procedure SetStatus(NewStatus: Option)
    begin
        Status:=NewStatus;
        Modify;
    end;
    procedure TriggerOnAfterPostPurchaseDoc(var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    var
        PurchPost: Codeunit "Purch.-Post";
    begin
    end;
    procedure DeferralHeadersExist(): Boolean var
        DeferralHeader: Record "Deferral Header";
        DeferralUtilities: Codeunit "Deferral Utilities";
    begin
        DeferralHeader.SetRange("Deferral Doc. Type", "Document Type"); //eddieDeferralUtilities.get);
        DeferralHeader.SetRange("Gen. Jnl. Template Name", '');
        DeferralHeader.SetRange("Gen. Jnl. Batch Name", '');
        DeferralHeader.SetRange("Document Type", "Document Type");
        DeferralHeader.SetRange("Document No.", "No.");
        exit(not DeferralHeader.IsEmpty);
    end;
    local procedure ConfirmUpdateDeferralDate()
    begin
        if HideValidationDialog then Confirmed:=true
        else
            Confirmed:=Confirm(DeferralLineQst, false, FieldCaption("Posting Date"));
        if Confirmed then UpdatePurchLines(PurchLine.FieldCaption("Deferral Code"), false);
    end;
    procedure IsCreditDocType(): Boolean begin
    //exit("Document Type" in ["Document Type"::"5", "Document Type"::"Return Order"]);
    end;
    procedure SetBuyFromVendorFromFilter()
    var
        BuyFromVendorNo: Code[20];
    begin
        BuyFromVendorNo:=GetFilterVendNo;
        if BuyFromVendorNo = '' then begin
            FilterGroup(2);
            BuyFromVendorNo:=GetFilterVendNo;
            FilterGroup(0);
        end;
        if BuyFromVendorNo <> '' then Validate("Buy-from Vendor No.", BuyFromVendorNo);
    end;
    procedure CopyBuyFromVendorFilter()
    var
        BuyFromVendorFilter: Text;
    begin
        BuyFromVendorFilter:=GetFilter("Buy-from Vendor No.");
        if BuyFromVendorFilter <> '' then begin
            FilterGroup(2);
            SetFilter("Buy-from Vendor No.", BuyFromVendorFilter);
            FilterGroup(0)end;
    end;
    local procedure GetFilterVendNo(): Code[20]begin
        if GetFilter("Buy-from Vendor No.") <> '' then if GetRangeMin("Buy-from Vendor No.") = GetRangeMax("Buy-from Vendor No.")then exit(GetRangeMax("Buy-from Vendor No."));
    end;
    local procedure UpdateVendorAddress()
    var
        Vendor: Record Vendor;
    begin
        if Vendor.Get("Buy-from Vendor No.")then if not Vendor.HasAddress then CopyBuyFromVendorAddressFieldsFromPurchaseDocument(Vendor);
        if "Pay-to Vendor No." <> "Buy-from Vendor No." then if Vendor.Get("Pay-to Vendor No.")then if not Vendor.HasAddress then CopyPayToVendorAddressFieldsFromPurchaseDocument(Vendor);
    end;
    local procedure CopyBuyFromVendorAddressFieldsFromPurchaseDocument(var Vendor: Record Vendor)
    begin
        Vendor.Address:="Buy-from Address";
        Vendor."Address 2":="Buy-from Address 2";
        Vendor.City:="Buy-from City";
        Vendor.Contact:="Buy-from Contact";
        Vendor."Country/Region Code":="Buy-from Country/Region Code";
        Vendor.County:="Buy-from County";
        Vendor."Post Code":="Buy-from Post Code";
        Vendor.Modify(true);
    end;
    local procedure CopyPayToVendorAddressFieldsFromPurchaseDocument(var Vendor: Record Vendor)
    begin
        Vendor.Address:="Pay-to Address";
        Vendor."Address 2":="Pay-to Address 2";
        Vendor.City:="Pay-to City";
        Vendor.Contact:="Pay-to Contact";
        Vendor."Country/Region Code":="Pay-to Country/Region Code";
        Vendor.County:="Pay-to County";
        Vendor."Post Code":="Pay-to Post Code";
        Vendor.Modify(true);
    end;
    procedure HasBuyFromAddress(): Boolean begin
        case true of "Buy-from Address" <> '': exit(true);
        "Buy-from Address 2" <> '': exit(true);
        "Buy-from City" <> '': exit(true);
        "Buy-from Country/Region Code" <> '': exit(true);
        "Buy-from County" <> '': exit(true);
        "Buy-from Post Code" <> '': exit(true);
        "Buy-from Contact" <> '': exit(true);
        end;
        exit(false);
    end;
    procedure HasShipToAddress(): Boolean begin
        case true of "Ship-to Address" <> '': exit(true);
        "Ship-to Address 2" <> '': exit(true);
        "Ship-to City" <> '': exit(true);
        "Ship-to Country/Region Code" <> '': exit(true);
        "Ship-to County" <> '': exit(true);
        "Ship-to Post Code" <> '': exit(true);
        "Collected By" <> '': exit(true);
        end;
        exit(false);
    end;
    procedure HasPayToAddress(): Boolean begin
        case true of "Pay-to Address" <> '': exit(true);
        "Pay-to Address 2" <> '': exit(true);
        "Pay-to City" <> '': exit(true);
        "Pay-to Country/Region Code" <> '': exit(true);
        "Pay-to County" <> '': exit(true);
        "Pay-to Post Code" <> '': exit(true);
        "Pay-to Contact" <> '': exit(true);
        end;
        exit(false);
    end;
    local procedure CopyBuyFromVendorAddressFieldsFromVendor(var BuyFromVendor: Record Vendor)
    begin
        if BuyFromVendorIsReplaced or ShouldCopyAddressFromBuyFromVendor(BuyFromVendor)then begin
            "Buy-from Address":=BuyFromVendor.Address;
            "Buy-from Address 2":=BuyFromVendor."Address 2";
            "Buy-from City":=BuyFromVendor.City;
            "Buy-from Post Code":=BuyFromVendor."Post Code";
            "Buy-from County":=BuyFromVendor.County;
            "Buy-from Country/Region Code":=BuyFromVendor."Country/Region Code";
        end;
    end;
    local procedure CopyShipToVendorAddressFieldsFromVendor(var BuyFromVendor: Record Vendor)
    begin
        if BuyFromVendorIsReplaced or ShouldCopyAddressFromBuyFromVendor(BuyFromVendor)then begin
            "Ship-to Address":=BuyFromVendor.Address;
            "Ship-to Address 2":=BuyFromVendor."Address 2";
            "Ship-to City":=BuyFromVendor.City;
            "Ship-to Post Code":=BuyFromVendor."Post Code";
            "Ship-to County":=BuyFromVendor.County;
            Validate("Ship-to Country/Region Code", BuyFromVendor."Country/Region Code");
        end;
    end;
    local procedure CopyPayToVendorAddressFieldsFromVendor(var PayToVendor: Record Vendor)
    begin
        if PayToVendorIsReplaced or ShouldCopyAddressFromPayToVendor(PayToVendor)then begin
            "Pay-to Address":=PayToVendor.Address;
            "Pay-to Address 2":=PayToVendor."Address 2";
            "Pay-to City":=PayToVendor.City;
            "Pay-to Post Code":=PayToVendor."Post Code";
            "Pay-to County":=PayToVendor.County;
            "Pay-to Country/Region Code":=PayToVendor."Country/Region Code";
        end;
    end;
    local procedure SetShipToAddress(ShipToName: Text[50]; ShipToName2: Text[50]; ShipToAddress: Text[50]; ShipToAddress2: Text[50]; ShipToCity: Text[30]; ShipToPostCode: Code[20]; ShipToCounty: Text[30]; ShipToCountryRegionCode: Code[10])
    begin
        "Ship-to Name":=ShipToName;
        "Ship-to Name 2":=ShipToName2;
        "Ship-to Address":=ShipToAddress;
        "Ship-to Address 2":=ShipToAddress2;
        "Ship-to City":=ShipToCity;
        "Ship-to Post Code":=ShipToPostCode;
        "Ship-to County":=ShipToCounty;
        "Ship-to Country/Region Code":=ShipToCountryRegionCode;
    end;
    local procedure ShouldCopyAddressFromBuyFromVendor(BuyFromVendor: Record Vendor): Boolean begin
        exit((not HasBuyFromAddress) and BuyFromVendor.HasAddress);
    end;
    local procedure ShouldCopyAddressFromPayToVendor(PayToVendor: Record Vendor): Boolean begin
        exit((not HasPayToAddress) and PayToVendor.HasAddress);
    end;
    local procedure BuyFromVendorIsReplaced(): Boolean begin
        exit((xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> "Buy-from Vendor No."));
    end;
    local procedure PayToVendorIsReplaced(): Boolean begin
        exit((xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> "Pay-to Vendor No."));
    end;
    local procedure UpdatePayToAddressFromBuyFromAddress(FieldNumber: Integer)
    begin
        if("Order Address Code" = '') and PayToAddressEqualsOldBuyFromAddress then case FieldNumber of FieldNo("Pay-to Address"): if xRec."Buy-from Address" = "Pay-to Address" then "Pay-to Address":="Buy-from Address";
            FieldNo("Pay-to Address 2"): if xRec."Buy-from Address 2" = "Pay-to Address 2" then "Pay-to Address 2":="Buy-from Address 2";
            FieldNo("Pay-to City"), FieldNo("Pay-to Post Code"): begin
                if xRec."Buy-from City" = "Pay-to City" then "Pay-to City":="Buy-from City";
                if xRec."Buy-from Post Code" = "Pay-to Post Code" then "Pay-to Post Code":="Buy-from Post Code";
                if xRec."Buy-from County" = "Pay-to County" then "Pay-to County":="Buy-from County";
                if xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" then "Pay-to Country/Region Code":="Buy-from Country/Region Code";
            end;
            FieldNo("Pay-to County"): if xRec."Buy-from County" = "Pay-to County" then "Pay-to County":="Buy-from County";
            FieldNo("Pay-to Country/Region Code"): if xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" then "Pay-to Country/Region Code":="Buy-from Country/Region Code";
            end;
    end;
    local procedure PayToAddressEqualsOldBuyFromAddress(): Boolean begin
        if(xRec."Buy-from Address" = "Pay-to Address") and (xRec."Buy-from Address 2" = "Pay-to Address 2") and (xRec."Buy-from City" = "Pay-to City") and (xRec."Buy-from County" = "Pay-to County") and (xRec."Buy-from Post Code" = "Pay-to Post Code") and (xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code")then exit(true);
    end;
    procedure ConfirmCloseUnposted(): Boolean var
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if PurchLinesExist then exit(InstructionMgt.ShowConfirm(DocumentNotPostedClosePageQst, InstructionMgt.QueryPostOnCloseCode));
        exit(true)end;
    local procedure InitFromVendor(VendorNo: Code[20]; VendorCaption: Text): Boolean begin
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        if VendorNo = '' then begin
            if not PurchLine.IsEmpty then Error(Text005, VendorCaption);
            Init;
            PurchSetup.Get;
            "No. Series":=xRec."No. Series";
            InitRecord;
            InitNoSeries;
            exit(true);
        end;
    end;
    local procedure InitFromContact(ContactNo: Code[20]; VendorNo: Code[20]; ContactCaption: Text): Boolean begin
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        if(ContactNo = '') and (VendorNo = '')then begin
            if not PurchLine.IsEmpty then Error(Text005, ContactCaption);
            Init;
            PurchSetup.Get;
            "No. Series":=xRec."No. Series";
            InitRecord;
            InitNoSeries;
            exit(true);
        end;
    end;
    local procedure LookupContact(VendorNo: Code[20]; ContactNo: Code[20]; var Contact: Record Contact)
    var
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        ContactBusinessRelation.SetCurrentKey("Link to Table", "No.");
        ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Vendor);
        ContactBusinessRelation.SetRange("No.", VendorNo);
        if ContactBusinessRelation.FindFirst then Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.")
        else
            Contact.SetRange("Company No.", '');
        if ContactNo <> '' then if Contact.Get(ContactNo)then;
    end;
    procedure SendRecords()
    var
        DocumentSendingProfile: Record "Document Sending Profile";
    begin
        if DocumentSendingProfile.LookUpProfileVendor("Buy-from Vendor No.", IsSingleVendorSelected, false)then SendProfile(DocumentSendingProfile);
    end;
    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
    begin
    // DocumentSendingProfile.TrySendToPrinterVendor(
    //  DummyReportSelections.Usage::"P.Order",Rec,"Buy-from Vendor No.",ShowRequestForm);
    end;
    local procedure IsSingleVendorSelected(): Boolean var
        SelectedCount: Integer;
        VendorCount: Integer;
        BuyFromVendorNoFilter: Text;
    begin
        SelectedCount:=Count;
        if SelectedCount < 1 then exit(false);
        if SelectedCount = 1 then exit(true);
        BuyFromVendorNoFilter:=GetFilter("Buy-from Vendor No.");
        SetRange("Buy-from Vendor No.", "Buy-from Vendor No.");
        VendorCount:=Count;
        SetFilter("Buy-from Vendor No.", BuyFromVendorNoFilter);
        exit(SelectedCount = VendorCount);
    end;
    procedure SendProfile(var DocumentSendingProfile: Record "Document Sending Profile")
    var
        DummyReportSelections: Record "Report Selections";
    begin
    /* DocumentSendingProfile.SendVendor(
          DummyReportSelections.Usage::"P.Order", Rec, "No.", "Buy-from Vendor No.",
          DocTxt, FieldNo("Buy-from Vendor No."), FieldNo("No.")); */
    end;
    procedure FormatStatus(CurrStatus: Integer): Integer var
        ApprovalEntry: Record "Approval Entry";
        NoOfApprovals: Integer;
        DocStatus: Option New, "HOD Approved", "Finance Approved", "Approval Pending", Rejected, "DED/DFA Approved";
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordId);
        ApprovalEntry.SetRange("Related to Change", false);
        //ApprovalEntry.SETRANGE(ApprovalEntry."Old Approval",FALSE);
        if ApprovalEntry.Find('-')then begin
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
            ApprovalEntry.SetRange("Record ID to Approve", RecordId);
            ApprovalEntry.SetRange("Related to Change", false);
            ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Approved);
            NoOfApprovals:=ApprovalEntry.Count;
            case true of NoOfApprovals = 0: begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
                ApprovalEntry.SetRange("Record ID to Approve", RecordId);
                ApprovalEntry.SetRange("Related to Change", false);
                ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Rejected);
                NoOfApprovals:=ApprovalEntry.Count;
                if NoOfApprovals <> 0 then begin
                    exit(DocStatus::Rejected);
                end
                else
                begin
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
                    ApprovalEntry.SetRange("Record ID to Approve", RecordId);
                    ApprovalEntry.SetRange("Related to Change", false);
                    ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Open);
                    NoOfApprovals:=ApprovalEntry.Count;
                    if NoOfApprovals <> 0 then exit(DocStatus::"Approval Pending")
                    else
                        exit(DocStatus::New);
                end;
            end;
            NoOfApprovals = 1: exit(DocStatus::"HOD Approved");
            NoOfApprovals = 2: exit(DocStatus::"Finance Approved");
            NoOfApprovals = 3: exit(DocStatus::"DED/DFA Approved");
            NoOfApprovals = 4: exit(DocStatus::"DED/DFA Approved");
            end;
        //To cater for the old approvals-Brian
        end
        else
        begin
            case Status of Status::Released: exit(DocStatus::"DED/DFA Approved");
            Status::Open: exit(DocStatus::New);
            Status::"Pending Approval": exit(DocStatus::"Approval Pending");
            Status::Disapproved: exit(DocStatus::Rejected);
            Status::Fulfilled: exit(DocStatus::"DED/DFA Approved");
            end;
        end;
    // ELSE
    // EXIT(CurrStatus);
    end;
    procedure InsertUserAccount(UserName: Code[100])
    var
        UserSetup: Record "User Setup";
        NoUserAcc: Label 'You do not have a user account. Please contact the system administrator.';
        Employee: Record Employee;
    begin
        // IF NOT UserSetup.GET(USERID) THEN
        //  BEGIN
        //    ERROR(NoUserAcc);
        //  END ELSE
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserName);
        if UserSetup.FindFirst then begin
            UserSetup.TestField("Customer No.");
            "Customer No.":=UserSetup."Customer No.";
            Validate("Customer No.");
            UserSetup.TestField("Employee No.");
            "Employee No.":=UserSetup."Employee No.";
            Validate("Employee No.");
            if Employee.Get("Employee No.")then begin
                Employee.TestField("Global Dimension 1 Code");
                //Employee.TestField("Global Dimension 2 Code");
                "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                Validate("Shortcut Dimension 1 Code");
            // "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
            // Validate("Shortcut Dimension 2 Code");
            end
            else
                Error('Employee cannot be found');
        end;
    end;
    local procedure CheckOpenDocs(DocType: Option Stock, Purchase, CAPEX, "Return Order", RFQ; MaxNo: Integer)
    var
        IRHeader: Record "Internal Request Header";
        MultiDocError: Label 'Kindly utilize your open documents before creating a new one';
    begin
    // IRHeader.Reset;
    // IRHeader.SetRange("Document Type", DocType);
    // IRHeader.SetRange("Requested By", UserId);
    // IRHeader.SetRange(Status, IRHeader.Status::Open);
    // if IRHeader.Count > MaxNo then
    //     Error(MultiDocError);
    end;
    local procedure GetEmpDetails(EmpNo: Code[20])
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmpNo)then begin
            "Employee Name":=(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
            "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
        end;
    end;
    procedure GetDueDate()
    var
        OrderThreshold: Record "Order Due Days Threshold";
    begin
        if "Document Date" <> 0D then begin
            CalcFields(Amount);
            OrderThreshold.Reset();
            OrderThreshold.SetFilter("Lower Limit", '<=%1', Amount);
            OrderThreshold.SetFilter("Upper Limit", '>=%1', Amount);
            IF OrderThreshold.FindFirst()then begin
                OrderThreshold.TestField("Due days");
                "Order Date":=CalcDate(OrderThreshold."Due days", "Document Date");
            end;
        end;
    end;
}

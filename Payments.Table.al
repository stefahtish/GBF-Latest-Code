table 50124 Payments
{
    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "Payment Type" = "Payment Type"::"Payment Voucher" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."PV Nos");
                end;
                if "Payment Type" = "Payment Type"::Imprest then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Imprest Nos");
                end;
                if "Payment Type" = "Payment Type"::"Petty Cash" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Petty Cash Nos");
                end;
                if "Payment Type" = "Payment Type"::"Petty Cash Surrender" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Petty Cash Surrender Nos");
                end;
                if "Payment Type" = "Payment Type"::"Imprest Surrender" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Imprest Surrender Nos");
                end;
                if "Payment Type" = "Payment Type"::Receipt then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Receipt Nos");
                end;
                if "Payment Type" = "Payment Type"::"Bank Transfer" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Bank Transfer Nos");
                end;
                if "Payment Type" = "Payment Type"::"Staff Claim" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Staff Claim Nos");
                end;
                if "Payment Type" = "Payment Type"::"Receipt-Property" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(InvestmentSetup."Receipt Nos");
                end;
                if "Payment Type" = "Payment Type"::"Input Tax" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Input Tax Nos");
                end;
                if "Payment Type" = "Payment Type"::"Service Charge" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Service Charge Nos");
                    if "Payment Type" = "Payment Type"::"Service Charge Surrender" then begin
                        if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Service Charge Surrender Nos");
                    end;
                    if "Payment Type" = "Payment Type"::"Service Charge Claim" then begin
                        if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Service Charge Claim Nos");
                    end;
                    if "Payment Type" = "Payment Type"::"EFT File Gen" then begin
                        if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."EFT File Gen Nos");
                    end;
                end;
            end;
        }
        field(2; Date; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*
                     CASE "Payment Type" OF
                      "Payment Type"::Imprest:
                        BEGIN
                         //Get the Imprest Deadline Date
                         IF NOT CashMgt.GET THEN
                          ERROR(Text000);
                          CashMgt.TESTFIELD("Imprest Due Date");
                           IF Date<>0D THEN
                            "Imprest Deadline":=CALCDATE(CashMgt."Imprest Due Date",Date);
                        END;
                     END;
                     */
            end;
        }
        field(3; "Pay Code"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Pay Mode"; Code[20])
        {
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                PayMethod: Record "Payment Method";
                Vendor: Record Vendor;
                PaymentLines: Record "Payment Lines";
            begin
                /*
                CalcFields("Pay Mode Type");
                case "Pay Mode Type" of
                    "Pay Mode Type"::EFT, "Pay Mode Type"::RTGS:
                        begin
                            if Vendor.Get("Account No.") then begin
                                Validate("Payee Bank Code", Vendor."Vendor Bank Code");
                                Validate("Payee Bank Branch Code", Vendor."Vendor Bank Branch Code");
                                Validate("Payee Bank Account No", Vendor."Vendor Bank Account No");
                                Validate("Payee Swift Code", Vendor."Vendor Swift Code");
                            end;

                        end;
                end;
                */
                PaymentLines.Reset();
                PaymentLines.SetRange(No, "No.");
                PaymentLines.SetRange("Payment Type", "Payment Type");
                if PaymentLines.FindSet() then begin
                    repeat
                        PaymentLines."Pay Mode" := "Pay Mode";
                        PaymentLines.Modify();
                    until PaymentLines.Next() = 0;
                end;
            end;
        }
        field(5; "Cheque No"; Code[20])
        {
            TableRelation = IF ("Cheque Type" = FILTER("Computer Check")) "Cheque Register"."Cheque No." WHERE("Bank Account No." = FIELD("Paying Bank Account"), Issued = CONST(false), Voided = CONST(false), Cancelled = CONST(false));

            trigger OnValidate()
            begin
                /*
                IF "Cheque No"<>'' THEN BEGIN
                PV.RESET;
                PV.SETRANGE(PV."Cheque No","Cheque No");
                IF PV.FIND('-') THEN BEGIN
                IF PV."No." <> "No." THEN
                   ERROR(Text002);
                END;
                END;
                */
                if "Cheque No" <> '' then begin
                    if "Cheque Type" = "Cheque Type"::"Computer Check" then begin
                        if Confirm('Are you sure you want to issue Cheque No. %1', false, "Cheque No") then begin
                            ChequeRegister.Reset;
                            ChequeRegister.SetRange(ChequeRegister."Cheque No.", "Cheque No");
                            if ChequeRegister.FindFirst then begin
                                ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Issued;
                                ChequeRegister."Issued By" := UserId;
                                ChequeRegister."Issued Doc No." := "No.";
                                ChequeRegister."Cheque Date" := "Cheque Date";
                                ChequeRegister.Issued := true;
                                ChequeRegister.Modify;
                            end;
                        end
                        else
                            "Cheque No" := '';
                    end;
                end;
            end;
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(8; Payee; Text[250])
        {
        }
        field(9; "On behalf of"; Text[250])
        {
        }
        field(10; "Created By"; Code[50])
        {
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; "Posted By"; Code[50])
        {
            Editable = true;
        }
        field(13; "Posted Date"; Date)
        {
            Editable = true;
        }
        field(14; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(15; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(16; "Time Posted"; Time)
        {
        }
        field(17; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Paying Bank Account2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payment Type" = FILTER("Petty Cash" | "Petty Cash Surrender")) "Bank Account" WHERE("Bank Type" = CONST("Petty Cash"))
            ELSE IF ("Payment Type" = FILTER(Imprest | "Imprest Surrender" | "Payment Voucher" | "Service Charge" | "Service Charge Claim")) "Bank Account" WHERE("Bank Type" = filter(Bank | "Petty Cash"))
            ELSE IF ("Payment Type" = FILTER(Receipt | "Staff Claim" | "Receipt-Property")) "Bank Account";

            trigger OnValidate()
            begin
                if Bank.Get("Paying Bank Account") then begin
                    //    Bank.TESTFIELD(Name);
                    //    Bank.TESTFIELD("Currency Code");
                    //    Bank.TESTFIELD("Bank Type");
                    "Bank Name" := Bank.Name;
                    Currency := Bank."Currency Code";
                end;
                // PaymentLines.Reset();
                // PaymentLines.SetRange(No, "No.");
                // if PaymentLines.Find('-') then
                //     repeat
                //         PaymentLines.validate("Account No");
                //     until PaymentLines.next = 0;
            end;
        }
        field(7; "Portal Request"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Paying Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payment Type" = FILTER("Petty Cash" | "Petty Cash Surrender")) "Bank Account" WHERE("Bank Type" = CONST("Petty Cash"))
            ELSE IF ("Payment Type" = FILTER(Imprest | "Imprest Surrender" | "Payment Voucher" | "Service Charge" | "Service Charge Claim")) "Bank Account" WHERE("Bank Type" = filter(Bank | "Petty Cash"))
            ELSE IF ("Payment Type" = FILTER(Receipt | "Staff Claim" | "Receipt-Property")) "Bank Account";

            trigger OnValidate()
            begin
                if Bank.Get("Paying Bank Account") then begin
                    //    Bank.TESTFIELD(Name);
                    //    Bank.TESTFIELD("Currency Code");
                    //    Bank.TESTFIELD("Bank Type");
                    "Bank Name" := Bank.Name;
                    Currency := Bank."Currency Code";
                end;
                // PaymentLines.Reset();
                // PaymentLines.SetRange(No, "No.");
                // if PaymentLines.Find('-') then
                //     repeat
                //         PaymentLines.validate("Account No");
                //     until PaymentLines.next = 0;
            end;
        }
        field(19; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Pending Prepayment,Released,Rejected,,Closed,Archived,Finance Approved';
            OptionMembers = Open,"Pending Approval","Pending Prepayment",Released,Rejected,Closed,Archived,"Finance Approved";
        }
        field(20; "Payment Type"; Option)
        {
            OptionCaption = 'Payment Voucher,Imprest,Staff Claim,Imprest Surrender,Petty Cash,Bank Transfer,Petty Cash Surrender,Receipt,Staff Advance,Receipt-Property,Input Tax,Service Charge,Service Charge Surrender,Service Charge Claim,Payment Request, Payroll EFT File Gen,EFT File Gen,Travel Request,Medical Cover Receipt,Group Life Receipt,Contribution Receipt,Accruals';
            OptionMembers = "Payment Voucher",Imprest,"Staff Claim","Imprest Surrender","Petty Cash","Bank Transfer","Petty Cash Surrender",Receipt,"Staff Advance","Receipt-Property","Input Tax","Service Charge","Service Charge Surrender","Service Charge Claim","Payment Request","Payroll EFT File Gen","EFT File Gen","Travel Request","Medical Cover Receipt","Group Life Receipt","Contribution Receipt",Accruals;
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            // begin
            //     modify();
            // end;
        }
        field(21; Currency; Code[20])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Receiving Bank Amount" <> 0 then Validate("Receiving Bank Amount");
                PaymentLines.Reset();
                PaymentLines.SetRange(No, "No.");
                if PaymentLines.Find('-') then
                    repeat
                        PaymentLines.Currency := Currency;
                        PaymentLines.validate(Currency);
                        PaymentLines.modify;
                    until PaymentLines.next = 0;
            end;
        }
        field(22; "No. Series"; Code[20])
        {
        }
        field(23; "Account Type"; enum "Gen. Journal Account Type")
        {
            Editable = true;
        }
        field(24; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Account Type" = CONST(Customer)) Customer
            ELSE IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor;

            trigger OnValidate()
            begin
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No.") then;
                            GLAccount.TestField("Direct Posting", true);
                            "Account Name" := GLAccount.Name;
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No.") then;
                            Vendor.TestField(Blocked, Vendor.Blocked::" ");
                            "Account Name" := Vendor.Name;
                            Payee := Vendor.Name;
                        end;
                    "Account Type"::Customer:
                        begin
                            Customer.Get("Account No.");
                            Customer.TestField(Blocked, Customer.Blocked::" ");
                            "Account Name" := Customer.Name;
                            //Validate Employee details
                            UserSetup.Reset();
                            UserSetup.SetRange(UserSetup."Customer No.", "Account No.");
                            if UserSetup.FindFirst then begin
                                if Customer.Get(UserSetup."Customer No.") then begin
                                    Customer.CalcFields("Balance (LCY)");
                                    if "Payment Type" = "Payment Type"::Imprest then begin
                                        if Customer."Balance (LCY)" > 0 then Error('You cannot apply for a new imprest because you have an outstanding balance of KES %1', Customer."Balance (LCY)");
                                    end;
                                end;
                                // eddie UserSetup.TestField("Employee No.");
                                //"Staff No.":=UserSetup."Employee No.";
                                Commit;
                                "Salary Scale" := GetSalaryScale("Staff No.");
                                "Responsibility Center" := UserSetup."User Responsibility Center";
                            end;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            Bank.Get("Account No.");
                            "Account Name" := Bank.Name;
                            Currency := Bank."Currency Code";
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Get("Account No.");
                            "Account Name" := FixedAsset.Description;
                        end;
                end;
            end;
        }
        field(25; "Account Name"; Text[100])
        {
        }
        field(26; "Imprest Amount"; Decimal)
        {
            Caption = 'Total Amount';
            CalcFormula = Sum("Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Surrendered; Boolean)
        {
        }
        field(28; "Applies- To Doc No."; Code[20])
        {
            trigger OnLookup()
            begin
                /*

                    CASE "Account Type" OF
                      "Account Type"::Customer:

                       BEGIN
                            CustLedger.RESET;
                            CustLedger.SETCURRENTKEY(CustLedger."Customer No.",Open,"Document No.");
                            CustLedger.SETRANGE(CustLedger."Customer No.","Account No.");
                            CustLedger.SETRANGE(Open,TRUE);
                            CustLedger.CALCFIELDS(CustLedger.Amount);
                           IF PAGE.RUNMODAL(25,CustLedger) = ACTION::LookupOK THEN BEGIN

                            "Applies- To Doc No.":=CustLedger."Document No.";

                           END;

                          END;
                       END;
                       */
            end;
        }
        field(29; "Petty Cash Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines".Amount WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Remaining Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Remaining Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Receipt Created"; Boolean)
        {
        }
        field(35; "Imprest Deadline"; Date)
        {
            Editable = false;
        }
        field(36; "Surrender Date"; Date)
        {
            Editable = true;
        }
        field(37; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(38; "Imprest Type"; Option)
        {
            OptionCaption = 'Normal,Project Imprest';
            OptionMembers = Normal,"Project Imprest";
        }
        field(41; "Travel Date"; Date)
        {
        }
        field(42; Cashier; Text[50])
        {
        }
        field(68; "Payment Release Date"; Date)
        {
        }
        field(69; "No. Printed"; Integer)
        {
        }
        field(81; "Surrender Status"; Option)
        {
            OptionCaption = ' ,Full,Partial';
            OptionMembers = " ",Full,Partial;
        }
        field(82; "Departure Date"; Date)
        {
        }
        field(85; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                /*
                    TESTFIELD(Status,Status::Pending);
                    IF NOT UserMgt.CheckRespCenter(1,"Shortcut Dimension 3 Code") THEN
                      ERROR(
                        Text001,
                        RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);

                    */
                /*
                   "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
                   IF "Location Code" = '' THEN BEGIN
                     IF InvtSetup.GET THEN
                       "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
                   END ELSE BEGIN
                     IF Location.GET("Location Code") THEN;
                     "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
                   END;

                   UpdateShipToAddress;
                      */
                /*
                 CreateDim(
                   DATABASE::"Responsibility Center","Responsibility Center",
                   DATABASE::Vendor,"Pay-to Vendor No.",
                   DATABASE::"Salesperson/Purchaser","Purchaser Code",
                   DATABASE::Campaign,"Campaign No.");

                 IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
                   RecreatePaymentLines(FIELDCAPTION("Responsibility Center"));
                   "Assigned User ID" := '';
                 END;
                   */
            end;
        }
        field(86; "Cheque Type"; Option)
        {
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(88; "Payment Narration"; Text[500])
        {
        }
        field(89; "Total VAT Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."VAT Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."W/Tax Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Total Net Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Net Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(92; "Total Payment Amount LCY"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."NetAmount LCY" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(93; "Total Retention Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Retention Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                Users: Record User;
                UserSetup: record "User Setup";
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                UserSetup.Reset();
                UserSetup.SetRange("HOD User", true);
            end;
        }
        field(95; "Posting Date"; Date)
        {
        }
        field(98; "Actual Amount Spent"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Actual Spent" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Cash Receipt Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Cash Receipt Amount" WHERE(No = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(100; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(106; "Imprest Issue Doc. No"; Code[20])
        {
            TableRelation = Payments."No." WHERE("Payment Type" = CONST(Imprest), Posted = CONST(true), Surrendered = CONST(false));

            trigger OnValidate()
            begin
                CheckIfSurrenderExists("Imprest Issue Doc. No");
                if PaymentRec.Get("Imprest Issue Doc. No") then begin
                    if "Payment Type" = "Payment Type"::"Imprest Surrender" then begin
                        if PaymentRec.Surrendered then Error(Text001, "Imprest Issue Doc. No");
                        "Account Type" := PaymentRec."Account Type";
                        "Account No." := PaymentRec."Account No.";
                        Validate("Account No.");
                        "Pay Mode" := PaymentRec."Pay Mode";
                        "Cheque No" := PaymentRec."Cheque No";
                        "Cheque Date" := PaymentRec."Cheque Date";
                        "Paying Bank Account" := PaymentRec."Paying Bank Account";
                        Currency := PaymentRec.Currency;
                        "Payment Narration" := PaymentRec."Payment Narration";
                        "Multi-Donor" := PaymentRec."Multi-Donor";
                        "Staff No." := PaymentRec."Staff No.";
                        "Payment Narration" := PaymentRec."Payment Narration";
                        Destination := PaymentRec.Destination;
                        "No of Days" := PaymentRec."No of Days";
                        "Date of Project" := PaymentRec."Date of Project";
                        "Date of Completion" := PaymentRec."Date of Completion";
                        "Due Date" := PaymentRec."Due Date";
                        "Posted Date" := PaymentRec."Posted Date";
                        "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                        Validate("Shortcut Dimension 1 Code");
                        "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Dimension Set ID" := PaymentRec."Dimension Set ID";
                        "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                        Validate("Shortcut Dimension 3 Code");
                        Validate("Dimension Set ID");
                        PaymentLine.Reset;
                        //PaymentLine.SETRANGE("Payment Type",PaymentRec."Payment Type"::Imprest);
                        PaymentLine.SetRange(No, PaymentRec."No.");
                        if PaymentLine.Find('-') then begin
                            PaymentLines.Reset;
                            PaymentLines.SetRange(No, "No.");
                            PaymentLines.DeleteAll();
                            repeat
                                ImpSurrLines.Init;
                                ImpSurrLines.TransferFields(PaymentLine);
                                ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender"; //Carol
                                ImpSurrLines.No := "No.";
                                ImpSurrLines."Line No" := GetNextLineNo();
                                ImpSurrLines."Actual Spent" := PaymentLine.Amount;
                                ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                                ImpSurrLines.Insert;
                            until PaymentLine.Next = 0;
                        end;
                        ExtPaymentLine.Reset();
                        ExtPaymentLine.SetRange(No, PaymentRec."No.");
                        if ExtPaymentLine.FindSet() then begin
                            ExtPaymentLines.Reset();
                            ExtPaymentLines.SetRange(No, "No.");
                            ExtPaymentLines.DeleteAll();
                            repeat
                                ExtInsurrLines.Init;
                                ExtInsurrLines.TransferFields(ExtPaymentLine);
                                ExtInsurrLines."Payment Type" := ExtInsurrLines."Payment Type"::"Imprest Surrender"; //Carol
                                ExtInsurrLines.No := "No.";
                                ExtInsurrLines."Line No" := GetExtNextLineNo();
                                ExtInsurrLines."Actual Spent" := ExtPaymentLine.Amount;
                                ExtInsurrLines.Purpose := PaymentRec."Payment Narration";
                                ExtInsurrLines.Insert;
                            until ExtPaymentLine.Next() = 0;
                        end;
                    end;
                end;
            end;
        }
        field(107; "Date Surrendered"; Date)
        {
        }
        field(108; "Surrendered By"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(109; "Actual Petty Cash Amount Spent"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Actual Spent" WHERE(No = FIELD("No."), "Payment Type" = CONST("Petty Cash Surrender")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(110; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(111; "Remaining Petty Cash Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Remaining Amount" WHERE(No = FIELD("No."), "Payment Type" = CONST("Petty Cash")));
            FieldClass = FlowField;
        }
        field(112; "Receipted Petty Cash Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Cash Receipt Amount" WHERE(No = FIELD("No."), "Payment Type" = CONST("Petty Cash Surrender")));
            FieldClass = FlowField;
        }
        field(113; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(114; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(115; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(116; "Petty Cash Issue Doc.No"; Code[20])
        {
            TableRelation = Payments."No." WHERE("Payment Type" = CONST("Petty Cash"), Posted = CONST(true), Surrendered = CONST(false));

            trigger OnValidate()
            var
                LineNo: integer;
            begin
                if PaymentRec.Get("Petty Cash Issue Doc.No") then begin
                    if PaymentRec.Surrendered then Error(Text002, "Petty Cash Issue Doc.No");
                    "Account Type" := PaymentRec."Account Type";
                    "Account No." := PaymentRec."Account No.";
                    Validate("Account No.");
                    "Pay Mode" := PaymentRec."Pay Mode";
                    "Paying Bank Account" := PaymentRec."Paying Bank Account";
                    Validate("Paying Bank Account");
                    "Cheque No" := PaymentRec."Cheque No";
                    "Cheque Date" := PaymentRec."Cheque Date";
                    Currency := PaymentRec.Currency;
                    "Payment Narration" := PaymentRec."Payment Narration";
                    "Staff No." := PaymentRec."Staff No.";
                    "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Dimension Set ID" := PaymentRec."Dimension Set ID";
                    "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    Validate("Shortcut Dimension 3 Code");
                    PaymentLine.Reset;
                    //PaymentLine.SETRANGE("Payment Type",PaymentRec."Payment Type"::"Petty Cash");
                    PaymentLine.SetRange(No, PaymentRec."No.");
                    if PaymentLine.Find('-') then begin
                        repeat //LineNo := LineNo + 10000;
                            ImpSurrLines.Init;
                            ImpSurrLines.TransferFields(PaymentLine);
                            GetNextLineNo();
                            ImpSurrLines."Line No" := GetNextLineNo;
                            ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Petty Cash Surrender";
                            ImpSurrLines.No := "No.";
                            ImpSurrLines.Purpose := PaymentLine.Description;
                            ImpSurrLines."Actual Spent" := ImpSurrLines.Amount;
                            // if not PaymentRec."Multi-Donor" then begin
                            //     ImpSurrLines."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                            //     Validate("Shortcut Dimension 1 Code");
                            //     ImpSurrLines."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                            //     Validate("Shortcut Dimension 2 Code");
                            //     ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                            // end else begin
                            //     ImpSurrLines."Shortcut Dimension 1 Code" := PaymentLine."Shortcut Dimension 1 Code";
                            //     Validate("Shortcut Dimension 1 Code");
                            //     ImpSurrLines."Shortcut Dimension 2 Code" := PaymentLine."Shortcut Dimension 2 Code";
                            //     Validate("Shortcut Dimension 2 Code");
                            //     ImpSurrLines."Shortcut Dimension 3 Code" := PaymentLine."Shortcut Dimension 3 Code";
                            //     Validate("Shortcut Dimension 3 Code");
                            //     ImpSurrLines.Purpose := PaymentLine.Description;
                            // end;
                            // Validate("Dimension Set ID");
                            // if not ImpSurrLines.Get(ImpSurrLines.No, ImpSurrLines."Line No") then
                            //     ImpSurrLines.Insert
                            // else begin
                            //ImpSurrLines.Reset;
                            //     ImpSurrLines.SetRange("Payment Type", ImpSurrLines."Payment Type"::"Petty Cash Surrender");
                            //     ImpSurrLines.SetRange(No, "No.");
                            //     ImpSurrLines.SetRange("Line No", PaymentLine."Line No");
                            //     if ImpSurrLines.Find('-') then begin
                            //         ImpSurrLines.TransferFields(PaymentLine);
                            //         ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Petty Cash Surrender";
                            //         ImpSurrLines.No := "No.";
                            //         //ImpSurrLines."Actual Spent":=PaymentLine.Amount;
                            //         ImpSurrLines.Modify;
                            //     end;
                            // end;
                            ImpSurrLines.Insert;
                        until PaymentLine.Next = 0;
                    end;
                end;
            end;
        }
        field(117; "Petty Cash Net Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Net Amount" WHERE(No = FIELD("No."), "Payment Type" = FILTER("Petty Cash" | "Petty Cash Surrender")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Multi-Donor"; Boolean)
        {
            trigger OnValidate()
            begin
                if not "Multi-Donor" then begin
                    if PaymentLinesExist then
                        if Confirm(Text003, false) then
                            DeletePaymentLines()
                        else
                            "Multi-Donor" := true;
                end;
            end;
        }
        field(119; "Received From"; Text[100])
        {
            trigger OnValidate()
            begin
                "On behalf of" := "Received From";
            end;
        }
        field(120; "Receipt Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(121; "Imp Surr Receipt Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Cash Receipt Amount" WHERE(No = FIELD("Imprest Surrender Doc. No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(122; "Imprest Surrender Doc. No"; Code[20])
        {
            TableRelation = Payments."No." WHERE("Payment Type" = CONST("Imprest Surrender"), Posted = CONST(false));

            trigger OnValidate()
            begin
                if PaymentRec.Get("Imprest Surrender Doc. No") then begin
                    if "Payment Type" = "Payment Type"::"Imprest Surrender" then begin
                        if PaymentRec.Surrendered then Error(Text001, "Imprest Issue Doc. No");
                        "Account Type" := PaymentRec."Account Type";
                        "Account No." := PaymentRec."Account No.";
                        Validate("Account No.");
                        "Pay Mode" := PaymentRec."Pay Mode";
                        "Cheque No" := PaymentRec."Cheque No";
                        "Cheque Date" := PaymentRec."Cheque Date";
                        "Paying Bank Account" := PaymentRec."Paying Bank Account";
                        Currency := PaymentRec.Currency;
                        "Payment Narration" := PaymentRec."Payment Narration";
                        "Multi-Donor" := PaymentRec."Multi-Donor";
                        Validate("Paying Bank Account");
                        "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                        Validate("Shortcut Dimension 1 Code");
                        "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Dimension Set ID" := PaymentRec."Dimension Set ID";
                        Validate("Dimension Set ID");
                        PaymentLine.Reset;
                        PaymentLine.SetRange(No, PaymentRec."No.");
                        if PaymentLine.Find('-') then begin
                            repeat
                                ImpSurrLines.Init;
                                ImpSurrLines.TransferFields(PaymentLine);
                                ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender"; //Carol
                                ImpSurrLines.No := "No.";
                                //ImpSurrLines."Actual Spent":=PaymentLine.Amount;
                                if "Multi-Donor" = true then begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentLine."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentLine."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                end
                                else begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                end;
                                Validate("Dimension Set ID");
                                ImpSurrLines.Purpose := PaymentLine.Description;
                                if not ImpSurrLines.Get(ImpSurrLines.No, ImpSurrLines."Line No") then
                                    ImpSurrLines.Insert
                                else begin
                                    ImpSurrLines.Reset;
                                    ImpSurrLines.SetRange("Payment Type", ImpSurrLines."Payment Type"::"Imprest Surrender"); //Carol
                                    ImpSurrLines.SetRange(No, "No.");
                                    ImpSurrLines.SetRange("Line No", PaymentLine."Line No");
                                    if ImpSurrLines.Find('-') then begin
                                        ImpSurrLines.TransferFields(PaymentLine);
                                        ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender"; //Carol
                                        ImpSurrLines.No := "No.";
                                        //ImpSurrLines."Actual Spent":=PaymentLine.Amount;
                                        ImpSurrLines.Modify;
                                    end;
                                end;
                            until PaymentLine.Next = 0;
                        end;
                    end;
                end;
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
        field(500; "Impress Amount 1"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(501; "Impress Amount 2"; Decimal)
        {
            CalcFormula = Sum("Ext Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(502; "Actual Amount Spent 1"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Actual Spent" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(503; "Actual Amount Spent 2"; Decimal)
        {
            CalcFormula = Sum("Ext Payment Lines"."Actual Spent" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(504; "Cash Receipt Amount 1"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Cash Receipt Amount" WHERE(No = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(505; "Cash Receipt Amount 2"; Decimal)
        {
            CalcFormula = Sum("Ext Payment Lines"."Cash Receipt Amount" WHERE(No = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(506; "Total Amount 1"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(507; "Total Amount 2"; Decimal)
        {
            CalcFormula = Sum("Ext Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Withheld VAT"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."W/T VAT Amount" WHERE(No = FIELD("No."), "Payment Type" = CONST("Payment Voucher")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Bank Name"; Text[50])
        {
            CalcFormula = Lookup("Bank Account".Name WHERE("No." = FIELD("Paying Bank Account")));
            Caption = 'Bank Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Notification Sent"; Boolean)
        {
        }
        field(50019; "DateTime Sent"; DateTime)
        {
        }
        field(50020; "Vendor Entry No"; Integer)
        {
            CalcFormula = Lookup("Vendor Ledger Entry"."Entry No." WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "User Id"; Code[30])
        {
            TableRelation = "User Setup";
        }
        field(50022; "User Department"; Code[20])
        {
            Editable = false;
            FieldClass = Normal;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(50023; "HOD Comments"; Text[100])
        {
        }
        field(50024; "Finance Comments"; Text[200])
        {
        }
        field(50025; "HOD Approver"; Code[20])
        {
        }
        field(50026; "Finance Approver"; Code[200])
        {
        }
        field(50027; "ISD Department"; Option)
        {
            Editable = false;
            FieldClass = Normal;
            OptionCaption = ' ,ISD Support,ISD Programs';
            OptionMembers = " ","ISD Support","ISD Programs";
        }
        field(50028; "Time Inserted"; Time)
        {
        }
        field(50029; "Levied Invoice"; Boolean)
        {
        }
        field(50030; "Cash Receipt No. Surr"; Code[10])
        {
            CalcFormula = Lookup("Payment Lines"."Imprest Receipt No." WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                MaxNo: Integer;
                Empl: Record Employee;
                ImprestNo: Code[20];
            begin
                if Empl.Get("Staff No.") then begin
                    "Account No." := empl."Imprest Customer Code";
                    ImprestNo := Empl."Imprest Customer Code";
                end;
                Customer.Reset();
                Customer.SetRange("No.", ImprestNo);
                if not Customer.FindFirst then begin
                    Error('There is no user setup for Staff No. %1', "Staff No.");
                end
                else begin
                    //  UserSetup.TestField("Customer No.");
                    //UserSetup.TestField("User Responsibility Center");
                    // if Customer.Get(ImprestNo) then begin
                    //     Customer.CalcFields("Balance (LCY)");
                    //     if "Payment Type" = "Payment Type"::Imprest then begin
                    //         if Customer."Balance (LCY)" > 0 then
                    //             Error('You cannot apply for a new imprest because you have an outstanding balance of KES %1', Customer."Balance (LCY)");
                    //     end;
                    // end;
                    //"Account No." := UserSetup."Customer No.";
                    Validate("Account No.");
                    //  "Salary Scale" := GetSalaryScale("Staff No.");
                    // "Responsibility Center" := UserSetup."User Responsibility Center";
                    MaxNo := GetJobGroupImprests("Staff No.");
                    case "Payment Type" of
                        "Payment Type"::Imprest:
                            CheckUnsurrenderedDoc("Payment Type", "Staff No.");
                        "Payment Type"::"Petty Cash":
                            CheckUnsurrenderedDoc("Payment Type", "Staff No.");
                    end;
                end;
            end;
        }
        field(50032; "Date of Project"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ExpectedDate: Date;
            begin
                if ("Payment Type" in ["Payment Type"::Imprest]) and ("Date of Project" < Today) then Error('Start Date %1 cannot be less than Today - %2', "Date of Project", Today);
                //Imprest application restriction to Travel date limit of application be less
                CashMgt.Get;
                CashMgt.TestField("Travel Limit Date");
                ExpectedDate := CalcDate(CashMgt."Travel Limit Date", Today);
                If ExpectedDate > "Date of Project" then Error('Travel Date Should be After %1 Days from Today - %2', CashMgt."Travel Limit Date", Today);
                if "No of Days" <> 0 then Validate("No of Days");
            end;
        }
        field(50033; "Date of Completion"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Payment Type" in ["Payment Type"::Imprest]) and ("Date of Completion" < "Date of Project") then Error('Return Date %1 cannot be less than Travel Date - %2', "Date of Completion", "Date of Project");
                CashMgt.Get;
                CashMgt.TestField("Imprest Due Date");
                "Due Date" := CalcDate(CashMgt."Imprest Due Date", "Date of Completion");
                //Get no of days
                "No of Days" := ("Date of Completion" - "Date of Project");
            end;
        }
        field(50034; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CompletionDateFormula := Format("No of Days") + 'D';
                /*IF "Date of Project"<>0D THEN
                      BEGIN
                        "Date of Completion":=CALCDATE(CompletionDateFormula,"Date of Project");
                        IF "Date of Completion"<>0D THEN
                          VALIDATE("Date of Completion");
                      END;

                    IF "Payment Type"="Payment Type"::Imprest THEN
                      BEGIN
                        PaymentLine.RESET;
                        PaymentLine.SETRANGE(PaymentLine.No,"No.");
                        IF PaymentLine.FIND('-') THEN
                          BEGIN
                            REPEAT
                              PaymentLine."No of Days":="No of Days";
                              PaymentLine.MODIFY;
                              COMMIT;

                              IF PaymentLine."Expenditure Type"<>'' THEN
                                PaymentLine.VALIDATE("Expenditure Type");
                            UNTIL PaymentLine.NEXT=0;
                          END;
                      END;
                      */
            end;
        }
        field(50036; Destination; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Destination."Destination Code";

            trigger OnValidate()
            begin
                if not "Apply on behalf" then begin
                    TestField(Cashier);
                    GetStaffNo(Cashier);
                    if "Staff No." <> '' then begin
                        if Employee.Get("Staff No.") then
                            Employee.TestField("Salary Scale")
                        else
                            Error(NoStaffNoError, "Staff No.");
                    end
                    else
                        Error('Staff No. can not be blank');
                end;
            end;
        }
        field(50037; "Receiving Bank Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CurrencyRec.InitRoundingPrecision;
                if Currency = '' then
                    "Receiving Amount LCY" := Round("Receiving Bank Amount", CurrencyRec."Amount Rounding Precision")
                else
                    "Receiving Amount LCY" := Round(CurrExchRate.ExchangeAmtFCYToLCY(Date, Currency, "Receiving Bank Amount", CurrExchRate.ExchangeRate(Date, Currency)), CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(50038; "Source Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if Bank.Get("Source Bank") then begin
                    "Source Currency" := Bank."Currency Code";
                    Validate("Source Currency");
                end;
            end;
        }
        field(50039; "Source Currency"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                if "Source Bank Amount" <> 0 then Validate("Source Bank Amount");
            end;
        }
        field(50040; "Source Bank Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CurrencyRec.InitRoundingPrecision;
                if "Source Currency" = '' then
                    "Source Amount LCY" := Round("Source Bank Amount", CurrencyRec."Amount Rounding Precision")
                else
                    "Source Amount LCY" := Round(CurrExchRate.ExchangeAmtFCYToLCY(Date, "Source Currency", "Source Bank Amount", CurrExchRate.ExchangeRate(Date, "Source Currency")), CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(50041; "Receiving Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Source Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Procurement Plan"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Check Printed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "EFT File Generated"; Boolean)
        {
            caption = 'Payment File Generated';
            DataClassification = ToBeClassified;
        }
        field(50046; "EFT Reference"; Text[30])
        {
            caption = 'Reference';
            DataClassification = ToBeClassified;
        }
        field(50047; "Imprest Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Imprest Receipt" = true then "Account Type" := "Account Type"::Customer;
            end;
        }
        field(50048; "Direct Expense"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Travel Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Local,Foreign';
            OptionMembers = "Local",Foreign;

            trigger OnValidate()
            var
                ImpLines: Record "Payment Lines";
            begin
                ImpLines.Reset();
                ImpLines.SetRange("Payment Type", "Payment Type");
                ImpLines.SetRange(No, "No.");
                if ImpLines.Find('-') then
                    repeat
                        ImpLines."Travel Type" := "Travel Type";
                        ImpLines.Modify();
                    until ImpLines.next = 0;
            end;
        }
        field(50050; "Total Witholding VAT Tax"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."W/T VAT Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "Payee PIN"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Claim Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,General Claim,Medical Claim,Imprest Claim,Mileage Claim';
            OptionMembers = " ","General Claim","Medical Claim",Imprest,"Mileage Claim";

            trigger OnValidate()
            begin
                if "Payment Type" = "Payment Type"::"Staff Claim" then begin
                    if "Claim Type" = "Claim Type"::Imprest then begin
                        if HasImprestAccountBalance("Account No.") then Error('You have an outstanding imprest balance of KES %1', ImpBalance);
                    end;
                end;
            end;
        }
        field(50053; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;

            trigger OnValidate()
            begin
                // IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
                //  TESTFIELD("Gen. Posting Type","Gen. Posting Type"::" ");
                // IF ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
                //  ERROR(Text006,"Gen. Posting Type");
                // CheckVATInAlloc;
                // IF "Gen. Posting Type" > 0 THEN
                //  VALIDATE("VAT Prod. Posting Group");
                // IF "Gen. Posting Type" <> "Gen. Posting Type"::Purchase THEN
                //  VALIDATE("Use Tax",FALSE)
            end;
        }
        field(50054; "Imprest Surrender Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Imprest Posted by PV"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "EFT Date"; Date)
        {
            caption = 'Payment file Date';
            DataClassification = ToBeClassified;
        }
        field(50057; "RTGS Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Salary Scale"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Transfer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single Bank,Multiple Banks';
            OptionMembers = " ","Single Bank","Multiple Banks";
        }
        field(50060; "Petty Cash Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payment Lines"."Amount (LCY)" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "Asset Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Money Market,Property,Equity,Bond,Mortgage,Unit Trust,Forex';
            OptionMembers = " ","Money Market",Property,Equity,Bond,Mortgage,"Unit Trust",Forex;
        }
        field(60001; "TPS Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "TPS Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Remove from Schedule"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60004; PRN; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "PV Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Pension,Payroll,Property,Board,Investment;
        }
        field(60007; Apportion; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("No Apportion", false);
                //Check If Applied Invoice is Apportioned
                Apportionment.CheckIfInvoiceApportioned("No.");
            end;
        }
        field(60008; "Deposit Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Service Charge Issue Doc. No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Payments."No." WHERE("Payment Type" = CONST("Service Charge"), Posted = CONST(true), Surrendered = CONST(false));

            trigger OnValidate()
            begin
                //CheckIfSurrenderExists("Imprest Issue Doc. No");
                if PaymentRec.Get("Service Charge Issue Doc. No") then begin
                    if "Payment Type" = "Payment Type"::"Service Charge Surrender" then begin
                        if PaymentRec.Surrendered then Error(Text001, "Imprest Issue Doc. No");
                        "Account Type" := PaymentRec."Account Type";
                        "Account No." := PaymentRec."Account No.";
                        Validate("Account No.");
                        "Pay Mode" := PaymentRec."Pay Mode";
                        "Cheque No" := PaymentRec."Cheque No";
                        "Cheque Date" := PaymentRec."Cheque Date";
                        "Paying Bank Account" := PaymentRec."Paying Bank Account";
                        Currency := PaymentRec.Currency;
                        "Payment Narration" := PaymentRec."Payment Narration";
                        "Multi-Donor" := PaymentRec."Multi-Donor";
                        "Staff No." := PaymentRec."Staff No.";
                        "Payment Narration" := PaymentRec."Payment Narration";
                        Destination := PaymentRec.Destination;
                        "No of Days" := PaymentRec."No of Days";
                        "Date of Project" := PaymentRec."Date of Project";
                        "Date of Completion" := PaymentRec."Date of Completion";
                        "Due Date" := PaymentRec."Due Date";
                        "Posted Date" := PaymentRec."Posted Date";
                        "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                        Validate("Shortcut Dimension 1 Code");
                        "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Dimension Set ID" := PaymentRec."Dimension Set ID";
                        "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                        Validate("Shortcut Dimension 3 Code");
                        Validate("Dimension Set ID");
                        PaymentLine.Reset;
                        //PaymentLine.SETRANGE("Payment Type",PaymentRec."Payment Type"::Imprest);
                        PaymentLine.SetRange(No, PaymentRec."No.");
                        if PaymentLine.Find('-') then begin
                            repeat
                                ImpSurrLines.Init;
                                ImpSurrLines.TransferFields(PaymentLine);
                                ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Service Charge Surrender"; //Carol
                                ImpSurrLines.No := "No.";
                                ImpSurrLines."Actual Spent" := ImpSurrLines.Amount;
                                if "Multi-Donor" = true then begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentLine."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentLine."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                end
                                else begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                    ImpSurrLines."Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                                    Validate("Shortcut Dimension 3 Code");
                                end;
                                Validate("Dimension Set ID");
                                ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                                if not ImpSurrLines.Get(ImpSurrLines.No, ImpSurrLines."Line No") then
                                    ImpSurrLines.Insert
                                else begin
                                    ImpSurrLines.Reset;
                                    ImpSurrLines.SetRange("Payment Type", ImpSurrLines."Payment Type"::"Service Charge Surrender"); //Carol
                                    ImpSurrLines.SetRange(No, "No.");
                                    ImpSurrLines.SetRange("Line No", PaymentLine."Line No");
                                    if ImpSurrLines.Find('-') then begin
                                        ImpSurrLines.TransferFields(PaymentLine);
                                        ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Service Charge Surrender"; //Carol
                                        ImpSurrLines.No := "No.";
                                        //ImpSurrLines."Actual Spent":=PaymentLine.Amount;
                                        ImpSurrLines.Modify;
                                    end;
                                end;
                            until PaymentLine.Next = 0;
                        end;
                    end;
                end;
            end;
        }
        field(60010; "Payroll Transfered"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60011; "No Apportion"; Boolean)
        {
            Caption = 'No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Apportion, false);
            end;
        }
        field(60012; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60013; "Service Charge Pmt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60014; "Confirm Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(60015; "Apply on behalf"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60016; "Confirm Receipt User"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60017; "Confirm Receipt Date-Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60018; TrainingNo; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "PV Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60020; "Payment Request Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60021; "Requested Payment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Invoice,Imprest,"Staff claim";
            OptionCaption = ' ,Invoice,Imprest,Staff claim';
        }
        field(60022; "Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60023; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Requested Payment" = const(Invoice)) "Purch. Inv. Header"."No." where("Remaining Amount" = filter(> 0))
            else if ("Requested Payment" = const(Imprest)) Payments where("Payment Type" = const(Imprest))
            else if ("Requested Payment" = const("Staff claim")) Payments where("Payment Type" = const("Staff Claim"));

            trigger OnValidate()
            var
                PInv: record "Purch. Inv. Header";
                Imprest: Record Payments;
                StaffClaim: Record Payments;
                Payments: Record Payments;
            begin
                if "Requested Payment" = "Requested Payment"::Invoice then begin
                    PInv.SetRange("No.", "Document No.");
                    if PInv.FindFirst() then Payee := PInv."Buy-from Vendor Name";
                end;
                if "Requested Payment" = "Requested Payment"::Imprest then begin
                    Imprest.SetRange("No.", "Document No.");
                    Imprest.SetRange("Payment Type", Imprest."Payment Type"::Imprest);
                    if Imprest.FindFirst() then Payee := Imprest."Account Name";
                end;
                if "Requested Payment" = "Requested Payment"::"Staff claim" then begin
                    StaffClaim.SetRange("No.", "Document No.");
                    StaffClaim.SetRange("Payment Type", StaffClaim."Payment Type"::"Staff Claim");
                    if StaffClaim.FindFirst() then Payee := StaffClaim."Account Name";
                end;
                Payments.reset;
                Payments.setfilter("No.", '<>%1', "No.");
                Payments.Setrange("Payment Type", Payments."Payment Type"::"Payment Voucher");
                Payments.Setrange("Requested Payment", "Requested Payment");
                Payments.Setrange("Document No.", "Document No.");
                Payments.Setrange(Requisition, true);
                Payments.SetRange("PV Created", false);
                if Payments.FindFirst() then Error('Another request %1 has been made for this document', Payments."No.");
            end;
        }
        field(60024; Select; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Select then
                    "Selected By" := UserId
                else
                    "Selected By" := '';
            end;
        }
        field(60025; "Selected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "Payee Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                if Banks.Get("Payee Bank Code") then
                    "Payee Bank Code Name" := Banks.Name
                else
                    "Payee Bank Code Name" := '';
                Validate("Payee Swift Code");
            end;
        }
        field(70004; "Payee Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code" = FIELD("Payee Bank Code"));

            trigger OnValidate()
            begin
                if BankBranchess.Get("Payee Bank Code", "Payee Bank Branch Code") then
                    "Payee Bank Branch Name" := BankBranchess."Branch Name"
                else
                    "Payee Bank Branch Name" := '';
                Validate("Payee Swift Code");
            end;
        }
        field(70005; "Payee Bank Account No"; Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("Payee Swift Code");
            end;
        }
        field(70006; "Payee Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if "Account Type" = "Account Type"::Vendor then
                    if Vendor.Get("Account No.") then begin
                        if Vendor."Vendor Bank Code" = '' then Vendor.Validate("Vendor Bank Code", "Payee Bank Code");
                        if Vendor."Vendor Bank Branch Code" = '' then Vendor.Validate("Vendor Bank Branch Code", "Payee Bank Branch Code");
                        if Vendor."Vendor Bank Account No" = '' then Vendor."Vendor Bank Account No" := "Payee Bank Account No";
                        if Vendor."Vendor Swift Code" = '' then Vendor."Vendor Swift Code" := "Payee Swift Code";
                    end;
            end;
        }
        field(70007; "Payee Bank Code Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "Payee Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70039; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70040; "Net Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70021; "Forex dealer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Forex Dealers";

            trigger OnValidate()
            var
                FDealers: Record "Forex Dealers";
            begin
                if FDealers.get("Forex dealer") then "Forex dealer name" := FDealers.Name;
            end;
        }
        field(70022; "Forex deal no"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70023; "Dirext/inverse"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",D,I;
            OptionCaption = ' ,D,I';
        }
        field(70024; "Forex Type"; text[100])
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ","FX Contract Rate","System Rate","Held Rate","Spot cover","Forward exchange cover";
        }
        field(70025; "Created By User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70042; Preview; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70051; "Conversion rate"; Decimal)
        {
            DecimalPlaces = 1 : 10;
            DataClassification = ToBeClassified;
        }
        field(70052; "Forex dealer name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70054; "Total EFT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("EFT Lines New"."Total Net Amount" where("Document No." = field("No.")));
        }
        field(70055; "Payment File"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Payment,Forex,Tax,Payroll,Investment;
        }
        field(70056; "Source Table No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70057; "Source Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70058; "Source RECORDID"; RecordId)
        {
            DataClassification = ToBeClassified;
        }
        field(70059; "Payroll Approval No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Approval";
            Editable = false;
        }
        field(70060; "Deduction Code."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = DeductionsX;
            Editable = false;
        }
        field(70061; "POP Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "POP Codes";

            trigger OnValidate()
            var
                PaymentLines: Record "Payment Lines";
            begin
                PaymentLines.Reset();
                PaymentLines.SetRange(No, "No.");
                PaymentLines.SetRange("Payment Type", "Payment Type");
                if PaymentLines.FindSet() then begin
                    repeat
                        PaymentLines."POP Code" := "POP Code";
                        PaymentLines.Modify();
                    until PaymentLines.Next() = 0;
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Account Name")
        {
        }
    }
    trigger OnInsert()
    var
        AccountType: Enum "Gen. Journal Account Type";
        Deductions: Record DeductionsX;
        UserSetup: Record "User Setup";
        Text001: Label 'You must define a welfare deduction to continue.';
    begin
        CashMgt.Get;
        CashMgt.TestField("Max Open Documents");
        GeneralLedgerSetup.Get;
        case "Payment Type" of
            "Payment Type"::"Payment Voucher":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("PV Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."PV Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::"Travel Request":
                begin
                    //CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("Travel Request Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Travel Request Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::Imprest:
                begin
                    CashMgt.TestField("Max Imprests Unsurrendered");
                    // CheckPendingDocs2("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("Imprest Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Imprest Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount;
                    Payee := "Account Name";
                    // CheckUnsurrenderedDoc("Payment Type", "Staff No.");
                end;
            "Payment Type"::"Petty Cash":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("Petty Cash Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Petty Cash Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    //Currency:=GeneralLedgerSetup."LCY Code";
                    InsertUserAccount;
                    InsertPayMode();
                    // CheckUnsurrenderedDoc("Payment Type", "Staff No.");
                end;
            "Payment Type"::"Petty Cash Surrender":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("Petty Cash Surrender Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Petty Cash Surrender Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount;
                end;
            "Payment Type"::"Imprest Surrender":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField(CashMgt."Imprest Surrender Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Imprest Surrender Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount;
                end;
            "Payment Type"::"Bank Transfer":
                begin
                    CashMgt.TestField(CashMgt."Bank Transfer Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Bank Transfer Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::Receipt:
                begin
                    CashMgt.TestField(CashMgt."Receipt Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::"Medical Cover Receipt":
                begin
                    CashMgt.TestField(CashMgt."Medical Cover Receipt Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Medical Cover Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::"Receipt-Property":
                begin
                    InvestmentSetup.Get;
                    InvestmentSetup.TestField("Receipt Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(InvestmentSetup."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::"Contribution Receipt":
                begin
                    CashMgt.TestField(CashMgt."Receipt Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::"Staff Claim":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField(CashMgt."Staff Claim Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Staff Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount;
                end;
            "Payment Type"::"Input Tax":
                begin
                    CashMgt.TestField(CashMgt."Input Tax Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Input Tax Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::"Service Charge":
                begin
                    CashMgt.TestField("Service Charge Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Service Charge Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            "Payment Type"::"Service Charge Surrender":
                begin
                    CashMgt.TestField("Service Charge Surrender Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Service Charge Surrender Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    "Surrender Date" := Today;
                end;
            "Payment Type"::"Service Charge Claim":
                begin
                    CashMgt.TestField("Service Charge Claim Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Service Charge Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    "Surrender Date" := Today;
                end;
            "Payment Type"::"EFT File Gen", "Payment Type"::"Payroll EFT File Gen":
                begin
                    CashMgt.TestField("EFT File Gen Nos");
                    if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."EFT File Gen Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    "EFT Reference" := "No.";
                    "EFT Date" := Today;
                end;
        end;
        "Created By" := UserId;
        "Created By User Name" := GetUserName();
        Cashier := UserId;
        Date := Today;
        "Time Inserted" := Time;
        UserSetup.get(UserId);
        //UserSetup.TestField("Employee No.");
        //"Staff No." := UserSetup."Employee No.";
        if Employee.Get(UserSetup."Employee No.") then begin
            Validate("Shortcut Dimension 1 Code", Employee."Global Dimension 1 Code");
            Validate("Shortcut Dimension 2 Code", Employee."Global Dimension 2 Code");
            "Salary Scale" := Employee."Salary Scale";
            //     Payee := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            // end else
            //     Error('Employee cannot be found');
            if Rec."Payment Type" <> Rec."Payment Type"::"Payment Voucher" then begin
                Payee := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"
            end;
        end;
        //Adding the User ID to pick the Current user:
        Rec."User Id" := UserId;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvestmentSetup: Record "Investment Setup";
        CashMgt: Record "Cash Management Setups";
        DimMgt: Codeunit DimensionManagement;
        Apportionment: Codeunit Apportionment;
        CompletionDateFormula: Text;
        PaymentLine: Record "Payment Lines";
        ExtPaymentLine: Record "Ext Payment Lines";
        Bank: Record "Bank Account";
        Customer: Record Customer;
        PaymentRec: Record Payments;
        ImpSurrLines: Record "Payment Lines";
        PaymentLines: Record "Payment Lines";
        ExtInsurrLines: Record "Ext Payment Lines";
        ExtPaymentLines: Record "Ext Payment Lines";
        Text051: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text001: Label 'The imprest %1 has been fully surrendered';
        Text002: Label 'The petty cash %1 has been fully surrendered';
        Text003: Label 'By disabling Multi-Donor the dimensions on the lines shall be reset \ You wish to proceed?';
        GeneralLedgerSetup: Record "General Ledger Setup";
        NoUserAcc: Label 'You do not have a user account. Please contact the system administrator.';
        "NoCustNo.": Label 'There is no imprest account associated with %1. Please contact the system administrator.';
        WrongAcc: Label 'Wrong account number associated with %1';
        MultiDocError: Label 'Kindly utilize your open documents before creating a new one';
        Employee: Record Employee;
        NoStaffNoError: Label 'Staff No. %1 can not be found in the Employees List. Kindly contact the system administrator.';
        AccountError: Label 'Please account for your previous %1 before applying for a new one';
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyRec: Record Currency;
        ChequeRegister: Record "Cheque Register";
        ImpBalance: Decimal;
        SurrExistsError: Label 'Imprest issued document %1 has been used in another Imprest Surrender document %2';
        Banks: Record Banks;
        BankBranchess: Record "Bank Branches";
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        UserSetup: Record "User Setup";
        GlobalPaymentLine: Record "Payment Lines";
        NextLineNo: Integer;

    local procedure GetUserName(): Code[100]
    var
        UserSetup: Record "User Setup";
        Users: record User;
    begin
        if UserSetup.Get(UserId) then;
        Users.reset;
        Users.SetRange("User Name", UserSetup."User ID");
        if Users.FindFirst() then exit(Users."Full Name");
    end;

    procedure InsertPayMode()
    var
        PaymentMethod: Record "Payment Method";
    begin
        PaymentMethod.Reset();
        case "Payment Type" of
            "Payment Type"::"Petty Cash":
                begin
                    PaymentMethod.SetRange("Bal. Account Type", PaymentMethod."Bal. Account Type"::Cash);
                    if PaymentMethod.FindFirst() then Validate("Pay Mode", PaymentMethod.Code);
                end;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if OldDimSetID <> "Dimension Set ID" then begin
            if PaymentLinesExist then UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    // procedure ShowDocDim()
    // var
    //     OldDimSetID: Integer;
    // begin
    //     OldDimSetID := "Dimension Set ID";
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet(
    //         "Dimension Set ID", StrSubstNo('%1 %2', "Payment Type", "No."),
    //         "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    //     if OldDimSetID <> "Dimension Set ID" then begin
    //         if PaymentLinesExist then
    //             UpdateAllLineDim("Dimension Set ID", OldDimSetID);
    //     end;
    // end;
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        //     IsHandled := false;
        //    // OnBeforeShowDocDim(Rec, xRec, IsHandled);
        //     if IsHandled then
        //         exit;
        Commit();
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            Rec, "Dimension Set ID", StrSubstNo('%1 %2', "Payment Type", "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        // OnShowDocDimOnBeforeUpdateSalesLines(Rec, xRec);
        if OldDimSetID <> "Dimension Set ID" then begin
            // OnShowDocDimOnBeforeSalesHeaderModify(Rec);
            Modify();
            if PaymentLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure GetCurrency()
    begin
        /*
              CurrencyCode := "Currency Code";

            IF CurrencyCode = '' THEN BEGIN
              CLEAR(Currency);
              Currency.InitRoundingPrecision
            END ELSE
              IF CurrencyCode <> Currency.Code THEN BEGIN
                Currency.GET(CurrencyCode);
                Currency.TESTFIELD("Amount Rounding Precision");
              END;
            */
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        if NewParentDimSetID = OldParentDimSetID then exit;
        if GuiAllowed then begin
            if not Confirm(Text051) then exit;
        end;
        PaymentLine.Reset;
        PaymentLine.SetRange("Payment Type", "Payment Type");
        PaymentLine.SetRange(PaymentLine.No, "No.");
        PaymentLine.LockTable;
        if PaymentLine.Find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(PaymentLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PaymentLine."Dimension Set ID" <> NewDimSetID then begin
                    PaymentLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(PaymentLine."Dimension Set ID", PaymentLine."Shortcut Dimension 1 Code", PaymentLine."Shortcut Dimension 2 Code");
                    PaymentLine.Modify;
                end;
            until PaymentLine.Next = 0;
    end;

    procedure PaymentLinesExist(): Boolean
    begin
        PaymentLine.Reset;
        PaymentLine.SetRange("Payment Type", "Payment Type");
        PaymentLine.SetRange(No, "No.");
        exit(PaymentLine.FindFirst);
    end;

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posted Date", "No.");
        NavigateForm.Run;
    end;

    procedure ValidateSurrender()
    var
        PCLines: Record "Payment Lines";
    begin
        TestField("Surrender Date");
        PCLines.Reset;
        PCLines.SetRange("Payment Type", "Payment Type");
        PCLines.SetRange(No, "No.");
        if PCLines.Find('-') then
            repeat
                PCLines.ValidateSurrenderLines();
            until PCLines.Next = 0;
    end;

    procedure CheckDocType(): Boolean
    begin
        if "Multi-Donor" then
            exit(true)
        else
            exit(false);
    end;

    procedure DeletePaymentLines(): Boolean
    begin
        PaymentLine.Reset;
        PaymentLine.SetRange("Payment Type", "Payment Type");
        PaymentLine.SetRange(No, "No.");
        if PaymentLine.Find('-') then
            repeat
                PaymentLine."Shortcut Dimension 1 Code" := '';
                PaymentLine."Shortcut Dimension 2 Code" := '';
                PaymentLine."Dimension Set ID" := 0;
                PaymentLine.Modify;
            until PaymentLine.Next = 0;
    end;

    procedure FormatStatus(CurrStatus: Integer): Integer
    var
        ApprovalEntry: Record "Approval Entry";
        NoOfApprovals: Integer;
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordId);
        ApprovalEntry.SetRange("Related to Change", false);
        //ApprovalEntry.SETRANGE(ApprovalEntry."Old Approval",FALSE);
        if ApprovalEntry.Find('-') then begin
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
            ApprovalEntry.SetRange("Record ID to Approve", RecordId);
            ApprovalEntry.SetRange("Related to Change", false);
            ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Approved);
            NoOfApprovals := ApprovalEntry.Count;
            case true of
                NoOfApprovals = 0:
                    begin
                        ApprovalEntry.Reset;
                        ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
                        ApprovalEntry.SetRange("Record ID to Approve", RecordId);
                        ApprovalEntry.SetRange("Related to Change", false);
                        ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Rejected);
                        NoOfApprovals := ApprovalEntry.Count;
                        if NoOfApprovals <> 0 then begin
                            exit(DocStatus::Rejected);
                        end
                        else begin
                            ApprovalEntry.Reset;
                            ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
                            ApprovalEntry.SetRange("Record ID to Approve", RecordId);
                            ApprovalEntry.SetRange("Related to Change", false);
                            ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Open);
                            NoOfApprovals := ApprovalEntry.Count;
                            if NoOfApprovals <> 0 then
                                exit(DocStatus::"Approval Pending")
                            else
                                exit(DocStatus::New);
                        end;
                    end;
                NoOfApprovals = 1:
                    exit(DocStatus::"HOD Approved");
                NoOfApprovals = 2:
                    exit(DocStatus::"Finance Approved");
                NoOfApprovals = 3:
                    exit(DocStatus::"DED/DFA Approved");
                NoOfApprovals = 4:
                    exit(DocStatus::"DED/DFA Approved");
            end;
            //To cater for the old approvals-Brian
        end
        else begin
            case Status of
                Status::Released:
                    exit(DocStatus::"DED/DFA Approved");
                Status::Open:
                    exit(DocStatus::New);
                Status::"Pending Approval":
                    exit(DocStatus::"Approval Pending");
                Status::Rejected:
                    exit(DocStatus::Rejected);
            end;
        end;
        // ELSE
        // EXIT(CurrStatus);
    end;

    procedure GetAccountNo(): Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then;
        //eddieUserSetup.TestField("Employee No.");
        exit(UserSetup."Employee No.");
    end;

    procedure DefaultPettyCash(var BankCode: Code[20]): Code[20]
    var
        PaymentMethod: Record "Payment Method";
        BankRec: Record "Bank Account";
    begin
        BankRec.Reset;
        BankRec.SetRange("Bank Type", BankRec."Bank Type"::"Petty Cash");
        if BankRec.Find('-') then BankCode := BankRec."No.";
        PaymentMethod.Reset;
        PaymentMethod.SetRange("Bal. Account Type", PaymentMethod."Bal. Account Type"::Cash);
        if PaymentMethod.Find('-') then exit(PaymentMethod.Code);
    end;

    procedure MarkAsPosted()
    begin
        Posted := true;
        "Posted By" := UserId;
        "Posted Date" := Today;
        "Time Posted" := Time;
        Modify;
    end;

    procedure GetPettyCashBank() PettyBank: Code[50]
    var
        Banks: Record "Bank Account";
    begin
        Banks.Reset;
        Banks.SetRange("Bank Type", Banks."Bank Type"::"Petty Cash");
        if Banks.FindFirst then begin
            PettyBank := Banks."No.";
            exit(PettyBank);
        end;
    end;

    local procedure InsertUserAccount()
    var
        UserSetup: Record "User Setup";
    begin
        // if not UserSetup.Get(UserId) then begin
        //     Error(NoUserAcc);
        // end else begin
        //     if GuiAllowed then begin
        //         UserSetup.TestField("Customer No.");
        //         UserSetup.TestField("User Responsibility Center");
        //         if Customer.Get(UserSetup."Customer No.") then begin
        //             Customer.CalcFields("Balance (LCY)");
        //             if "Payment Type" = "Payment Type"::Imprest then begin
        //                 if Customer."Balance (LCY)" > 0 then
        //                     Error('You cannot apply for a new imprest because you have an outstanding balance of KES %1', Customer."Balance (LCY)");
        //             end;
        //         end;
        //         //  "Account No." := UserSetup."Customer No.";
        //         //Validate("Account No.");
        //         UserSetup.TestField("Employee No.");
        //         "Staff No." := UserSetup."Employee No.";
        //         Commit;
        //         "Salary Scale" := GetSalaryScale("Staff No.");
        //         "Responsibility Center" := UserSetup."User Responsibility Center";
        //     end;
        // end;
    end;

    local procedure CheckPendingDocs(PayType: Option "Payment Voucher",Imprest,"Staff Claim","Imprest Surrender","Petty Cash","Bank Transfer","Petty Cash Surrender",Receipt,"Staff Advance"; MaxNo: Integer)
    begin
        // PaymentRec.Reset;
        // PaymentRec.SetRange("Payment Type", PayType);
        // PaymentRec.SetRange(Cashier, UserId);
        // PaymentRec.SetFilter(Status, '%1', PaymentRec.Status::Open);
        // if PaymentRec.Count > MaxNo then
        //     Error(MultiDocError);
    end;

    local procedure CheckPendingDocs2(PayType: Option "Payment Voucher",Imprest,"Staff Claim","Imprest Surrender","Petty Cash","Bank Transfer","Petty Cash Surrender",Receipt,"Staff Advance"; MaxNo: Integer)
    begin
        PaymentRec.Reset;
        PaymentRec.SetRange("Payment Type", PayType);
        PaymentRec.SetRange(Cashier, UserId);
        PaymentRec.SetFilter(Status, '%1', PaymentRec.Status::Open);
        if PaymentRec.Count >= 1 then Error(MultiDocError);
    end;

    local procedure GetStaffNo(UserCode: Code[50]): Code[50]
    var
        Users: Record "User Setup";
    begin
        if Users.Get(UserCode) then begin
            "Staff No." := Users."Employee No.";
            exit(Users."Employee No.");
        end;
    end;

    local procedure CheckUnsurrenderedDoc(PayType: Option "Payment Voucher",Imprest,"Staff Claim","Imprest Surrender","Petty Cash","Bank Transfer","Petty Cash Surrender",Receipt,"Staff Advance"; StaffNo: Code[50])
    var
        MaxNo: Integer;
        CashSetup: Record "Cash Management Setups";
    begin
        // if GuiAllowed then begin
        //     MaxNo := GetJobGroupImprests(StaffNo);
        //     PaymentRec.Reset;
        //     PaymentRec.SetRange("Payment Type", PayType);
        //     PaymentRec.SetRange(Posted, true);
        //     PaymentRec.SetRange(Surrendered, false);
        //     PaymentRec.SetRange(Cashier, UserId);
        //     if PaymentRec.Count >= MaxNo then
        //         Error(AccountError, Format("Payment Type"));
        // end;
    end;

    local procedure GetJobGroupImprests(StaffNo: Code[50]): Integer
    var
        Employee: Record Employee;
        SalaryScale: Record "Salary Scale";
    begin
        // if Employee.Get(StaffNo) then begin
        //     Employee.TestField("Salary Scale");
        //     SalaryScale.Reset;
        //     SalaryScale.SetRange(Scale, Employee."Salary Scale");
        //     if SalaryScale.FindFirst then;
        //     SalaryScale.TestField("Max Imprest");
        //     exit(SalaryScale."Max Imprest");
        // end else
        //     Error('Staff No. does not exist');
    end;

    local procedure HasImprestAccountBalance(AcNo: Code[50]): Boolean
    var
        CustRec: Record Customer;
    begin
        if CustRec.Get(AcNo) then begin
            CustRec.CalcFields("Balance (LCY)");
            ImpBalance := CustRec."Balance (LCY)";
            if CustRec."Balance (LCY)" > 0 then exit(true);
            exit(false);
        end;
    end;

    local procedure GetSalaryScale(StaffNo: Code[50]): Code[10]
    var
        Employee: Record Employee;
        SalaryScale: Record "Salary Scale";
    begin
        if Employee.Get(StaffNo) then begin
            Employee.TestField("Salary Scale");
            exit(Employee."Salary Scale");
        end
        else
            Error('Staff %1 does not exist', StaffNo);
    end;

    local procedure CheckIfSurrenderExists(SurrenderDoc: Code[50])
    begin
        PaymentRec.Reset();
        PaymentRec.SetRange("Payment Type", PaymentRec."Payment Type"::"Imprest Surrender");
        PaymentRec.SetRange("Imprest Issue Doc. No", SurrenderDoc);
        PaymentRec.setfilter("No.", '<>%1', "No.");
        if PaymentRec.FindFirst then Error(SurrExistsError, SurrenderDoc, PaymentRec."No.");
    end;

    procedure ConfirmFundsReceipt()
    begin
        if GuiAllowed then
            if Confirm('Are you sure you want to confirm Funds Receipt?', false) then begin
                TestField("Created By", UserId);
                if GuiAllowed then if "Confirm Receipt" = true then Error('You cannot confirm more than once');
                "Confirm Receipt" := true;
                "Confirm Receipt User" := UserId;
                "Confirm Receipt Date-Time" := CurrentDateTime;
                Modify();
            end;
    end;

    procedure ConfirmFundsReceipt2()
    begin
        TestField("Created By", "User ID");
        "Confirm Receipt" := true;
        "Confirm Receipt User" := UserId;
        "Confirm Receipt Date-Time" := CurrentDateTime;
        Modify();
    end;

    procedure GetNextLineNo(): Integer
    var
        paymentlines: Record "Payment Lines";
    begin
        paymentlines.RESET;
        paymentlines.SETRANGE(paymentlines.No, "No.");
        IF paymentlines.FINDLAST THEN
            EXIT(paymentlines."Line No" + 10000)
        ELSE
            EXIT(10000);
    END;

    procedure GetExtNextLineNo(): Integer
    var
        Extpaymentlines: Record "Ext Payment Lines";
    begin
        Extpaymentlines.RESET;
        Extpaymentlines.SETRANGE(Extpaymentlines.No, "No.");
        IF Extpaymentlines.FINDLAST THEN
            EXIT(Extpaymentlines."Line No" + 10000)
        ELSE
            EXIT(10000);
    END;

    procedure CheckRejectionComment(PaymentType: Enum "Payment Type"; DocumentNo: Code[20]): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalComment: Record "Approval Comment Line";
        RecRef: RecordRef;
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetCurrentKey("Last Date-Time Modified");
        ApprovalEntry.SetRange("Table ID", Database::Payments);
        ApprovalEntry.SetRange("Document No.", DocumentNo);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Rejected);
        case PaymentType of
            PaymentType::"Payment Voucher":
                ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Payment Voucher");
        end;
        if ApprovalEntry.FindLast() then begin
            ApprovalEntry.CalcFields(Comment);
            if ApprovalEntry.Comment then
                exit(false)
            else
                exit(true);
        end;
        exit(false);
    end;
    //Procedure to check whether is Open or Pending Imprest()
    procedure CheckingStatus(ImprestRec: Record Payments)
    var
        UnImprest: Record Payments;
    begin
        UnImprest.Reset();
        //  UnImprest.SetRange("User Id", ImprestRec."User Id");
        UnImprest.SetRange("Account No.", ImprestRec."Account No.");
        UnImprest.SetRange("Payment Type", UnImprest."Payment Type"::Imprest);
        UnImprest.SetRange(Status, UnImprest.Status::"Pending Approval");
        if UnImprest.FindFirst() then begin
            Error('You still have %1 Imprest. You cannot apply for another one.', UnImprest.Status);
        end;
    end;

    procedure CheckPendingSurrenderImp(AppImprest: Record Payments)
    var
        Imprest: Record Payments;
        Txt0002: Label 'You still have unsurrended Imprest for date %1 with Imprest Amount %2. You cannot apply for another one until You Surrender the Previous Imprest';
    begin
        Imprest.Reset();
        Imprest.SetRange("Account No.", AppImprest."Account No.");
        // Imprest.SetRange("User Id", AppImprest."User Id");
        Imprest.SetRange("Payment Type", Imprest."Payment Type"::Imprest);
        Imprest.SetRange(Surrendered, false);
        if Imprest.FindFirst() then begin
            Imprest.CalcFields("Imprest Amount");
            if Imprest."Imprest Amount" <= 0 then begin
                Error(Txt0002, Imprest."Date of Project", Imprest."Imprest Amount");
            end;
        end;
    end;
}

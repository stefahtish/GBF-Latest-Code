table 50460 "Payments Header"
{
    DataCaptionFields = "No.", Payee;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Non';
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    //  GenLedgerSetup.GET;
                    NoSeriesMgt.TestManual("No. Series");
                    "No. Series":='';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';

            trigger OnValidate()
            begin
            /*IF PayLinesExist THEN BEGIN
                ERROR('You first need to delete the existing Payment lines before changing the Currency Code'
                );
                END ELSE BEGIN
                   "Paying Bank Account":='';
                   VALIDATE("Paying Bank Account");
                END;
                IF  "Currency Code" = xRec."Currency Code" THEN
                  UpdateCurrencyFactor;
                
                IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                    UpdateCurrencyFactor;
                  END ELSE
                    IF "Currency Code" <> '' THEN
                      UpdateCurrencyFactor;*/
            //Update Payment Lines
            //   UpdateLines();
            end;
        }
        field(3; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0: 15;
            Editable = false;
            MinValue = 0;
        }
        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Description = 'Check Filter';
            TableRelation = Currency WHERE("EMU Currency"=FILTER(false));

            trigger OnValidate()
            begin
                /* if PayLinesExist then begin
                     //ERROR('You first need to delete the existing Payment lines before changing the Currency Code');
                 end else begin
                     "Paying Bank Account" := '';
                     Validate("Paying Bank Account");
                 end;
                 if "Currency Code" = xRec."Currency Code" then
                     UpdateCurrencyFactor;

                 if "Currency Code" <> xRec."Currency Code" then begin
                     UpdateCurrencyFactor;
                 end else
                     if "Currency Code" <> '' then
                         UpdateCurrencyFactor;
 */
                //Update Payment Lines
                UpdateLines();
            end;
        }
        field(9; Payee; Text[100])
        {
            Caption = 'Bénéficiaire';
            Description = 'Stores the name of the person who received the money';
        }
        field(10; "Payment Notification Message"; Text[100])
        {
            Caption = 'Message de notification de paiement';
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';

            trigger OnValidate()
            begin
                //update lines
                PayLine.Reset;
                PayLine.SetRange(PayLine.No, "No.");
                if PayLine.FindSet then PayLine.ModifyAll(PayLine."Payment Notification Message", "Payment Notification Message", true);
            end;
        }
        field(11; Cashier; Code[50])
        {
            Caption = 'caissier';
            Description = 'Stores the identifier of the cashier in the database';

            trigger OnValidate()
            begin
            /*
                 UserDept.RESET;
                UserDept.SETRANGE(UserDept.UserID,Cashier);
                IF UserDept.FIND('-') THEN
                  //"Global Dimension 1 Code":=UserDept.Department;
                */
            end;
        }
        field(16; Posted; Boolean)
        {
            Caption = 'Publié';
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(17; "Date Posted"; Date)
        {
            Caption = 'date de publication';
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(18; "Time Posted"; Time)
        {
            Caption = 'Heure de publication';
            Description = 'Stores the time when the payment voucher was posted';
        }
        field(19; "Posted By"; Code[50])
        {
            Caption = 'Posté par';
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(20; "Total Payment Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line".Amount WHERE(No=FIELD("No.")));
            Caption = 'Montant total du paiement';
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            Caption = 'compte bancaire payant';
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAcc.Reset;
                "Bank Name":='';
                if BankAcc.Get("Paying Bank Account")then begin
                    // if "Pay Mode" = "Pay Mode"::Cash then begin
                    //     if BankAcc."Bank Type" <> BankAcc."Bank Type"::Cash then
                    //         Error('This Payment can only be made against Banks Handling Cash');
                    // end;
                    "Bank Name":=BankAcc.Name;
                    "Paying Bank Acc No":=BankAcc."Bank Account No.";
                //"Currency Code":=BankAcc."Currency Code";
                // VALIDATE("Currency Code");
                end;
                PLine.Reset;
                PLine.SetRange(PLine.No, "No.");
                PLine.SetRange(PLine."Account Type", PLine."Account Type"::"Bank Account");
                PLine.SetRange(PLine."Account No.", "Paying Bank Account");
                if PLine.FindFirst then;
                //ERROR(Text002);
                PLine.Reset;
                PLine.SetRange(PLine.No, "No.");
                if PLine.Find('-')then repeat PLine."Paying Bank Account":="Paying Bank Account";
                        if BankAcc.Get("Paying Bank Account")then begin
                            PLine."Bank Sort Code":=BankAcc."Sort Code";
                            PLine."Paying Bank Acc No":=BankAcc."Bank Account No.";
                        end;
                        PLine.Modify;
                    until PLine.Next = 0;
            end;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-')then "Function Name":=DimVal.Name;
            //UpdateLines;
            //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(35; Status; Option)
        {
            Caption = 'Statut';
            Description = 'Stores the status of the record in the database';
            Editable = true;
            OptionCaption = 'Pending,1st Approval,2nd Approval,Cheque Printing,Posted,Cancelled,Checking,VoteBook,Pending Approval,Approved,Rejected';
            OptionMembers = Pending, "1st Approval", "2nd Approval", "Cheque Printing", Posted, Cancelled, Checking, VoteBook, "Pending Approval", Approved, Rejected;
        }
        field(38; "Payment Type"; Option)
        {
            Caption = 'Type de paiement';
            OptionMembers = Normal, "Petty Cash", Express;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-')then "Budget Center Name":=DimVal.Name;
            //UpdateLines;
            //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            Caption = 'Nom de la fonction';
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[100])
        {
            Caption = 'Nom du centre budgétaire';
            Description = 'Stores the name of the budget center in the database';
        }
        field(59; "Bank Name"; Text[100])
        {
            Caption = 'Nom de la banque';
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61; Select; Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(62; "Total VAT Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."VAT Amount LCY" WHERE(No=FIELD("No.")));
            Caption = 'Montant total de la TVA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Withholding Tax Amount LCY" WHERE(No=FIELD("No.")));
            Caption = 'Montant total de l''impôt à retenir';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Total Net Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Net Amount" WHERE(No=FIELD("No.")));
            Caption = 'Montant net total';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Current Status"; Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(66; "Cheque No."; Code[20])
        {
            Caption = 'Numero de cheque';
        }
        field(67; "Pay Mode"; Option)
        {
            Caption = 'Mode de paiement';
            OptionCaption = ' ,Cash,Cheque,Electronic Funds Transfer,Payment Instruction,Custom 3,Custom 4,Custom 5';
            OptionMembers = " ", Cash, Cheque, "Electronic Funds Transfer", "Payment Instruction", "Custom 3", "Custom 4", "Custom 5";
        }
        field(68; "Payment Release Date"; Date)
        {
            Caption = 'Date de sortie du paiement';

            trigger OnValidate()
            begin
            //Changed to ensure Release date is not less than the Date entered
            /* IF "Payment Release Date"<Date THEN
                    ERROR('The Payment Release Date cannot be lesser than the Document Date');
                */
            end;
        }
        field(69; "No. Printed"; Integer)
        {
        }
        field(70; "VAT Base Amount"; Decimal)
        {
            Caption = 'Montant de base de la TVA';
        }
        field(71; "Exchange Rate"; Decimal)
        {
        }
        field(72; "Currency Reciprical"; Decimal)
        {
        }
        field(73; "Current Source A/C Bal."; Decimal)
        {
        }
        field(74; "Cancellation Remarks"; Text[250])
        {
        }
        field(75; "Register Number"; Integer)
        {
        }
        field(76; "From Entry No."; Integer)
        {
        }
        field(77; "To Entry No."; Integer)
        {
        }
        field(78; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(79; "Total Payment Amount LCY"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."NetAmount LCY" WHERE(No=FIELD("No.")));
            Caption = 'Montant total du paiement local';
            FieldClass = FlowField;
        }
        field(80; "Document Type"; Option)
        {
            OptionMembers = "Payment Voucher", "Petty Cash";
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-')then Dim3:=DimVal.Name end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-')then Dim4:=DimVal.Name end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';

            //  TableRelation = "Responsibility Center BR";
            trigger OnValidate()
            begin
                //TESTFIELD(Status,Status::Pending);
                if PayLinesExist then begin
                //ERROR('You first need to delete the existing Payment lines before changing the Responsibility Center');
                end
                else
                begin
                    //"Currency Code":='';
                    Validate("Currency Code");
                    "Paying Bank Account":='';
                    Validate("Paying Bank Account");
                end;
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
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
            end;
        }
        field(86; "Cheque Type"; Option)
        {
            Caption = 'Vérifier le type';
            OptionMembers = " ", "Computer Check", "Manual Check";
        }
        field(87; "Total Retention Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Retention  Amount" WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(88; "Payment Narration"; Text[250])
        {
            Caption = 'Narration de paiement';

            trigger OnValidate()
            begin
                //update lines
                PayLine.Reset;
                PayLine.SetRange(PayLine.No, "No.");
                if PayLine.FindSet then PayLine.ModifyAll(PayLine.Narration, "Payment Narration", true);
            end;
        }
        field(100; "Invoice No"; Code[20])
        {
            Description = 'Holds The Purchase invoice number if it is related to purch invoice, does not post';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions end;
        }
        field(481; "External Doc No"; Code[20])
        {
            Caption = 'numero  externe du doc';
        }
        field(482; "Intercompany Transaction"; Boolean)
        {
            Caption = 'Transaction intersociétés';
        }
        field(483; "Target Base"; Option)
        {
            OptionCaption = 'General,Vendor';
            OptionMembers = General, Vendor;
        }
        field(484; "EFT Batch No."; Code[20])
        {
            Caption = 'numero de groupe EFT';
        //TableRelation = "EFT Header".No WHERE(Transferred = CONST(false),
        //                                     "Bank  No" = FIELD("Paying Bank Account"));
        }
        field(485; "Paying Bank Acc No"; Code[50])
        {
            Caption = 'numero du compte bancaire payant';
        }
        field(486; "System Date"; Date)
        {
            FieldClass = Normal;
        }
        field(487; "Last Approved Date"; DateTime)
        {
            CalcFormula = Max("Approval Entry"."Last Date-Time Modified" WHERE("Document No."=FIELD("No.")));
            Caption = 'Date de la dernière approbation';
            FieldClass = FlowField;
        }
        field(488; "Last Approver"; Code[30])
        {
            Caption = 'Dernier approbateur';
        }
        field(489; "Gl Account"; Code[20])
        {
            CalcFormula = Lookup("Payment Line"."Account No." WHERE(No=FIELD("No.")));
            FieldClass = FlowField;
            TableRelation = "Payment Line";
        }
        field(490; "Mail Sent"; Boolean)
        {
        }
        field(491; "Payment For"; Option)
        {
            Caption = 'Paiement pour';
            OptionCaption = ',Customer,Vendor,Staff,Others';
            OptionMembers = , Customer, Vendor, Staff, Others;

            trigger OnValidate()
            begin
                PayLine.Reset;
                PayLine.SetRange(PayLine.No, "No.");
                if PayLine.FindSet then PayLine.ModifyAll(PayLine."Payment For", "Payment For", true);
            end;
        }
        field(492; "Pure claim No"; Code[30])
        {
        }
        field(493; "Final Approval Date"; Date)
        {
            Caption = 'Date d''approbation finale';
        }
        field(494; "In Gl"; Code[20])
        {
            CalcFormula = Lookup("G/L Entry"."Document No." WHERE("Document No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(495; "Expense Budget For The Month"; Decimal)
        {
        }
        field(496; "Expense Actual For the Month"; Decimal)
        {
        }
        field(497; "Expense Budget Year Till Date"; Decimal)
        {
        }
        field(498; "Expense Actual Year TIll Date"; Decimal)
        {
        }
        field(500; Type; Code[50])
        {
            CalcFormula = Lookup("Payment Line".Type WHERE(No=FIELD("No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Responsibility Center")
        {
        }
        key(Key3; Status, "No.")
        {
        }
        key(Key4; "Responsibility Center", "Global Dimension 1 Code")
        {
        }
        key(Key5; "External Doc No")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if(Status = Status::Approved) or (Status = Status::Posted) or (Status = Status::"Pending Approval")then Error('You Cannot Delete this record');
    end;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            GenLedgerSetup.Get;
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "No.", "No. Series");
        //NoSeriesMgt.InitSeries(GenLedgerSetup."Petty Cash Payments No",xRec."No. Series",0D,"No.","No. Series");
        end;
        UserTemplate.Reset;
        UserTemplate.SetRange(UserTemplate.UserID, UserId);
        if UserTemplate.FindFirst then begin
            if "Payment Type" = "Payment Type"::"Petty Cash" then begin
            //UserTemplate.TESTFIELD(UserTemplate."Default Petty Cash Bank");
            // "Paying Bank Account":=UserTemplate."Default Petty Cash Bank";
            end
            else
            begin
                "Paying Bank Account":=UserTemplate."Default Payment Bank";
            end;
            Validate("Paying Bank Account");
        end;
        Date:=Today;
        Cashier:=UserId;
        Validate(Cashier);
        "System Date":=Today;
    end;
    trigger OnModify()
    begin
        if Status = Status::Pending then UpdateLines();
    /*IF (Status=Status::Approved) OR (Status=Status::Posted) THEN
           ERROR('You Cannot modify an already approved/posted document');*/
    end;
    var CStatus: Code[20];
    //PVUsers: Record "CshMgt PV Steps Users";
    UserTemplate: Record "Cash Office User Template";
    GLAcc: Record "G/L Account";
    Cust: Record Customer;
    Vend: Record Vendor;
    FA: Record "Fixed Asset";
    BankAcc: Record "Bank Account";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    GenLedgerSetup: Record "Cash Office Setup";
    RecPayTypes: Record "Receipts and Payment Types";
    CashierLinks: Record "Cashier Link";
    GLAccount: Record "G/L Account";
    EntryNo: Integer;
    SingleMonth: Boolean;
    DateFrom: Date;
    DateTo: Date;
    Budget: Decimal;
    CurrMonth: Code[10];
    CurrYR: Code[10];
    BudgDate: Text[30];
    BudgetDate: Date;
    YrBudget: Decimal;
    BudgetDateTo: Date;
    BudgetAvailable: Decimal;
    GenLedSetup: Record "General Ledger Setup";
    "Total Budget": Decimal;
    CommittedAmount: Decimal;
    MonthBudget: Decimal;
    Expenses: Decimal;
    Header: Text[250];
    "Date From": Text[30];
    "Date To": Text[30];
    LastDay: Date;
    TotAmt: Decimal;
    DimVal: Record "Dimension Value";
    //PVSteps: Record "CshMgt PV Process Road";
    PLine: Record "Payment Line";
    // RespCenter: Record "Responsibility Center BR";
    UserMgt: Codeunit "User Setup Management BR";
    Text001: Label 'Your identification is set up to process from %1 %2 only.';
    CurrExchRate: Record "Currency Exchange Rate";
    PayLine: Record "Payment Line";
    Text002: Label 'There is an Account number on the  payment lines the same as Paying Bank Account you are trying to select.';
    DimMgt: Codeunit DimensionManagement;
    GLBudgetEntry: Record "G/L Budget Entry";
    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate:=Date;
            "Currency Factor":=CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end
        else
            "Currency Factor":=0;
    end;
    procedure UpdateLines()
    begin
        PLine.Reset;
        PLine.SetRange(PLine.No, "No.");
        if PLine.FindFirst then begin
            repeat PLine."Global Dimension 1 Code":="Global Dimension 1 Code";
                PLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                PLine."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
                PLine."Shortcut Dimension 4 Code":="Shortcut Dimension 4 Code";
                PLine."Currency Code":="Currency Code";
                PLine."Currency Factor":="Currency Factor";
                PLine."Paying Bank Account":="Paying Bank Account";
                PayLine."Payment Type":="Payment Type";
                PLine.Validate("Currency Factor");
                PLine.Modify;
            until PLine.Next = 0;
        end;
    end;
    procedure PayLinesExist(): Boolean begin
        PayLine.Reset;
        PayLine.SetRange("Payment Type", "Payment Type");
        PayLine.SetRange(No, "No.");
        exit(PayLine.FindFirst);
    end;
    local procedure TestNoSeries(): Boolean begin
        if "Payment Type" = "Payment Type"::"Petty Cash" then GenLedgerSetup.TestField(GenLedgerSetup."Petty Cash Payments No")
        else if "Payment Type" = "Payment Type"::Express then GenLedgerSetup.TestField(GenLedgerSetup."Payment Request Nos")
            else
                GenLedgerSetup.TestField(GenLedgerSetup."Normal Payments No");
    end;
    local procedure GetNoSeriesCode(): Code[10]var
        NoSeriesCode: Code[20];
    begin
        if "Payment Type" = "Payment Type"::"Petty Cash" then NoSeriesCode:=GenLedgerSetup."Petty Cash Payments No"
        else if "Payment Type" = "Payment Type"::Express then NoSeriesCode:=GenLedgerSetup."Payment Request Nos"
            else
                NoSeriesCode:=GenLedgerSetup."Normal Payments No";
        exit(GetNoSeriesRelCode(NoSeriesCode));
    end;
    procedure ShowDimensions()
    begin
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Payments', "No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8]of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
    procedure GetNoSeriesRelCode(NoSeriesCode: Code[20]): Code[10]var
        GenLedgerSetup: Record "General Ledger Setup";
        //RespCenter: Record "Responsibility Center BR";
        DimMgt: Codeunit DimensionManagement;
        NoSrsRel: Record "No. Series Relationship";
    begin
    /*EXIT(GetNoSeriesRelCode(NoSeriesCode));
        GenLedgerSetup.Get;
        case GenLedgerSetup."Base No. Series" of
            GenLedgerSetup."Base No. Series"::"Responsibility Center":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Responsibility Center");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 1":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Global Dimension 1 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 2":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Shortcut Dimension 2 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 3":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Shortcut Dimension 3 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 4":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Shortcut Dimension 4 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            else
                exit(NoSeriesCode);*/
    //  end;
    end;
}

table 50461 "Receipts Header"
{
    Caption = 'Receipts Header';
    DrillDownPageID = "Receipt List";
    LookupPageID = "Receipt List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the code of the receipt in the database';

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
            Description = 'Stores the date when the receipt was entered into the system';
        }
        field(3; Cashier; Code[50])
        {
            Description = 'Stores the user id of the cashier';
        }
        field(4; "Date Posted"; Date)
        {
        }
        field(5; "Time Posted"; Time)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /*
                IF PayLinesExist THEN BEGIN
                ERROR('You first need to delete the existing Receipt lines before changing the Currency Code'
                );
                
                END;
                */
                if BankAcc.Get("Bank Code")then "Bank Name":=BankAcc.Name;
            end;
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; "Amount Received"; Decimal)
        {
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-')then "Dim 1 Name":=DimVal.Name;
                UpdateLines;
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-')then "Dim 2 Name":=DimVal.Name;
                UpdateLines;
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if PayLinesExist then begin
                    Error('You first need to delete the existing Payment lines before changing the Currency Code');
                end
                else
                begin
                    "Bank Code":='';
                end;
                /*IF  "Currency Code" = xRec."Currency Code" THEN
                  UpdateCurrencyFactor;
                
                IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                    UpdateCurrencyFactor;
                  END ELSE
                    */
                if "Currency Code" <> '' then UpdateCurrencyFactor;
                //Update Receipt Lines
                UpdateLines();
            end;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0: 15;
            Editable = true;
            MinValue = 0;
        }
        field(38; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Receipt Line".Amount WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Posted By"; Code[50])
        {
        }
        field(40; "Print No."; Integer)
        {
        }
        field(41; Status; Option)
        {
            OptionMembers = " ", Normal, "Post Dated", Posted, Partial, "Pending Approval", Approved, Cancelled;
        }
        field(42; "Cheque No."; Code[20])
        {
        }
        field(43; "No. Printed"; Integer)
        {
        }
        field(44; "Created By"; Code[50])
        {
        }
        field(45; "Created Date Time"; DateTime)
        {
        }
        field(46; "Register No."; Integer)
        {
        }
        field(47; "From Entry No."; Integer)
        {
        }
        field(48; "To Entry No."; Integer)
        {
        }
        field(49; "Document Date"; Date)
        {
        }
        field(81; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';

            //   TableRelation = "Responsibility Center BR";
            trigger OnValidate()
            begin
                //TESTFIELD(Status,Status::"Pending Approval");
                /*IF PayLinesExist THEN BEGIN
                  ERROR('You first need to delete the existing Payment lines before changing the Responsibility Center');
                END ELSE BEGIN
                  "Currency Code":='';
                  VALIDATE("Currency Code");
                  "Bank Code":='';
                END;
                */
                TestField(Status, Status::" ");
            /* if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                  Error(
                    Text001,
                    RespCenter.TableCaption, UserMgt.GetPurchasesFilter);

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
        field(83; "Shortcut Dimension 3 Code"; Code[20])
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
        field(84; "Shortcut Dimension 4 Code"; Code[20])
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
        field(86; Dim3; Text[250])
        {
        }
        field(87; Dim4; Text[250])
        {
        }
        field(88; "Bank Name"; Text[250])
        {
        }
        field(89; "Receipt Type"; Option)
        {
            Description = 'CRDNAV';
            OptionCaption = 'Bank,Cash,Loan/Lease';
            OptionMembers = Bank, Cash, "Loan/Lease";
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
        field(69009; Bank; Text[30])
        {
        }
        field(69010; Branch; Text[30])
        {
        }
        field(69011; "Dim 1 Name"; Text[100])
        {
        }
        field(69012; "Dim 2 Name"; Text[100])
        {
        }
        field(69013; "Cheque Date"; Date)
        {
        }
        field(69014; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT,Deposit Slip,Banker''s Cheque,Debit/Credit Card';
            OptionMembers = " ", Cash, Cheque, EFT, "Deposit Slip", "Banker's Cheque", "Debit/Credit Card";

            trigger OnValidate()
            begin
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get();
            /*IF "Pay Mode"="Pay Mode"::"Deposit Slip" THEN
                  BEGIN
                    "Bank Account":=GenLedgerSetup."Default Bank Deposit Slip A/C";
                  END; */
            end;
        }
        field(69015; "Receipt Narration"; Text[100])
        {
        }
        field(69016; "Net Amount"; Decimal)
        {
            CalcFormula = Sum("Receipt Line"."Net Amount" WHERE(No=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(69017; "Net Amount LCY"; Decimal)
        {
            CalcFormula = Sum("Receipt Line".NetAmountLCY WHERE(No=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(69018; "Loan No."; Code[10])
        {
            CalcFormula = Lookup("Receipt Line"."Loan No" WHERE(No=FIELD("No.")));
            Description = 'CRDNAV';
            FieldClass = FlowField;
        }
        field(69019; "Loan Product Type"; Code[20])
        {
            CalcFormula = Lookup("Receipt Line"."Loan Product Type" WHERE(No=FIELD("No.")));
            Description = 'CRDNAV';
            FieldClass = FlowField;
        }
        field(69020; "Manual Posting"; Boolean)
        {
            Description = 'CRDNAV';
        }
        field(69021; "G/L Account"; Code[20])
        {
            CalcFormula = Lookup("Receipt Line"."Account No." WHERE(No=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(69022; "Loan Repayment Date"; Date)
        {
            //   TableRelation = "Loan Repayment Schedule"."Repayment Date" WHERE("Loan No." = FIELD("Loan No."));
            trigger OnValidate()
            begin
            /*   LRS.SetRange(LRS."Loan No.", "Loan No.");
                   LRS.SetRange(LRS."Repayment Date", "Loan Repayment Date");
                   if LRS.FindFirst then
                       "Principal Repayment" := LRS."Principal Repayment";
                       */
            end;
        }
        field(69023; "Principal Repayment"; Decimal)
        {
        }
        field(69024; "Loan Repayment no"; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Posted then Error('You Cannot Delete this record');
        RLine.SetRange(RLine.No, "No.");
        if RLine.FindFirst then repeat RLine.Delete;
            until RLine.Next = 0;
    end;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            GenLedgerSetup.Get;
            TestNoSeries;
            //  NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series",0D,"No.","No. Series");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Receipts No", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Cashier:=UserId;
        /*UserTemplate.RESET;
        UserTemplate.SETRANGE(UserTemplate.UserID,USERID);
        IF UserTemplate.FINDFIRST THEN
          BEGIN
            //"Bank Code":=UserTemplate."Default Receipts Bank";
            //VALIDATE("Bank Code");
            Cashier:=USERID;
          END;
        //*****************************JACK**************************/
        "Created By":=USERID;
        "Created Date Time":=CREATEDATETIME(TODAY, TIME);
        //*****************************END***************************//
        "Document Date":=TODAY;
        IF Usersetup.GET(USERID)THEN BEGIN
            //  "Global Dimension 1 Code" := Usersetup."Global Dimension 1 Code";
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Global Dimension No.", 1);
            DimVal.SETRANGE(DimVal.Code, "Global Dimension 1 Code");
            IF DimVal.FIND('-')THEN "Dim 1 Name":=DimVal.Name;
            //"Shortcut Dimension 2 Code" := Usersetup."Shortcut Dimension 2 Code";
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
            DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
            IF DimVal.FIND('-')THEN "Dim 2 Name":=DimVal.Name;
            //"Shortcut Dimension 3 Code" := Usersetup."Shortcut Dimension 3 Code";
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Global Dimension No.", 3);
            DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 3 Code");
            IF DimVal.FIND('-')THEN Dim3:=DimVal.Name;
        END;
    end;
    var GenLedgerSetup: Record "Cash Office Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserTemplate: Record "Cash Office User Template";
    RLine: Record "Receipt Line";
    //RespCenter: Record "Responsibility Center BR";
    UserMgt: Codeunit "User Setup Management BR";
    Text001: Label 'Your identification is set up to process from %1 %2 only.';
    DimVal: Record "Dimension Value";
    BankAcc: Record "Bank Account";
    DimMgt: Codeunit DimensionManagement;
    Usersetup: Record "User Setup";
    CurrExchRate: Record "Currency Exchange Rate";
    //LRS: Record "Loan Repayment Schedule";
    procedure PayLinesExist(): Boolean begin
        RLine.Reset;
        RLine.SetRange(RLine.No, "No.");
        exit(RLine.FindFirst);
    end;
    local procedure TestNoSeries(): Boolean begin
        if "Receipt Type" = "Receipt Type"::Bank then GenLedgerSetup.TestField(GenLedgerSetup."Receipts No")
        else
            GenLedgerSetup.TestField(GenLedgerSetup."Cash Receipt Nos")end;
    local procedure GetNoSeriesCode(): Code[10]var
        NoSrsRel: Record "No. Series Relationship";
        NoSeriesCode: Code[20];
    begin
        if "Receipt Type" = "Receipt Type"::Bank then NoSeriesCode:=GenLedgerSetup."Receipts No"
        else
            NoSeriesCode:=GenLedgerSetup."Cash Receipt Nos";
        exit(GetNoSeriesRelCode(NoSeriesCode));
    /*
        NoSrsRel.SETRANGE(NoSrsRel.Code,NoSeriesCode);
        NoSrsRel.SETRANGE(NoSrsRel."Responsibility Center","Responsibility Center");
        
        IF NoSrsRel.FINDFIRST THEN
        EXIT(NoSrsRel."Series Code")
        ELSE
        EXIT(NoSeriesCode);
        
        IF NoSrsRel.FINDSET THEN BEGIN
          IF PAGE.RUNMODAL(458,NoSrsRel,NoSrsRel."Series Code") = ACTION::LookupOK THEN
          EXIT(NoSrsRel."Series Code")
        END
        ELSE
        EXIT(NoSeriesCode);
        */
    end;
    procedure ShowDimensions()
    begin
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Receipt', "No."));
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
        //  RespCenter: Record "Responsibility Center BR";
        DimMgt: Codeunit DimensionManagement;
        NoSrsRel: Record "No. Series Relationship";
    begin
        //EXIT(GetNoSeriesRelCode(NoSeriesCode));
        GenLedgerSetup.Get;
    /* case GenLedgerSetup."Base No. Series" of
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
                 exit(NoSeriesCode);
         end;
         */
    end;
    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        "Currency Factor":=0;
        if "Currency Code" <> '' then begin
            CurrencyDate:=Date;
            "Currency Factor":=CurrExchRate.ExchangeRate(Date, "Currency Code");
        end
        else
            "Currency Factor":=0;
    end;
    procedure UpdateLines()
    begin
        RLine.Reset;
        RLine.SetRange(RLine.No, "No.");
        if RLine.FindFirst then begin
            repeat RLine."Global Dimension 1 Code":="Global Dimension 1 Code";
                RLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                RLine."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
                RLine."Shortcut Dimension 4 Code":="Shortcut Dimension 4 Code";
                RLine.Validate("Currency Factor", "Currency Factor");
                RLine."Bank Code":="Bank Code";
                RLine.Validate("Currency Code", "Currency Code");
                //RLine.VALIDATE("Currency Factor");
                RLine.Modify;
            until RLine.Next = 0;
        end;
    end;
}

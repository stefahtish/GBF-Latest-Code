codeunit 50106 Committment
{
    trigger OnRun()
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
    end;
    var UncommittmentDate: Date;
    HasGotGLSetup: Boolean;
    GLSetupShortcutDimCode: array[8]of Code[20];
    GeneralLedgerSetup: Record "General Ledger Setup";
    Payments: Record Payments;
    procedure LPOCommittment(var PurchHeader: Record "Purchase Header"; var ErrorMsg: Text)
    var
        PurchaseLines: Record "Purchase Line";
        Committments: Record "Commitment Entries";
        Item: Record Item;
        GLAccount: Record "G/L Account";
        FixedAsset: Record "Fixed Asset";
        EntryNo: Integer;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        GenLedSetup: Record "General Ledger Setup";
        InventoryAccount: Code[20];
        AcquisitionAccount: Code[20];
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        CommittedAmount: Decimal;
        Vendor: Record Vendor;
        DisbursedAmount: Decimal;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        PurchaseLines.Reset;
        PurchaseLines.SetRange(PurchaseLines."Document No.", PurchHeader."No.");
        PurchaseLines.SetRange(PurchaseLines."Document Type", PurchaseLines."Document Type"::Order);
        if PurchaseLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(GetLPOAccountNo(PurchaseLines))then begin
                    Committments.Init;
                    Committments."Commitment No":=PurchHeader."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::LPO;
                    PurchHeader.Validate("Order Date");
                    if PurchHeader."Order Date" = 0D then Error('Please enter the order date');
                    Committments."Commitment Date":=PurchHeader."Order Date";
                    Committments."Global Dimension 1":=PurchaseLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PurchaseLines."Shortcut Dimension 2 Code";
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchaseLines.Type of PurchaseLines.Type::Item: begin
                        Item.Reset;
                        if Item.Get(PurchaseLines."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                        InventoryPostingSetup.Get(PurchaseLines."Location Code", Item."Inventory Posting Group");
                        //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                        Item.TestField("Item G/L Budget Account");
                        InventoryAccount:=Item."Item G/L Budget Account";
                        Committments.Account:=InventoryAccount;
                    end;
                    PurchaseLines.Type::"G/L Account": begin
                        Committments.Account:=PurchaseLines."No.";
                    end;
                    PurchaseLines.Type::"Fixed Asset": begin
                        if FixedAssetPG.Get(PurchaseLines."Posting Group")then begin
                            FixedAssetPG.TestField("Acquisition Cost Account");
                            AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                            Committments.Account:=AcquisitionAccount;
                        end;
                    end;
                    end;
                    Committments."Committed Amount":=PurchaseLines."Amount Including VAT";
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    case PurchaseLines.Type of PurchaseLines.Type::Item: begin
                        GLAccount.SetRange(GLAccount."No.", InventoryAccount);
                    end;
                    PurchaseLines.Type::"G/L Account": begin
                        GLAccount.SetRange(GLAccount."No.", PurchaseLines."No.");
                    end;
                    PurchaseLines.Type::"Fixed Asset": GLAccount.SetRange(GLAccount."No.", AcquisitionAccount);
                    end;
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    //Get budget amount avaliable
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PurchaseLines."Dimension Set ID");
                    DimMgt.GetShortcutDimensions(PurchaseLines."Dimension Set ID", ShortcutDimCode);
                    FetchDimValue(PurchaseLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PurchHeader."Order Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                        DisbursedAmount:=GLAccount."Disbursed Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    if PurchaseLines.Type = PurchaseLines.Type::Item then CommitmentEntries.SetRange(CommitmentEntries.Account, InventoryAccount);
                    if PurchaseLines.Type = PurchaseLines.Type::"G/L Account" then CommitmentEntries.SetRange(CommitmentEntries.Account, PurchaseLines."No.");
                    if PurchaseLines.Type = PurchaseLines.Type::"Fixed Asset" then CommitmentEntries.SetRange(CommitmentEntries.Account, AcquisitionAccount);
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PurchHeader."Order Date");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    Commit;
                    if LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.")then Message('Line No %1 has been commited', PurchaseLines."Line No.")
                    else if CommittedAmount + PurchaseLines."Amount Including VAT" > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', PurchaseLines."Shortcut Dimension 1 Code", PurchaseLines."Shortcut Dimension 2 Code", Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount, PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount, PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError:=true;
                            Commit;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=PurchHeader."No.";
                    Committments.No:=PurchaseLines."No.";
                    Committments."Line No.":=PurchaseLines."Line No.";
                    Committments."Account Type":=Committments."Account Type"::Vendor;
                    Committments."Account No.":=PurchaseLines."Buy-from Vendor No.";
                    if Vendor.Get(PurchaseLines."Buy-from Vendor No.")then Committments."Account Name":=Vendor.Name;
                    Committments.Description:=PurchaseLines.Description;
                    Committments."Dimension Set ID":=PurchaseLines."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        PurchaseLines.Committment:=true;
                        PurchaseLines.Modify;
                        if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Line Amount")));
                    end;
                end;
            until PurchaseLines.Next = 0;
        end;
    end;
    procedure LineCommitted(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer)Exists: Boolean var
        Committed: Record "Commitment Entries";
    begin
        //Modified by Brian
        // Exists:=FALSE;
        // Committed.RESET;
        // Committed.SETRANGE(Committed."Commitment No",CommittmentNo);
        // Committed.SETRANGE(Committed.No,No);
        // Committed.SETRANGE(Committed."Line No.",LineNo);
        // Committed.SETFILTER(Committed."Commitment Type",'%1|%2',Committed."Commitment Type"::Commitment,Committed."Commitment Type"::"Commitment Reversal");
        // IF Committed.FIND('-') THEN
        //  BEGIN
        //    Committed.CALCSUMS("Committed Amount");
        //    IF Committed."Committed Amount"=0 THEN
        //      Exists:=FALSE
        //    ELSE
        //      Exists:=TRUE;
        //  END;
        Exists:=false;
        Committed.Reset;
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed.No, No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-')then Exists:=true;
    end;
    procedure ImprestCommittment(var ImprestHeader: Record Payments; var ErrorMsg: Text)
    var
        ImprestLines: Record "Payment Lines";
        ExtImprestLines: Record "Ext Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF ImprestHeader.Status<>ImprestHeader.Status::Released THEN
            ERROR('The imprest is not fully approved');*/
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(ImprestLines."Account No")then begin
                    if CheckImprestCostOfSales(ImprestLines."Account No", ImprestLines."Expenditure Type") = false then begin
                        Committments.Init;
                        Committments."Commitment No":=ImprestHeader."No.";
                        Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                        Committments."Document Type":=Committments."Document Type"::Imprest;
                        ImprestHeader.TestField(Date);
                        Committments."Commitment Date":=ImprestHeader.Date;
                        Committments."Global Dimension 1":=ImprestLines."Shortcut Dimension 1 Code";
                        Committments."Global Dimension 2":=ImprestLines."Shortcut Dimension 2 Code";
                        Committments.Account:=ImprestLines."Account No";
                        Committments."Committed Amount":=ImprestLines.Amount;
                        //Confirm the Amount to be issued does not exceed the budget and amount Committed
                        //Get Budget for the G/L
                        GenLedSetup.Get;
                        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                        GLAccount.SetRange(GLAccount."No.", ImprestLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImprestLines."Dimension Set ID");
                        //Get Dimensions
                        DimMgt.GetShortcutDimensions(ImprestLines."Dimension Set ID", ShortcutDimCode);
                        /*IF ShortcutDimCode[1]<>'' THEN
                        GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                        IF ShortcutDimCode[2]<>'' THEN
                        GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                        IF ShortcutDimCode[3]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                        IF ShortcutDimCode[4]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                        IF ShortcutDimCode[5]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                        IF ShortcutDimCode[6]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                        FetchDimValue(ImprestLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                        //Get budget amount avaliable
                        GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                        if GLAccount.Find('-')then begin
                            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                            BudgetAmount:=GLAccount."Budgeted Amount";
                            Expenses:=GLAccount."Net Change";
                            BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                        end;
                        //Get committed Amount
                        CommittedAmount:=0;
                        CommitmentEntries.Reset;
                        CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                        CommitmentEntries.SetRange(CommitmentEntries.Account, ImprestLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ImprestLines."Dimension Set ID");
                        CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                        if ImprestHeader.Date = 0D then Error('Please insert the imprest date');
                        CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                        CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                        CommittedAmount:=CommitmentEntries."Committed Amount";
                        LineError:=false;
                        if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No")then Message('Line No %1 has been committed', ImprestLines."Line No")
                        else if CommittedAmount + ImprestLines.Amount > BudgetAvailable then begin //brian
                                if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', ImprestLines."Shortcut Dimension 1 Code", ImprestLines."Shortcut Dimension 2 Code", Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ImprestLines.FieldCaption("Shortcut Dimension 2 Code"))
                                else
                                    ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ImprestLines.FieldCaption("Shortcut Dimension 2 Code"));
                                LineError:=true;
                            end;
                        Committments.User:=UserId;
                        Committments."Document No":=ImprestHeader."No.";
                        Committments.No:=ImprestLines."Account No";
                        Committments."Line No.":=ImprestLines."Line No";
                        Committments."Account Type":=Committments."Account Type"::Customer;
                        Committments."Account No.":=ImprestHeader."Account No.";
                        if Customer.Get(ImprestHeader."Account No.")then Committments."Account Name":=Customer.Name;
                        Committments.Description:=ImprestLines.Description;
                        Committments."Dimension Set ID":=ImprestLines."Dimension Set ID";
                        GeneralLedgerSetup.Get;
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                        //Check whether line is committed.
                        if not LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No")then begin
                            EntryNo:=EntryNo + 1;
                            Committments."Entry No":=EntryNo;
                            Committments.Insert;
                            ImprestLines.Committed:=true;
                            ImprestLines.Modify;
                        // if LineError = false then
                        //     Message('Items Committed Successfully and the balance is %1',
                        //     Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)));
                        end;
                    end;
                end;
            until ImprestLines.Next = 0;
        end;
        //External Lines
        ExtImprestLines.SetRange(ExtImprestLines.No, ImprestHeader."No.");
        if ExtImprestLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(ExtImprestLines."Account No")then begin
                    if CheckImprestCostOfSales(ExtImprestLines."Account No", ExtImprestLines."Expenditure Type") = false then begin
                        Committments.Init;
                        Committments."Commitment No":=ImprestHeader."No.";
                        Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                        Committments."Document Type":=Committments."Document Type"::Imprest;
                        ImprestHeader.TestField(Date);
                        Committments."Commitment Date":=ImprestHeader.Date;
                        Committments."Global Dimension 1":=ExtImprestLines."Shortcut Dimension 1 Code";
                        Committments."Global Dimension 2":=ExtImprestLines."Shortcut Dimension 2 Code";
                        Committments.Account:=ExtImprestLines."Account No";
                        Committments."Committed Amount":=ExtImprestLines.Amount;
                        GenLedSetup.Get;
                        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                        GLAccount.SetRange(GLAccount."No.", ExtImprestLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ExtImprestLines."Dimension Set ID");
                        DimMgt.GetShortcutDimensions(ExtImprestLines."Dimension Set ID", ShortcutDimCode);
                        FetchDimValue(ExtImprestLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                        GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                        if GLAccount.Find('-')then begin
                            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                            BudgetAmount:=GLAccount."Budgeted Amount";
                            Expenses:=GLAccount."Net Change";
                            BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                        end;
                        CommittedAmount:=0;
                        CommitmentEntries.Reset;
                        CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                        CommitmentEntries.SetRange(CommitmentEntries.Account, ExtImprestLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ExtImprestLines."Dimension Set ID");
                        CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                        if ImprestHeader.Date = 0D then Error('Please insert the imprest date');
                        CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                        CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                        CommittedAmount:=CommitmentEntries."Committed Amount";
                        LineError:=false;
                        if LineCommitted(ImprestHeader."No.", ExtImprestLines."Account No", ExtImprestLines."Line No")then Message('Line No %1 has been committed', ExtImprestLines."Line No")
                        else if CommittedAmount + ExtImprestLines.Amount > BudgetAvailable then begin //brian
                                if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', ExtImprestLines."Shortcut Dimension 1 Code", ExtImprestLines."Shortcut Dimension 2 Code", Abs(BudgetAvailable - (CommittedAmount + ExtImprestLines.Amount)), BudgetAvailable - CommittedAmount, ExtImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ExtImprestLines.FieldCaption("Shortcut Dimension 2 Code"))
                                else
                                    ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + ExtImprestLines.Amount)), BudgetAvailable - CommittedAmount, ExtImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ExtImprestLines.FieldCaption("Shortcut Dimension 2 Code"));
                                LineError:=true;
                            end;
                        Committments.User:=UserId;
                        Committments."Document No":=ImprestHeader."No.";
                        Committments.No:=ExtImprestLines."Account No";
                        Committments."Line No.":=ExtImprestLines."Line No";
                        Committments."Account Type":=Committments."Account Type"::Customer;
                        Committments."Account No.":=ImprestHeader."Account No.";
                        if Customer.Get(ImprestHeader."Account No.")then Committments."Account Name":=Customer.Name;
                        Committments.Description:=ExtImprestLines.Description;
                        Committments."Dimension Set ID":=ExtImprestLines."Dimension Set ID";
                        GeneralLedgerSetup.Get;
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                        if not LineCommitted(ImprestHeader."No.", ExtImprestLines."Account No", ExtImprestLines."Line No")then begin
                            EntryNo:=EntryNo + 1;
                            Committments."Entry No":=EntryNo;
                            Committments.Insert;
                            ExtImprestLines.Committed:=true;
                            ExtImprestLines.Modify;
                        end;
                    end;
                end;
            until ExtImprestLines.Next = 0;
        end;
    end;
    procedure ImprestCommittment2(var ImprestHeader: Record Payments; var ErrorMsg: Text)
    var
        ImprestLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF ImprestHeader.Status<>ImprestHeader.Status::Released THEN
            ERROR('The imprest is not fully approved');*/
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat //if IsAccountVotebookEntry(ImprestLines."Account No") then begin
                if CheckImprestCostOfSales(ImprestLines."Account No", ImprestLines."Expenditure Type") = false then begin
                    Committments.Init;
                    Committments."Commitment No":=ImprestHeader."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::Imprest;
                    ImprestHeader.TestField(Date);
                    Committments."Commitment Date":=ImprestHeader.Date;
                    Committments."Global Dimension 1":=ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=ImprestLines."Shortcut Dimension 2 Code";
                    Committments.Account:=ImprestLines."Account No";
                    Committments."Committed Amount":=ImprestLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ImprestLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImprestLines."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(ImprestLines."Dimension Set ID", ShortcutDimCode);
                    /*IF ShortcutDimCode[1]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    IF ShortcutDimCode[2]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    IF ShortcutDimCode[3]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    IF ShortcutDimCode[4]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    IF ShortcutDimCode[5]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    IF ShortcutDimCode[6]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(ImprestLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ImprestLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ImprestLines."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if ImprestHeader.Date = 0D then Error('Please insert the imprest date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No")then Message('Line No %1 has been committed', ImprestLines."Line No")
                    else if CommittedAmount + ImprestLines.Amount > BudgetAvailable then begin //brian
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', ImprestLines."Shortcut Dimension 1 Code", ImprestLines."Shortcut Dimension 2 Code", Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ImprestLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ImprestLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=ImprestHeader."No.";
                    Committments.No:=ImprestLines."Account No";
                    Committments."Line No.":=ImprestLines."Line No";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=ImprestHeader."Account No.";
                    if Customer.Get(ImprestHeader."Account No.")then Committments."Account Name":=Customer.Name;
                    Committments.Description:=ImprestLines.Description;
                    Committments."Dimension Set ID":=ImprestLines."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        ImprestLines.Committed:=true;
                        ImprestLines.Modify;
                        if LineError = false then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)));
                    end;
                end;
            until ImprestLines.Next = 0;
        end;
    end;
    procedure ReverseImprestCommittment(var Imprest: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        Committments2: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        Committments2.Reset();
        Committments2.SetRange("Document No", Imprest."No.");
        if Committments2.Find('-')then repeat Committments.Reset();
                if Committments.FindLast then EntryNo:=Committments."Entry No";
                if IsAccountVotebookEntry(Committments2."Account")then begin
                    // if CheckImprestCostOfSales(ImprestLines."Account No", ImprestLines."Expenditure Type") = false then begin
                    Committments.Init;
                    Committments.TransferFields(Committments2);
                    Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Commitment Date":=Imprest.Date;
                    Committments."Entry No":=EntryNo + 1;
                    Committments."Committed Amount":=-Committments2."Committed Amount";
                    Committments.Insert();
                    Committments2."Uncommittment Date":=Imprest."Posting Date";
                    Committments2.Modify();
                end;
            until Committments2.Next() = 0;
    end;
    procedure ReverseLPOCommittment(var PurchHeader: Record "Purchase Header")
    var
        Committment: Record "Commitment Entries";
        PurchLine: Record "Purchase Line";
        EntryNo: Integer;
        Item: Record Item;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        GenLedSetup: Record "General Ledger Setup";
        InventoryAccount: Code[20];
        AcquisitionAccount: Code[20];
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
    begin
        if Confirm('Are you sure you want to reverse the committed entries for Order no ' + PurchHeader."No." + '?', false) = true then begin
            Committment.Reset;
            Committment.SetRange(Committment."Commitment No", PurchHeader."No.");
            if Committment.Find('-')then begin
                Committment.DeleteAll;
            end;
            PurchLine.Reset;
            PurchLine.SetRange(PurchLine."Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
            if PurchLine.FindFirst then begin
                repeat //Insert Reversal entries in the committment entries table
                    if Committment.Find('+')then EntryNo:=Committment."Entry No";
                    EntryNo:=EntryNo + 1;
                    GenLedSetup.Get;
                    if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.")then begin
                        Committment.Init;
                        Committment."Entry No":=EntryNo;
                        Committment."Commitment No":=PurchHeader."No.";
                        Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                        Committment."Document Type":=Committment."Document Type"::LPO;
                        Committment."Commitment Date":=PurchLine."Order Date";
                        //Dimensions
                        Committment."Global Dimension 1":=PurchLine."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2":=PurchLine."Shortcut Dimension 2 Code";
                        Committment."Dimension Set ID":=PurchLine."Dimension Set ID";
                        //Dimensions
                        //Case of G/L Account,Item,Fixed Asset
                        case PurchLine.Type of PurchLine.Type::Item: begin
                            Item.Reset;
                            if Item.Get(PurchLine."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                            InventoryPostingSetup.Get(PurchLine."Location Code", Item."Inventory Posting Group");
                            InventoryAccount:=InventoryPostingSetup."Inventory Account";
                            Committment.Account:=InventoryAccount;
                        end;
                        PurchLine.Type::"G/L Account": begin
                            Committment.Account:=PurchLine."No.";
                        end;
                        PurchLine.Type::"Fixed Asset": begin
                            FixedAsset.Reset;
                            FixedAsset.Get(PurchLine."No.");
                            FixedAssetPG.Get(FixedAsset."FA Posting Group");
                            AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                            Committment.Account:=AcquisitionAccount;
                        end;
                        end;
                        Committment."Committed Amount":=-PurchLine."Line Amount";
                        Committment.User:=UserId;
                        Committment."Document No":=PurchHeader."No.";
                        Committment.No:=PurchLine."No.";
                        Committment."Account Type":=Committment."Account Type"::Vendor;
                        Committment."Account No.":=PurchLine."Buy-from Vendor No.";
                        if Vendor.Get(PurchLine."Buy-from Vendor No.")then Committment."Account Name":=Vendor.Name;
                        Committment.Description:=PurchLine.Description;
                        GeneralLedgerSetup.Get;
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committment."Budget Code":=GetCommittedBudget(PurchHeader."No.");
                        Committment.Insert;
                        //Mark entries as uncommited
                        PurchLine.Committment:=false;
                        PurchLine.Modify;
                    end;
                until PurchLine.Next = 0;
            end;
            Message('Committed entries for Order No %1 Have been reversed Successfully', PurchHeader."No.");
        end;
    end;
    // procedure ReverseImprestCommittment(var ImprestHeader: Record Payments)
    // var
    //     Committment: Record "Commitment Entries";
    //     ImprestLine: Record "Payment Lines";
    //     GenLedSetup: Record "General Ledger Setup";
    //     EntryNo: Integer;
    // begin
    //     if Confirm('Are you sure you want to reverse the committed entries for Imprest no ' + ImprestHeader."No." + '?', false) = true then begin
    //         Committment.Reset;
    //         Committment.SetRange(Committment."Commitment No", ImprestHeader."No.");
    //         if Committment.Find('-') then begin
    //             Committment.DeleteAll;
    //         end;
    //         ImprestLine.Reset;
    //         ImprestLine.SetRange(ImprestLine.No, ImprestHeader."No.");
    //         if ImprestLine.FindFirst then begin
    //             if Committment.FindLast then
    //                 EntryNo := Committment."Entry No";
    //             repeat
    //                 //Insert reversal entries into the committment table
    //                 if LineCommitted(ImprestHeader."No.", ImprestLine."Account No", ImprestLine."Line No") then begin
    //                     Committment.Init;
    //                     Committment."Commitment No" := ImprestHeader."No.";
    //                     Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
    //                     Committment."Document Type" := Committment."Document Type"::Imprest;
    //                     Committment."Commitment Date" := ImprestHeader.Date;
    //                     Committment."Dimension Set ID" := ImprestHeader."Dimension Set ID";
    //                     Committment."Global Dimension 1" := ImprestLine."Shortcut Dimension 1 Code";
    //                     Committment."Global Dimension 2" := ImprestLine."Shortcut Dimension 2 Code";
    //                     Committment."Dimension Set ID" := ImprestLine."Dimension Set ID";
    //                     Committment.Account := ImprestLine."Account No";
    //                     Committment."Committed Amount" := -ImprestLine.Amount;
    //                     Committment.User := UserId;
    //                     Committment."Document No" := ImprestHeader."No.";
    //                     Committment.No := ImprestLine."Account No";
    //                     Committment."Line No." := ImprestLine."Line No";
    //                     GeneralLedgerSetup.Get;
    //                     GeneralLedgerSetup.TestField("Current Budget");
    //                     Committment."Budget Code" := GetCommittedBudget(ImprestHeader."No.");
    //                     EntryNo := EntryNo + 1;
    //                     Committment."Entry No" := EntryNo;
    //                     Committment.Insert;
    //                     //Mark imprest lines entries as uncommited
    //                     ImprestLine.Committed := false;
    //                     ImprestLine.Modify;
    //                 end;
    //             until ImprestLine.Next = 0;
    //         end;
    //         Message('Committed entries for Imprest No %1 Have been reversed Successfully', ImprestHeader."No.");
    //     end;
    // end;
    procedure UncommitLPO(var PurchHeader: Record "Purchase Header")
    var
        Committment: Record "Commitment Entries";
        PurchLine: Record "Purchase Line";
        EntryNo: Integer;
        Item: Record Item;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        GenLedSetup: Record "General Ledger Setup";
        InventoryAccount: Code[20];
        AcquisitionAccount: Code[20];
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        CommEntries: Record "Commitment Entries";
    begin
        //Post Reversals to committment entries
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.Find('-')then begin
            Committment.Reset;
            Committment.SetRange(Committment."Commitment No", PurchHeader."No.");
            Committment.SetRange(Committment."Commitment Type", Committment."Commitment Type"::Commitment);
            if Committment.Find('-')then UncommittmentDate:=Committment."Commitment Date";
            repeat if CommEntries.Find('+')then EntryNo:=CommEntries."Entry No";
                if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.")then begin
                    Committment.Init;
                    Committment."Entry No":=EntryNo + 1;
                    Committment."Commitment No":=PurchHeader."No.";
                    Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                    Committment."Document Type":=Committment."Document Type"::LPO;
                    //Insert the same
                    Committment."Commitment Date":=UncommittmentDate;
                    Committment."Uncommittment Date":=PurchLine."Order Date";
                    //Dimensions
                    Committment."Global Dimension 1":=PurchLine."Shortcut Dimension 1 Code";
                    Committment."Global Dimension 2":=PurchLine."Shortcut Dimension 2 Code";
                    //Dimensions
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchLine.Type of PurchLine.Type::Item: begin
                        Item.Reset;
                        if Item.Get(PurchLine."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                        InventoryPostingSetup.Get(PurchLine."Location Code", Item."Inventory Posting Group");
                        //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                        Item.TestField("Item G/L Budget Account");
                        InventoryAccount:=Item."Item G/L Budget Account";
                        Committment.Account:=InventoryAccount;
                    end;
                    PurchLine.Type::"G/L Account": begin
                        Committment.Account:=PurchLine."No.";
                    end;
                    PurchLine.Type::"Fixed Asset": begin
                        FixedAsset.Reset;
                        FixedAsset.Get(PurchLine."No.");
                        FixedAssetPG.Get(FixedAsset."FA Posting Group");
                        AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                        Committment.Account:=AcquisitionAccount;
                    end;
                    end;
                    Committment."Committed Amount":=-PurchLine."Amount Including VAT";
                    Committment.User:=UserId;
                    Committment."Document No":=PurchHeader."No.";
                    Committment.No:=PurchLine."No.";
                    Committment."Line No.":=PurchLine."Line No.";
                    Committment."Account Type":=Committment."Account Type"::Vendor;
                    Committment."Account No.":=PurchLine."Buy-from Vendor No.";
                    if Vendor.Get(PurchLine."Buy-from Vendor No.")then Committment."Account Name":=Vendor.Name;
                    Committment.Description:=PurchLine.Description;
                    Committment."Dimension Set ID":=PurchLine."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committment."Budget Code":=GetCommittedBudget(PurchHeader."No.");
                    Committment.Insert;
                end;
            until PurchLine.Next = 0;
        end;
    //End Post Reversal to Committment entries
    //Note LPO Uncommittment.
    end;
    procedure UncommitImprest(var ImprestHeader: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
        Customer: Record Customer;
    begin
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            Committments.Reset;
            Committments.SetRange(Committments."Commitment No", ImprestHeader."No.");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Commitment);
            if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
            repeat if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No")then begin
                    Committments.Init;
                    Committments."Commitment No":=ImprestHeader."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type":=Committments."Document Type"::Imprest;
                    //Insert same Commitment Date
                    Committments."Commitment Date":=UncommittmentDate;
                    Committments."Uncommittment Date":=ImprestHeader.Date;
                    Committments."Dimension Set ID":=ImprestHeader."Dimension Set ID";
                    Committments."Global Dimension 1":=ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=ImprestLines."Shortcut Dimension 2 Code";
                    Committments.Account:=ImprestLines."Account No";
                    Committments."Committed Amount":=-LastCommittment(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No");
                    Committments.User:=UserId;
                    Committments."Document No":=ImprestHeader."No.";
                    Committments.No:=ImprestLines."Account No";
                    Committments."Line No.":=ImprestLines."Line No";
                    Committments."Dimension Set ID":=ImprestLines."Dimension Set ID";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=ImprestHeader."Account No.";
                    if Customer.Get(ImprestHeader."Account No.")then Committments."Account Name":=Customer.Name;
                    Committments.Description:=ImprestLines.Description;
                    Committments."Dimension Set ID":=ImprestLines."Dimension Set ID";
                    Committments."Payment Posted":=true;
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GetCommittedBudget(ImprestHeader."No.");
                    Committments.Insert;
                end;
            until ImprestLines.Next = 0;
        end;
    end;
    procedure CreatePV(var ImprestHeader: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        PVLines: Record "Payment Lines";
        LineNo: Integer;
        CSetup: Record "Cash Management Setups";
        PettyCashLines: Record "Payment Lines";
    begin
        //Check whether the petty cash Limt has been exceeded or not
        CSetup.Get;
        CSetup.TestField("Imprest Limit");
        ImprestHeader.CalcFields("Imprest Amount");
        if ImprestHeader."Imprest Amount" > CSetup."Imprest Limit" then begin
            //Create a PV
            ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
            if ImprestLines.FindFirst then begin
                repeat PVLines.Init;
                    PVLines.No:=ImprestHeader."No.";
                    PVLines."Line No":=ImprestLines."Line No";
                    PVLines.Date:=ImprestHeader.Date;
                    PVLines."Account Type":=ImprestLines."Account Type";
                    PVLines."Account No":=ImprestLines."Account No";
                    PVLines."Account Name":=ImprestLines."Account Name";
                    PVLines.Description:=ImprestLines.Description;
                    PVLines.Amount:=ImprestLines.Amount;
                    PVLines.Validate(Amount);
                    PVLines."Dimension Set ID":=ImprestHeader."Dimension Set ID";
                    //PVLines."Global Dimension 1 Code":=ImprestLines."Global Dimension 1 Code";
                    //PVLines."Global Dimension 2 Code":=ImprestLines."Global Dimension 2 Code";
                    if not PVLines.Get(PVLines.No, PVLines."Line No")then PVLines.Insert;
                until ImprestLines.Next = 0;
            end;
            ImprestHeader."Payment Type":=ImprestHeader."Payment Type"::"Payment Voucher";
            //ImprestHeader."Original Document":=ImprestHeader."Original Document"::Imprest;
            ImprestHeader.Status:=ImprestHeader.Status::Released;
            //ImprestHeader."PV Creation DateTime":=CREATEDATETIME(TODAY,TIME);
            //ImprestHeader."User Id":=USERID;
            ImprestHeader.Modify(true);
            Message('Payment Voucher No %1 has been successfully created', ImprestHeader."No.");
        end
        else
        begin
            //Create a petty cash
            ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
            if ImprestLines.FindFirst then begin
                repeat PettyCashLines.Init;
                    PettyCashLines.No:=ImprestHeader."No.";
                    PettyCashLines."Line No":=ImprestLines."Line No";
                    PettyCashLines."Account Type":=ImprestLines."Account Type";
                    PettyCashLines."Account No":=ImprestLines."Account No";
                    PettyCashLines."Account Name":=ImprestLines."Account Name";
                    PettyCashLines.Description:=ImprestLines.Description;
                    PettyCashLines.Amount:=ImprestLines.Amount;
                    PettyCashLines."Dimension Set ID":=ImprestLines."Dimension Set ID";
                    //PettyCashLines."Global Dimension 1 Code":=ImprestLines."Global Dimension 1 Code";
                    //PettyCashLines."Global Dimension 2 Code":=ImprestLines."Global Dimension 2 Code";
                    if not PettyCashLines.Get(PettyCashLines.No, PettyCashLines."Line No")then PettyCashLines.Insert;
                until ImprestLines.Next = 0;
            end;
            ImprestHeader."Payment Type":=ImprestHeader."Payment Type"::"Petty Cash";
            //ImprestHeader."Original Document":=ImprestHeader."Original Document"::Imprest;
            ImprestHeader.Status:=ImprestHeader.Status::Open;
            //ImprestHeader."PV Creation DateTime":=CREATEDATETIME(TODAY,TIME);
            //ImprestHeader."PV Creator ID":=USERID;
            ImprestHeader.Modify(true);
            Message('Petty Cash No %1 has been successfully created', ImprestHeader."No.");
        end;
    end;
    procedure LastCommittment(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer)CommittmentAmt: Decimal var
        Committed: Record "Commitment Entries";
    begin
        Committed.Reset;
        Committed.SetRange("Commitment Type", Committed."Commitment Type"::Commitment);
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed.No, No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-')then exit(Committed."Committed Amount");
    end;
    procedure PettyCashCommittment(PettyCash: Record Payments; var ErrorMsg: Text)
    var
        PettyCashLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF PettyCash.Status<>PettyCash.Status::Released THEN
            ERROR('The petty cash voucher is not fully approved');
        */
        PettyCashLines.Reset;
        PettyCashLines.SetRange(No, PettyCash."No.");
        PettyCashLines.SetRange("Account Type", PettyCashLines."Account Type"::"G/L Account");
        if PettyCashLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(PettyCashLines."Account No")then begin
                    Committments.Init;
                    Committments."Commitment No":=PettyCash."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Petty Cash";
                    PettyCash.TestField(Date);
                    Committments."Commitment Date":=PettyCash.Date;
                    Committments."Dimension Set ID":=PettyCashLines."Dimension Set ID";
                    Committments."Global Dimension 1":=PettyCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PettyCashLines."Shortcut Dimension 2 Code";
                    Committments.Account:=PettyCashLines."Account No";
                    Committments."Committed Amount":=PettyCashLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PettyCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PettyCashLines."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(PettyCashLines."Dimension Set ID", ShortcutDimCode);
                    /*
                    IF ShortcutDimCode[1]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    IF ShortcutDimCode[2]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    IF ShortcutDimCode[3]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    IF ShortcutDimCode[4]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    IF ShortcutDimCode[5]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    IF ShortcutDimCode[6]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);
                    */
                    FetchDimValue(PettyCashLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PettyCash.Date);
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Approved Budget";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PettyCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PettyCashLines."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PettyCash.Date = 0D then Error('Please insert the petty cash date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PettyCash.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No")then Message('Line No %1 has been commited', PettyCashLines."Line No")
                    else if CommittedAmount + PettyCashLines.Amount > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PettyCashLines.Amount)), BudgetAvailable - CommittedAmount, PettyCashLines.FieldCaption("Shortcut Dimension 1 Code"), PettyCashLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PettyCashLines.Amount)), BudgetAvailable - CommittedAmount, PettyCashLines.FieldCaption("Shortcut Dimension 1 Code"), PettyCashLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=PettyCash."No.";
                    Committments.No:=PettyCashLines."Account No";
                    Committments."Line No.":=PettyCashLines."Line No";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=PettyCash."Account No.";
                    if GLAccount.Get(PettyCash."Account No.")then Committments."Account Name":=GLAccount.Name;
                    Committments.Description:=PettyCashLines.Description;
                    Committments."Dimension Set ID":=PettyCashLines."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        PettyCashLines.Committed:=true;
                        PettyCashLines.Modify;
                        if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + PettyCashLines.Amount)));
                    end;
                end;
            until PettyCashLines.Next = 0;
        end;
    end;
    procedure ReversePettyCashCommittment(var PettyCash: Record Payments)
    var
        Committment: Record "Commitment Entries";
        PettyCashLine: Record "Payment Lines";
        EntryNo: Integer;
    begin
        if Confirm('Are you sure you want to reverse the committed entries for Petty Cash no ' + PettyCash."No." + '?', false) = true then begin
            Committment.Reset;
            Committment.SetRange(Committment."Commitment No", PettyCash."No.");
            if Committment.Find('-')then begin
                Committment.DeleteAll;
            end;
            PettyCashLine.Reset;
            PettyCashLine.SetRange(No, PettyCash."No.");
            if PettyCashLine.FindFirst then begin
                if Committment.FindLast then EntryNo:=Committment."Entry No";
                repeat //Insert reversal entries into the committment table
                    if LineCommitted(PettyCash."No.", PettyCashLine."Account No", PettyCashLine."Line No")then begin
                        Committment.Init;
                        Committment."Commitment No":=PettyCash."No.";
                        Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                        Committment."Document Type":=Committment."Document Type"::"Petty Cash";
                        Committment."Commitment Date":=PettyCash.Date;
                        Committment."Dimension Set ID":=PettyCashLine."Dimension Set ID";
                        Committment."Global Dimension 1":=PettyCashLine."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2":=PettyCashLine."Shortcut Dimension 2 Code";
                        Committment.Account:=PettyCashLine."Account No";
                        Committment."Committed Amount":=-PettyCashLine.Amount;
                        Committment.User:=UserId;
                        Committment."Document No":=PettyCash."No.";
                        Committment.No:=PettyCashLine."Account No";
                        Committment."Line No.":=PettyCashLine."Line No";
                        EntryNo:=EntryNo + 1;
                        Committment."Entry No":=EntryNo;
                        GeneralLedgerSetup.Get;
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committment."Budget Code":=GetCommittedBudget(PettyCash."No.");
                        Committment.Insert;
                        //Mark imprest lines entries as uncommited
                        PettyCashLine.Committed:=false;
                        PettyCashLine.Modify;
                    end;
                until PettyCashLine.Next = 0;
            end;
            Message('Committed entries for Petty Cash No %1 Have been reversed Successfully', PettyCash."No.");
        end;
    end;
    procedure UncommitPettyCash(var PettyCash: Record Payments)
    var
        PettyCashLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        PettyCashLines.SetRange(No, PettyCash."No.");
        if PettyCashLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            Committments.Reset;
            Committments.SetRange(Committments."Commitment No", PettyCash."No.");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Commitment);
            if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
            repeat if LineCommitted(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No")then begin
                    Committments.Init;
                    Committments."Commitment No":=PettyCash."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type":=Committments."Document Type"::"Petty Cash";
                    //Insert same Commitment Date
                    Committments."Commitment Date":=UncommittmentDate;
                    Committments."Uncommittment Date":=PettyCash.Date;
                    Committments."Dimension Set ID":=PettyCash."Dimension Set ID";
                    Committments."Global Dimension 1":=PettyCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PettyCashLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID":=PettyCash."Dimension Set ID";
                    Committments.Account:=PettyCashLines."Account No";
                    Committments."Committed Amount":=-LastCommittment(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No");
                    Committments.User:=UserId;
                    Committments."Document No":=PettyCash."No.";
                    Committments.No:=PettyCashLines."Account No";
                    Committments."Line No.":=PettyCashLines."Line No";
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GetCommittedBudget(PettyCash."No.");
                    Committments.Insert;
                end;
            until PettyCashLines.Next = 0;
        end;
    end;
    procedure CheckPVCommittment(PV: Record Payments)
    var
        PVLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        PVLines.Reset;
        PVLines.SetRange(No, PV."No.");
        PVLines.SetRange("Account Type", PVLines."Account Type"::"G/L Account");
        if PVLines.Find('-')then begin
            repeat if IsAccountVotebookEntry(PVLines."Account No")then begin
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PVLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PV.Date);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PVLines."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PVLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PV.Date = 0D then Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PV.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(PVLines."Account No")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + PVLines.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3 CommittedAmount %4', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)), BudgetAvailable, CommittedAmount);
                    end;
                end;
            until PVLines.Next = 0;
        end;
    end;
    procedure CheckImprestCommittment(Imprest: Record Payments)
    var
        ImpLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        ReceiptsandPaymentTypes: Record "Receipts and Payment Types";
    begin
        ImpLines.Reset;
        ImpLines.SetRange(No, Imprest."No.");
        ImpLines.SetRange("Account Type", ImpLines."Account Type"::"G/L Account");
        if ImpLines.Find('-')then begin
            /* //Cheruiyot
            ReceiptsandPaymentTypes.RESET;
            ReceiptsandPaymentTypes.SETRANGE(Code,ImpLines."Expenditure Type");
            IF ReceiptsandPaymentTypes.FIND('-') THEN
            IF ReceiptsandPaymentTypes."Cost of Sale"=FALSE THEN
             //End Cheruiyot */
            repeat if IsAccountVotebookEntry(ImpLines."Account No")then begin
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ImpLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Imprest.Date);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImpLines."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ImpLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if Imprest.Date = 0D then Error('Please insert the document date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Imprest.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(ImpLines."Account No")then;
                    //IF GLAccount."Votebook Entry" THEN BEGIN
                    if CommittedAmount + ImpLines.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + ImpLines.Amount)), BudgetAvailable - CommittedAmount);
                //END;
                end;
            until ImpLines.Next = 0;
        end;
    end;
    procedure CheckPettyCashCommittment(PC: Record Payments)
    var
        PCLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        PCLines.Reset;
        PCLines.SetRange(No, PC."No.");
        PCLines.SetRange("Account Type", PCLines."Account Type"::"G/L Account");
        if PCLines.Find('-')then begin
            repeat if IsAccountVotebookEntry(PCLines."Account No")then begin
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PCLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PC.Date);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PCLines."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PCLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PC.Date = 0D then Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PC.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(PCLines."Account No")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + PCLines.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + PCLines.Amount)), BudgetAvailable - CommittedAmount);
                    end;
                end;
            until PCLines.Next = 0;
        end;
    end;
    procedure FetchDimValue(DimSetID: Integer; var ShortcutDimCode: array[8]of Code[20]; var DimValueName: array[8]of Text)
    var
        i: Integer;
        DimSetEntry: Record "Dimension Set Entry";
    begin
        GetGLSetup;
        for i:=1 to 8 do begin
            ShortcutDimCode[i]:='';
            if GLSetupShortcutDimCode[i] <> '' then if DimSetEntry.Get(DimSetID, GLSetupShortcutDimCode[i])then begin
                    DimSetEntry.CalcFields("Dimension Name", "Dimension Value Name");
                    ShortcutDimCode[i]:=DimSetEntry."Dimension Value Code";
                    DimValueName[i]:=DimSetEntry."Dimension Value Name";
                end;
        end;
    end;
    local procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get;
            GLSetupShortcutDimCode[1]:=GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2]:=GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3]:=GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4]:=GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5]:=GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6]:=GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7]:=GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8]:=GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup:=true;
        end;
    end;
    procedure EncumberPayments(Payments: Record Payments)
    var
        CommittmentEntries: Record "Commitment Entries";
    begin
        CommittmentEntries.Reset;
        CommittmentEntries.SetRange("Commitment No", Payments."No.");
        CommittmentEntries.SetRange("Commitment Type", CommittmentEntries."Commitment Type"::Commitment);
        CommittmentEntries.SetRange("Payment Posted", false);
        if CommittmentEntries.Find('-')then repeat CommittmentEntries."Commitment Type":=CommittmentEntries."Commitment Type"::Encumberance;
                CommittmentEntries.Modify;
            until CommittmentEntries.Next = 0;
    end;
    procedure UnencumberPettyCash(var PettyCash: Record Payments)
    var
        PettyCashLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        PettyCashLines.SetRange(No, PettyCash."No.");
        if PettyCashLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            Committments.Reset;
            Committments.SetRange(Committments."Commitment No", PettyCash."Petty Cash Issue Doc.No");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Encumberance);
            if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
            repeat if LineCommitted(PettyCash."Petty Cash Issue Doc.No", PettyCashLines."Account No", PettyCashLines."Line No")then begin
                    Committments.Init;
                    Committments."Commitment No":=PettyCash."Petty Cash Issue Doc.No";
                    Committments."Commitment Type":=Committments."Commitment Type"::"Encumberance Reversal";
                    Committments."Document Type":=Committments."Document Type"::"Petty Cash";
                    //Insert same Commitment Date
                    Committments."Commitment Date":=UncommittmentDate;
                    Committments."Uncommittment Date":=PettyCash.Date;
                    Committments."Dimension Set ID":=PettyCash."Dimension Set ID";
                    Committments."Global Dimension 1":=PettyCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PettyCashLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID":=PettyCash."Dimension Set ID";
                    Committments.Account:=PettyCashLines."Account No";
                    Committments."Account No.":=PettyCash."Account No.";
                    Committments."Account Name":=PettyCash."Account Name";
                    Committments.Description:=PettyCash."Payment Narration";
                    Committments."Committed Amount":=-LastCommittment(PettyCash."Petty Cash Issue Doc.No", PettyCashLines."Account No", PettyCashLines."Line No");
                    Committments.User:=UserId;
                    Committments."Document No":=PettyCash."No.";
                    Committments.No:=PettyCashLines."Account No";
                    Committments."Line No.":=PettyCashLines."Line No";
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GetCommittedBudget(PettyCash."No.");
                    Committments.Insert;
                end;
            until PettyCashLines.Next = 0;
        end;
    end;
    procedure UnencumberImprest(var ImprestHeader: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            Committments.Reset;
            Committments.SetRange(Committments."Commitment No", ImprestHeader."Imprest Issue Doc. No");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Encumberance);
            if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
            repeat if LineCommitted(ImprestHeader."Imprest Issue Doc. No", ImprestLines."Account No", ImprestLines."Line No")then begin
                    Committments.Init;
                    Committments."Commitment No":=ImprestHeader."Imprest Issue Doc. No";
                    Committments."Commitment Type":=Committments."Commitment Type"::"Encumberance Reversal";
                    Committments."Document Type":=Committments."Document Type"::Imprest;
                    //Insert same Commitment Date
                    Committments."Commitment Date":=UncommittmentDate;
                    Committments."Uncommittment Date":=ImprestHeader.Date;
                    Committments."Dimension Set ID":=ImprestHeader."Dimension Set ID";
                    Committments."Global Dimension 1":=ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=ImprestLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID":=ImprestHeader."Dimension Set ID";
                    Committments.Account:=ImprestLines."Account No";
                    Committments."Committed Amount":=-LastCommittment(ImprestHeader."Imprest Issue Doc. No", ImprestLines."Account No", ImprestLines."Line No");
                    Committments.User:=UserId;
                    Committments."Document No":=ImprestHeader."No.";
                    Committments.No:=ImprestLines."Account No";
                    Committments."Line No.":=ImprestLines."Line No";
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GetCommittedBudget(ImprestHeader."Imprest Issue Doc. No");
                    Committments.Insert;
                end;
            until ImprestLines.Next = 0;
        end;
    end;
    procedure CheckImprestSurrenderCommittment(Imprest: Record Payments)
    var
        ImpLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        ImpLines.Reset;
        ImpLines.SetRange(No, Imprest."No.");
        ImpLines.SetRange("Account Type", ImpLines."Account Type"::"G/L Account");
        if ImpLines.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(ImpLines."Account No")then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ImpLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Imprest.Date);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImpLines."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ImpLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if Imprest.Date = 0D then Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Imprest.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(ImpLines."Account No")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + (ImpLines."Actual Spent" - ImpLines.Amount) > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + (ImpLines."Actual Spent" - ImpLines.Amount))), BudgetAvailable - CommittedAmount);
                    end;
                end;
            until ImpLines.Next = 0;
        end;
    end;
    procedure ImprestSurrenderCommittment(var ImprestHeader: Record Payments; var ErrorMsg: Text)
    var
        ImprestLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF ImprestHeader.Status<>ImprestHeader.Status::Released THEN
            ERROR('The imprest is not fully approved');
        */
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(ImprestLines."Account No")then begin
                    Committments.Init;
                    Committments."Commitment No":=ImprestHeader."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Imprest Surrender";
                    ImprestHeader.TestField(Date);
                    Committments."Commitment Date":=ImprestHeader.Date;
                    Committments."Global Dimension 1":=ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=ImprestLines."Shortcut Dimension 2 Code";
                    Committments.Account:=ImprestLines."Account No";
                    Committments."Committed Amount":=ImprestLines."Actual Spent" - ImprestLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ImprestLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImprestLines."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(ImprestLines."Dimension Set ID", ShortcutDimCode);
                    /*IF ShortcutDimCode[1]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    IF ShortcutDimCode[2]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    IF ShortcutDimCode[3]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    IF ShortcutDimCode[4]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    IF ShortcutDimCode[5]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    IF ShortcutDimCode[6]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(ImprestLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Approved Budget";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ImprestLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ImprestLines."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if ImprestHeader.Date = 0D then Error('Please insert the imprest date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No")then Message('Line No %1 has been commited', ImprestLines."Line No")
                    else if(CommittedAmount + (ImprestLines."Actual Spent" - ImprestLines.Amount)) > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, %7, %8 By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + (ImprestLines."Actual Spent" - ImprestLines.Amount))), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ImprestLines.FieldCaption("Shortcut Dimension 2 Code"), ImprestLines.FieldCaption("Shortcut Dimension 4 Code"), ImprestLines."Shortcut Dimension 4 Code")
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, %7, %8 By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + (ImprestLines."Actual Spent" - ImprestLines.Amount))), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"), ImprestLines.FieldCaption("Shortcut Dimension 2 Code"), ImprestLines.FieldCaption("Shortcut Dimension 4 Code"), ImprestLines."Shortcut Dimension 4 Code");
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=ImprestHeader."No.";
                    Committments.No:=ImprestLines."Account No";
                    Committments."Line No.":=ImprestLines."Line No";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=ImprestHeader."Account No.";
                    if Customer.Get(ImprestHeader."Account No.")then Committments."Account Name":=Customer.Name;
                    Committments.Description:=ImprestLines.Description;
                    Committments."Dimension Set ID":=ImprestLines."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No") and ((ImprestLines."Actual Spent" - ImprestLines.Amount) > 0)then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        ImprestLines.Committed:=true;
                        ImprestLines.Modify;
                        if not LineError and ((ImprestLines."Actual Spent" - ImprestLines.Amount) > 0)then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + ImprestLines."Actual Spent" - ImprestLines.Amount)));
                    end;
                end;
            until ImprestLines.Next = 0;
        end;
    //CreatePV(ImprestHeader);
    end;
    procedure PurchReqCommittment(var IR: Record "Internal Request Header"; var ErrorMsg: Text)
    var
        IRLine: Record "Internal Request Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
        Items: Record Item;
        CommittmentAccount: Code[100];
    begin
        ErrorMsg:='';
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        //IRLine.SetRange(IRLine.Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-')then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat case IRLine.Type of IRLine.Type::"G/L Account": CommittmentAccount:=IRLine."No.";
                IRLine.Type::Item: begin
                    Items.Get(IRLine."No.");
                    //Items.Get(ItemNo);
                    if not(Items.Type = Items.Type::"Non-Inventory")then begin
                        Items.TestField("Item G/L Budget Account");
                        BudgetEntry.Reset();
                        // BudgetEntry.SetRange("Global Dimension 2 Code", PaymentRec."Shortcut Dimension 2 Code");
                        BudgetEntry.SetFilter("Budget Name", GLSetup."Current Budget");
                        // BudgetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                        if BudgetEntry.FindFirst()then begin
                            CommittmentAccount:=BudgetEntry."G/L Account No.";
                        end;
                    // CommittmentAccount := Items."Item G/L Budget Account";
                    end;
                end;
                end;
                if IsAccountVotebookEntry(CommittmentAccount)then begin
                    Committments.Init;
                    Committments."Commitment No":=IR."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Purchase Requisition";
                    IR.TestField("Order Date");
                    Committments."Commitment Date":=IR."Order Date";
                    Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
                    Committments.Account:=IRLine."No.";
                    Committments."Committed Amount":=IRLine.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", CommittmentAccount);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(IRLine."Dimension Set ID", ShortcutDimCode);
                    /*IF ShortcutDimCode[1]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    IF ShortcutDimCode[2]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    IF ShortcutDimCode[3]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    IF ShortcutDimCode[4]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    IF ShortcutDimCode[5]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    IF ShortcutDimCode[6]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(IRLine."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Order Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Approved Budget";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, CommittmentAccount);
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", IRLine."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Order Date" = 0D then Error('Please insert the imprest date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", IR."Order Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(IR."No.", CommittmentAccount, IRLine."Line No.")then Message('Line No %1 has been commited', IRLine."Line No.")
                    else if CommittedAmount + IRLine.Amount > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=IR."No.";
                    Committments.No:=IRLine."No.";
                    Committments."Line No.":=IRLine."Line No.";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=CommittmentAccount;
                    if Customer.Get(IRLine."No.")then Committments."Account Name":=Customer.Name;
                    Committments.Description:=IRLine.Description;
                    Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(IR."No.", CommittmentAccount, IRLine."Line No.")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        IRLine.Committed:=true;
                        IRLine.Modify;
                        if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)));
                    end;
                end;
            until IRLine.Next = 0;
        end;
    //CreatePV(IR);
    end;
    procedure PurchReqCommittmentWorkplan(var IR: Record "Internal Request Header"; var ErrorMsg: Text; Var ItemNo: code[20])
    var
        IRLine: Record "Internal Request Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
        Items: Record Item;
        CommittmentAccount: Code[100];
    begin
        ErrorMsg:='';
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        //IRLine.SetRange(IRLine.Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-')then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat case IRLine.Type of IRLine.Type::"G/L Account": CommittmentAccount:=IRLine."No.";
                IRLine.Type::Item: begin
                    //Items.Get(IRLine."No.");
                    Items.Get(ItemNo);
                    if items.Type <> Items.Type::"Non-Inventory" then begin
                        Items.TestField("Item G/L Budget Account");
                        BudgetEntry.Reset();
                        // BudgetEntry.SetRange("Global Dimension 2 Code", PaymentRec."Shortcut Dimension 2 Code");
                        BudgetEntry.SetFilter("Budget Name", GLSetup."Current Budget");
                        // BudgetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                        if BudgetEntry.FindFirst()then begin
                            CommittmentAccount:=BudgetEntry."G/L Account No.";
                        end;
                    end;
                end;
                end;
                if IsAccountVotebookEntry(CommittmentAccount)then begin
                    Committments.Init;
                    Committments."Commitment No":=IR."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Purchase Requisition";
                    IR.TestField("Order Date");
                    Committments."Commitment Date":=IR."Order Date";
                    Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
                    Committments.Account:=IRLine."No.";
                    Committments."Committed Amount":=IRLine.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", CommittmentAccount);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(IRLine."Dimension Set ID", ShortcutDimCode);
                    /*IF ShortcutDimCode[1]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    IF ShortcutDimCode[2]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    IF ShortcutDimCode[3]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    IF ShortcutDimCode[4]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    IF ShortcutDimCode[5]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    IF ShortcutDimCode[6]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(IRLine."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Order Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Approved Budget";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, CommittmentAccount);
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", IRLine."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Order Date" = 0D then Error('Please insert the imprest date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", IR."Order Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(IR."No.", CommittmentAccount, IRLine."Line No.")then Message('Line No %1 has been commited', IRLine."Line No.")
                    else if CommittedAmount + IRLine.Amount > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=IR."No.";
                    Committments.No:=IRLine."No.";
                    Committments."Line No.":=IRLine."Line No.";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=CommittmentAccount;
                    if Customer.Get(IRLine."No.")then Committments."Account Name":=Customer.Name;
                    Committments.Description:=IRLine.Description;
                    Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(IR."No.", CommittmentAccount, IRLine."Line No.")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        IRLine.Committed:=true;
                        IRLine.Modify;
                        if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)));
                    end;
                end;
            until IRLine.Next = 0;
        end;
    //CreatePV(IR);
    end;
    procedure UncommitPurchReq(var IRLine: Record "Internal Request Line"; var IR: Record "Internal Request Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        //Update Dimension Set ID
        Committments.Reset;
        Committments.SetRange("Commitment No", IRLine."Document No.");
        Committments.SetRange(No, IRLine."No.");
        Committments.SetRange("Line No.", IRLine."Line No.");
        if Committments.Find('-')then begin
            Committments."Dimension Set ID":=IRLine."Dimension Set ID";
            Committments.Modify;
        end;
        Committments.Reset;
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        EntryNo:=EntryNo + 1;
        Committments.Reset;
        Committments.SetRange("Commitment No", IR."No.");
        Committments.SetRange("Commitment Type", Committments."Commitment Type"::Commitment);
        if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
        Committments.Init;
        Committments."Commitment No":=IRLine."Document No.";
        Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
        Committments."Document Type":=Committments."Document Type"::"Purchase Requisition";
        //Insert same Commitment Date
        Committments."Commitment Date":=UncommittmentDate;
        Committments."Uncommittment Date":=Today;
        Committments."Dimension Set ID":=IRLine."Dimension Set ID";
        Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
        Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
        Committments.Account:=IRLine."No.";
        Committments."Committed Amount":=-IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
        Committments."Account No.":=IRLine."No.";
        Committments.User:=UserId;
        Committments."Document No":=IR."No.";
        Committments.No:=IRLine."No.";
        Committments."Line No.":=IRLine."Line No.";
        Committments."Entry No":=EntryNo;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code":=GetCommittedBudget(IRLine."Document No.");
        Committments.Insert;
    end;
    procedure UncommitPurchReqOnQuote(QuoteNo: Code[20]; ReqNo: Code[20])
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
        Quote: Record "Quote Evaluation Header";
        IR: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
    begin
        Quote.Reset;
        Quote.SetRange("Quote No", QuoteNo);
        Quote.SetRange("Requisition No", ReqNo);
        if Quote.FindFirst then begin
            IR.Reset;
            IR.SetRange("No.", ReqNo);
            if IR.FindFirst then begin
                IRLine.Reset;
                IRLine.SetRange("Document No.", IR."No.");
                if IRLine.Find('-')then begin
                    repeat Committments.Reset;
                        Committments.SetRange("Commitment No", IRLine."Document No.");
                        Committments.SetRange(No, IRLine."No.");
                        Committments.SetRange("Line No.", IRLine."Line No.");
                        if Committments.Find('-')then begin
                            Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                            Committments.Modify;
                        end;
                        Committments.Reset;
                        if Committments.FindLast then EntryNo:=Committments."Entry No";
                        EntryNo:=EntryNo + 1;
                        Committments.Reset;
                        Committments.SetRange("Commitment No", IR."No.");
                        Committments.SetRange("Commitment Type", Committments."Commitment Type"::Commitment);
                        if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
                        Committments.Init;
                        Committments."Commitment No":=IRLine."Document No.";
                        Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                        //Insert same Commitment Date
                        Committments."Commitment Date":=UncommittmentDate;
                        Committments."Uncommittment Date":=IR."Posting Date";
                        Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                        Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
                        Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
                        Committments.Account:=IRLine."No.";
                        Committments."Committed Amount":=-IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
                        Committments."Account No.":=IRLine."No.";
                        Committments.User:=UserId;
                        Committments."Document No":=IR."No.";
                        Committments.No:=IRLine."No.";
                        Committments."Line No.":=IRLine."Line No.";
                        Committments."Entry No":=EntryNo;
                        GeneralLedgerSetup.Get;
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committments."Budget Code":=GetCommittedBudget(IRLine."Document No.");
                        Committments.Insert;
                    until IRLine.Next = 0;
                end;
            end;
        end;
    end;
    procedure CheckPurchReqCommittment(IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        CommittmentAccount: Code[100];
        Items: Record Item;
    begin
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        //IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-')then begin
            repeat case IRLine.Type of IRLine.Type::"G/L Account": CommittmentAccount:=IRLine."No.";
                IRLine.Type::Item: begin
                    //Error('item is %1', IRLine."No.");
                    Items.Get(IRLine."No.");
                    if Items.Type <> Items.Type::"Non-Inventory" then begin
                        Items.TestField("Item G/L Budget Account");
                        BudgetEntry.Reset();
                        // BudgetEntry.SetRange("Global Dimension 2 Code", PaymentRec."Shortcut Dimension 2 Code");
                        BudgetEntry.SetFilter("Budget Name", GLSetup."Current Budget");
                        // BudgetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                        if BudgetEntry.FindFirst()then begin
                            CommittmentAccount:=BudgetEntry."G/L Account No.";
                        end;
                    end;
                // CommittmentAccount := Items."Item G/L Budget Account";
                end;
                end;
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(CommittmentAccount)then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", CommittmentAccount);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, CommittmentAccount);
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Posting Date" = 0D then Error('Please insert the posting date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(IRLine."No.")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                    end;
                end;
            until IRLine.Next = 0;
        end;
    end;
    procedure CheckPurchReqCommittmentWorkplan(IR: Record "Internal Request Header"; Var ItemNo: code[20])
    var
        IRLine: Record "Internal Request Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        CommittmentAccount: Code[100];
        Items: Record Item;
    begin
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        //IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-')then begin
            repeat case IRLine.Type of IRLine.Type::"G/L Account": CommittmentAccount:=IRLine."No.";
                IRLine.Type::Item: begin
                    //Error('item is %1', IRLine."No.");
                    // Items.Get(IRLine."No.");
                    Items.Get(ItemNo);
                    //condition 
                    if Items.type <> Items.type::"Non-Inventory" then begin
                        Items.TestField("Item G/L Budget Account");
                        BudgetEntry.Reset();
                        // BudgetEntry.SetRange("Global Dimension 2 Code", PaymentRec."Shortcut Dimension 2 Code");
                        BudgetEntry.SetFilter("Budget Name", GLSetup."Current Budget");
                        // BudgetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                        if BudgetEntry.FindFirst()then begin
                            CommittmentAccount:=BudgetEntry."G/L Account No.";
                        end;
                    // CommittmentAccount := Items."Item G/L Budget Account";
                    end;
                end;
                end;
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(CommittmentAccount)then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", CommittmentAccount);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, CommittmentAccount);
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Posting Date" = 0D then Error('Please insert the posting date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(IRLine."No.")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                    end;
                end;
            until IRLine.Next = 0;
        end;
    end;
    procedure CheckPurchReqCommittmentWP(ActivityP: Record "Activity Work Programme"; Var ItemNo: code[20])
    var
        IRLine: Record "Activity Work Programme Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        CommittmentAccount: Code[100];
        Items: Record Item;
        BudgetEntry: Record "G/L Budget Entry";
        GLSetup: record "General Ledger Setup";
    begin
        GLSetup.get;
        BudgetEntry.Reset();
        // BudgetEntry.SetRange("Global Dimension 2 Code", PaymentRec."Shortcut Dimension 2 Code");
        BudgetEntry.SetFilter("Budget Name", GLSetup."Current Budget");
        // BudgetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
        if BudgetEntry.FindFirst()then begin
            CommittmentAccount:=BudgetEntry."G/L Account No.";
        end;
        ActivityP.CalcFields("Total Purchase Amount");
        IRLine.Reset;
        IRLine.SetRange("No.", ActivityP."No.");
        IRLine.SetRange("Purchase Type", IRLine."Purchase Type"::"Procurement Process");
        if IRLine.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(CommittmentAccount)then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", CommittmentAccount);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", ActivityP."Document Date");
                    // if GenLedSetup."Use Dimensions For Budget" then
                    //     GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, CommittmentAccount);
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", ActivityP."Document Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(IRLine."No.")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                    end;
                    Committments.Init;
                    Committments."Commitment No":=ActivityP."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Purchase Invoice";
                    Committments."Commitment Date":=ActivityP."Document Date";
                    Committments."Global Dimension 2":=ActivityP."Shortcut Dimension 2 Code";
                    Committments.Account:=CommittmentAccount;
                    Committments."Committed Amount":=ActivityP."Total Purchase Amount";
                    Committments.User:=UserId;
                    Committments."Document No":=ActivityP."No.";
                    Committments.No:=ActivityP."No.";
                    Committments."Line No.":=' ';
                    Committments."Account Type":=Committments."Account Type"::"G/L Account";
                    Committments."Account No.":=CommittmentAccount;
                    if GLAccount.Get(CommittmentAccount)then Committments."Account Name":=GLAccount.Name;
                    Committments.Description:=Committments."Account Name";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(ActivityP."No.", ActivityP."No.", Committments."Line No.")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        Message('Items Committed Successfully');
                    end;
                end;
            until IRLine.Next = 0;
        end;
    end;
    procedure EncumberPO(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        EntryNo:=EntryNo + 1;
        Committments.Init;
        Committments."Commitment No":=PurchLine."Document No.";
        Committments."Commitment Type":=Committments."Commitment Type"::Encumberance;
        Committments."Document Type":=Committments."Document Type"::LPO;
        //Insert same Commitment Date
        Committments."Commitment Date":=UncommittmentDate;
        Committments."Uncommittment Date":=PurchHeader."Posting Date";
        Committments."Dimension Set ID":=PurchLine."Dimension Set ID";
        Committments."Global Dimension 1":=PurchLine."Shortcut Dimension 1 Code";
        Committments."Global Dimension 2":=PurchLine."Shortcut Dimension 2 Code";
        Committments.Account:=PurchLine."No.";
        Committments."Account No.":=PurchLine."No.";
        Committments."Committed Amount":=PurchLine.Amount;
        Committments.User:=UserId;
        Committments."Document No":=PurchHeader."No.";
        Committments.No:=PurchLine."No.";
        Committments."Line No.":=PurchLine."Line No.";
        Committments."Entry No":=EntryNo;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
        Committments.Insert;
    end;
    procedure EncumberSinv(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        EntryNo:=EntryNo + 1;
        Committments.Init;
        Committments."Commitment No":=SalesLine."Document No.";
        Committments."Commitment Type":=Committments."Commitment Type"::Encumberance;
        Committments."Document Type":=Committments."Document Type"::LPO;
        //Insert same Commitment Date
        Committments."Commitment Date":=UncommittmentDate;
        Committments."Uncommittment Date":=SalesHeader."Posting Date";
        Committments."Dimension Set ID":=SalesLine."Dimension Set ID";
        Committments."Global Dimension 1":=SalesLine."Shortcut Dimension 1 Code";
        Committments."Global Dimension 2":=SalesLine."Shortcut Dimension 2 Code";
        Committments.Account:=SalesLine."No.";
        Committments."Account No.":=SalesLine."No.";
        Committments."Committed Amount":=SalesLine.Amount;
        Committments.User:=UserId;
        Committments."Document No":=SalesHeader."No.";
        Committments.No:=SalesLine."No.";
        Committments."Line No.":=SalesLine."Line No.";
        Committments."Entry No":=EntryNo;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
        Committments.Insert;
    end;
    procedure CheckPurchReqBeforeOrder(IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        IR.CalcFields("Original Committed Amount", "Amount Including VAT");
        if IR."Amount Including VAT" > IR."Original Committed Amount" then Error('You have Exceeded Budget for the original committed amount of %1 By %2, Current Total %3', IR."Original Committed Amount", Abs(IR."Original Committed Amount" - (IR."Amount Including VAT")), IR."Amount Including VAT");
    end;
    procedure PurchInvoiceCommittment(var PurchHeader: Record "Purchase Header"; var ErrorMsg: Text)
    var
        PurchaseLines: Record "Purchase Line";
        Committments: Record "Commitment Entries";
        Item: Record Item;
        GLAccount: Record "G/L Account";
        FixedAsset: Record "Fixed Asset";
        EntryNo: Integer;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        GenLedSetup: Record "General Ledger Setup";
        InventoryAccount: Code[20];
        AcquisitionAccount: Code[20];
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        CommittedAmount: Decimal;
        Vendor: Record Vendor;
        DisbursedAmount: Decimal;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        PurchaseLines.Reset;
        PurchaseLines.SetRange(PurchaseLines."Document No.", PurchHeader."No.");
        PurchaseLines.SetRange(PurchaseLines."Document Type", PurchaseLines."Document Type"::Invoice);
        if PurchaseLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(GetLPOAccountNo(PurchaseLines))then begin
                    Committments.Init;
                    Committments."Commitment No":=PurchHeader."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Purchase Invoice";
                    PurchHeader.Validate("Order Date");
                    if PurchHeader."Order Date" = 0D then Error('Please enter the order date');
                    Committments."Commitment Date":=PurchHeader."Order Date";
                    Committments."Global Dimension 1":=PurchaseLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PurchaseLines."Shortcut Dimension 2 Code";
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchaseLines.Type of PurchaseLines.Type::Item: begin
                        Item.Reset;
                        if Item.Get(PurchaseLines."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                        InventoryPostingSetup.Get(PurchaseLines."Location Code", Item."Inventory Posting Group");
                        //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                        Item.TestField("Item G/L Budget Account");
                        InventoryAccount:=Item."Item G/L Budget Account";
                        Committments.Account:=InventoryAccount;
                    end;
                    PurchaseLines.Type::"G/L Account": begin
                        Committments.Account:=PurchaseLines."No.";
                    end;
                    PurchaseLines.Type::"Fixed Asset": begin
                        if FixedAssetPG.Get(PurchaseLines."Posting Group")then begin
                            FixedAssetPG.TestField("Acquisition Cost Account");
                            AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                            Committments.Account:=AcquisitionAccount;
                        end;
                    end;
                    end;
                    Committments."Committed Amount":=PurchaseLines."Amount Including VAT";
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    case PurchaseLines.Type of PurchaseLines.Type::Item: begin
                        GLAccount.SetRange(GLAccount."No.", InventoryAccount);
                    end;
                    PurchaseLines.Type::"G/L Account": begin
                        GLAccount.SetRange(GLAccount."No.", PurchaseLines."No.");
                    end;
                    PurchaseLines.Type::"Fixed Asset": GLAccount.SetRange(GLAccount."No.", AcquisitionAccount);
                    end;
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    //Get budget amount avaliable
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PurchaseLines."Dimension Set ID");
                    DimMgt.GetShortcutDimensions(PurchaseLines."Dimension Set ID", ShortcutDimCode);
                    FetchDimValue(PurchaseLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PurchHeader."Order Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                        DisbursedAmount:=GLAccount."Disbursed Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    if PurchaseLines.Type = PurchaseLines.Type::Item then CommitmentEntries.SetRange(CommitmentEntries.Account, InventoryAccount);
                    if PurchaseLines.Type = PurchaseLines.Type::"G/L Account" then CommitmentEntries.SetRange(CommitmentEntries.Account, PurchaseLines."No.");
                    if PurchaseLines.Type = PurchaseLines.Type::"Fixed Asset" then CommitmentEntries.SetRange(CommitmentEntries.Account, AcquisitionAccount);
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PurchHeader."Order Date");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    Commit;
                    if LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.")then Message('Line No %1 has been commited', PurchaseLines."Line No.")
                    else if CommittedAmount + PurchaseLines."Amount Including VAT" > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', PurchaseLines."Shortcut Dimension 1 Code", PurchaseLines."Shortcut Dimension 2 Code", Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount, PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount, PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError:=true;
                            Commit;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=PurchHeader."No.";
                    Committments.No:=PurchaseLines."No.";
                    Committments."Line No.":=PurchaseLines."Line No.";
                    Committments."Account Type":=Committments."Account Type"::Vendor;
                    Committments."Account No.":=PurchaseLines."Buy-from Vendor No.";
                    if Vendor.Get(PurchaseLines."Buy-from Vendor No.")then Committments."Account Name":=Vendor.Name;
                    Committments.Description:=PurchaseLines.Description;
                    Committments."Dimension Set ID":=PurchaseLines."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        PurchaseLines.Committment:=true;
                        PurchaseLines.Modify;
                        if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Line Amount")));
                    end;
                end;
            until PurchaseLines.Next = 0;
        end;
    end;
    procedure UncommitPurchInvoice(var IR: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
        IRLine: Record "Purchase Line";
    begin
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        EntryNo:=EntryNo + 1;
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange("Document Type", IR."Document Type");
        if IRLine.FindFirst then repeat Committments.Init;
                Committments."Commitment No":=IRLine."Document No.";
                Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                //Insert same Commitment Date
                Committments."Commitment Date":=UncommittmentDate;
                Committments."Uncommittment Date":=IR."Posting Date";
                Committments."Dimension Set ID":=IR."Dimension Set ID";
                Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
                Committments."Dimension Set ID":=IR."Dimension Set ID";
                Committments.Account:=IRLine."No.";
                Committments."Committed Amount":=-IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
                Committments.User:=UserId;
                Committments."Document No":=IR."No.";
                Committments.No:=IRLine."No.";
                Committments."Line No.":=IRLine."Line No.";
                Committments."Entry No":=EntryNo;
                GeneralLedgerSetup.Get;
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code":=GetCommittedBudget(IRLine."Document No.");
                Committments.Insert;
                EntryNo:=EntryNo + 1;
            until IRLine.Next = 0;
    end;
    procedure CheckPurchInvoiceCommittment(IR: Record "Purchase Header")
    var
        IRLine: Record "Purchase Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        ErrorMsg: Label 'You have Exceeded Budget for G/L Account No %1 Fund %5 By %2 Budget Available %3 CommittedAmount %4';
    begin
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(IRLine."No.")then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", IRLine."No.");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Posting Date" = 0D then Error('Please insert the posting date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(IRLine."No.")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then Error(ErrorMsg, Committments.Account, Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable, CommittedAmount, IRLine."Shortcut Dimension 1 Code");
                    end;
                end;
            until IRLine.Next = 0;
        end;
    end;
    procedure CheckStaffReqCommittment(StaffReq: Record "Staff Travel Request")
    var
        StaffReqLines: Record "Staff Travel Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        StaffReqLines.Reset;
        StaffReqLines.SetRange("No.", StaffReq."No.");
        StaffReqLines.SetRange("Account Type", StaffReqLines."Account Type"::"G/L Account");
        if StaffReqLines.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(StaffReqLines."Account No")then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", StaffReqLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", StaffReq."Request Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, StaffReqLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if StaffReq."Request Date" = 0D then Error('Please insert the request date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", StaffReq."Request Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(StaffReqLines."Account No")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + StaffReqLines."Estimated Cost" > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 Fund %5 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + StaffReqLines."Estimated Cost")), BudgetAvailable - CommittedAmount, StaffReqLines."Shortcut Dimension 1 Code");
                    end;
                end;
            until StaffReqLines.Next = 0;
        end;
    end;
    procedure StaffReqCommittment(var StaffReq: Record "Staff Travel Request"; var ErrorMsg: Text)
    var
        StaffReqLines: Record "Staff Travel Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF ImprestHeader.Status<>ImprestHeader.Status::Released THEN
            ERROR('The imprest is not fully approved');
        */
        StaffReqLines.SetRange(StaffReqLines."No.", StaffReq."No.");
        if StaffReqLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat Committments.Init;
                Committments."Commitment No":=StaffReq."No.";
                Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                StaffReq.TestField("Request Date");
                Committments."Commitment Date":=StaffReq."Request Date";
                Committments."Global Dimension 1":=StaffReqLines."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2":=StaffReqLines."Shortcut Dimension 2 Code";
                Committments.Account:=StaffReqLines."Account No";
                Committments."Committed Amount":=StaffReqLines."Estimated Cost";
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.Get;
                GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                GLAccount.SetRange(GLAccount."No.", StaffReqLines."Account No");
                if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", StaffReqLines."Dimension Set ID");
                //Get Dimensions
                DimMgt.GetShortcutDimensions(StaffReqLines."Dimension Set ID", ShortcutDimCode);
                /*IF ShortcutDimCode[1]<>'' THEN
                GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                IF ShortcutDimCode[2]<>'' THEN
                GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                IF ShortcutDimCode[3]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                IF ShortcutDimCode[4]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                IF ShortcutDimCode[5]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                IF ShortcutDimCode[6]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                FetchDimValue(StaffReqLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                //Get budget amount avaliable
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", StaffReq."Request Date");
                if GLAccount.Find('-')then begin
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                    BudgetAmount:=GLAccount."Approved Budget";
                    Expenses:=GLAccount."Net Change";
                    BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                end;
                //Get committed Amount
                CommittedAmount:=0;
                CommitmentEntries.Reset;
                CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                CommitmentEntries.SetRange(CommitmentEntries.Account, StaffReqLines."Account No");
                if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", StaffReqLines."Dimension Set ID");
                CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                if StaffReq."Request Date" = 0D then Error('Please insert the request date');
                CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", StaffReq."Request Date");
                CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                CommittedAmount:=CommitmentEntries."Committed Amount";
                LineError:=false;
                if LineCommitted(StaffReq."No.", StaffReqLines."Account No", StaffReqLines."Line No.")then Message('Line No %1 has been commited', StaffReqLines."Line No.")
                else if CommittedAmount + StaffReqLines."Estimated Cost" > BudgetAvailable then begin
                        if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + StaffReqLines."Estimated Cost")), BudgetAvailable - CommittedAmount, StaffReqLines.FieldCaption("Shortcut Dimension 1 Code"), StaffReqLines.FieldCaption("Shortcut Dimension 2 Code"))
                        else
                            ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + StaffReqLines."Estimated Cost")), BudgetAvailable - CommittedAmount, StaffReqLines.FieldCaption("Shortcut Dimension 1 Code"), StaffReqLines.FieldCaption("Shortcut Dimension 2 Code"));
                        LineError:=true;
                    end;
                Committments.User:=UserId;
                Committments."Document No":=StaffReq."No.";
                Committments.No:=StaffReqLines."Account No";
                Committments."Line No.":=StaffReqLines."Line No.";
                Committments."Account Type":=Committments."Account Type"::Customer;
                Committments."Account No.":=StaffReq."Employee No.";
                if Customer.Get(StaffReq."Employee No.")then Committments."Account Name":=Customer.Name;
                Committments.Description:=StaffReq."Reason for Travel";
                Committments."Dimension Set ID":=StaffReqLines."Dimension Set ID";
                GeneralLedgerSetup.Get;
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                //Check whether line is committed.
                if not LineCommitted(StaffReq."No.", StaffReqLines."Account No", StaffReqLines."Line No.")then begin
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    Committments.Insert;
                    StaffReqLines.Committed:=true;
                    StaffReqLines.Modify;
                    if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + StaffReqLines."Estimated Cost")));
                end;
            until StaffReqLines.Next = 0;
        end;
    //CreatePV(ImprestHeader);
    end;
    procedure EncumberPOStaffReq(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        EntryNo:=EntryNo + 1;
        Committments.Init;
        Committments."Commitment No":=PurchLine."Document No.";
        Committments."Commitment Type":=Committments."Commitment Type"::Encumberance;
        //Insert same Commitment Date
        Committments."Commitment Date":=UncommittmentDate;
        Committments."Uncommittment Date":=PurchHeader."Posting Date";
        Committments."Dimension Set ID":=PurchHeader."Dimension Set ID";
        //Committments."Global Dimension 1":=IRLine."Global Dimension 1 Code";
        //Committments."Global Dimension 2":=IRLine."Global Dimension 2 Code";
        Committments.Account:=PurchLine."No.";
        Committments."Committed Amount":=PurchLine.Amount;
        Committments.User:=UserId;
        Committments."Document No":=PurchHeader."No.";
        Committments.No:=PurchLine."No.";
        Committments."Line No.":=PurchLine."Line No.";
        Committments."Entry No":=EntryNo;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code":=GetCommittedBudget(PurchLine."Document No.");
        Committments.Insert;
    end;
    procedure UncommitPurchInvoiceStaffReq(var StaffReq: Record "Staff Travel Request")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
        StaffReqLines: Record "Staff Travel Line";
    begin
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        EntryNo:=EntryNo + 1;
        StaffReqLines.Reset;
        StaffReqLines.SetRange("No.", StaffReq."No.");
        if StaffReqLines.Find('-')then repeat Committments.Init;
                Committments."Commitment No":=StaffReqLines."No.";
                Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                //Insert same Commitment Date
                Committments."Commitment Date":=UncommittmentDate;
                Committments."Uncommittment Date":=StaffReq."Request Date";
                Committments."Dimension Set ID":=StaffReqLines."Dimension Set ID";
                //Committments."Global Dimension 1":=StaffReqLines."Global Dimension 1 Code";
                //Committments."Global Dimension 2":=StaffReqLines."Global Dimension 2 Code";
                Committments.Account:=StaffReqLines."No.";
                Committments."Committed Amount":=-StaffReqLines."Estimated Cost";
                Committments.User:=UserId;
                Committments."Document No":=StaffReq."No.";
                Committments.No:=StaffReqLines."No.";
                Committments."Line No.":=StaffReqLines."Line No.";
                Committments."Entry No":=EntryNo;
                Committments.Insert;
                EntryNo:=EntryNo + 1;
            until StaffReqLines.Next = 0;
    end;
    procedure CheckPettyCashSurrenderCommittment(PCash: Record Payments)
    var
        PCashLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        PCashLines.Reset;
        PCashLines.SetRange(No, PCash."No.");
        PCashLines.SetRange("Account Type", PCashLines."Account Type"::"G/L Account");
        if PCashLines.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(PCashLines."Account No")then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PCashLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PCash.Date);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PCashLines."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PCashLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PCash.Date = 0D then Error('Please insert the Petty Cash Surrender date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PCash.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(PCashLines."Account No")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + (PCashLines."Actual Spent" - PCashLines.Amount) > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + (PCashLines."Actual Spent" - PCashLines.Amount))), BudgetAvailable - CommittedAmount);
                    end;
                end;
            until PCashLines.Next = 0;
        end;
    end;
    procedure PettyCashSurrenderCommittment(var PCash: Record Payments; var ErrorMsg: Text)
    var
        PCashLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF ImprestHeader.Status<>ImprestHeader.Status::Released THEN
            ERROR('The imprest is not fully approved');
        */
        PCashLines.SetRange(PCashLines.No, PCash."No.");
        if PCashLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(PCashLines."Account No")then begin
                    Committments.Init;
                    Committments."Commitment No":=PCash."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    PCash.TestField(Date);
                    Committments."Commitment Date":=PCash.Date;
                    Committments."Global Dimension 1":=PCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PCashLines."Shortcut Dimension 2 Code";
                    Committments.Account:=PCashLines."Account No";
                    Committments."Committed Amount":=PCashLines."Actual Spent" - PCashLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PCashLines."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(PCashLines."Dimension Set ID", ShortcutDimCode);
                    /*IF ShortcutDimCode[1]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    IF ShortcutDimCode[2]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    IF ShortcutDimCode[3]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    IF ShortcutDimCode[4]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    IF ShortcutDimCode[5]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    IF ShortcutDimCode[6]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(PCashLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PCash.Date);
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Approved Budget";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PCashLines."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PCash.Date = 0D then Error('Please insert the Petty Cash Surrender date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PCash.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(PCash."No.", PCashLines."Account No", PCashLines."Line No")then Message('Line No %1 has been commited', PCashLines."Line No")
                    else if(CommittedAmount + (PCashLines."Actual Spent" - PCashLines.Amount)) > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PCashLines.Amount)), BudgetAvailable - CommittedAmount, PCashLines.FieldCaption("Shortcut Dimension 1 Code"), PCashLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PCashLines.Amount)), BudgetAvailable - CommittedAmount, PCashLines.FieldCaption("Shortcut Dimension 1 Code"), PCashLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=PCash."No.";
                    Committments.No:=PCashLines."Account No";
                    Committments."Line No.":=PCashLines."Line No";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=PCash."Account No.";
                    if Customer.Get(PCash."Account No.")then Committments."Account Name":=Customer.Name;
                    CommitmentEntries.Description:=PCashLines.Description;
                    CommitmentEntries."Dimension Set ID":=PCashLines."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PCash."No.", PCashLines."Account No", PCashLines."Line No") and ((PCashLines."Actual Spent" - PCashLines.Amount) > 0)then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        PCashLines.Committed:=true;
                        PCashLines.Modify;
                        if not LineError and ((PCashLines."Actual Spent" - PCashLines.Amount) > 0)then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + PCashLines."Actual Spent" - PCashLines.Amount)));
                    end;
                end;
            until PCashLines.Next = 0;
        end;
    //CreatePV(ImprestHeader);
    end;
    procedure ReversePurchReqCommittment(var PurchReq: Record "Internal Request Header")
    var
        Committment: Record "Commitment Entries";
        PurchReqLine: Record "Internal Request Line";
        EntryNo: Integer;
    begin
        //IF ConfirmMsg THEN
        //if Confirm('Are you sure you want to reverse the committed entries for Purchase Requisition no ' + PurchReq."No." + '?', false) = true then
        //EXIT;
        Committment.Reset;
        Committment.SetRange(Committment."Commitment No", PurchReq."No.");
        if Committment.Find('-')then begin
            Committment.DeleteAll;
        end;
        PurchReqLine.Reset;
        PurchReqLine.SetRange("Document Type", PurchReq."Document Type");
        PurchReqLine.SetRange("Document No.", PurchReq."No.");
        if PurchReqLine.FindFirst then begin
            if Committment.FindLast then EntryNo:=Committment."Entry No";
            repeat //Insert reversal entries into the committment table
                if LineCommitted(PurchReq."No.", PurchReqLine."No.", PurchReqLine."Line No.")then begin
                    Committment.Init;
                    Committment."Commitment No":=PurchReq."No.";
                    Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                    Committment."Commitment Date":=PurchReq."Posting Date";
                    Committment."Global Dimension 1":=PurchReqLine."Shortcut Dimension 1 Code";
                    Committment."Global Dimension 2":=PurchReqLine."Shortcut Dimension 2 Code";
                    Committment."Dimension Set ID":=PurchReqLine."Dimension Set ID";
                    Committment.Account:=PurchReqLine."No.";
                    Committment."Committed Amount":=-PurchReqLine.Amount;
                    Committment.User:=UserId;
                    Committment."Document No":=PurchReq."No.";
                    Committment.No:=PurchReqLine."No.";
                    Committment."Line No.":=PurchReqLine."Line No.";
                    EntryNo:=EntryNo + 1;
                    Committment."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committment."Budget Code":=GeneralLedgerSetup."Current Budget";
                    Committment.Insert;
                    //Mark imprest lines entries as uncommited
                    PurchReqLine.Committed:=false;
                    PurchReqLine.Modify;
                end;
            until PurchReqLine.Next = 0;
        end;
        PurchReq.Uncommitted:=true;
        PurchReq.Modify;
        Message('Committed entries for Requisition No %1 Have been reversed Successfully', PurchReq."No.");
    end;
    procedure ReverseStaffReqCommittment(var StaffReq: Record "Staff Travel Request")
    var
        Committment: Record "Commitment Entries";
        StaffReqLine: Record "Staff Travel Line";
        EntryNo: Integer;
    begin
        //IF ConfirmMsg THEN
        if Confirm('Are you sure you want to reverse the committed entries for Purchase Requisition no ' + StaffReq."No." + '?', false) = true then //EXIT;
            Committment.Reset;
        Committment.SetRange(Committment."Commitment No", StaffReq."No.");
        if Committment.Find('-')then begin
            Committment.DeleteAll;
        end;
        StaffReqLine.Reset;
        StaffReqLine.SetRange("No.", StaffReq."No.");
        if StaffReqLine.FindFirst then begin
            if Committment.FindLast then EntryNo:=Committment."Entry No";
            repeat //Insert reversal entries into the committment table
                if LineCommitted(StaffReq."No.", StaffReqLine."No.", StaffReqLine."Line No.")then begin
                    Committment.Init;
                    Committment."Commitment No":=StaffReq."No.";
                    Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                    Committment."Commitment Date":=StaffReq."Request Date";
                    Committment."Dimension Set ID":=StaffReqLine."Dimension Set ID";
                    Committment."Global Dimension 1":=StaffReqLine."Shortcut Dimension 1 Code";
                    Committment."Global Dimension 2":=StaffReqLine."Shortcut Dimension 2 Code";
                    Committment.Account:=StaffReqLine."No.";
                    Committment."Committed Amount":=-StaffReqLine.Amount;
                    Committment.User:=UserId;
                    Committment."Document No":=StaffReq."No.";
                    Committment.No:=StaffReqLine."No.";
                    Committment."Line No.":=StaffReqLine."Line No.";
                    EntryNo:=EntryNo + 1;
                    Committment."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committment."Budget Code":=GeneralLedgerSetup."Current Budget";
                    Committment.Insert;
                    //Mark imprest lines entries as uncommited
                    StaffReqLine.Committed:=false;
                    StaffReqLine.Modify;
                end;
            until StaffReqLine.Next = 0;
        end;
        Message('Committed entries for Requisition No %1 Have been reversed Successfully', StaffReq."No.");
    end;
    procedure UnencumberPO(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
        EncumberedAmt: Decimal;
    begin
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        Committments.Reset;
        Committments.SetRange("Commitment No", PurchHeader."No.");
        Committments.SetRange("Commitment Type", Committments."Commitment Type"::Encumberance);
        Committments.SetRange(No, PurchLine."No.");
        Committments.SetRange("Line No.", PurchLine."Line No.");
        if Committments.Find('-')then begin
            UncommittmentDate:=Committments."Commitment Date";
            EncumberedAmt:=Committments."Committed Amount";
        end;
        if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.")then begin
            Committments.Init;
            Committments."Commitment No":=PurchHeader."No.";
            Committments."Commitment Type":=Committments."Commitment Type"::"Encumberance Reversal";
            //Insert same Commitment Date
            Committments."Commitment Date":=UncommittmentDate;
            Committments."Uncommittment Date":=PurchHeader."Posting Date";
            Committments."Dimension Set ID":=PurchLine."Dimension Set ID";
            Committments."Global Dimension 1":=PurchLine."Shortcut Dimension 1 Code";
            Committments."Global Dimension 2":=PurchLine."Shortcut Dimension 2 Code";
            Committments.Account:=PurchLine."No.";
            Committments."Account No.":=PurchLine."No.";
            Committments."Committed Amount":=-EncumberedAmt;
            Committments.User:=UserId;
            Committments."Document No":=PurchHeader."No.";
            Committments.No:=PurchLine."No.";
            Committments."Line No.":=PurchLine."Line No.";
            EntryNo:=EntryNo + 1;
            Committments."Entry No":=EntryNo;
            GeneralLedgerSetup.Get;
            GeneralLedgerSetup.TestField("Current Budget");
            Committments."Budget Code":=GetCommittedBudget(PurchHeader."No.");
            Committments.Insert;
        end;
    end;
    procedure StaffClaimCommittment(Claim: Record Payments; var ErrorMsg: Text)
    var
        ClaimLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF PettyCash.Status<>PettyCash.Status::Released THEN
            ERROR('The petty cash voucher is not fully approved');
        */
        ClaimLines.Reset;
        ClaimLines.SetRange(No, Claim."No.");
        ClaimLines.SetRange("Account Type", ClaimLines."Account Type"::"G/L Account");
        if ClaimLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat //Check if not Medical ceiling claim
                if not IsMedicalCeilingClaim(ClaimLines."Expenditure Type")then begin
                    if IsAccountVotebookEntry(ClaimLines."Account No")then begin
                        if CheckImprestCostOfSales(ClaimLines."Account No", ClaimLines."Expenditure Type") = false then begin
                            Committments.Init;
                            Committments."Commitment No":=Claim."No.";
                            Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                            Committments."Document Type":=Committments."Document Type"::"Staff Claim";
                            Claim.TestField(Date);
                            Committments."Commitment Date":=Claim.Date;
                            Committments."Dimension Set ID":=ClaimLines."Dimension Set ID";
                            Committments."Global Dimension 1":=ClaimLines."Shortcut Dimension 1 Code";
                            Committments."Global Dimension 2":=ClaimLines."Shortcut Dimension 2 Code";
                            Committments.Account:=ClaimLines."Account No";
                            Committments."Committed Amount":=ClaimLines.Amount;
                            //Confirm the Amount to be issued does not exceed the budget and amount Committed
                            //Get Budget for the G/L
                            GenLedSetup.Get;
                            GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                            GLAccount.SetRange(GLAccount."No.", ClaimLines."Account No");
                            if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ClaimLines."Dimension Set ID");
                            //Get Dimensions
                            DimMgt.GetShortcutDimensions(ClaimLines."Dimension Set ID", ShortcutDimCode);
                            /*
                            IF ShortcutDimCode[1]<>'' THEN
                            GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                            IF ShortcutDimCode[2]<>'' THEN
                            GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                            IF ShortcutDimCode[3]<>'' THEN
                            GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                            IF ShortcutDimCode[4]<>'' THEN
                            GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                            IF ShortcutDimCode[5]<>'' THEN
                            GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                            IF ShortcutDimCode[6]<>'' THEN
                            GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);
                            */
                            FetchDimValue(ClaimLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                            //Get budget amount avaliable
                            GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Claim.Date);
                            if GLAccount.Find('-')then begin
                                GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                                BudgetAmount:=GLAccount."Approved Budget";
                                Expenses:=GLAccount."Net Change";
                                BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                            end;
                            //Get committed Amount
                            CommittedAmount:=0;
                            CommitmentEntries.Reset;
                            CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                            CommitmentEntries.SetRange(CommitmentEntries.Account, ClaimLines."Account No");
                            if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ClaimLines."Dimension Set ID");
                            CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                            if Claim.Date = 0D then Error('Please insert the petty cash date');
                            CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Claim.Date);
                            CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                            CommittedAmount:=CommitmentEntries."Committed Amount";
                            LineError:=false;
                            if LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No")then Message('Line No %1 has been committed', ClaimLines."Line No")
                            else if CommittedAmount + ClaimLines.Amount > BudgetAvailable then begin
                                    if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)), BudgetAvailable - CommittedAmount, ClaimLines.FieldCaption("Shortcut Dimension 1 Code"), ClaimLines.FieldCaption("Shortcut Dimension 2 Code"))
                                    else
                                        ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)), BudgetAvailable - CommittedAmount, ClaimLines.FieldCaption("Shortcut Dimension 1 Code"), ClaimLines.FieldCaption("Shortcut Dimension 2 Code"));
                                    LineError:=true;
                                end;
                            Committments.User:=UserId;
                            Committments."Document No":=Claim."No.";
                            Committments.No:=ClaimLines."Account No";
                            Committments."Line No.":=ClaimLines."Line No";
                            Committments."Account Type":=Committments."Account Type"::Customer;
                            Committments."Account No.":=Claim."Account No.";
                            if GLAccount.Get(Claim."Account No.")then Committments."Account Name":=GLAccount.Name;
                            CommitmentEntries.Description:=ClaimLines.Description;
                            CommitmentEntries."Dimension Set ID":=ClaimLines."Dimension Set ID";
                            GeneralLedgerSetup.Get;
                            GeneralLedgerSetup.TestField("Current Budget");
                            Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                            //Check whether line is committed.
                            if not LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No")then begin
                                EntryNo:=EntryNo + 1;
                                Committments."Entry No":=EntryNo;
                                Committments.Insert;
                                ClaimLines.Committed:=true;
                                ClaimLines.Modify;
                            // if not LineError then
                            //     Message('Items Committed Successfully and the balance is %1',
                            //     Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)));
                            end;
                        end;
                    end;
                end;
            until ClaimLines.Next = 0;
        end;
    end;
    procedure CheckStaffClaimCommittment(Claim: Record Payments)
    var
        ClaimLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        ClaimLines.Reset;
        ClaimLines.SetRange(No, Claim."No.");
        ClaimLines.SetRange("Account Type", ClaimLines."Account Type"::"G/L Account");
        if ClaimLines.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(ClaimLines."Account No")then begin
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ClaimLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Claim.Date);
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ClaimLines."Dimension Set ID");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ClaimLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if Claim.Date = 0D then Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Claim.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if GLAccount.Get(ClaimLines."Account No")then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + ClaimLines.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)), BudgetAvailable - CommittedAmount);
                    end;
                end;
            until ClaimLines.Next = 0;
        end;
    end;
    procedure PurchQuoteCommittment(var IR: Record "Quote Evaluation Header"; var ErrorMsg: Text)
    var
        IRLine: Record "Quote Evaluation";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF IR.Status<>IR.Status::Released THEN
            ERROR('The imprest is not fully approved');*/
        IRLine.SetRange(IRLine."Quote No", IR."Quote No");
        IRLine.SetRange(IRLine.Awarded, true);
        if IRLine.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat Committments.Init;
                Committments."Commitment No":=IR."Quote No";
                Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                //IR.TESTFIELD("Posting Date");
                Committments."Commitment Date":=Today;
                Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
                Committments.Account:=IRLine."Quote No";
                Committments."Committed Amount":=IRLine.Amount;
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.Get;
                GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                GLAccount.SetRange(GLAccount."No.", IRLine."No.");
                if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                //Get Dimensions
                DimMgt.GetShortcutDimensions(IRLine."Dimension Set ID", ShortcutDimCode);
                /*IF ShortcutDimCode[1]<>'' THEN
                GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                IF ShortcutDimCode[2]<>'' THEN
                GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                IF ShortcutDimCode[3]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                IF ShortcutDimCode[4]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                IF ShortcutDimCode[5]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                IF ShortcutDimCode[6]<>'' THEN
                GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                FetchDimValue(IRLine."Dimension Set ID", ShortcutDimCode, DimValueName);
                //Get budget amount avaliable
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Today);
                if GLAccount.Find('-')then begin
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                    BudgetAmount:=GLAccount."Approved Budget";
                    Expenses:=GLAccount."Net Change";
                    BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                end;
                //Get committed Amount
                CommittedAmount:=0;
                CommitmentEntries.Reset;
                CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", IRLine."Dimension Set ID");
                CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                //     IF IR."Posting Date"=0D THEN
                //        ERROR('Please insert the imprest date');
                CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Today);
                CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                CommittedAmount:=CommitmentEntries."Committed Amount";
                LineError:=false;
                if LineCommitted(IR."Quote No", IRLine."No.", IRLine."Line No")then Message('Line No %1 has been commited', IRLine."Line No")
                else if CommittedAmount + IRLine.Amount > BudgetAvailable then begin
                        if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"))
                        else
                            ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"));
                        LineError:=true;
                    end;
                Committments.User:=UserId;
                Committments."Document No":=IR."Quote No";
                Committments.No:=IRLine."No.";
                Committments."Line No.":=IRLine."Line No";
                Committments."Account Type":=Committments."Account Type"::Customer;
                Committments."Account No.":=IRLine."No.";
                if Customer.Get(IRLine."No.")then Committments."Account Name":=Customer.Name;
                Committments.Description:=IRLine.Description;
                Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                GeneralLedgerSetup.Get;
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                //Check whether line is committed.
                if not LineCommitted(IR."Quote No", IRLine."No.", IRLine."Line No")then begin
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    Committments.Insert;
                    IRLine.Committed:=true;
                    IRLine.Modify;
                // if not LineError then
                //     Message('Items Committed Successfully and the balance is %1',
                //     Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)));
                end;
            until IRLine.Next = 0;
        end;
    //CreatePV(IR);
    end;
    procedure CheckPurchQuoteCommittment(IR: Record "Quote Evaluation Header")
    var
        IRLine: Record "Quote Evaluation";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        IRLine.Reset;
        IRLine.SetRange("Quote No", IR."Quote No");
        IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        IRLine.SetRange(Awarded, true);
        if IRLine.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.Get;
                GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                GLAccount.SetRange(GLAccount."No.", IRLine."No.");
                //Get budget amount avaliable
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Today);
                if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                if GLAccount.Find('-')then begin
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    BudgetAmount:=GLAccount."Budgeted Amount";
                    Expenses:=GLAccount."Net Change";
                    BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                end;
                //Get committed Amount
                CommittedAmount:=0;
                CommitmentEntries.Reset;
                CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                //     IF IR."Posting Date"=0D THEN
                //        ERROR('Please insert the posting date');
                CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Today);
                CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                CommittedAmount:=CommitmentEntries."Committed Amount";
                if GLAccount.Get(IRLine."No.")then;
                if GLAccount."Votebook Entry" then begin
                    if CommittedAmount + IRLine.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                end;
            until IRLine.Next = 0;
        end;
    end;
    procedure PVCommittment(PV: Record Payments; var ErrorMsg: Text)
    var
        PVLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        PVLines.Reset;
        PVLines.SetRange(No, PV."No.");
        PVLines.SetRange("Account Type", PVLines."Account Type"::"G/L Account");
        if PVLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if not IsClaimOrImprestPayment(PVLines."Expenditure Type", 2)then begin
                    if IsAccountVotebookEntry(PVLines."Account No")then begin
                        Committments.Init;
                        Committments."Commitment No":=PV."No.";
                        Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                        PV.TestField(Date);
                        Committments."Commitment Date":=PV.Date;
                        Committments."Dimension Set ID":=PVLines."Dimension Set ID";
                        Committments."Global Dimension 1":=PVLines."Shortcut Dimension 1 Code";
                        Committments."Global Dimension 2":=PVLines."Shortcut Dimension 2 Code";
                        Committments.Account:=PVLines."Account No";
                        Committments."Committed Amount":=PVLines.Amount;
                        //Confirm the Amount to be issued does not exceed the budget and amount Committed
                        //Get Budget for the G/L
                        GenLedSetup.Get;
                        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                        GLAccount.SetRange(GLAccount."No.", PVLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PVLines."Dimension Set ID");
                        //Get Dimensions
                        DimMgt.GetShortcutDimensions(PVLines."Dimension Set ID", ShortcutDimCode);
                        /*
                        IF ShortcutDimCode[1]<>'' THEN
                        GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                        IF ShortcutDimCode[2]<>'' THEN
                        GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                        IF ShortcutDimCode[3]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                        IF ShortcutDimCode[4]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                        IF ShortcutDimCode[5]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                        IF ShortcutDimCode[6]<>'' THEN
                        GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);
                        */
                        FetchDimValue(PVLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                        //Get budget amount avaliable
                        GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PV.Date);
                        if GLAccount.Find('-')then begin
                            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget", Encumberance);
                            BudgetAmount:=GLAccount."Approved Budget";
                            Expenses:=GLAccount."Net Change";
                            BudgetAvailable:=GLAccount."Approved Budget" - (GLAccount."Net Change"); //+GLAccount.Encumberance);
                        end;
                        //Get committed Amount
                        CommittedAmount:=0;
                        CommitmentEntries.Reset;
                        CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                        CommitmentEntries.SetRange(CommitmentEntries.Account, PVLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PVLines."Dimension Set ID");
                        CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                        if PV.Date = 0D then Error('Please insert the pv date');
                        CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PV.Date);
                        CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                        CommittedAmount:=CommitmentEntries."Committed Amount";
                        LineError:=false;
                        if LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No")then Message('Line No %1 has been commited', PVLines."Line No")
                        else if CommittedAmount + PVLines.Amount > BudgetAvailable then begin
                                if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)), BudgetAvailable - CommittedAmount, PVLines.FieldCaption("Shortcut Dimension 1 Code"), PVLines.FieldCaption("Shortcut Dimension 2 Code"))
                                else
                                    ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)), BudgetAvailable - CommittedAmount, PVLines.FieldCaption("Shortcut Dimension 1 Code"), PVLines.FieldCaption("Shortcut Dimension 2 Code"));
                                LineError:=true;
                            end;
                        Committments.User:=UserId;
                        Committments."Document No":=PV."No.";
                        Committments.No:=PVLines."Account No";
                        Committments."Line No.":=PVLines."Line No";
                        Committments."Account Type":=Committments."Account Type"::Customer;
                        Committments."Account No.":=PV."Account No.";
                        if GLAccount.Get(PV."Account No.")then Committments."Account Name":=GLAccount.Name;
                        Committments.Description:=PVLines.Description;
                        Committments."Dimension Set ID":=PVLines."Dimension Set ID";
                        Committments."Document Type":=Committments."Document Type"::"Payment Voucher";
                        GeneralLedgerSetup.Get;
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                        //Check whether line is committed.
                        if not LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No")then begin
                            EntryNo:=EntryNo + 1;
                            Committments."Entry No":=EntryNo;
                            Committments.Insert;
                            PVLines.Committed:=true;
                            PVLines.Modify;
                            if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)));
                        end;
                    end;
                end;
            until PVLines.Next = 0;
        end;
    end;
    procedure ReversePVCommittment(var PV: Record Payments)
    var
        Committment: Record "Commitment Entries";
        PVLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        if Confirm('Are you sure you want to reverse the committed entries for PV no ' + PV."No." + '?', false) = true then begin
            Committment.Reset;
            Committment.SetRange(Committment."Commitment No", PV."No.");
            if Committment.Find('-')then begin
                Committment.DeleteAll;
            end;
            PVLines.Reset;
            PVLines.SetRange(No, PV."No.");
            if PVLines.FindFirst then begin
                if Committment.FindLast then EntryNo:=Committment."Entry No";
                repeat //Insert reversal entries into the committment table
                    if LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No")then begin
                        Committment.Init;
                        Committment."Commitment No":=PV."No.";
                        Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                        Committment."Commitment Date":=PV.Date;
                        Committment."Dimension Set ID":=PVLines."Dimension Set ID";
                        Committment."Global Dimension 1":=PVLines."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2":=PVLines."Shortcut Dimension 2 Code";
                        Committment."Dimension Set ID":=PVLines."Dimension Set ID";
                        Committment.Account:=PVLines."Account No";
                        Committment."Committed Amount":=-PVLines.Amount;
                        Committment.User:=UserId;
                        Committment."Document No":=PV."No.";
                        Committment.No:=PVLines."Account No";
                        Committment."Line No.":=PVLines."Line No";
                        EntryNo:=EntryNo + 1;
                        Committment."Document Type":=Committment."Document Type"::"Payment Voucher";
                        Committment."Entry No":=EntryNo;
                        GeneralLedgerSetup.Get;
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committment."Budget Code":=GetCommittedBudget(PV."No.");
                        Committment.Insert;
                        //Mark imprest lines entries as uncommited
                        PVLines.Committed:=false;
                        PVLines.Modify;
                    end;
                until PVLines.Next = 0;
            end;
        //MESSAGE('Committed entries for Petty Cash No %1 Have been reversed Successfully',PV."No.");
        end;
    end;
    procedure UncommitPV(var PV: Record Payments)
    var
        PVLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
    begin
        PVLines.SetRange(No, PV."No.");
        if PVLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            Committments.Reset;
            Committments.SetRange(Committments."Commitment No", PV."No.");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Commitment);
            if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
            repeat if LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No")then begin
                    Committments.Init;
                    Committments."Commitment No":=PV."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type":=Committments."Document Type"::"Payment Voucher";
                    //Insert same Commitment Date
                    Committments."Commitment Date":=UncommittmentDate;
                    Committments."Uncommittment Date":=PV.Date;
                    Committments."Dimension Set ID":=PV."Dimension Set ID";
                    Committments."Global Dimension 1":=PVLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PVLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID":=PVLines."Dimension Set ID";
                    Committments.Account:=PVLines."Account No";
                    Committments."Committed Amount":=-LastCommittment(PV."No.", PVLines."Account No", PVLines."Line No");
                    Committments.User:=UserId;
                    Committments."Document No":=PV."No.";
                    Committments.No:=PVLines."Account No";
                    Committments."Line No.":=PVLines."Line No";
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GetCommittedBudget(PV."No.");
                    Committments.Insert;
                end;
            until PVLines.Next = 0;
        end;
    end;
    procedure StoreReqCommittment(var IR: Record "Internal Request Header"; var ErrorMsg: Text)
    var
        IRLine: Record "Internal Request Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ErrorMsg:='';
        /*
        IF IR.Status<>IR.Status::Released THEN
            ERROR('The imprest is not fully approved');*/
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        if IRLine.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(IRLine."Item G/L Budget Account")then begin
                    Committments.Init;
                    Committments."Commitment No":=IR."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Store Requisition";
                    IR.TestField("Document Date");
                    Committments."Commitment Date":=Today;
                    Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
                    if IRLine.Type <> IRLine.Type::Item then Committments.Account:=IRLine."No."
                    else
                        Committments.Account:=IRLine."Item G/L Budget Account";
                    Committments."Committed Amount":=IRLine."Line Amount";
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GenLedSetup.TestField("Current Budget");
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    if IRLine.Type <> IRLine.Type::Item then GLAccount.SetRange(GLAccount."No.", IRLine."No.")
                    else
                        GLAccount.SetRange(GLAccount."No.", IRLine."Item G/L Budget Account");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(IRLine."Dimension Set ID", ShortcutDimCode);
                    /*IF ShortcutDimCode[1]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    IF ShortcutDimCode[2]<>'' THEN
                    GLAccount.SETRANGE("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    IF ShortcutDimCode[3]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    IF ShortcutDimCode[4]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    IF ShortcutDimCode[5]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    IF ShortcutDimCode[6]<>'' THEN
                    GLAccount.SETRANGE("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(IRLine."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Document Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Approved Budget";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                    //MESSAGE('bud amt %1-expenses %2-avail %3',BudgetAmount,Expenses,BudgetAvailable);
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    if IRLine.Type <> IRLine.Type::Item then CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.")
                    else
                        CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."Item G/L Budget Account");
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", IRLine."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    /*IF IR."Posting Date"=0D THEN
                       ERROR('Please insert the imprest date');*/
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", IR."Document Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(IR."No.", IRLine."No.", IRLine."Line No.")then Message('Line No %1 has been commited', IRLine."Line No.")
                    else if CommittedAmount + IRLine."Line Amount" > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for Item No. %5 Amount %6 under %8, %1 ,%9, %2, on G/L Account %7 By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), (BudgetAvailable - CommittedAmount), IRLine."No.", IRLine."Line Amount", IRLine."Item G/L Budget Account", IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"), IRLine.FieldCaption("Shortcut Dimension 4 Code"), IRLine."Shortcut Dimension 4 Code")
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for Item No. %5 Amount %6 under %8, %1 ,%9, %2, on G/L Account %7 By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), (BudgetAvailable - CommittedAmount), IRLine."No.", IRLine."Line Amount", IRLine."Item G/L Budget Account", IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"), IRLine.FieldCaption("Shortcut Dimension 4 Code"), IRLine."Shortcut Dimension 4 Code");
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=IR."No.";
                    Committments.No:=IRLine."No.";
                    Committments."Line No.":=IRLine."Line No.";
                    if IRLine.Type <> IRLine.Type::Item then begin
                        //Committments."Account Type" := Committments."Account Type"::"5";
                        Committments."Account No.":=IRLine."No." end
                    else
                        Committments."Account Type":=Committments."Account Type"::"G/L Account";
                    Committments."Account No.":=IRLine."Item G/L Budget Account";
                    if Customer.Get(IRLine."No.")then Committments."Account Name":=Customer.Name;
                    Committments.Description:=IRLine.Description;
                    Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(IR."No.", IRLine."No.", IRLine."Line No.")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        IRLine.Committed:=true;
                        IRLine.Modify;
                        if not LineError then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + IRLine."Line Amount")));
                    end;
                end;
            until IRLine.Next = 0;
        end;
    //CreatePV(IR);
    end;
    procedure UncommitStoreReq(var IR: Record "Internal Request Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
        IRLine: Record "Internal Request Line";
    begin
        //Update Dimension Set ID
        IRLine.Reset;
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        if IRLine.Find('-')then begin
            repeat Committments.Reset;
                Committments.SetRange("Commitment No", IRLine."Document No.");
                Committments.SetRange(No, IRLine."No.");
                Committments.SetRange("Line No.", IRLine."Line No.");
                if Committments.Find('-')then begin
                    Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                    Committments.Modify;
                end;
                Committments.Reset;
                if Committments.FindLast then EntryNo:=Committments."Entry No";
                EntryNo:=EntryNo + 1;
                Committments.Reset;
                Committments.SetRange("Commitment No", IR."No.");
                Committments.SetRange("Commitment Type", Committments."Commitment Type"::Commitment);
                if Committments.Find('-')then UncommittmentDate:=Committments."Commitment Date";
                Committments.Init;
                Committments."Commitment No":=IRLine."Document No.";
                Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                Committments."Document Type":=Committments."Document Type"::"Store Requisition";
                //Insert same Commitment Date
                Committments."Commitment Date":=UncommittmentDate;
                Committments."Uncommittment Date":=IR."Document Date";
                Committments."Dimension Set ID":=IRLine."Dimension Set ID";
                Committments."Global Dimension 1":=IRLine."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2":=IRLine."Shortcut Dimension 2 Code";
                if IRLine.Type <> IRLine.Type::Item then Committments.Account:=IRLine."No."
                else
                    Committments.Account:=IRLine."Item G/L Budget Account";
                Committments."Committed Amount":=-IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
                if IRLine.Type <> IRLine.Type::Item then Committments."Account No.":=IRLine."No."
                else
                    Committments."Account No.":=IRLine."Item G/L Budget Account";
                Committments.User:=UserId;
                Committments."Document No":=IR."No.";
                Committments.No:=IRLine."No.";
                Committments."Line No.":=IRLine."Line No.";
                Committments."Entry No":=EntryNo;
                GeneralLedgerSetup.Get;
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code":=GetCommittedBudget(IRLine."Document No.");
                Committments.Insert;
            until IRLine.Next = 0;
        end;
    end;
    procedure CheckStoreReqCommittment(IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
    begin
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        //IRLine.SETRANGE(Type,IRLine.Type::"G/L Account");
        if IRLine.Find('-')then begin
            repeat //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.Get;
                GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                if IRLine.Type = IRLine.Type::"G/L Account" then GLAccount.SetRange(GLAccount."No.", IRLine."No.")
                else
                    GLAccount.SetRange(GLAccount."No.", IRLine."Item G/L Budget Account");
                //Get budget amount avaliable
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Document Date");
                if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                if GLAccount.Find('-')then begin
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    BudgetAmount:=GLAccount."Budgeted Amount";
                    Expenses:=GLAccount."Net Change";
                    BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                end;
                //Get committed Amount
                CommittedAmount:=0;
                CommitmentEntries.Reset;
                CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                /*IF IR."Posting Date"=0D THEN
                   ERROR('Please insert the posting date');*/
                CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", IR."Document Date");
                CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                CommittedAmount:=CommitmentEntries."Committed Amount";
                if GLAccount.Get(IRLine."No.")then;
                if GLAccount."Votebook Entry" then begin
                    if CommittedAmount + IRLine.Amount > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                end;
            until IRLine.Next = 0;
        end;
    end;
    local procedure CheckImprestCostOfSales(AcNo: Code[50]; ExpCode: Code[150]): Boolean var
        RecTypes: Record "Receipts and Payment Types";
    begin
        RecTypes.Reset;
        RecTypes.SetFilter(Type, '%1|%2', RecTypes.Type::Imprest, RecTypes.Type::Claim);
        RecTypes.SetRange(Code, ExpCode);
        RecTypes.SetRange("Account No.", AcNo);
        if RecTypes.FindFirst then begin
            if RecTypes."Cost of Sale" then exit(true)
            else
                exit(false);
        end;
    end;
    procedure ReversePostedLPOEntries(PurchInvHeader: Record "Purch. Inv. Header")
    var
        InventoryAccount: Code[50];
        EntryNo: Integer;
        Committment: Record "Commitment Entries";
        PurchInvLine: Record "Purch. Inv. Line";
        Item: Record Item;
        GLAccount: Record "G/L Account";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        AcquisitionAccount: Code[50];
        Vendor: Record Vendor;
    begin
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Find('-')then begin
            if Committment.Find('+')then EntryNo:=Committment."Entry No"
            else
                EntryNo:=0;
            repeat if LineCommitted(PurchInvHeader."Order No.", PurchInvLine."No.", PurchInvLine."Line No.")then begin
                    if PurchInvLine."Amount Including VAT" <> 0 then begin
                        Committment.Reset;
                        Committment.SetRange("Document Type", Committment."Document Type"::LPO);
                        Committment.SetRange("Document No", PurchInvHeader."Order No.");
                        if Committment.Find('-')then begin
                            EntryNo:=EntryNo + 1;
                            Committment.Init;
                            Committment."Entry No":=EntryNo;
                            Committment."Commitment No":=PurchInvHeader."Order No.";
                            Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                            Committment."Document Type":=Committment."Document Type"::LPO;
                            Committment."Commitment Date":=PurchInvHeader."Posting Date";
                            //Dimensions
                            Committment."Global Dimension 1":=PurchInvLine."Shortcut Dimension 1 Code";
                            Committment."Global Dimension 2":=PurchInvLine."Shortcut Dimension 2 Code";
                            Committment."Dimension Set ID":=PurchInvHeader."Dimension Set ID";
                            //Dimensions
                            //Case of G/L Account,Item,Fixed Asset
                            case PurchInvLine.Type of PurchInvLine.Type::Item: begin
                                Item.Reset;
                                if Item.Get(PurchInvLine."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                                InventoryPostingSetup.Get(PurchInvLine."Location Code", Item."Inventory Posting Group");
                                //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                                Item.TestField("Item G/L Budget Account");
                                InventoryAccount:=Item."Item G/L Budget Account";
                                Committment.Account:=InventoryAccount;
                            end;
                            PurchInvLine.Type::"G/L Account": begin
                                Committment.Account:=PurchInvLine."No.";
                            end;
                            PurchInvLine.Type::"Fixed Asset": begin
                                if FixedAssetPG.Get(PurchInvLine."Posting Group")then begin
                                    FixedAssetPG.TestField("Acquisition Cost Account");
                                    AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                                    Committment.Account:=AcquisitionAccount;
                                end;
                            end;
                            end;
                            Committment."Committed Amount":=-PurchInvLine."Amount Including VAT";
                            Committment.User:=UserId;
                            Committment."Document No":=Committment."Account No.";
                            Committment.No:=Committment.No;
                            Committment."Account Type":=Committment."Account Type"::Vendor;
                            Committment."Account No.":=PurchInvLine."Buy-from Vendor No.";
                            if Vendor.Get(PurchInvLine."Buy-from Vendor No.")then Committment."Account Name":=Vendor.Name;
                            Committment.Description:=PurchInvLine.Description;
                            Committment."Document No":=PurchInvHeader."No.";
                            Committment."Uncommittment Date":=Today;
                            GeneralLedgerSetup.Get;
                            GeneralLedgerSetup.TestField("Current Budget");
                            Committment."Budget Code":=GetCommittedBudget(PurchInvHeader."Order No.");
                            Committment.Insert;
                        end;
                    end;
                end;
            until PurchInvLine.Next = 0;
        end;
    end;
    procedure ReverseStaffClaimCommittment(Claim: Record Payments)
    var
        ClaimLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
    begin
        ClaimLines.Reset;
        ClaimLines.SetRange(No, Claim."No.");
        ClaimLines.SetRange("Account Type", ClaimLines."Account Type"::"G/L Account");
        if ClaimLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No")then begin
                    Committments.Init;
                    Committments."Commitment No":=Claim."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type":=Committments."Document Type"::"Staff Claim";
                    Claim.TestField(Date);
                    Committments."Commitment Date":=Today;
                    Committments."Uncommittment Date":=Today;
                    Committments."Dimension Set ID":=ClaimLines."Dimension Set ID";
                    Committments."Global Dimension 1":=ClaimLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=ClaimLines."Shortcut Dimension 2 Code";
                    Committments.Account:=ClaimLines."Account No";
                    Committments."Committed Amount":=-ClaimLines.Amount;
                    Committments.User:=UserId;
                    Committments."Document No":=Claim."No.";
                    Committments.No:=ClaimLines."Account No";
                    Committments."Line No.":=ClaimLines."Line No";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=Claim."Account No.";
                    if GLAccount.Get(Claim."Account No.")then Committments."Account Name":=GLAccount.Name;
                    CommitmentEntries.Description:=ClaimLines.Description;
                    CommitmentEntries."Dimension Set ID":=ClaimLines."Dimension Set ID";
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GetCommittedBudget(Claim."No.");
                    Committments.Insert;
                end;
            until ClaimLines.Next = 0;
        end;
    end;
    procedure EncumberImprest(var ImprestHeader: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        CSetup: Record "Cash Management Setups";
        Customer: Record Customer;
    begin
        ImprestLines.SetRange(No, ImprestHeader."No.");
        if ImprestLines.FindFirst then begin
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No")then begin
                    Committments.Init;
                    Committments."Commitment No":=ImprestHeader."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Encumberance;
                    Committments."Document Type":=Committments."Document Type"::Imprest;
                    Committments."Commitment Date":=Today;
                    Committments."Uncommittment Date":=ImprestHeader.Date;
                    Committments."Dimension Set ID":=ImprestHeader."Dimension Set ID";
                    Committments."Global Dimension 1":=ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=ImprestLines."Shortcut Dimension 2 Code";
                    Committments.Account:=ImprestLines."Account No";
                    Committments."Committed Amount":=LastCommittment(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No");
                    Committments.User:=UserId;
                    Committments."Document No":=ImprestHeader."No.";
                    Committments.No:=ImprestLines."Account No";
                    Committments."Line No.":=ImprestLines."Line No";
                    Committments."Dimension Set ID":=ImprestLines."Dimension Set ID";
                    Committments."Account Type":=Committments."Account Type"::Customer;
                    Committments."Account No.":=ImprestHeader."Account No.";
                    if Customer.Get(ImprestHeader."Account No.")then Committments."Account Name":=Customer.Name;
                    Committments.Description:=ImprestLines.Description;
                    Committments."Dimension Set ID":=ImprestLines."Dimension Set ID";
                    EntryNo:=EntryNo + 1;
                    Committments."Entry No":=EntryNo;
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GetCommittedBudget(ImprestHeader."No.");
                    Committments.Insert;
                end;
            until ImprestLines.Next = 0;
        end;
    end;
    procedure CancelPaymentsCommitments(Payments: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Commitment No", Payments."No.");
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll;
        Commit;
    end;
    procedure CancelIRCommitments(IR: Record "Internal Request Header")
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Commitment No", IR."No.");
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll;
        Commit;
    end;
    procedure CancelOrderCommitments(PurchaseHeader: Record "Purchase Header")
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Commitment No", PurchaseHeader."No.");
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll;
        Commit;
    end;
    procedure GetCommittedBudget(CommittedNo: Code[50]): Code[50]var
        CommEntries: Record "Commitment Entries";
        GLSetup: Record "General Ledger Setup";
    begin
        CommEntries.Reset;
        CommEntries.SetRange("Commitment No", CommittedNo);
        CommEntries.SetRange("Commitment Type", CommEntries."Commitment Type"::Commitment);
        if CommEntries.FindFirst then exit(CommEntries."Budget Code")
        else
        begin
            GLSetup.Get;
            exit(GLSetup."Current Budget");
        end;
    end;
    procedure IsClaimOrImprestPayment(ExpType: Code[50]; PayType: Option " ", Receipt, Payment, Imprest, Claim, Advance, Expense, "Petty Cash"): Boolean var
        PaymentLines: Record "Payment Lines";
        RecTypes: Record "Receipts and Payment Types";
    begin
        if RecTypes.Get(ExpType, PayType)then begin
            if((RecTypes."Imprest Payment") or (RecTypes."Claim Payment"))then exit(true)
            else
                exit(false);
        end;
    end;
    procedure IsMedicalCeilingClaim(ClaimType: Code[50]): Boolean var
        ClaimTypes: Record "Receipts and Payment Types";
    begin
        ClaimTypes.Reset;
        ClaimTypes.SetRange(Code, ClaimType);
        ClaimTypes.SetRange(Type, ClaimTypes.Type::Claim);
        if ClaimTypes.FindFirst then begin
            if ClaimTypes."Check Medical Ceiling" then exit(true)
            else
                exit(false);
        end;
    end;
    procedure IsAccountVotebookEntry(GLAccount: Code[20]): Boolean var
        GLAccountRec: Record "G/L Account";
    begin
        GLAccountRec.Reset;
        GLAccountRec.SetRange("No.", GLAccount);
        if GLAccountRec.FindFirst then if GLAccountRec."Votebook Entry" then exit(true)
            else
                exit(false);
    end;
    local procedure GetLPOAccountNo(PurchaseLine: Record "Purchase Line"): Code[20]var
        Items: Record Item;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
    begin
        case PurchaseLine.Type of PurchaseLine.Type::"G/L Account": exit(PurchaseLine."No.");
        PurchaseLine.Type::Item: begin
            if Items.Get(PurchaseLine."No.")then begin
                if(Items.Type = Items.Type::"Non-Inventory")then begin
                    Items.TestField("Item G/L Budget Account");
                end;
                exit(Items."Item G/L Budget Account");
            end;
        end;
        PurchaseLine.Type::"Fixed Asset": begin
            if FAPostingGroup.Get(PurchaseLine."Posting Group")then begin
                FAPostingGroup.TestField("Acquisition Cost Account");
                exit(FAPostingGroup."Acquisition Cost Account");
            end;
        end;
        end;
    end;
    procedure ReversePostedPurchInvEntries(PurchInvHeader: Record "Purch. Inv. Header")
    var
        InventoryAccount: Code[50];
        EntryNo: Integer;
        Committment: Record "Commitment Entries";
        PurchInvLine: Record "Purch. Inv. Line";
        Item: Record Item;
        GLAccount: Record "G/L Account";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        AcquisitionAccount: Code[50];
        Vendor: Record Vendor;
    begin
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Find('-')then begin
            if Committment.Find('+')then EntryNo:=Committment."Entry No"
            else
                EntryNo:=0;
            repeat if LineCommitted(PurchInvHeader."No.", PurchInvLine."No.", PurchInvLine."Line No.")then begin
                    if PurchInvLine."Amount Including VAT" <> 0 then begin
                        Committment.Reset;
                        Committment.SetRange("Document Type", Committment."Document Type"::"Purchase Invoice");
                        Committment.SetRange("Document No", PurchInvHeader."No.");
                        if Committment.Find('-')then begin
                            EntryNo:=EntryNo + 1;
                            Committment.Init;
                            Committment."Entry No":=EntryNo;
                            Committment."Commitment No":=PurchInvHeader."Order No.";
                            Committment."Commitment Type":=Committment."Commitment Type"::"Commitment Reversal";
                            Committment."Document Type":=Committment."Document Type"::"Purchase Invoice";
                            Committment."Commitment Date":=PurchInvHeader."Posting Date";
                            //Dimensions
                            Committment."Global Dimension 1":=PurchInvLine."Shortcut Dimension 1 Code";
                            Committment."Global Dimension 2":=PurchInvLine."Shortcut Dimension 2 Code";
                            Committment."Dimension Set ID":=PurchInvHeader."Dimension Set ID";
                            //Dimensions
                            //Case of G/L Account,Item,Fixed Asset
                            case PurchInvLine.Type of PurchInvLine.Type::Item: begin
                                Item.Reset;
                                if Item.Get(PurchInvLine."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                                InventoryPostingSetup.Get(PurchInvLine."Location Code", Item."Inventory Posting Group");
                                //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                                Item.TestField("Item G/L Budget Account");
                                InventoryAccount:=Item."Item G/L Budget Account";
                                Committment.Account:=InventoryAccount;
                            end;
                            PurchInvLine.Type::"G/L Account": begin
                                Committment.Account:=PurchInvLine."No.";
                            end;
                            PurchInvLine.Type::"Fixed Asset": begin
                                if FixedAssetPG.Get(PurchInvLine."Posting Group")then begin
                                    FixedAssetPG.TestField("Acquisition Cost Account");
                                    AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                                    Committment.Account:=AcquisitionAccount;
                                end;
                            end;
                            end;
                            Committment."Committed Amount":=-PurchInvLine."Amount Including VAT";
                            Committment.User:=UserId;
                            Committment."Document No":=Committment."Account No.";
                            Committment.No:=Committment.No;
                            Committment."Account Type":=Committment."Account Type"::Vendor;
                            Committment."Account No.":=PurchInvLine."Buy-from Vendor No.";
                            if Vendor.Get(PurchInvLine."Buy-from Vendor No.")then Committment."Account Name":=Vendor.Name;
                            Committment.Description:=PurchInvLine.Description;
                            Committment."Document No":=PurchInvHeader."No.";
                            Committment."Uncommittment Date":=Today;
                            GeneralLedgerSetup.Get;
                            GeneralLedgerSetup.TestField("Current Budget");
                            Committment."Budget Code":=GetCommittedBudget(PurchInvHeader."No.");
                            Committment.Insert;
                        end;
                    end;
                end;
            until PurchInvLine.Next = 0;
        end;
    end;
    procedure TrainingRequestCommittment(var TrainingRequest: Record "Training Request"; var ErrorMsg: Text)
    var
        TrainingRequestLines: Record "Training Request Lines";
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
        LineNo: Integer;
        StartDate: Date;
    begin
        ErrorMsg:='';
        TrainingRequest.TestField("Training Need");
        TrainingRequest.TestField("Planned Start Date");
        StartDate:=TrainingRequest."Planned Start Date";
        LineNo:=0;
        TrainingRequestLines.Reset;
        TrainingRequestLines.SetRange(TrainingRequestLines."Document No.", TrainingRequest."Request No.");
        if TrainingRequestLines.FindFirst then begin
            Committments.Reset;
            if Committments.FindLast then EntryNo:=Committments."Entry No";
            repeat if IsAccountVotebookEntry(TrainingRequestLines."G/L Account")then begin
                    LineNo+=10000;
                    Committments.Init;
                    Committments."Commitment No":=TrainingRequest."Request No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
                    Committments."Document Type":=Committments."Document Type"::"Training Request";
                    Committments."Commitment Date":=Today;
                    Committments."Global Dimension 1":=TrainingRequest."Global Dimension 1 Code";
                    Committments."Global Dimension 2":=TrainingRequest."Global Dimension 2 Code";
                    Committments.Account:=TrainingRequestLines."G/L Account";
                    Committments."Committed Amount":=TrainingRequestLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", TrainingRequestLines."G/L Account");
                    if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", TrainingRequest."Dimension Set ID");
                    FetchDimValue(TrainingRequest."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", StartDate);
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount:=GLAccount."Approved Budget";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, TrainingRequestLines."G/L Account");
                    if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", TrainingRequest."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", StartDate);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    LineError:=false;
                    if LineCommitted(TrainingRequest."Request No.", TrainingRequestLines."G/L Account", LineNo)then Message('Line No %1 has been committed', LineNo)
                    else if CommittedAmount + TrainingRequestLines.Amount > BudgetAvailable then begin
                            if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', TrainingRequest."Global Dimension 1 Code", TrainingRequest."Global Dimension 2 Code", Abs(BudgetAvailable - (CommittedAmount + TrainingRequestLines.Amount)), BudgetAvailable - CommittedAmount, TrainingRequest.FieldCaption("Global Dimension 1 Code"), TrainingRequest.FieldCaption("Global Dimension 2 Code"))
                            else
                                ErrorMsg:=ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', DimValueName[1], DimValueName[2], Abs(BudgetAvailable - (CommittedAmount + TrainingRequestLines.Amount)), BudgetAvailable - CommittedAmount, TrainingRequest.FieldCaption("Global Dimension 1 Code"), TrainingRequest.FieldCaption("Global Dimension 2 Code"));
                            LineError:=true;
                        end;
                    Committments.User:=UserId;
                    Committments."Document No":=TrainingRequest."Request No.";
                    Committments.No:=TrainingRequestLines."G/L Account";
                    Committments."Line No.":=LineNo;
                    Committments."Account Type":=Committments."Account Type"::"G/L Account";
                    Committments.Description:=TrainingRequest.Description;
                    Committments."Dimension Set ID":=TrainingRequest."Dimension Set ID";
                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(TrainingRequest."Request No.", TrainingRequestLines."G/L Account", LineNo)then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        TrainingRequestLines.Committed:=true;
                        TrainingRequestLines.Modify;
                    //            IF LineError=FALSE THEN
                    //              MESSAGE('Items Committed Successfully and the balance is %1',
                    //              ABS(BudgetAvailable-(CommittedAmount+TrainingRequestLines.Amount)));
                    end;
                end;
            until TrainingRequestLines.Next = 0;
            if LineError = false then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + TrainingRequestLines.Amount)));
        //    TrainingRequest.Status:=TrainingNeed.Status::Application;
        //    TrainingNeed.MODIFY;
        end;
    end;
    procedure CheckWPCommittment(WP: Record "Activity Work Programme")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
    begin
        if IsAccountVotebookEntry(WP."Account No")then begin
            WP.CalcFields("Total Amount");
            //Confirm the Amount to be issued does not exceed the budget and amount Committed
            //Get Budget for the G/L
            if WP."Activity End Date" = 0D then Error('Please insert the Activity End Date');
            GenLedSetup.Get;
            GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
            GLAccount.SetRange(GLAccount."No.", WP."Account No");
            //Get budget amount avaliable
            GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", WP."Activity End Date");
            if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", WP."Dimension Set ID");
            if GLAccount.Find('-')then begin
                GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                BudgetAmount:=GLAccount."Budgeted Amount";
                Expenses:=GLAccount."Net Change";
                BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
            end;
            //Get committed Amount
            CommittedAmount:=0;
            CommitmentEntries.Reset;
            CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
            CommitmentEntries.SetRange(CommitmentEntries.Account, WP."Account No");
            CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
            CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", WP."Activity End Date");
            CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
            CommittedAmount:=CommitmentEntries."Committed Amount";
            if GLAccount.Get(WP."Account No")then;
            if CommittedAmount + WP."Total Amount" > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + WP."Total Amount")), BudgetAvailable - CommittedAmount);
        end;
    end;
    // procedure WPCommittment(var WP: Record "Activity Work Programme"; var ErrorMsg: Text)
    // var
    //     Committments: Record "Commitment Entries";
    //     EntryNo: Integer;
    //     BudgetAmount: Decimal;
    //     Expenses: Decimal;
    //     BudgetAvailable: Decimal;
    //     CommittedAmount: Decimal;
    //     CommitmentEntries: Record "Commitment Entries";
    //     GenLedSetup: Record "General Ledger Setup";
    //     GLAccount: Record "G/L Account";
    //     Customer: Record Customer;
    //     DimMgt: Codeunit DimensionManagement;
    //     ShortcutDimCode: array[8] of Code[20];
    //     DimValueName: array[8] of Text;
    //     LineError: Boolean;
    //     LineNo: Integer;
    // begin
    //     ErrorMsg := '';
    //     LineNo := 0;
    //     if Committments.FindLast then
    //         EntryNo := Committments."Entry No";
    //     if IsAccountVotebookEntry(WP."Account No") then begin
    //         if WP."Activity End Date" = 0D then
    //             Error('Please insert the Activity End Date');
    //         WP.CalcFields("Total Amount");
    //         Committments.Init;
    //         Committments."Commitment No" := WP."No.";
    //         Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
    //         // Committments."Document Type" := Committments."Document Type"::Workplan;
    //         WP.TestField("Activity End Date");
    //         Committments."Commitment Date" := WP."Activity End Date";
    //         Committments."Global Dimension 1" := WP."Shortcut Dimension 1 Code";
    //         Committments."Global Dimension 2" := WP."Shortcut Dimension 2 Code";
    //         Committments.Account := WP."Account No";
    //         Committments."Committed Amount" := WP."Total Amount";
    //         //Confirm the Amount to be issued does not exceed the budget and amount Committed
    //         //Get Budget for the G/L
    //         GenLedSetup.Get;
    //         GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
    //         GLAccount.SetRange(GLAccount."No.", WP."Account No");
    //         if GenLedSetup."Use Dimensions For Budget" then
    //             GLAccount.SetRange(GLAccount."Dimension Set ID Filter", WP."Dimension Set ID");
    //         //Get Dimensions
    //         DimMgt.GetShortcutDimensions(WP."Dimension Set ID", ShortcutDimCode);
    //         FetchDimValue(WP."Dimension Set ID", ShortcutDimCode, DimValueName);
    //         //Get budget amount avaliable
    //         GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", WP."Activity End Date");
    //         if GLAccount.Find('-') then begin
    //             GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
    //             BudgetAmount := GLAccount."Budgeted Amount";
    //             Expenses := GLAccount."Net Change";
    //             BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
    //         end;
    //         //Get committed Amount
    //         CommittedAmount := 0;
    //         CommitmentEntries.Reset;
    //         CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
    //         CommitmentEntries.SetRange(CommitmentEntries.Account, WP."Account No");
    //         if GenLedSetup."Use Dimensions For Budget" then
    //             CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", WP."Dimension Set ID");
    //         CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
    //         CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
    //                                    WP."Activity End Date");
    //         CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
    //         CommittedAmount := CommitmentEntries."Committed Amount";
    //         LineError := false;
    //         if LineCommitted(WP."No.", WP."Account No", LineNo) then
    //             Message('Activity Workplan No %1 has been committed', WP."No.")
    //         else
    //             if CommittedAmount + WP."Total Amount" > BudgetAvailable then begin
    //                 if ErrorMsg = '' then
    //                     ErrorMsg := StrSubstNo('You have Exceeded Budget for G/L Account No %1 %2 By %3 \ The Budget Available is %4'
    //                    , WP."Account No", WP."Account Name",
    //                     Abs(BudgetAvailable - (CommittedAmount + WP."Total Amount")), BudgetAvailable - CommittedAmount);
    //                 LineError := true;
    //             end;
    //         Committments.User := UserId;
    //         Committments."Document No" := WP."No.";
    //         Committments.No := WP."Account No";
    //         Committments."Line No." := 0;
    //         Committments."Account Type" := Committments."Account Type"::"G/L Account";
    //         Committments."Account No." := WP."Account No";
    //         Committments."Account Name" := WP."Account Name";
    //         Committments.Description := WP.Description;
    //         Committments."Dimension Set ID" := WP."Dimension Set ID";
    //         GeneralLedgerSetup.Get;
    //         GeneralLedgerSetup.TestField("Current Budget");
    //         Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
    //         //Check whether line is committed.
    //         if not LineCommitted(WP."No.", WP."Account No", LineNo) then begin
    //             EntryNo := EntryNo + 1;
    //             Committments."Entry No" := EntryNo;
    //             Committments.Insert;
    //             WP.Committed := true;
    //             WP.Modify;
    //             if LineError = false then
    //                 Message('Items Committed Successfully and the balance is %1',
    //                 Abs(BudgetAvailable - (CommittedAmount + WP."Total Amount")));
    //         end;
    //     end;
    // end;
    // procedure UncommitWP(var ImprestHeader: Record Payments)
    // var
    //     ImprestLines: Record "Payment Lines";
    //     Committments: Record "Commitment Entries";
    //     EntryNo: Integer;
    //     CSetup: Record "Cash Management Setups";
    //     Customer: Record Customer;
    //     WP: Record "Activity Work Programme";
    //     LineNo: Integer;
    // begin
    //     ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
    //     ImprestLines.SetFilter("Activity Work Programme", '<>%1', '');
    //     if ImprestLines.FindFirst then begin
    //         if Committments.FindLast then
    //             EntryNo := Committments."Entry No";
    //         LineNo := 0;
    //         if WP.Get(ImprestLines."Activity Work Programme") then;
    //         Committments.Reset;
    //         Committments.SetRange(Committments."Commitment No", ImprestLines."Activity Work Programme");
    //         Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Commitment);
    //         if Committments.Find('-') then
    //             UncommittmentDate := Committments."Commitment Date";
    //         if LineCommitted(ImprestLines."Activity Work Programme", WP."Account No", LineNo) then begin
    //             Committments.Init;
    //             Committments."Commitment No" := ImprestLines."Activity Work Programme";
    //             Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
    //             Committments."Document Type" := Committments."Document Type"::Workplan;
    //             //Insert same Commitment Date
    //             Committments."Commitment Date" := UncommittmentDate;
    //             Committments."Uncommittment Date" := ImprestHeader."Surrender Date";
    //             Committments."Dimension Set ID" := WP."Dimension Set ID";
    //             Committments."Global Dimension 1" := WP."Shortcut Dimension 1 Code";
    //             Committments."Global Dimension 2" := WP."Shortcut Dimension 2 Code";
    //             Committments.Account := WP."Account No";
    //             Committments."Committed Amount" := -ImprestHeader."Imprest Amount";
    //             Committments.User := UserId;
    //             Committments."Document No" := WP."No.";
    //             Committments.No := WP."Account No";
    //             Committments."Line No." := LineNo;
    //             Committments."Dimension Set ID" := WP."Dimension Set ID";
    //             Committments."Account Type" := Committments."Account Type"::"G/L Account";
    //             Committments."Account No." := WP."Account No";
    //             Committments."Account Name" := WP."Account Name";
    //             Committments.Description := WP.Description;
    //             Committments."Payment Posted" := true;
    //             EntryNo := EntryNo + 1;
    //             Committments."Entry No" := EntryNo;
    //             GeneralLedgerSetup.Get;
    //             GeneralLedgerSetup.TestField("Current Budget");
    //             Committments."Budget Code" := GetCommittedBudget(ImprestHeader."No.");
    //             Committments.Insert;
    //         end;
    //     end;
    // end;
    procedure CheckProjectCommittment(Project: Record "ProjectMan")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        CashSetup: Record "Cash Management Setups";
    begin
        CashSetup.Get();
        CashSetup.TestField("Projects G/L Account");
        if IsAccountVotebookEntry(CashSetup."Projects G/L Account")then begin
            // Project.CalcFields("");
            //Confirm the Amount to be issued does not exceed the budget and amount Committed
            //Get Budget for the G/L
            if Project."Project End Date" = 0D then Error('Please insert the Activity End Date');
            GenLedSetup.Get;
            GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
            GLAccount.SetRange(GLAccount."No.", CashSetup."Projects G/L Account");
            //Get budget amount avaliable
            GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Project."Project End Date");
            if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", Project."Dimension Set ID");
            if GLAccount.Find('-')then begin
                GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                BudgetAmount:=GLAccount."Budgeted Amount";
                Expenses:=GLAccount."Net Change";
                BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
            end;
            //Get committed Amount
            CommittedAmount:=0;
            CommitmentEntries.Reset;
            CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
            CommitmentEntries.SetRange(CommitmentEntries.Account, CashSetup."Projects G/l Account");
            CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
            CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Project."Project End Date");
            CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
            CommittedAmount:=CommitmentEntries."Committed Amount";
            if GLAccount.Get(CashSetup."Projects G/l Account")then;
            if CommittedAmount + Project."Project Estimated Cost" > BudgetAvailable then Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3', Committments.Account, Abs(BudgetAvailable - (CommittedAmount + Project."Project Estimated Cost")), BudgetAvailable - CommittedAmount);
        end;
    end;
    procedure ProjectCommittment(var Project: Record "ProjectMan"; var ErrorMsg: Text)
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        DimValueName: array[8]of Text;
        LineError: Boolean;
        LineNo: Integer;
        CashSetup: Record "Cash Management Setups";
        GLName: Text;
    begin
        CashSetup.Get();
        GLAccount.Reset();
        If GLAccount.Get(CashSetup."Projects G/L Account")then GLName:=GLAccount.Name;
        ErrorMsg:='';
        LineNo:=0;
        if Committments.FindLast then EntryNo:=Committments."Entry No";
        if IsAccountVotebookEntry(CashSetup."Projects G/L Account")then begin
            if Project."Project End Date" = 0D then Error('Please insert the Project End Date');
            Committments.Init;
            Committments."Commitment No":=Project."Project No.";
            Committments."Commitment Type":=Committments."Commitment Type"::Commitment;
            // Committments."Document Type" := Committments."Document Type"::Workplan;
            Project.TestField("Project End Date");
            Committments."Commitment Date":=Project."Project End Date";
            Committments."Global Dimension 1":=Project."Shortcut Dimension 3 Code";
            // Committments."Global Dimension 2" := Project."Shortcut Dimension 2 Code";
            Committments.Account:=CashSetup."Projects G/L Account";
            Committments."Committed Amount":=Project."Project Estimated Cost";
            //Confirm the Amount to be issued does not exceed the budget and amount Committed
            //Get Budget for the G/L
            GenLedSetup.Get;
            GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
            GLAccount.SetRange(GLAccount."No.", CashSetup."Projects G/L Account");
            if GenLedSetup."Use Dimensions For Budget" then GLAccount.SetRange(GLAccount."Dimension Set ID Filter", Project."Dimension Set ID");
            //Get Dimensions
            DimMgt.GetShortcutDimensions(Project."Dimension Set ID", ShortcutDimCode);
            FetchDimValue(Project."Dimension Set ID", ShortcutDimCode, DimValueName);
            //Get budget amount avaliable
            GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Project."Project End Date");
            if GLAccount.Find('-')then begin
                GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                BudgetAmount:=GLAccount."Budgeted Amount";
                Expenses:=GLAccount."Net Change";
                BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
            end;
            //Get committed Amount
            CommittedAmount:=0;
            CommitmentEntries.Reset;
            CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
            CommitmentEntries.SetRange(CommitmentEntries.Account, CashSetup."Projects G/L Account");
            if GenLedSetup."Use Dimensions For Budget" then CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", Project."Dimension Set ID");
            CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
            CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", Project."Project End Date");
            CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
            CommittedAmount:=CommitmentEntries."Committed Amount";
            LineError:=false;
            if LineCommitted(Project."Project No.", CashSetup."Projects G/L Account", LineNo)then Message('Project No %1 has been committed', Project."Project No.")
            else if CommittedAmount + Project."Project Estimated Cost" > BudgetAvailable then begin
                    if ErrorMsg = '' then ErrorMsg:=StrSubstNo('You have Exceeded Budget for G/L Account No %1 %2 By %3 \ The Budget Available is %4', CashSetup."Projects G/L Account", GLName, Abs(BudgetAvailable - (CommittedAmount + Project."Project Estimated Cost")), BudgetAvailable - CommittedAmount);
                    LineError:=true;
                end;
            Committments.User:=UserId;
            Committments."Document No":=Project."Project No.";
            Committments.No:=CashSetup."Projects G/L Account";
            Committments."Line No.":=0;
            Committments."Account Type":=Committments."Account Type"::"G/L Account";
            Committments."Account No.":=CashSetup."Projects G/L Account";
            Committments."Account Name":=GLName;
            Committments.Description:=Project."Project Name";
            Committments."Dimension Set ID":=Project."Dimension Set ID";
            GeneralLedgerSetup.Get;
            GeneralLedgerSetup.TestField("Current Budget");
            Committments."Budget Code":=GeneralLedgerSetup."Current Budget";
            //Check whether line is committed.
            if not LineCommitted(Project."Project No.", CashSetup."Projects G/L Account", LineNo)then begin
                EntryNo:=EntryNo + 1;
                Committments."Entry No":=EntryNo;
                Committments.Insert;
                Project.Committed:=true;
                Project.Modify;
                if LineError = false then Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + Project."Project Estimated Cost")));
            end;
        end;
    end;
    var BudgetEntry: Record "G/L Budget Entry";
    GLSetup: record "General Ledger Setup";
}

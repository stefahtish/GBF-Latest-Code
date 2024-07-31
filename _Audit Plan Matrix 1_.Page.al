page 50891 "Audit Plan Matrix 1"
{
    DataCaptionExpression = AuditName;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = Audit;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        //MATRIX_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                    end;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        /*FOR MATRIX_CurrentColumnOrdinal := 1 TO MATRIX_CurrentNoOfMatrixColumn DO BEGIN
              MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
            END;*/
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        //EXIT(FindRec(LineDimOption,Rec,Which));
    end;

    trigger OnOpenPage()
    begin
        IF AuditPeriod.GETFILTER("Global Dimension 1 Filter") <> '' THEN GlobalDim1Filter := AuditPeriod.GETFILTER("Global Dimension 1 Filter");
        IF AuditPeriod.GETFILTER("Global Dimension 2 Filter") <> '' THEN GlobalDim2Filter := AuditPeriod.GETFILTER("Global Dimension 2 Filter");
        GLSetup.GET;
    end;

    var
        MATRIX_CellData: array[12] of Decimal;
        RoundingFactorFormatString: Text;
        [InDataSet]
        Emphasize: Boolean;
        MATRIX_CaptionSet: array[12] of Text[80];
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        Text001: Label 'Period';
        Text002: Label 'You may only edit column 1 to %1.';
        MATRIX_MatrixRecord: Record Audit;
        MatrixRecords: array[12] of Record Audit;
        GLAccBudgetBuf: Record "G/L Acc. Budget Buffer";
        RoundingFactor: Option "None","1","1000","1000000";
        GLBudgetName: Record Audit;
        BusUnitFilter: Code[250];
        AuditName: Code[20];
        AuditPeriod: Record "Audit Period";
        GlobalDim1Filter: Code[250];
        GlobalDim2Filter: Code[250];
        GLSetup: Record "General Ledger Setup";
        DateFilter: Text[30];
        MatrixMgt: Codeunit "Matrix Management";
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        PeriodInitialized: Boolean;
        InternalDateFilter: Text[30];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        ColumnDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";

    local procedure FormatStr(): Text
    begin
        EXIT(RoundingFactorFormatString);
    end;

    local procedure UpdateAmount(MATRIX_ColumnOrdinal: Integer)
    var
        NewAmount: Decimal;
    begin
        IF MATRIX_ColumnOrdinal > MATRIX_CurrentNoOfMatrixColumn THEN ERROR(Text002, MATRIX_CurrentNoOfMatrixColumn);
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        NewAmount := FromRoundedValue(MATRIX_CellData[MATRIX_ColumnOrdinal]);
        IF CalcAmount(TRUE) = 0 THEN; // To set filters correctly
        GLAccBudgetBuf.CALCFIELDS("Budgeted Amount");
        GLAccBudgetBuf.VALIDATE("Budgeted Amount", NewAmount);
        //Amount := MatrixMgt.RoundValue(CalcAmount(FALSE),RoundingFactor);
        CurrPage.UPDATE;
    end;

    local procedure FromRoundedValue(OrgAmount: Decimal): Decimal
    var
        NewAmount: Decimal;
    begin
        NewAmount := OrgAmount;
        CASE RoundingFactor OF
            RoundingFactor::"1000":
                NewAmount := OrgAmount * 1000;
            RoundingFactor::"1000000":
                NewAmount := OrgAmount * 1000000;
        END;
        EXIT(NewAmount);
    end;

    local procedure CalcAmount(SetColumnFilter: Boolean): Decimal
    begin
        SetCommonFilters(GLAccBudgetBuf);
        SetDimFilters(GLAccBudgetBuf, 0);
        IF SetColumnFilter THEN SetDimFilters(GLAccBudgetBuf, 1);
        GLAccBudgetBuf.CALCFIELDS("Budgeted Amount");
        EXIT(GLAccBudgetBuf."Budgeted Amount");
    end;

    local procedure SetCommonFilters(var TheGLAccBudgetBuf: Record "G/L Acc. Budget Buffer")
    begin
        /*WITH TheGLAccBudgetBuf DO BEGIN
              RESET;
              SETRANGE("Budget Filter",GLBudgetName.Name);
              IF BusUnitFilter <> '' THEN
                SETFILTER("Business Unit Filter",BusUnitFilter);
              IF GLAccFilter <> '' THEN
                SETFILTER("G/L Account Filter",GLAccFilter);
              IF IncomeBalanceGLAccFilter <> IncomeBalanceGLAccFilter::" " THEN
                SETRANGE("Income/Balance",IncomeBalanceGLAccFilter);
              IF DateFilter <> '' THEN
                SETFILTER("Date Filter",DateFilter);
              IF GlobalDim1Filter <> '' THEN
                SETFILTER("Global Dimension 1 Filter",GlobalDim1Filter);
              IF GlobalDim2Filter <> '' THEN
                SETFILTER("Global Dimension 2 Filter",GlobalDim2Filter);
              IF BudgetDim1Filter <> '' THEN
                SETFILTER("Budget Dimension 1 Filter",BudgetDim1Filter);
              IF BudgetDim2Filter <> '' THEN
                SETFILTER("Budget Dimension 2 Filter",BudgetDim2Filter);
              IF BudgetDim3Filter <> '' THEN
                SETFILTER("Budget Dimension 3 Filter",BudgetDim3Filter);
              IF BudgetDim4Filter <> '' THEN
                SETFILTER("Budget Dimension 4 Filter",BudgetDim4Filter);
            END;
            */
    end;

    local procedure SetDimFilters(var TheGLAccBudgetBuf: Record "G/L Acc. Budget Buffer"; LineOrColumn: Option Line,Column)
    var
        DimCodeBuf: Record "Dimension Code Buffer";
        DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
    begin
        /*IF LineOrColumn = LineOrColumn::Line THEN BEGIN
              DimCodeBuf := Rec;
              DimOption := LineDimOption;
            END ELSE BEGIN
              DimCodeBuf := MATRIX_MatrixRecord;
              DimOption := ColumnDimOption;
            END;

            WITH TheGLAccBudgetBuf DO
              CASE DimOption OF
                DimOption::"G/L Account":
                  IF DimCodeBuf.Totaling <> '' THEN
                    GLAccBudgetBuf.SETFILTER("G/L Account Filter",DimCodeBuf.Totaling)
                  ELSE
                    GLAccBudgetBuf.SETRANGE("G/L Account Filter",DimCodeBuf.Code);
                DimOption::Period:
                  SETRANGE("Date Filter",DimCodeBuf."Period Start",DimCodeBuf."Period End");
                DimOption::"Business Unit":
                  SETRANGE("Business Unit Filter",DimCodeBuf.Code);
                DimOption::"Global Dimension 1":
                  IF DimCodeBuf.Totaling <> '' THEN
                    SETFILTER("Global Dimension 1 Filter",DimCodeBuf.Totaling)
                  ELSE
                    SETRANGE("Global Dimension 1 Filter",DimCodeBuf.Code);
                DimOption::"Global Dimension 2":
                  IF DimCodeBuf.Totaling <> '' THEN
                    SETFILTER("Global Dimension 2 Filter",DimCodeBuf.Totaling)
                  ELSE
                    SETRANGE("Global Dimension 2 Filter",DimCodeBuf.Code);
                DimOption::"Budget Dimension 1":
                  IF DimCodeBuf.Totaling <> '' THEN
                    SETFILTER("Budget Dimension 1 Filter",DimCodeBuf.Totaling)
                  ELSE
                    SETRANGE("Budget Dimension 1 Filter",DimCodeBuf.Code);
                DimOption::"Budget Dimension 2":
                  IF DimCodeBuf.Totaling <> '' THEN
                    SETFILTER("Budget Dimension 2 Filter",DimCodeBuf.Totaling)
                  ELSE
                    SETRANGE("Budget Dimension 2 Filter",DimCodeBuf.Code);
                DimOption::"Budget Dimension 3":
                  IF DimCodeBuf.Totaling <> '' THEN
                    SETFILTER("Budget Dimension 3 Filter",DimCodeBuf.Totaling)
                  ELSE
                    SETRANGE("Budget Dimension 3 Filter",DimCodeBuf.Code);
                DimOption::"Budget Dimension 4":
                  IF DimCodeBuf.Totaling <> '' THEN
                    SETFILTER("Budget Dimension 4 Filter",DimCodeBuf.Totaling)
                  ELSE
                    SETRANGE("Budget Dimension 4 Filter",DimCodeBuf.Code);
              END;
            */
    end;

    local procedure MATRIX_OnAfterGetRecord(MATRIX_ColumnOrdinal: Integer)
    begin
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        //MATRIX_CellData[MATRIX_ColumnOrdinal] :=
    end;

    procedure Load(MatrixColumns1: array[32] of Text[80]; var MatrixRecords1: array[12] of Record Audit; CurrentNoOfMatrixColumns: Integer; _GlobalDim1Filter: Code[250]; _GlobalDim2Filter: Code[250]; var _GLBudgetName: Record Audit; _DateFilter: Text[30]; _RoundingFactor: Integer; _PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period")
    var
        i: Integer;
    begin
        FOR i := 1 TO 12 DO MATRIX_CellData[i] := 0;
        FOR i := 1 TO 12 DO BEGIN
            IF MatrixColumns1[i] = '' THEN
                MATRIX_CaptionSet[i] := ''
            ELSE
                MATRIX_CaptionSet[i] := MatrixColumns1[i];
            MatrixRecords[i] := MatrixRecords1[i];
        END;
        IF CurrentNoOfMatrixColumns > ARRAYLEN(MATRIX_CellData) THEN
            MATRIX_CurrentNoOfMatrixColumn := ARRAYLEN(MATRIX_CellData)
        ELSE
            MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
        GlobalDim1Filter := _GlobalDim1Filter;
        GlobalDim2Filter := _GlobalDim2Filter;
        GLBudgetName := _GLBudgetName;
        DateFilter := _DateFilter;
        RoundingFactor := _RoundingFactor;
        PeriodType := _PeriodType;
        //eddie RoundingFactorFormatString := MatrixMgt.f(RoundingFactor, FALSE);
    end;

    local procedure FindRec(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; var AuditPeriod: Record "Audit Period"; Which: Text[250]): Boolean
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        Period: Record Date;
        DimVal: Record "Dimension Value";
        PeriodFormMgt: Codeunit PeriodPageManagement;
        Found: Boolean;
    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    /*GLAcc."No." := DimCodeBuf.Code;
                                IF GLAccFilter <> '' THEN
                                  GLAcc.SETFILTER("No.",GLAccFilter);
                                SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
                                IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN
                                  GLAcc.SETRANGE("Account Category",GLAccCategoryFilter);
                                Found := GLAcc.FIND(Which);
                                IF Found THEN
                                  CopyGLAccToBuf(GLAcc,DimCodeBuf);*/
                END;
            DimOption::Period:
                BEGIN
                    IF NOT PeriodInitialized THEN DateFilter := '';
                    PeriodInitialized := TRUE;
                    Period."Period Start" := AuditPeriod."Period Start";
                    IF DateFilter <> '' THEN
                        Period.SETFILTER("Period Start", DateFilter)
                    ELSE IF NOT PeriodInitialized AND (InternalDateFilter <> '') THEN Period.SETFILTER("Period Start", InternalDateFilter);
                    Found := PeriodFormMgt.FindDate(Which, Period, PeriodType);
                    IF Found THEN CopyPeriodToBuf(Period, AuditPeriod);
                END;
            DimOption::"Business Unit":
                BEGIN
                    /*BusUnit.Code := DimCodeBuf.Code;
                                IF BusUnitFilter <> '' THEN
                                  BusUnit.SETFILTER(Code,BusUnitFilter);
                                Found := BusUnit.FIND(Which);
                                IF Found THEN
                                  CopyBusUnitToBuf(BusUnit,DimCodeBuf);*/
                END;
            DimOption::"Global Dimension 1":
                BEGIN
                    IF GlobalDim1Filter <> '' THEN DimVal.SETFILTER(Code, GlobalDim1Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    // DimVal.Code := DimCodeBuf.Code; GetBack
                    Found := DimVal.FIND(Which);
                    IF Found THEN CopyDimValToBuf(DimVal, AuditPeriod);
                END;
            DimOption::"Global Dimension 2":
                BEGIN
                    IF GlobalDim2Filter <> '' THEN DimVal.SETFILTER(Code, GlobalDim2Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    //DimVal.Code := DimCodeBuf.Code; GetBack
                    Found := DimVal.FIND(Which);
                    IF Found THEN CopyDimValToBuf(DimVal, AuditPeriod);
                END;
        /*DimOption::"Budget Dimension 1":
          BEGIN
            IF BudgetDim1Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim1Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            Found := DimVal.FIND(Which);
            IF Found THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;
        DimOption::"Budget Dimension 2":
          BEGIN
            IF BudgetDim2Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim2Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            Found := DimVal.FIND(Which);
            IF Found THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;
        DimOption::"Budget Dimension 3":
          BEGIN
            IF BudgetDim3Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim3Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            Found := DimVal.FIND(Which);
            IF Found THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;
        DimOption::"Budget Dimension 4":
          BEGIN
            IF BudgetDim4Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim4Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            Found := DimVal.FIND(Which);
            IF Found THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;*/
        END;
        EXIT(Found);
    end;

    local procedure NextRec(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; var DimCodeBuf: Record "Dimension Code Buffer"; Steps: Integer): Integer
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        Period: Record Date;
        DimVal: Record "Dimension Value";
        PeriodFormMgt: Codeunit PeriodPageManagement;
        ResultSteps: Integer;
    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    /*GLAcc."No." := DimCodeBuf.Code;
                                IF GLAccFilter <> '' THEN
                                  GLAcc.SETFILTER("No.",GLAccFilter);
                                SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
                                IF GLAccCategoryFilter <> GLAccCategoryFilter::" " THEN
                                  GLAcc.SETRANGE("Account Category",GLAccCategoryFilter);
                                ResultSteps := GLAcc.NEXT(Steps);
                                IF ResultSteps <> 0 THEN
                                  CopyGLAccToBuf(GLAcc,DimCodeBuf);*/
                END;
            DimOption::Period:
                BEGIN
                    IF DateFilter <> '' THEN Period.SETFILTER("Period Start", DateFilter);
                    Period."Period Start" := DimCodeBuf."Period Start";
                    ResultSteps := PeriodFormMgt.NextDate(Steps, Period, PeriodType);
                    IF ResultSteps <> 0 THEN CopyPeriodToBuf(Period, AuditPeriod);
                END;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.Code := DimCodeBuf.Code;
                    IF BusUnitFilter <> '' THEN BusUnit.SETFILTER(Code, BusUnitFilter);
                    ResultSteps := BusUnit.NEXT(Steps);
                    IF ResultSteps <> 0 THEN CopyBusUnitToBuf(BusUnit, DimCodeBuf);
                END;
            DimOption::"Global Dimension 1":
                BEGIN
                    IF GlobalDim1Filter <> '' THEN DimVal.SETFILTER(Code, GlobalDim1Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN CopyDimValToBuf(DimVal, AuditPeriod);
                END;
            DimOption::"Global Dimension 2":
                BEGIN
                    IF GlobalDim2Filter <> '' THEN DimVal.SETFILTER(Code, GlobalDim2Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN CopyDimValToBuf(DimVal, AuditPeriod);
                END;
        /*DimOption::"Budget Dimension 1":
          BEGIN
            IF BudgetDim1Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim1Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            ResultSteps := DimVal.NEXT(Steps);
            IF ResultSteps <> 0 THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;
        DimOption::"Budget Dimension 2":
          BEGIN
            IF BudgetDim2Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim2Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            ResultSteps := DimVal.NEXT(Steps);
            IF ResultSteps <> 0 THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;
        DimOption::"Budget Dimension 3":
          BEGIN
            IF BudgetDim3Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim3Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            ResultSteps := DimVal.NEXT(Steps);
            IF ResultSteps <> 0 THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;
        DimOption::"Budget Dimension 4":
          BEGIN
            IF BudgetDim4Filter <> '' THEN
              DimVal.SETFILTER(Code,BudgetDim4Filter);
            DimVal."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
            DimVal.SETRANGE("Dimension Code",DimVal."Dimension Code");
            DimVal.Code := DimCodeBuf.Code;
            ResultSteps := DimVal.NEXT(Steps);
            IF ResultSteps <> 0 THEN
              CopyDimValToBuf(DimVal,DimCodeBuf);
          END;*/
        END;
        EXIT(ResultSteps);
    end;

    local procedure CopyPeriodToBuf(var ThePeriod: Record Date; var AuditPeriod: Record "Audit Period")
    var
        Period2: Record Date;
    begin
        AuditPeriod.INIT;
        AuditPeriod.Period := FORMAT(ThePeriod."Period Start");
        AuditPeriod."Period Start" := ThePeriod."Period Start";
        AuditPeriod."Period End" := ThePeriod."Period End";
        IF DateFilter <> '' THEN BEGIN
            Period2.SETFILTER("Period End", DateFilter);
            IF Period2.GETRANGEMAX("Period End") < AuditPeriod."Period End" THEN AuditPeriod."Period End" := Period2.GETRANGEMAX("Period End");
        END;
        AuditPeriod.Description := ThePeriod."Period Name";
    end;

    local procedure CopyBusUnitToBuf(var TheBusUnit: Record "Business Unit"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        TheDimCodeBuf.INIT;
        TheDimCodeBuf.Code := TheBusUnit.Code;
        IF TheBusUnit.Name <> '' THEN
            TheDimCodeBuf.Name := TheBusUnit.Name
        ELSE
            TheDimCodeBuf.Name := TheBusUnit."Company Name";
    end;

    local procedure CopyDimValToBuf(var TheDimVal: Record "Dimension Value"; var AuditPeriod: Record "Audit Period")
    begin
        AuditPeriod.INIT;
        AuditPeriod.Period := TheDimVal.Code;
        AuditPeriod.Description := TheDimVal.Name;
        //Totaling := TheDimVal.Totaling;
        //Indentation := TheDimVal.Indentation;
        //"Show in Bold" :=
        //TheDimVal."Dimension Value Type" <> TheDimVal."Dimension Value Type"::Standard;
    end;

    local procedure LookUpCode(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; DimCode: Text[30]; "Code": Text[30])
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        DimVal: Record "Dimension Value";
    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    GLAcc.GET(Code);
                    PAGE.RUNMODAL(PAGE::"G/L Account List", GLAcc);
                END;
            DimOption::Period:
                ;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.GET(Code);
                    PAGE.RUNMODAL(PAGE::"Business Unit List", BusUnit);
                END;
            DimOption::"Global Dimension 1", DimOption::"Global Dimension 2", DimOption::"Budget Dimension 1", DimOption::"Budget Dimension 2", DimOption::"Budget Dimension 3", DimOption::"Budget Dimension 4":
                BEGIN
                    DimVal.SETRANGE("Dimension Code", DimCode);
                    DimVal.GET(DimCode, Code);
                    PAGE.RUNMODAL(PAGE::"Dimension Value List", DimVal);
                END;
        END;
    end;
}

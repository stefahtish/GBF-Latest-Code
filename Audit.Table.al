table 50494 Audit
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Type of Audit"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Types";
        }
        field(4; "Risk Assessment Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,High,Moderate,Low';
            OptionMembers = " ", High, Moderate, Low;
        }
        field(5; "Audit Dimension 1 Code"; Code[20])
        {
            Caption = 'Budget Dimension 1 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Audit Dimension 1 Code" <> xRec."Audit Dimension 1 Code" THEN IF Dim.CheckIfDimUsed("Audit Dimension 1 Code", 9, Code, '', 0)THEN ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(6; "Audit Dimension 2 Code"; Code[20])
        {
            Caption = 'Budget Dimension 2 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Audit Dimension 2 Code" <> xRec."Audit Dimension 2 Code" THEN IF Dim.CheckIfDimUsed("Audit Dimension 2 Code", 10, Code, '', 0)THEN ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(7; "Audit Dimension 3 Code"; Code[20])
        {
            Caption = 'Budget Dimension 3 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Audit Dimension 3 Code" <> xRec."Audit Dimension 3 Code" THEN IF Dim.CheckIfDimUsed("Audit Dimension 3 Code", 11, Code, '', 0)THEN ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(8; "Audit Dimension 4 Code"; Code[20])
        {
            Caption = 'Budget Dimension 4 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Audit Dimension 4 Code" <> xRec."Audit Dimension 4 Code" THEN IF Dim.CheckIfDimUsed("Audit Dimension 4 Code", 12, Code, '', 0)THEN ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Dim: Record Dimension;
    DimSetEntry: Record "Dimension Set Entry";
    TempDimSetEntry: Record "Dimension Set Entry" temporary;
    Text000: Label '%1\You cannot use the same dimension twice in the same budget.';
    Text001: Label 'Updating budget entries @1@@@@@@@@@@@@@@@@@@';
    local procedure UpdateGLBudgetEntryDim()
    var
        GLBudgetEntry: Record "G/L Budget Entry";
        Window: Dialog;
        TotalCount: Integer;
        i: Integer;
        T0: Time;
    begin
    /*
        GLBudgetEntry.SETCURRENTKEY("Budget Name");
        GLBudgetEntry.SETRANGE("Budget Name",Name);
        GLBudgetEntry.SETFILTER("Dimension Set ID",'<>%1',0);
        TotalCount := COUNT;
        Window.OPEN(Text001);
        T0 := TIME;
        GLBudgetEntry.LOCKTABLE;
        IF GLBudgetEntry.FINDSET THEN
          REPEAT
            i := i + 1;
            IF TIME > T0 + 750 THEN BEGIN
              Window.UPDATE(1,10000 * i DIV TotalCount);
              T0 := TIME;
            END;
            GLBudgetEntry."Budget Dimension 1 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID","Budget Dimension 1 Code");
            GLBudgetEntry."Budget Dimension 2 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID","Budget Dimension 2 Code");
            GLBudgetEntry."Budget Dimension 3 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID","Budget Dimension 3 Code");
            GLBudgetEntry."Budget Dimension 4 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID","Budget Dimension 4 Code");
            GLBudgetEntry.MODIFY;
          UNTIL GLBudgetEntry.NEXT = 0;
        Window.CLOSE;
        */
    end;
    local procedure GetDimValCode(DimSetID: Integer; DimCode: Code[20]): Code[20]begin
        IF DimCode = '' THEN EXIT('');
        IF TempDimSetEntry.GET(DimSetID, DimCode)THEN EXIT(TempDimSetEntry."Dimension Value Code");
        IF DimSetEntry.GET(DimSetID, DimCode)THEN TempDimSetEntry:=DimSetEntry
        ELSE
        BEGIN
            TempDimSetEntry.INIT;
            TempDimSetEntry."Dimension Set ID":=DimSetID;
            TempDimSetEntry."Dimension Code":=DimCode;
        END;
        TempDimSetEntry.INSERT;
        EXIT(TempDimSetEntry."Dimension Value Code")end;
}

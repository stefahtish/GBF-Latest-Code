page 50590 "Training Needs Lines"
{
    PageType = ListPart;
    SourceTable = "Training Needs Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Code"; Rec."Expense Code")
                {
                }
                field("Expense name"; Rec."Expense name")
                {
                }
                field(Amount; Rec.Amount)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field(BudgetAmount; BudgetAmount)
                {
                    Caption = 'Budget Amount';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        GLBudgetEntry.Reset;
                        GLBudgetEntry.SetFilter("G/L Account No.", Rec."G/L Account");
                        GLBudgetEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                        GLBudgetEntry.SetRange(Date, BudgetStartDate, Rec."Start Date");
                        PAGE.Run(Page::"G/L Budget Entries", GLBudgetEntry);
                    end;
                }
                field(Expenses; Expenses)
                {
                    Caption = 'Expenses';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        GLEntry.Reset;
                        GLEntry.SetFilter("G/L Account No.", Rec."G/L Account");
                        GLEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                        GLEntry.SetRange("Posting Date", BudgetStartDate, Rec."Start Date");
                        PAGE.Run(Page::"General Ledger Entries", GLEntry);
                    end;
                }
                field(TrainingAmount; TrainingAmount)
                {
                    Caption = 'Training Amount';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        TrainingNeedLines.Reset;
                        TrainingNeedLines.SetRange("G/L Account", Rec."G/L Account");
                        TrainingNeedLines.SetRange("Start Date", BudgetStartDate, Rec."Start Date");
                        TrainingNeedLines.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                        TrainingNeedLines.SetFilter(Status, '<>%1', TrainingNeedLines.Status::Open);
                        PAGE.Run(Page::"Training Needs Lines", TrainingNeedLines);
                    end;
                }
                field(BudgetAvailable; BudgetAvailable)
                {
                    Caption = 'Budget Available';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        GetBudgetAvailable;
    end;

    trigger OnOpenPage()
    begin
        GetBudgetAvailable;
    end;

    var
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        TrainingAmount: Decimal;
        BudgetStartDate: Date;
        GLBudgetEntry: Record "G/L Budget Entry";
        GLEntry: Record "G/L Entry";
        TrainingNeedLines: Record "Training Needs Lines";

    local procedure GetBudgetAvailable()
    var
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        AccountNo: Code[20];
    begin
        //AccountNoFilter:='';
        AccountNo := '';
        BudgetAmount := 0;
        Expenses := 0;
        BudgetAvailable := 0;
        TrainingAmount := 0;
        GenLedSetup.Get;
        BudgetStartDate := GenLedSetup."Current Budget Start Date";
        GLAccount.Reset;
        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
        GLAccount.SetFilter(GLAccount."No.", Rec."G/L Account");
        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", Rec."Dimension Set ID");
        GLAccount.SetRange(GLAccount."Date Filter", BudgetStartDate, Rec."Start Date");
        if GLAccount.Find('-') then begin
            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
            BudgetAmount := GLAccount."Approved Budget";
            Expenses := GLAccount."Net Change";
        end;
        TrainingNeedLines.Reset;
        TrainingNeedLines.SetRange("G/L Account", Rec."G/L Account");
        TrainingNeedLines.SetRange("Start Date", BudgetStartDate, Rec."Start Date");
        TrainingNeedLines.SetRange("Dimension Set ID", Rec."Dimension Set ID");
        TrainingNeedLines.SetFilter(Status, '<>%1', TrainingNeedLines.Status::Open);
        if TrainingNeedLines.FindFirst then begin
            TrainingNeedLines.CalcSums(Amount);
            TrainingAmount := TrainingNeedLines.Amount;
        end;
        BudgetAvailable := BudgetAmount - (Expenses + TrainingAmount);
        // TrainingNeedsLines.RESET;
        // TrainingNeedsLines.SETCURRENTKEY("G/L Account");
        // TrainingNeedsLines.SETRANGE("Document No.",Code);
        // IF TrainingNeedsLines.FINDFIRST THEN
        //  REPEAT
        //    IF TrainingNeedsLines."G/L Account"<>'' THEN
        //      IF AccountNoFilter<>'' THEN
        //        BEGIN
        //          IF TrainingNeedsLines."G/L Account"<>AccountNo THEN
        //            AccountNoFilter+='|'+TrainingNeedsLines."G/L Account";
        //          AccountNo:=TrainingNeedsLines."G/L Account";
        //        END ELSE
        //          BEGIN
        //            AccountNoFilter:=TrainingNeedsLines."G/L Account";
        //            AccountNo:=TrainingNeedsLines."G/L Account";
        //          END;
        //  UNTIL TrainingNeedsLines.NEXT=0;
        //
        // GLBudgetEntry.RESET;
        // GLBudgetEntry.SETFILTER("G/L Account No.",AccountNoFilter);
        // GLBudgetEntry.SETRANGE("Dimension Set ID","Dimension Set ID");
        // GLBudgetEntry.SETRANGE(Date,BudgetStartDate,TODAY);
        // IF GLBudgetEntry.FINDFIRST THEN
        //  BEGIN
        //    GLBudgetEntry.CALCSUMS(Amount);
        //    BudgetAmount:=GLBudgetEntry.Amount;
        //  END;
        //
        // GLEntry.RESET;
        // GLEntry.SETFILTER("G/L Account No.",AccountNoFilter);
        // GLEntry.SETRANGE("Dimension Set ID","Dimension Set ID");
        // GLEntry.SETRANGE("Posting Date",BudgetStartDate,TODAY);
        // IF GLEntry.FINDFIRST THEN
        //  BEGIN
        //    GLEntry.CALCSUMS(Amount);
        //    Expenses:=GLEntry.Amount;
        //  END;
        //
        // BudgetAvailable:=BudgetAmount-Expenses;
    end;
}

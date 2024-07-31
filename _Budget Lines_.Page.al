page 51087 "Budget Lines"
{
    PageType = ListPart;
    SourceTable = "Research Budget Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    Caption = 'Budget Account';

                    trigger OnValidate()
                    begin
                        GetBudgetAvailable;
                    end;
                }
                field("Expense name"; Rec."Expense name")
                {
                    Enabled = false;
                }
                field(Amount; Rec.Amount)
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
        // TrainingNeedLines.Reset;
        // TrainingNeedLines.SetRange("G/L Account", "G/L Account");
        // TrainingNeedLines.SetRange("Start Date", BudgetStartDate, "Start Date");
        // TrainingNeedLines.SetRange("Dimension Set ID", "Dimension Set ID");
        // TrainingNeedLines.SetFilter(Status, '<>%1', TrainingNeedLines.Status::Open);
        // if TrainingNeedLines.FindFirst then begin
        //     TrainingNeedLines.CalcSums(Amount);
        //     TrainingAmount := TrainingNeedLines.Amount;
        // end;
        // BudgetAvailable := BudgetAmount - (Expenses + TrainingAmount);
    end;
}

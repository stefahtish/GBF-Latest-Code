page 51277 "Training Budget Items"
{
    PageType = ListPart;
    SourceTable = "Training Budget";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Budget Item No"; Rec."Budget Item No")
                {
                    Editable = false;
                }
                field("Training Expense Code"; Rec."Training Expense Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Expense Code field.', Comment = '%';
                    Visible = false;
                }
                field("Training Expence Name"; Rec."Training Expence Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Expence Name field.', Comment = '%';
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                }
                field("Approved Budget"; Rec."Approved Budget")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                }
                field(Actual; Rec.Actual)
                {
                }
                field(Commitment; Rec.Commitment)
                {
                }
                field("1stQuarter"; "1stQuarter")
                {
                    Caption = '1st Quarter';
                    Visible = false;
                }
                field("2ndQuarter"; "2ndQuarter")
                {
                    Caption = '2nd Quarter';
                    Visible = false;
                }
                field("3rdQuarter"; "3rdQuarter")
                {
                    Caption = '3rd Quarter';
                    Visible = false;
                }
                field("4thQuarter"; "4thQuarter")
                {
                    Caption = '4th Quarter';
                    Visible = false;
                }
                field("Budget Year"; Rec."Training Year")
                {
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
        //GetQuarters;
    end;

    trigger OnOpenPage()
    begin
        //GetQuarters;
    end;

    var
        AccPeriod: Record "Accounting Period";
        NewYear: Date;
        "1stQuarter": Decimal;
        "2ndQuarter": Decimal;
        "3rdQuarter": Decimal;
        "4thQuarter": Decimal;
        TrainingBudget: Record "Training Budget";

    procedure GetQuarters1()
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-') then NewYear := AccPeriod."Starting Date";
        //Get 1st Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "1stQuarter" := Rec."Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "2ndQuarter" := Rec."Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "3rdQuarter" := Rec."Estimated Cost";
        end;
        //Get 4th Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "4thQuarter" := Rec."Estimated Cost";
        end;
    end;
}

page 51323 "Procurement Plan Items2"
{
    PageType = List;
    SourceTable = "Procurement Plan";
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
                field("Plan Item No"; Rec."Plan Item No")
                {
                    Visible = false;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                }
                field("Process Type"; Rec."Process Type")
                {
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Youth; Rec.Youth)
                {
                }
                field(Women; Rec.Women)
                {
                }
                field(PWDS; Rec.PWDS)
                {
                }
                field("Citizen contractors"; Rec."Citizen contractors")
                {
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                }
                field("Margin of pref local contr"; Rec."Margin of pref local contr")
                {
                }
                field("1stQuarter"; Rec.Quarter1)
                {
                    Caption = 'Qtr1';
                }
                field("2ndQuarter"; Rec.Quarter2)
                {
                    Caption = 'Qtr2';
                }
                field("3rdQuarter"; Rec.Quarter3)
                {
                    Caption = 'Qtr3';
                }
                field("4thQuarter"; Rec.Quarter4)
                {
                    Caption = 'Qtr4';
                }
                field(Category; Rec.Category)
                {
                    //Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    //ApplicationArea = All;
                }
                field("Activity Name"; Rec."Activity Name")
                {
                    // ApplicationArea = All;
                }
                field("Funds Provider"; Rec."Funds Provider")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Visible = false;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Amount To Post"; Rec."Amount To Post")
                {
                    Caption = 'Total Estimated Cost';
                    Editable = false;
                    Visible = false;
                }
                field(Actual; Rec.Actual)
                {
                    Visible = false;
                }
                field(Commitment; Rec.Commitment)
                {
                    Visible = false;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Visible = false;
                }
                field("Plan Year"; Rec."Plan Year")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        // GetQuarters1;
    end;

    trigger OnOpenPage()
    begin
        //GetQuarters;
    end;

    var
        AccPeriod: Record "Accounting Period";
        NewYear: Date;
        // "1stQuarter": Decimal;
        // "2ndQuarter": Decimal;
        // "3rdQuarter": Decimal;
        // "4thQuarter": Decimal;
        ProcPlan: Record "Procurement Plan";

    procedure GetQuarters1()
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-') then NewYear := AccPeriod."Starting Date";
        //Get 1st Quarter Budget
        ProcPlan.SetRange("Plan Item No", Rec."Plan Item No");
        ProcPlan.SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter1 := Rec."Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        ProcPlan.SetRange("Plan Item No", Rec."Plan Item No");
        ProcPlan.SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter2 := Rec."Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        ProcPlan.SetRange("Plan Item No", Rec."Plan Item No");
        ProcPlan.SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter3 := Rec."Estimated Cost";
        end;
        //Get 4th Quarter Budget
        ProcPlan.SetRange("Plan Item No", Rec."Plan Item No");
        ProcPlan.SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter4 := Rec."Estimated Cost";
        end;
    end;
}

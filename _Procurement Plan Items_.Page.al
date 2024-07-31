page 50757 "Procurement Plan Items"
{
    PageType = ListPart;
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
                    ApplicationArea = Basic, Suite;
                }
                field("Plan Item No"; Rec."Plan Item No")
                {
                    ToolTip = 'Specifies the value of the Plan Item No field';
                    ApplicationArea = All;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Plan Description"; Rec."Procurement Plan Description")
                {
                    Caption = 'Procurement Plan Item/Service Description';
                    ToolTip = 'Specifies the value of the Procurement Plan Description field.';
                    ApplicationArea = All;
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pre-Qualifications"; Rec."Pre-Qualifications")
                {
                    ToolTip = 'Specifies the value of the Pre-Qualifications field.';
                    ApplicationArea = All;
                }
                field(Youth; Rec.Youth)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Women; Rec.Women)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(PWDS; Rec.PWDS)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Citizen contractors"; Rec."Citizen contractors")
                {
                    //ApplicationArea = Basic, Suite;
                    visible = false;
                }
                field(General; Rec.General)
                {
                    ToolTip = 'Specifies the value of the General field.';
                    ApplicationArea = All;
                }
                field("AGPO/General"; Rec."AGPO/General")
                {
                    ToolTip = 'Specifies the value of the AGPO/General field.';
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Margin of pref local contr"; Rec."Margin of pref local contr")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Timing Of Activities"; Rec."Timing Of Activities")
                {
                    ToolTip = 'Specifies the value of the Timing Of Activities field.';
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Activity Name"; Rec."Activity Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Funds Provider"; Rec."Funds Provider")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Amount To Post"; Rec."Amount To Post")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Estimated Cost';
                    Editable = false;
                    Visible = false;
                }
                field(Actual; Rec.Actual)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Commitment; Rec.Commitment)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Plan Year"; Rec."Plan Year")
                {
                    ApplicationArea = Basic, Suite;
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
        //GetQuarters1;
    end;

    trigger OnOpenPage()
    begin
        //GetQuarters1;
    end;

    var
        AccPeriod: Record "Accounting Period";
        NewYear: Date;
        "1stQuarter": Decimal;
        "2ndQuarter": Decimal;
        "3rdQuarter": Decimal;
        "4thQuarter": Decimal;
        ProcPlan: Record "Procurement Plan";

    procedure GetQuarters1()
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-') then NewYear := AccPeriod."Starting Date";
        //Get 1st Quarter Budget
        ProcPlan.SetRange("No.", Rec."No.");
        ProcPlan.SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter1 := Rec."Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        ProcPlan.SetRange("No.", Rec."No.");
        ProcPlan.SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter2 := Rec."Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        ProcPlan.SetRange("No.", Rec."No.");
        ProcPlan.SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter3 := Rec."Estimated Cost";
        end;
        //Get 4th Quarter Budget
        ProcPlan.SetRange("No.", Rec."No.");
        ProcPlan.SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            Rec.Quarter4 := Rec."Estimated Cost";
        end;
    end;
}

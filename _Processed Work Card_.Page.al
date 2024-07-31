page 51009 "Processed Work Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Contract_WorkP;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("IPC No."; Rec."IPC No.")
                {
                }
                field(Number; Rec.Number)
                {
                    trigger OnValidate()
                    begin
                        //Number:="Contract No."+'-'+FORMAT("IPC No.");
                    end;
                }
            }
            group("Value Of Work")
            {
                field("Previous Gross work done Date"; Rec."Previous Gross work done Date")
                {
                }
                field("Previous Gross work done"; Rec."Previous Gross work done")
                {
                }
                field("Present Gross work done Date"; Rec."Present Gross work done Date")
                {
                }
                field("Present Gross work done"; Rec."Present Gross work done")
                {
                }
                field("Cummulative Gross work done"; Rec."Cummulative Gross work done")
                {
                }
                field("Material on site"; Rec."Material on site")
                {
                }
                field(Daywork; Rec.Daywork)
                {
                }
                field("Variation Orders"; Rec."Variation Orders")
                {
                }
                field(Claims; Rec.Claims)
                {
                }
                field("Price Adjustment"; Rec."Price Adjustment")
                {
                }
                field("Price Adj Foreign"; Rec."Price Adj Foreign")
                {
                }
                field("Price Adj Local"; Rec."Price Adj Local")
                {
                }
                field("Interest on Late Payment"; Rec."Interest on Late Payment")
                {
                }
                field("Description Total"; Rec."Description Total")
                {
                }
                field("Prev Retation At 10%"; Rec."Prev Retation At 10%")
                {
                }
                field("present Retation At 10%"; Rec."present Retation At 10%")
                {
                }
            }
            group(Retension)
            {
                field("Cummulative Retation At 10%"; Rec."Cummulative Retation At 10%")
                {
                }
                field("Retation Total"; Rec."Retation Total")
                {
                }
                field("Balance of Rec Advance Payment"; Rec."Balance of Rec Advance Payment")
                {
                }
            }
            group(Recovery)
            {
                field("Recovery Advance Payment"; Rec."Recovery Advance Payment")
                {
                }
                field("Prev Recovery Advance Payment"; Rec."Prev Recovery Advance Payment")
                {
                }
                field("Prec Recovery Advance Payment"; Rec."Prec Recovery Advance Payment")
                {
                }
                field("Total Recovery Advance Payment"; Rec."Total Recovery Advance Payment")
                {
                }
                field("Last Certificate No."; Rec."Last Certificate No.")
                {
                }
            }
            group("Recovery of Advance")
            {
                field("Prev Payment on Last Cert"; Rec."Prev Payment on Last Cert")
                {
                }
                field("Relaese of 50% Retation"; Rec."Relaese of 50% Retation")
                {
                }
                field("75% Material on site"; Rec."75% Material on site")
                {
                }
                field("Calculate cost of material"; Rec."Calculate cost of material")
                {
                }
                field("Last Payment Certificate"; Rec."Last Payment Certificate")
                {
                }
                field(processed; Rec.processed)
                {
                }
            }
            group("Amount Payable")
            {
                field("Cummulative Net Due"; Rec."Cummulative Net Due")
                {
                }
                field("Net Due to Contractor"; Rec."Net Due to Contractor")
                {
                }
                field("Total Due inc(VAT)"; Rec."Total Due inc(VAT)")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Generate Certificate")
            {
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("IPC No.");
                    WorkProcessed.Reset;
                    WorkProcessed.SetRange("IPC No.", Rec."IPC No.");
                    if WorkProcessed.Find('-') then REPORT.Run(Report::"Work Certificate", true, false, WorkProcessed);
                end;
            }
            action(Reverse)
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    if Confirm('Reverse?', true) then WorkProcessed.Reset;
                    WorkProcessed.SetRange("Contract No.", Rec."Contract No.");
                    WorkProcessed.SetRange("IPC No.", Rec."IPC No.");
                    if WorkProcessed.Find('-') then begin
                        Contract_WorkRv.Init;
                        Contract_WorkRv.TransferFields(WorkProcessed);
                        Contract_WorkRv.Insert;
                        WorkProcessed.Delete;
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        "SubTotal(3to9)" := Rec."Previous Gross work done" + Rec."Present Gross work done" + Rec."Material on site" + Rec.Daywork + Rec."Variation Orders" + Rec.Claims + Rec."Price Adj Foreign" + Rec."Price Adj Local" + Rec."Interest on Late Payment";
        "cummRet(11+12)" := Rec."Prev Retation At 10%" + Rec."present Retation At 10%";
        "SubTotal(10-13)" := "SubTotal(3to9)" - "cummRet(11+12)";
        "CummRec(16+17)" := Rec."Prev Recovery Advance Payment" + Rec."Prec Recovery Advance Payment";
        "BalAdv(15-18)" := Rec."Recovery Advance Payment" - "CummRec(16+17)";
        "CumNetCont(14-18)" := "SubTotal(10-13)" - "CummRec(16+17)";
        "Net ducCONT(20-21)" := "CumNetCont(14-18)" - GetPreviousTotalAmount(Rec."IPC No." - 1);
        TotalDUECONTRCR := "Net ducCONT(20-21)" + Rec."Relaese of 50% Retation";
        Rec."Cummulative Net Due" := "CumNetCont(14-18)";
        Rec."Net Due to Contractor" := "Net ducCONT(20-21)";
        Rec."Total Due inc(VAT)" := TotalDUECONTRCR;
        LastIPC := Rec."IPC No." - 1;
        WorkProcessed.SetRange("Contract No.", Rec."Contract No.");
        WorkProcessed.SetRange("IPC No.", Rec."IPC No." - 1);
        if WorkProcessed.Find('-') then "SubTotal(3to9)" := Rec."Previous Gross work done" + Rec."Present Gross work done" + Rec."Material on site" + Rec.Daywork + Rec."Variation Orders" + Rec.Claims + Rec."Price Adj Foreign" + Rec."Price Adj Local" + Rec."Interest on Late Payment";
        "cummRet(11+12)" := Rec."Prev Retation At 10%" + Rec."present Retation At 10%";
        "SubTotal(10-13)" := "SubTotal(3to9)" - "cummRet(11+12)";
        "CummRec(16+17)" := Rec."Prev Recovery Advance Payment" + Rec."Prec Recovery Advance Payment";
        "BalAdv(15-18)" := Rec."Recovery Advance Payment" - "CummRec(16+17)";
        "CumNetCont(14-18)" := "SubTotal(10-13)" - "CummRec(16+17)";
        "Net ducCONT(20-21)" := "CumNetCont(14-18)" - Rec."Prev Payment on Last Cert";
        TotalDUECONTRCR := "Net ducCONT(20-21)" + Rec."Relaese of 50% Retation";
        //  "Prev Payment on Last Cert":=TotalDUECONTRCR;
        //  MESSAGE('%1-%2',LastIPC,TotalDUECONTRCR);
    end;

    trigger OnOpenPage()
    begin
        // //"Last Certificate No.":=Rec."IPC No."-1;
        //    LastIPC:=Rec."IPC No."-1;
        // WorkProcessed.SETRANGE("Contract No.","Contract No.");
        // WorkProcessed.GET(LastIPC);
        // IF WorkProcessed.FIND('-') THEN
        // prev
    end;

    var
        WorkCont: Record Contract_Work;
        WorkProcessed: Record Contract_WorkP;
        Text001: Label 'Contract %1, IPC no%2 has been Reversed';
        "SubTotal(3to9)": Decimal;
        "cummRet(11+12)": Decimal;
        "SubTotal(10-13)": Decimal;
        "CummRec(16+17)": Decimal;
        "BalAdv(15-18)": Decimal;
        "CumNetCont(14-18)": Decimal;
        "Net ducCONT(20-21)": Decimal;
        TotalDUECONTRCR: Decimal;
        LastIPC: Integer;
        Contract_WorkRv: Record Contract_WorkRv;

    local procedure GetPreviousTotalAmount(ipcNo: Integer): Decimal
    begin
        WorkProcessed.Reset;
        WorkProcessed.SetRange("Contract No.", Rec."Contract No.");
        WorkProcessed.SetRange("IPC No.", Rec."IPC No." - 1);
        if WorkProcessed.Find('-') then "SubTotal(3to9)" := Rec."Previous Gross work done" + Rec."Present Gross work done" + Rec."Material on site" + Rec.Daywork + Rec."Variation Orders" + Rec.Claims + Rec."Price Adj Foreign" + Rec."Price Adj Local" + Rec."Interest on Late Payment";
        "cummRet(11+12)" := Rec."Prev Retation At 10%" + Rec."present Retation At 10%";
        "SubTotal(10-13)" := "SubTotal(3to9)" - "cummRet(11+12)";
        "CummRec(16+17)" := Rec."Prev Recovery Advance Payment" + Rec."Prec Recovery Advance Payment";
        "BalAdv(15-18)" := Rec."Recovery Advance Payment" - "CummRec(16+17)";
        "CumNetCont(14-18)" := "SubTotal(10-13)" - "CummRec(16+17)";
        "Net ducCONT(20-21)" := "CumNetCont(14-18)" - Rec."Prev Payment on Last Cert";
        TotalDUECONTRCR := "Net ducCONT(20-21)" + Rec."Relaese of 50% Retation";
        //  "Prev Payment on Last Cert":=TotalDUECONTRCR;
        //  MESSAGE('%1-%2',LastIPC,TotalDUECONTRCR);
    end;
}

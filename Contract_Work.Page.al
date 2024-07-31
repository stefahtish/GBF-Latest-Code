page 50996 Contract_Work
{
    PageType = Card;
    SourceTable = Contract_Work;
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
                field("No."; Rec."No.")
                {
                    trigger OnValidate()
                    begin
                        Rec."No." := Rec."Contract No." + '-' + Format(Rec."IPC No.");
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
                    trigger OnValidate()
                    begin
                        ContractWork.Reset;
                        ContractWork.SetRange("Contract No.", Rec."Contract No.");
                        if ContractWork.Find('-') then Rec."Cummulative Gross work done" := Rec."Present Gross work done" + Rec."Previous Gross work done";
                    end;
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
                field("Price Adj Foreign"; Rec."Price Adj Foreign")
                {
                }
                field("Price Adj Local"; Rec."Price Adj Local")
                {
                }
                field("Interest on Late Payment"; Rec."Interest on Late Payment")
                {
                    trigger OnAssistEdit()
                    begin
                        //"Sub-Total(3-9)":="Cummulative Gross work done"+"Material on site"+Daywork+"Variation Orders"+Claims+"Price Adj Local"+"Price Adj Foreign";
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //"Sub-Total(3-9)":="Cummulative Gross work done"+"Material on site"+Daywork+"Variation Orders"+Claims+"Price Adj Local"+"Price Adj Foreign";
                    end;

                    trigger OnValidate()
                    begin
                        //"Sub-Total(3-9)":="Cummulative Gross work done"+"Material on site"+Daywork+"Variation Orders"+Claims+"Price Adj Local"+"Price Adj Foreign";
                    end;
                }
                field("Description Total"; Rec."Description Total")
                {
                    Caption = 'Value of Work Total';
                }
            }
            group(Retention)
            {
                field("Prev Retation At 10%"; Rec."Prev Retation At 10%")
                {
                }
                field("present Retation At 10%"; Rec."present Retation At 10%")
                {
                }
                field("Cummulative Retation At 10%"; Rec."Cummulative Retation At 10%")
                {
                    trigger OnValidate()
                    begin
                        // "Cummulative Retation At 10%":="Prev Retation At 10%"+"present Retation At 10%";
                        // "Sub-Total(10-15)":="Sub-Total(3-9)"+"Cummulative Retation At 10%";
                    end;
                }
                field("Retation Total"; Rec."Retation Total")
                {
                }
            }
            group("Recovery of Advance")
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
                    trigger OnValidate()
                    begin
                        //"Total Recovery Advance Payment":="Prev Recovery Advance Payment"+"Prec Recovery Advance Payment";
                    end;
                }
                field("Balance of Rec Advance Payment"; Rec."Balance of Rec Advance Payment")
                {
                    trigger OnValidate()
                    begin
                        //"Balance of Rec Advance Payment":="Recovery Advance Payment"-"Total Recovery Advance Payment";
                    end;
                }
            }
            group("Amount Payable")
            {
                field("Cummulative Net Due"; Rec."Cummulative Net Due")
                {
                    trigger OnValidate()
                    begin
                        //"Cummulative Net Due":="Sub-Total(10-13)"-"Total Recovery Advance Payment";
                    end;
                }
                field("Last Certificate No."; Rec."Last Certificate No.")
                {
                }
                field("Prev Payment on Last Cert"; Rec."Prev Payment on Last Cert")
                {
                }
                field("Net Due to Contractor"; Rec."Net Due to Contractor")
                {
                    trigger OnValidate()
                    begin
                        //"Net Due to Contractor":="Cummulative Net Due"-"Prev Payment on Last Cert";
                    end;
                }
                field("Relaese of 50% Retation"; Rec."Relaese of 50% Retation")
                {
                }
                field("Total Due inc(VAT)"; Rec."Total Due inc(VAT)")
                {
                    trigger OnValidate()
                    begin
                        //"Total Due inc(VAT)":="Net Due to Contractor";
                    end;
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

                trigger OnAction()
                begin
                    Rec.TestField("IPC No.");
                    ContractWork.Reset;
                    ContractWork.SetRange("Contract No.", Rec."Contract No.");
                    if ContractWork.Find('-') then REPORT.Run(Report::"Consultant Certificate", true, false, Rec);
                end;
            }
            action(Cerificate)
            {
                trigger OnAction()
                begin
                    REPORT.Run(Report::"Work Certificate", true, false, Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        ContractWork.Reset;
        ContractWork.SetRange("Contract No.", Rec."Contract No.");
        if ContractWork.Find('-') then begin
            ContractWork.Get(Rec."Contract No.");
            "Sub-Total(3-9)" := Rec."Cummulative Gross work done" + Rec."Material on site" + Rec.Daywork + Rec."Variation Orders" + Rec.Claims + Rec."Price Adj Local" + Rec."Price Adj Foreign";
            Rec."Cummulative Retation At 10%" := Rec."Prev Retation At 10%" + Rec."present Retation At 10%";
            "Sub-Total(10-13)" := "Sub-Total(3-9)" + Rec."Cummulative Retation At 10%";
            Rec."Total Recovery Advance Payment" := Rec."Prev Recovery Advance Payment" + Rec."Prec Recovery Advance Payment";
            Rec."Balance of Rec Advance Payment" := Rec."Recovery Advance Payment" - Rec."Total Recovery Advance Payment";
            Rec."Cummulative Net Due" := "Sub-Total(10-13)" - Rec."Total Recovery Advance Payment";
            Rec."Net Due to Contractor" := Rec."Cummulative Net Due" - Rec."Prev Payment on Last Cert";
            Rec."Total Due inc(VAT)" := Rec."Net Due to Contractor";
            ContractWork.Modify;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ContractWork.Reset;
        ContractWork.SetRange("Contract No.", Rec."Contract No.");
        if ContractWork.Find('-') then Rec."Cummulative Gross work done" := Rec."Present Gross work done" + Rec."Previous Gross work done";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        ContractWork.Reset;
        ContractWork.SetRange("Contract No.", Rec."Contract No.");
        if ContractWork.Find('-') then Rec."Cummulative Gross work done" := Rec."Present Gross work done" + Rec."Previous Gross work done";
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        /*"Cummulative Gross work done":="Present Gross work done"+"Previous Gross work done";
            ContractWork.RESET;
            ContractWork.SETRANGE("Contract No.","Contract No.");
            IF ContractWork.FIND('-') THEN
              BEGIN
                ContractWork.GET("Contract No.");
                    "Sub-Total(3-9)":="Cummulative Gross work done"+"Material on site"+Daywork+"Variation Orders"+Claims+"Price Adj Local"+"Price Adj Foreign";
                    "Cummulative Retation At 10%":="Prev Retation At 10%"+"present Retation At 10%";
                    "Sub-Total(10-13)":="Sub-Total(3-9)"+"Cummulative Retation At 10%";
                    "Total Recovery Advance Payment":="Prev Recovery Advance Payment"+"Prec Recovery Advance Payment";
                    "Balance of Rec Advance Payment":="Recovery Advance Payment"-"Total Recovery Advance Payment";
                    "Cummulative Net Due":="Sub-Total(10-13)"-"Total Recovery Advance Payment";
                    "Net Due to Contractor":="Cummulative Net Due"-"Prev Payment on Last Cert";
                    "Total Due inc(VAT)":="Net Due to Contractor";
                  ContractWork.MODIFY;

              END;*/
    end;

    trigger OnOpenPage()
    begin
        Rec."Cummulative Gross work done" := Rec."Present Gross work done" + Rec."Previous Gross work done";
        ContractWork.Reset;
        ContractWork.SetRange("Contract No.", Rec."Contract No.");
        if ContractWork.Find('-') then begin
            // ContractWork.GET("Contract No.");
            "Sub-Total(3-9)" := Rec."Cummulative Gross work done" + Rec."Material on site" + Rec.Daywork + Rec."Variation Orders" + Rec.Claims + Rec."Price Adj Local" + Rec."Price Adj Foreign";
            Rec."Cummulative Retation At 10%" := Rec."Prev Retation At 10%" + Rec."present Retation At 10%";
            "Sub-Total(10-13)" := "Sub-Total(3-9)" + Rec."Cummulative Retation At 10%";
            Rec."Total Recovery Advance Payment" := Rec."Prev Recovery Advance Payment" + Rec."Prec Recovery Advance Payment";
            Rec."Balance of Rec Advance Payment" := Rec."Recovery Advance Payment" - Rec."Total Recovery Advance Payment";
            Rec."Cummulative Net Due" := "Sub-Total(10-13)" - Rec."Total Recovery Advance Payment";
            Rec."Net Due to Contractor" := Rec."Cummulative Net Due" - Rec."Prev Payment on Last Cert";
            Rec."Total Due inc(VAT)" := Rec."Net Due to Contractor";
            "Sub-Total(3-9)" := Rec."Description Total";
            "Sub-Total(10-13)" := Rec."Retation Total";
            //ContractWork.MODIFY;
            //        MESSAGE('%1-%2',"Sub-Total(3-9)",'Subtotal3-9');
            //        MESSAGE('%1-%2',"Sub-Total(10-13)",'Subtotal10-13');
        end;
    end;

    var
        "Sub-Total(3-9)": Decimal;
        "Sub-Total(10-13)": Decimal;
        ContractWork: Record Contract_Work;
}

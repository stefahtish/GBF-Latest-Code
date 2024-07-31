page 51006 "Work Contract2"
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
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }
                field(processed; Rec.processed)
                {
                    Enabled = false;
                }
            }
            group("Value of Works")
            {
                Editable = Rec."Status" <> Rec."Status"::"Posted";

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
                field("Material on site"; Rec."Material on site")
                {
                    trigger OnValidate()
                    begin
                        if Confirm(Text002, true) then Rec."Calculate cost of material" := true;
                        //Rec.MODIFY;
                        if Rec."Calculate cost of material" then begin
                            Rec."75% Material on site" := 0.75 * Rec."Material on site";
                        end
                        else
                            Rec."75% Material on site" := 0;
                    end;
                }
                field("Calculate cost of material"; Rec."Calculate cost of material")
                {
                    trigger OnValidate()
                    begin
                        //Rec.CALCFIELDS("Material on site");
                        if Rec."Calculate cost of material" then begin
                            Rec."75% Material on site" := 0.75 * Rec."Material on site";
                        end
                        else
                            Rec."75% Material on site" := 0;
                    end;
                }
                field("75% Material on site"; Rec."75% Material on site")
                {
                    Editable = false;
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
                }
            }
            group(Retension)
            {
                Editable = Rec."Status" <> Rec."Status"::"Posted";

                field("Prev Retation At 10%"; Rec."Prev Retation At 10%")
                {
                }
                field("present Retation At 10%"; Rec."present Retation At 10%")
                {
                }
            }
            group("Recovery of Advance")
            {
                Editable = Rec."Status" <> Rec."Status"::"Posted";

                field("Recovery Advance Payment"; Rec."Recovery Advance Payment")
                {
                }
                field("Prev Recovery Advance Payment"; Rec."Prev Recovery Advance Payment")
                {
                }
                field("Prec Recovery Advance Payment"; Rec."Prec Recovery Advance Payment")
                {
                }
            }
            group("Amount Payable")
            {
                Editable = Rec."Status" <> Rec."Status"::"Posted";

                field("Last Certificate No."; Rec."Last Certificate No.")
                {
                }
                field("Last Payment Certificate"; Rec."Last Payment Certificate")
                {
                    Visible = false;
                }
                field("Prev Payment on Last Cert"; Rec."Prev Payment on Last Cert")
                {
                }
                field("Relaese of 50% Retation"; Rec."Relaese of 50% Retation")
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
                Enabled = Rec."processed" = True;
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.TestField("IPC No.");
                    WorkCont.Reset;
                    WorkCont.SetRange("Contract No.", Rec."Contract No.");
                    WorkCont.SetRange("IPC No.", Rec."IPC No.");
                    if WorkCont.Find('-') then REPORT.Run(Report::"Incident Register", true, false, WorkCont);
                end;
            }
            action(Cerificate)
            {
                Visible = false;

                trigger OnAction()
                begin
                    // REPORT.RUN(51519948,TRUE,FALSE,Rec);
                end;
            }
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    if Rec.processed = true then begin
                        Error(Text001, Rec."Contract No.", Rec."IPC No.");
                    end; //ELSE
                    if Confirm('Post', true) then Rec.processed := true;
                    Rec.Status := Rec.Status::Posted;
                    Rec.Modify;
                    WorkCont.Reset;
                    WorkCont.SetRange("Contract No.", Rec."Contract No.");
                    WorkCont.SetRange("IPC No.", Rec."IPC No.");
                    if WorkCont.Find('-') then begin
                        WorkProcessed.Init;
                        WorkProcessed.TransferFields(WorkCont);
                        WorkProcessed.Insert;
                    end
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec."Last Certificate No." > 1 then begin
            Rec."Last Certificate No." := Rec."IPC No." - 1;
            LastIPC := Rec."IPC No." - 1;
            Rec.Modify;
            if Rec.processed = true then begin
                WorkProcessed.SetRange("Contract No.", Rec."Contract No.");
                WorkProcessed.SetRange("IPC No.", LastIPC);
                if WorkProcessed.Find('-') then Rec."Prev Payment on Last Cert" := WorkProcessed."Net Due to Contractor";
                Rec.Modify;
            end;
            //  ELSE ERROR(Text003);
        end
    end;

    var
        WorkCont: Record Contract_Work;
        WorkProcessed: Record Contract_WorkP;
        Text001: Label 'Contract %1, IPC no%2 has been Posted';
        Text002: Label 'Calculate 75% Material on site?';
        LastIPC: Integer;
        Text003: Label 'Contract %1, IPC no%2 has not been Posted';
}

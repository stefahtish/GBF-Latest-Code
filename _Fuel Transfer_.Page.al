page 51272 "Fuel Transfer"
{
    Caption = 'Fuel Transfer';
    PageType = List;
    SourceTable = "Fuel  Balance Transfer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    Enabled = false;
                }
                field("FA No."; Rec."FA No.")
                {
                    trigger OnValidate()
                    var
                        FA: Record "Fixed Asset";
                    begin
                        FA.Reset();
                        FA.SetRange("No.", Rec."FA No.");
                        if FA.FindFirst() then begin
                            FA.CalcFields("Card balance");
                            AvailablBal := FA."Card balance";
                        end;
                    end;
                }
                field("Card No"; Rec."Card No")
                {
                }
                field(AvailablBal; AvailablBal)
                {
                    Caption = 'Available Balance';
                    Enabled = false;
                }
                field("New Fixed Asset"; Rec."New Fixed Asset")
                {
                }
                field("New Card No"; Rec."New Card No")
                {
                }
                field(Amount; Rec.Amount)
                {
                    trigger OnValidate()
                    begin
                        if Rec.Amount > AvailablBal then Error('Amount to transfer is greater than available balance');
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Transfer)
            {
                Visible = not Rec.Transferred;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProcMgmt: Codeunit "Procurement Management";
                begin
                    ProcMgmt.FuelTransfer(Rec);
                    CurrPage.close;
                end;
            }
        }
    }
    var
        AvailablBal: Decimal;
}

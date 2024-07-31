page 50119 "Banks Cheque Register"
{
    PageType = List;
    SourceTable = "Bank Account";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Cheques)
            {
                Caption = 'Cheque Register';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Cheque Register";
                RunPageLink = "Bank Account No." = FIELD("No.");
                RunPageMode = View;
            }
            action(Generate)
            {
                Caption = 'Generate Cheque Nos';
                Image = CreateSerialNo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Confirm001, false) = true then begin
                        BankAccount.Reset;
                        BankAccount.SetRange(BankAccount."No.", Rec."No.");
                        if BankAccount.FindFirst then begin
                            REPORT.Run(Report::"Generate Cheque Nos", true, false, BankAccount);
                        end;
                    end
                    else
                        exit;
                end;
            }
        }
    }
    var
        BankAccount: Record "Bank Account";
        Confirm001: Label 'Are you sure you want to generate cheque nos for the selected bank?';
}

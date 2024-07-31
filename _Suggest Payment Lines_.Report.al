report 50103 "Suggest Payment Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SuggestPaymentLines.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.", "Buy-from Vendor No.";

            trigger OnAfterGetRecord()
            begin
                GetLastPVLine(PVNo, LineNo);
                PurchInvLine.Reset;
                PurchInvLine.SetRange("Document No.", "No.");
                if PurchInvLine.FindFirst then
                    repeat
                        PVLines.Init;
                        PVLines.No := PVNo;
                        PVLines."Line No" := LineNo + 1000;
                        PVLines."Account Type" := PVLines."Account Type"::Vendor;
                        PVLines."Account No" := "Purch. Inv. Header"."Buy-from Vendor No.";
                        PVLines.Validate("Account No");
                        PVLines.Description := "Purch. Inv. Header"."Posting Description";
                        PVLines.Amount := PurchInvLine.Amount;
                        PVLines.Validate(Amount);
                        PVLines."Applies-to Doc Type" := PVLines."Applies-to Doc Type"::Invoice;
                        PVLines."Applies-to Doc. No." := "Purch. Inv. Header"."No.";
                        PVLines."Dimension Set ID" := PurchInvLine."Dimension Set ID";
                        LineNo := LineNo + 1000;
                        PVLines.Insert;
                    until PurchInvLine.Next = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        Type: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        PurchInvLine: Record "Purch. Inv. Line";
        LineNo: Integer;
        PVNo: Code[20];
        PVLines: Record "Payment Lines";

    procedure GetLastPVLine(var DocumentNo: Code[20]; var LineNo: Integer)
    var
        PVLines2: Record "Payment Lines";
    begin
        PVLines2.Reset;
        PVLines2.SetRange(No, DocumentNo);
        if PVLines2.FindLast then begin
            LineNo := PVLines2."Line No" + 1000;
            Message('%1', PVLines2."Line No" + 1000);
        end;
    end;

    procedure GetNo(var DocumentNo: Code[20])
    begin
        PVNo := DocumentNo;
    end;
}

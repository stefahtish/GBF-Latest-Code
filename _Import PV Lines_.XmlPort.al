xmlport 50100 "Import PV Lines"
{
    Caption = 'Import Payment Voucher Lines';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Payment Lines";
            "Payment Lines")
            {
                AutoUpdate = true;
                XmlName = 'PayLines';

                fieldelement(AcNo;
                "Payment Lines"."Account No")
                {
                }
                fieldelement(Amount;
                "Payment Lines".Amount)
                {
                }
                fieldelement(Desc;
                "Payment Lines".Description)
                {
                }
                trigger OnAfterInitRecord()
                begin
                    "Payment Lines"."Expenditure Type" := PayType;
                    GetPaymentType("Payment Lines"."Expenditure Type");
                end;

                trigger OnBeforeInsertRecord()
                begin
                    "Payment Lines".No := PaymentHeaderNo;
                    "Payment Lines"."Line No" := GetLineNo;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Payment Type"; PayType)
                {
                    Caption = 'Payment Type';
                    TableRelation = "Receipts and Payment Types".Code WHERE(Type = FILTER(Payment));
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    var
        PayType: Code[20];
        PaymentHeaderNo: Code[50];
        NoUnitsFoundError: Label 'Student No. %1 has not registered for Unit %2. Therefore, you cannot asign them marks for the same';
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account";
        PayHeader: Record Payments;
        MaxScoreError: Label '%1 Mark(s) assigned to Student No. %2 is greater than the maximum allowable score of %3 Mark(s) for %4 Programme.';
        NoexistError: Label 'Student No. %1 could not be located';
        CurrStudentError: Label 'Student No. %1 is not a current student';
        RecTypes: Record "Receipts and Payment Types";

    procedure GetHeaderNo(PayHeader: Record Payments)
    begin
        PaymentHeaderNo := PayHeader."No.";
    end;

    local procedure GetPaymentType(PType: Code[20])
    begin
        RecTypes.Reset;
        RecTypes.SetRange(Code, PType);
        if RecTypes.FindFirst then begin
            "Payment Lines"."Account Type" := RecTypes."Account Type";
            "Payment Lines".Description := RecTypes.Description;
        end;
    end;

    local procedure GetLineNo(): Integer
    var
        LineNo: Integer;
        Payment: Record Payments;
        PLines: Record "Payment Lines";
    begin
        PLines.Reset;
        PLines.SetRange(No, PaymentHeaderNo);
        if PLines.FindLast then
            LineNo := PLines."Line No" + 10000
        else
            LineNo := 10000;
        exit(LineNo);
    end;
}

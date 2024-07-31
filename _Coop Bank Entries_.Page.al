page 50838 "Coop Bank Entries"
{
    Caption = 'Coop Bank Entries';
    PageType = List;
    SourceTable = "Bank Entries";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                }
                field(TransactionReferenceCode; Rec.TransactionReferenceCode)
                {
                    ApplicationArea = All;
                }
                field(TransactionDate; Rec.TransactionDate)
                {
                    ApplicationArea = All;
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field(DocumentReferenceNumber; Rec.DocumentReferenceNumber)
                {
                    ApplicationArea = All;
                }
                field(BankCode; Rec.BankCode)
                {
                    ApplicationArea = All;
                }
                field(BranchCode; Rec.BranchCode)
                {
                    ApplicationArea = All;
                }
                field(PaymentDate; Rec.PaymentDate)
                {
                    ApplicationArea = All;
                }
                field(PaymentReferenceCode; Rec.PaymentReferenceCode)
                {
                    ApplicationArea = All;
                }
                field(PaymentCode; Rec.PaymentCode)
                {
                    ApplicationArea = All;
                }
                field(PaymentMode; Rec.PaymentMode)
                {
                    ApplicationArea = All;
                }
                field(PaymentAmount; Rec.PaymentAmount)
                {
                    ApplicationArea = All;
                }
                field(AdditionalInfo; Rec.AdditionalInfo)
                {
                    ApplicationArea = All;
                }
                field(AccountNumber; Rec.AccountNumber)
                {
                    ApplicationArea = All;
                }
                field(InstituitionCode; Rec.InstituitionCode)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

table 50178 "Bank Entries"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(2; TransactionReferenceCode; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(3; TransactionDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; TotalAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Currency; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(6; BankCode; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(7; BranchCode; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; PaymentDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; PaymentReferenceCode; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; PaymentCode; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; PaymentMode; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; PaymentAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; AdditionalInfo; Code[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(14; AccountNumber; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(15; InstituitionCode; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(16; DocumentReferenceNumber; Code[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }
}

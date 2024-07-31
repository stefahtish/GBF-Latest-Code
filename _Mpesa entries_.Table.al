table 50177 "Mpesa entries"
{
    Caption = 'Mpesa entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; TransID; Code[300])
        {
            Caption = 'TransID';
            DataClassification = ToBeClassified;
        }
        field(2; TransactionType; Code[300])
        {
            Caption = 'TransactionType';
            DataClassification = ToBeClassified;
        }
        field(3; TransTime; Time)
        {
            Caption = 'TransTime';
            DataClassification = ToBeClassified;
        }
        field(4; TransAmount; Decimal)
        {
            Caption = 'TransAmount';
            DataClassification = ToBeClassified;
        }
        field(5; BusinessShortCode; Code[300])
        {
            Caption = 'BusinessShortCode';
            DataClassification = ToBeClassified;
        }
        field(6; BillRefNumber; Code[300])
        {
            Caption = 'BillRefNumber';
            DataClassification = ToBeClassified;
        }
        field(7; InvoiceNumber; Code[100])
        {
            Caption = 'InvoiceNumber';
            DataClassification = ToBeClassified;
        }
        field(8; OrgAccountBalance; Decimal)
        {
            Caption = 'OrgAccountBalance';
            DataClassification = ToBeClassified;
        }
        field(9; ThirdPartyTransID; Code[200])
        {
            Caption = 'ThirdPartyTransID';
            DataClassification = ToBeClassified;
        }
        field(10; MSISDN; Code[200])
        {
            Caption = 'MSISDN';
            DataClassification = ToBeClassified;
        }
        field(11; FirstName; Text[100])
        {
            Caption = 'FirstName';
            DataClassification = ToBeClassified;
        }
        field(12; MiddleName; Text[100])
        {
            Caption = 'MiddleName';
            DataClassification = ToBeClassified;
        }
        field(13; LastName; Text[100])
        {
            Caption = 'LastName';
            DataClassification = ToBeClassified;
        }
        field(14; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; TransID)
        {
            Clustered = true;
        }
    }
}

tableextension 50144 "Invest_Sales&ReceivalbeSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Bill Batch No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Tenant Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50002; "Water Bill No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50003; "Management Fee Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50004; "Managment Fee %"; Decimal)
        {
        }
        field(50005; "Default Customer Posting Group"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }
        field(50006; "Default Gen Business Group"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Default Gen Business Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50007; "Default VAT Posting Group"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Default VAT Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
    }
}

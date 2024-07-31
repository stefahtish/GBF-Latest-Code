page 50822 "Mpesa Entries"
{
    ApplicationArea = All;
    Caption = 'Mpesa Entries';
    PageType = List;
    SourceTable = "Mpesa entries";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(TransactionType; Rec.TransactionType)
                {
                    ApplicationArea = All;
                }
                field(TransID; Rec.TransID)
                {
                    ApplicationArea = All;
                }
                field(TransTime; Rec.TransTime)
                {
                    ApplicationArea = All;
                }
                field(TransAmount; Rec.TransAmount)
                {
                    ApplicationArea = All;
                }
                field(ThirdPartyTransID; Rec.ThirdPartyTransID)
                {
                    ApplicationArea = all;
                }
                field(BusinessShortCode; Rec.BusinessShortCode)
                {
                    ApplicationArea = All;
                }
                field(BillRefNumber; Rec.BillRefNumber)
                {
                    ApplicationArea = All;
                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                    ApplicationArea = All;
                }
                field(OrgAccountBalance; Rec.OrgAccountBalance)
                {
                    ApplicationArea = All;
                }
                field(MSISDN; Rec.MSISDN)
                {
                    ApplicationArea = All;
                }
                field(FirstName; Rec.FirstName)
                {
                    ApplicationArea = All;
                }
                field(MiddleName; Rec.MiddleName)
                {
                    ApplicationArea = All;
                }
                field(LastName; Rec.LastName)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

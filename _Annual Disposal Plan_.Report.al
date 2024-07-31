report 50183 "Annual Disposal Plan"
{
    WordLayout = './AnnualDisposalPlan.docx';
    DefaultLayout = Word;
    ApplicationArea = All;

    dataset
    {
        dataitem(AnnualDisposalHeader; "AnnualDisposal Header")
        {
            column(Created_by; "Created by")
            {
            }
            column(Accounting_Period; "Accounting Period")
            {
            }
            column(Year; Year)
            {
            }
            dataitem(Lines; "Annual Asset Disposal Lines")
            {
                DataItemLink = "No." = field("No.");

                column(FA_No_; "FA No.")
                {
                }
                column(FA_Name; "FA Name")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Acquisition_Date; "Acquisition Date")
                {
                }
                column(Original_Purchase_Value; "Original Purchase Value")
                {
                }
                column(Estimated_Current_Value; "Estimated Current Value")
                {
                }
                column(Reasons_for_disposal; "Reasons for disposal")
                {
                }
                column(Item_Life_span; "Item Life span")
                {
                }
                column(Ref__No_to_the_asset_register_; "Ref. No to the asset register ")
                {
                }
                column(Disposal_Method; "Disposal Method")
                {
                }
                column(Cost_of_managing_disposal; "Cost of managing disposal")
                {
                }
                column(Disposal_Initiation; "Disposal Initiation")
                {
                }
                column(Bid_Documents_Prepared; "Bid Documents Prepared")
                {
                }
                column(Invitation_To_Tender; "Invitation To Tender")
                {
                }
                column(Bid_Opening; "Bid Opening")
                {
                }
                column(Accounting_officer_Award; "Accounting officer Award")
                {
                }
                column(Notification_of_Award; "Notification of Award")
                {
                }
                column(Contract_Signed; "Contract Signed")
                {
                }
                column(Disposal_Completed; "Disposal Completed")
                {
                }
                column(Notice_to_PPRA; "Notice to PPRA")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}

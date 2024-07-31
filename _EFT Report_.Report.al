report 50320 "EFT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Report 51519819 - EFTReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            column(No; "No.")
            {
            }
            column(Date; Date)
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            dataitem(EFTLines; "EFT Lines New")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(EFTDate; Date)
                {
                }
                column(PayeeBankCode; "Payee Bank Code")
                {
                }
                column(PayeeBankBranchCode; "Payee Bank Branch Code")
                {
                }
                column(PayeeBankAccountNo; "Payee Bank Account No")
                {
                }
                column(Payee; Payee)
                {
                }
                column(TotalAmount; "Total Amount")
                {
                }
                column(PaymentNarration; "Payment Narration")
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
    trigger OnPreReport()
    var
        Text001: Label 'Company information has not been setup.';
    begin
        if not CompanyInfo.Get() then Error(Text001);
    end;

    var
        CompanyInfo: Record "Company Information";
}

report 50337 "Bank Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Bank Balances.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "Bank Acc. Posting Group", "Date Filter";

            column(No_BankAccount; "Bank Account"."No.")
            {
            }
            column(Name_BankAccount; "Bank Account".Name)
            {
            }
            column(Title; STRSUBSTNO('SCHEDULE OF BANK BALANCE  AS AT %1', EndDate))
            {
            }
            column(Company; CompanyInfo.Name)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(Balance_BankAccount; "Bank Account"."Net Change")
            {
            }
            column(BalanceLCY_BankAccount; "Bank Account"."Net Change (LCY)")
            {
            }
            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                EndDate := "Bank Account".GETRANGEMAX("Date Filter");
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        EndDate: Date;
        CompanyInfo: Record "Company Information";
}

report 50141 "Bank Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BankPayments.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = WHERE(Posted = CONST(true));
            RequestFilterFields = "No.", "Payment Type";

            column(No_Payments; Payments."No.")
            {
            }
            column(PayingBankAccount_Payments; GetBankName(Payments."Paying Bank Account"))
            {
            }
            column(PaymentType_Payments; Payments."Payment Type")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo.County)
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = FIELD("No.");

                column(No_PaymentLines; "Payment Lines".No)
                {
                }
                column(AccountType_PaymentLines; "Payment Lines"."Account Type")
                {
                }
                column(AccountNo_PaymentLines; "Payment Lines"."Account No")
                {
                }
                column(AccountName_PaymentLines; "Payment Lines"."Account Name")
                {
                }
                column(Description_PaymentLines; "Payment Lines".Description)
                {
                }
                column(Amount_PaymentLines; "Payment Lines".Amount)
                {
                }
            }
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";

    local procedure GetBankName(BankCode: Code[20]): Text
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.Get(BankCode) then exit(BankAccount.Name);
    end;
}

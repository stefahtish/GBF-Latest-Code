report 50123 "Receipt Custom"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReceiptCustom.rdl';
    Caption = 'Receipt';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            RequestFilterFields = "No.";

            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(No; Payments."No.")
            {
            }
            column(Date; Payments.Date)
            {
            }
            column(Pay_Mode; Payments."Pay Mode")
            {
            }
            column(Cheque_No; Payments."Cheque No")
            {
            }
            column(Received_From; Payments."Received From")
            {
            }
            column(Currency; Payments.Currency)
            {
            }
            column(Amounts; Payments."Receipt Amount")
            {
            }
            column(PaymentReleaseDate_Payments; Payments."Payment Release Date")
            {
            }
            column(Amount_Words; NumberText[1])
            {
            }
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = FIELD("No.");

                column(Description; "Payment Lines".Description)
                {
                }
                column(Amount; "Payment Lines".Amount)
                {
                }
                column(VAT_Amount; "Payment Lines"."VAT Amount")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                Paymgt.InitTextVariable;
                Paymgt.FormatNoText(NumberText, "Receipt Amount", CurrencyCodeText);
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        NumberText: array[2] of Text;
        CurrencyCodeText: Code[20];
        Paymgt: Codeunit "Payments Management";
}

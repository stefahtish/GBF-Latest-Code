report 50128 "Receipt Custom - College"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReceiptCustomCollege.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            RequestFilterFields = "No.";

            column(Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
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
        NumberText: array[2] of Text[80];
        CurrencyCodeText: Code[20];
        Paymgt: Codeunit "Payments Management";
}

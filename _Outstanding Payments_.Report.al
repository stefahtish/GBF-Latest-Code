report 50121 "Outstanding Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OutstandingPayments.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = WHERE(Posted = CONST(true), Surrendered = CONST(false));
            RequestFilterFields = "Payment Type";

            column(No_Payments; Payments."No.")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(PayMode_Payments; Payments."Pay Mode")
            {
            }
            column(ChequeNo_Payments; Payments."Cheque No")
            {
            }
            column(ChequeDate_Payments; Payments."Cheque Date")
            {
            }
            column(Payee_Payments; Payments.Payee)
            {
            }
            column(AccountNo_Payments; Payments."Account No.")
            {
            }
            column(AccountName_Payments; Payments."Account Name")
            {
            }
            column(ImprestAmount_Payments; Payments."Imprest Amount")
            {
            }
            column(StaffNo_Payments; Payments."Staff No.")
            {
            }
            column(DateofProject_Payments; Payments."Date of Project")
            {
            }
            column(DateofCompletion_Payments; Payments."Date of Completion")
            {
            }
            column(DueDate_Payments; Payments."Due Date")
            {
            }
            column(NoofDays_Payments; Payments."No of Days")
            {
            }
            column(Destination_Payments; Payments.Destination)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
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
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(AsAt; AsAt)
            {
            }
            trigger OnPreDataItem()
            begin
                //Payments.SETFILTER("Due Date",'<=%1',AsAt);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    Caption = 'Due As At';
                    ApplicationArea = All;
                }
            }
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
        if AsAt = 0D then AsAt := Today;
    end;

    var
        AsAt: Date;
        CompanyInfo: Record "Company Information";
}

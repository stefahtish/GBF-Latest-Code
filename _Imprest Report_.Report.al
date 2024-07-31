report 50500 "Imprest Report"
{
    Caption = 'Imprest Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521632 ImprestReport.rdl';

    dataset
    {
        dataitem(PaymentsRec; Payments)
        {
            DataItemTableView = where("Payment Type"=const(Imprest));
            RequestFilterFields = Status;

            column(No; PaymentsRec."No.")
            {
            }
            column(AppDate; PaymentsRec.Date)
            {
            }
            column(DateCreated; PaymentsRec."Date Created")
            {
            }
            column(DateFilter; PaymentsRec."Date Filter")
            {
            }
            column(DueDate; PaymentsRec."Due Date")
            {
            }
            column(DateofCompletion; PaymentsRec."Date of Completion")
            {
            }
            column(DateSurrendered; PaymentsRec."Date Surrendered")
            {
            }
            column(DateofProject; PaymentsRec."Date of Project")
            {
            }
            column(PostedDate; PaymentsRec."Posted Date")
            {
            }
            column(EFTDate; PaymentsRec."EFT Date")
            {
            }
            column(RTGSDate; PaymentsRec."RTGS Date")
            {
            }
            column(PostedBy; PaymentsRec."Posted By")
            {
            }
            column(TimeInserted; PaymentsRec."Time Inserted")
            {
            }
            column(TimePosted; PaymentsRec."Time Posted")
            {
            }
            column(RecAccountType; PaymentsRec."Account Type")
            {
            }
            column(AccountNo; PaymentsRec."Account No.")
            {
            }
            column(AccountName; PaymentsRec."Account Name")
            {
            }
            column(StaffNo; PaymentsRec."Staff No.")
            {
            }
            column(CreatedBy; PaymentsRec."Created By")
            {
            }
            column(CreatedByUserName; PaymentsRec."Created By User Name")
            {
            }
            column(Posted; PaymentsRec.Posted)
            {
            }
            column(PaymentType; PaymentsRec."Payment Type")
            {
            }
            column(Status; PaymentsRec.Status)
            {
            }
            column(ImprestAmount; PaymentsRec."Imprest Amount")
            {
            }
            column(ImpressAmount1; PaymentsRec."Impress Amount 1")
            {
            }
            column(ImpressAmount2; PaymentsRec."Impress Amount 2")
            {
            }
            column(ImprestDeadline; PaymentsRec."Imprest Deadline")
            {
            }
            column(Destination; PaymentsRec.Destination)
            {
            }
            column(ShortcutDimension1Code; PaymentsRec."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; PaymentsRec."Shortcut Dimension 2 Code")
            {
            }
            column(NoofDays; PaymentsRec."No of Days")
            {
            }
            column(TotalAmount; PaymentsRec."Total Amount")
            {
            }
            column(PayModeDetails; PaymentsRec."Pay Mode")
            {
            }
            column(ChequeNo; PaymentsRec."Cheque No")
            {
            }
            column(ChequeDate; PaymentsRec."Cheque Date")
            {
            }
            column(ImprestPayee; PaymentsRec.Payee)
            {
            }
            column(PayingBankAccount; PaymentsRec."Paying Bank Account")
            {
            }
            column(Surrendered; PaymentsRec.Surrendered)
            {
            }
            column(SurrenderedBy; PaymentsRec."Surrendered By")
            {
            }
            column(SurrenderStatus; PaymentsRec."Surrender Status")
            {
            }
            column(Cashier; PaymentsRec.Cashier)
            {
            }
            column(ResponsibilityCenter; PaymentsRec."Responsibility Center")
            {
            }
            column(ChequeType; PaymentsRec."Cheque Type")
            {
            }
            column(PaymentNarration; PaymentsRec."Payment Narration")
            {
            }
            column(TravelType; PaymentsRec."Travel Type")
            {
            }
            column(CmpLogo; CompanyInformation.Picture)
            {
            }
            column(CmpAddress; CompanyInformation.Address)
            {
            }
            column(CmpPostcode; CompanyInformation."Post Code")
            {
            }
            column(CmpPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CmpCity; CompanyInformation.City)
            {
            }
            column(CmpEmail; CompanyInformation."E-Mail")
            {
            }
            column(Homepage; CompanyInformation."Home Page")
            {
            }
            dataitem(PaymentLines; "Payment Lines")
            {
                DataItemLinkReference = PaymentsRec;
                DataItemLink = No=field("No.");

                column(PayNo; PaymentLines.No)
                {
                }
                column(ImprestType; PaymentLines."Expenditure Type")
                {
                }
                column(LinePaymentType; PaymentLines."Payment Type")
                {
                }
                column(ClaimType; PaymentLines."Claim Type")
                {
                }
                column(AccountType; PaymentLines."Account Type")
                {
                }
                column(LineAccountNo; PaymentLines."Account No")
                {
                }
                column(LineAccountName; PaymentLines."Account Name")
                {
                }
                column(Description; PaymentLines.Description)
                {
                }
                column(BasedOnTravelRates; PaymentLines."Based On Travel Rates")
                {
                }
                column(LineNoofDays; PaymentLines."No of Days")
                {
                }
                column(LineDailyRate; PaymentLines."Daily Rate")
                {
                }
                column(Amount; PaymentLines.Amount)
                {
                }
                column(AmountLCY; PaymentLines."Amount (LCY)")
                {
                }
                column(NetAmount; PaymentLines."Net Amount")
                {
                }
                column(NetAmountLCY; PaymentLines."NetAmount LCY")
                {
                }
                column(PayModeType; PaymentLines."Pay Mode Type")
                {
                }
                column(PayMode; PaymentLines."Pay Mode")
                {
                }
                column(GLAccounttoDebit; PaymentLines."G/L Account to Debit")
                {
                }
                column(BalAccountType; PaymentLines."Bal Account Type")
                {
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var CompanyInformation: Record "Company Information";
}

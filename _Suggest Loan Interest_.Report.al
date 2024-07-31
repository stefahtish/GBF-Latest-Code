report 50261 "Suggest Loan Interest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SuggestLoanInterest.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(LoanApplication; "Loan Application")
        {
            CalcFields = "Total Repayment";
            DataItemTableView = WHERE("Loan Status" = FILTER(Issued));
            RequestFilterFields = "Loan No", "Date filter";
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
}

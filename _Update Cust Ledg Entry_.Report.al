report 50374 "Update Cust Ledg Entry"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateCustLedgEntry.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
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

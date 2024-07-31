report 50330 "Termination of Procurement"
{
    Caption = 'Termination of Procurement & Disposal';
    DefaultLayout = RDLC;
    RDLCLayout = './TerminationOfProcurement.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(ProcurementRequest; "Procurement Request")
        {
            column(TenderStatus; "Tender Status")
            {
            }
            column(TenderType; "Tender Type")
            {
            }
            column(TenderClosingDate; TenderClosingDate)
            {
            }
            column(TenderOpeningDate; TenderOpeningDate)
            {
            }
            column(Terminated; Terminated)
            {
            }
            column(TerminationCode; "Termination Code")
            {
            }
            column(TerminationDate; "Termination Date")
            {
            }
            column(TerminationReason; "Termination Reason")
            {
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

report 50101 "Test Report - Default=RDLC"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Test Report - Default=RDLC.rdlc';
    WordLayout = './Test Report - Default=RDLC.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1; "Customer")
        {
            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(Name; Name)
            {
                IncludeCaption = true;
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
}


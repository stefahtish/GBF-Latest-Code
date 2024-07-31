report 50100 "Test Report - Default=Word"
{
    RDLCLayout = './Test Report - Default=Word.rdlc';
    WordLayout = './Test Report - Default=Word.docx';
    DefaultLayout = Word;
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

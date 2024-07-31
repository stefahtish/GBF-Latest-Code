report 50140 "Post Apportionment"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    ApplicationArea = All;

    dataset
    {
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
    trigger OnPostReport()
    begin
        Apportionment.PostICApportionEntry;
    end;

    var
        Apportionment: Codeunit Apportionment;
}

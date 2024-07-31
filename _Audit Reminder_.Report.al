report 50364 "Audit Reminder"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AuditReminder.rdlc';
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
    trigger OnPreReport()
    begin
        AuditMgt.MailReportDeadlineReminder;
    end;

    var
        AuditMgt: Codeunit "Internal Audit Management";
        TestInt: Decimal;
}

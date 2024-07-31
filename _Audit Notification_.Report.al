report 50355 "Audit Notification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AuditNotification.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Communication Header"; "Communication Header")
        {
            column(SenderName; "Communication Header"."Sender Name")
            {
            }
            column(ReceipientName; "Communication Header"."Receipient Name")
            {
            }
            column(EMailSubject; "Communication Header"."E-Mail Subject")
            {
            }
            column(AuditerName; "Communication Header"."Auditer Name")
            {
            }
            column(AuditFirm; "Communication Header"."Audit Firm")
            {
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
    end;

    var
        CompanyInfo: Record "Company Information";
}

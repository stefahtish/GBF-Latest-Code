codeunit 50153 "Timesheet Reminders"
{

    trigger OnRun()

    var
        EmployeeRec: Record Employee;
        CompanyInfo: Record "Company Information";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
        NewBody: Label 'Dear %1, <br><br>This is a friendly reminder to fill in your timesheet for the week by the end of the day today.<br><br>Kind Regards,<br><br>%3.';
    begin
        // Get company information
        CompanyInfo.Get;
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        // Set email subject
        Subject := 'Weekly Timesheet Reminder';

        // Loop through all active employees and send reminder emails
        EmployeeRec.Reset();
        EmployeeRec.SetRange(Status, EmployeeRec.Status::Active);
        if EmployeeRec.FindSet() then
            repeat
                if EmployeeRec."E-Mail" <> '' then begin
                    // Prepare email body
                    Body := StrSubstNo(NewBody, EmployeeRec."First Name", Format(Today, 0, 'ShortDate'), CompanyInfo.Name);

                    // Create and send the email directly
                    EmailMessage.Create(EmployeeRec."E-Mail", Subject, Body, true);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                end;
            until EmployeeRec.Next() = 0;
    end;
}



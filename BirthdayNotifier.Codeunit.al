codeunit 50152 BirthdayNotifier
{
    Subtype = Normal;

    trigger OnRun()
    begin
        CheckAndNotifyBirthdays();
        checkAndNotifJoin();
    end;
    local procedure CheckAndNotifyBirthdays()
    var
        EmployeeRec: Record Employee;
        Notification: Notification;
        Today: Date;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Receipient: list of[Text];
        Subject: Text;
        NewBody: Text;
    begin
        if EmployeeRec.FindSet()then repeat Receipient.Add(EmployeeRec."E-Mail");
                NewBody:='Today is the birthday of' + EmployeeRec.FullName() + 'Thank you';
                Subject:='Today is the birthday of ' + EmployeeRec.FullName();
                if(EmployeeRec."Birth Date" <> 0D) and (Date2DMY(EmployeeRec."Birth Date", 2) = Date2DMY(Today, 2)) and (Date2DMY(EmployeeRec."Birth Date", 1) = Date2DMY(Today, 1))then begin
                    EmailMessage.Create(Receipient, Subject, NewBody, true);
                    Email.Send(EmailMessage, enum::"Email Scenario"::Default)end;
            until EmployeeRec.Next() = 0;
    end;
    local procedure CheckAndNotifJoin()
    var
        EmployeeRec: Record Employee;
        Notification: Notification;
        Today: Date;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Receipient: list of[Text];
        Subject: Text;
        NewBody: Text;
    begin
        if EmployeeRec.FindSet()then repeat Receipient.Add(EmployeeRec."E-Mail");
                NewBody:='Work Anniversary' + EmployeeRec.FullName() + 'Thank you';
                Subject:='Today is the work Anniversary for' + EmployeeRec.FullName();
                if(EmployeeRec."Date Of Join" <> 0D) and (Date2DMY(EmployeeRec."Date Of Join", 2) = Date2DMY(Today, 2)) and (Date2DMY(EmployeeRec."Date Of Join", 1) = Date2DMY(Today, 1))then begin
                    EmailMessage.Create(Receipient, Subject, NewBody, true);
                    Email.Send(EmailMessage, enum::"Email Scenario"::Default)end;
            until EmployeeRec.Next() = 0;
    end;
}

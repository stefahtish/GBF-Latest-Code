report 50514 "Birthday and anniversary"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(EmployeeRec; Employee)
        {
            trigger OnAfterGetRecord()
            begin
                NewBody:='Today is the birthday of' + EmployeeRec.FullName() + 'Thank you';
                Subject:='Today is the birthday of ' + EmployeeRec.FullName();
                if((EmployeeRec."Birth Date" <> 0D) and (Date2DMY(EmployeeRec."Birth Date", 2) = Date2DMY(Today, 2)) and (Date2DMY(EmployeeRec."Birth Date", 1) = Date2DMY(Today, 1)))then begin
                    Receipient.Add(EmployeeRec."E-Mail");
                    EmailMessage.Create(Receipient, Subject, NewBody, true);
                    Email.Send(EmailMessage, enum::"Email Scenario"::Default)end;
                NewBody2:='Work anniversary' + EmployeeRec.FullName() + 'Thank you';
                Subject2:='Today is the work Anniversary for' + EmployeeRec.FullName();
                if(EmployeeRec."Date Of Join" <> 0D) and (Date2DMY(EmployeeRec."Date Of Join", 2) = Date2DMY(Today, 2)) and (Date2DMY(EmployeeRec."Date Of Join", 1) = Date2DMY(Today, 1))then begin
                    Receipient2.Add(EmployeeRec."E-Mail");
                    EmailMessage.Create(Receipient2, Subject2, NewBody2, true);
                    Email.Send(EmailMessage, enum::"Email Scenario"::Default)end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
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
                action(LayoutName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var Notification: Notification;
    Today: Date;
    EmailMessage: Codeunit "Email Message";
    Email: Codeunit Email;
    Receipient: list of[Text];
    Receipient2: list of[Text];
    Subject: Text;
    NewBody: Text;
    Subject2: Text;
    NewBody2: Text;
}

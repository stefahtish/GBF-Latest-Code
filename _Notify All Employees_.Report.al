report 50457 "Notify All Employees"
{
    Caption = 'Notify All Employees';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            trigger OnAfterGetRecord()
            var
                FirstPart: Label 'Dear %1,<br> <br>';
                MainBody: Text;
            begin
                HRsetup.Get();
                HRSetup.TestField("Human Resource Emails");
                EmpRec.Reset();
                If EmpRec.Get(Employee."No.") then begin
                    Window.Update(1, 'Notifying' + "First Name" + ' ' + "Middle Name");
                    // HRMgmt.NotifyAllEmployees(EmpRec."No.");
                    Clear(Receipient);
                    Subject := HRsetup."Email Subject";
                    TimeNow := (Format(Time));
                    SenderAddress := HRsetup."Human Resource Emails";
                    If EmpRec."Company E-Mail" <> ' ' then Receipient.Add(EmpRec."Company E-Mail");
                    SMTP.Create(Receipient, Subject, '', true);
                    SMTP.AppendtoBody(StrSubstNo(FirstPart, Employee."First Name"));
                    MainBody := HRsetup."Employee Email Body" + ' ' + '<br> <br>Regards, <br>' + CompInfo.Name;
                    SMTP.AppendtoBody(HRsetup."Email Text");
                    email.Send(SMTP);
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange(Employee."Employment Status", Employee."Employment Status"::Active);
            end;
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfo.get();
    end;

    var
        HRMgmt: Codeunit "HR Management";
        EmpRec: Record Employee;
        Window: Dialog;
        TimeNow: Text;
        SenderName: Text;
        SMTP: Codeunit "email message";
        email: Codeunit email;
        EmailMessage: Codeunit "Email Message";
        SenderAddress: Text;
        Receipient: list of [text];
        Subject: Text;
        HRsetup: Record "Human Resources Setup";
        CompInfo: Record "Company Information";
}

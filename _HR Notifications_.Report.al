report 50190 "HR Notifications"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = WHERE("Birth Date" = FILTER(<> 0D));

            trigger OnAfterGetRecord()
            begin
                // EmployeeBirthday;
                // FleetNextService(FA."No.");
                Hrmgt.EmployeeBirthday(Employee);
            end;
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
    var
        CompanyInfo: Record "Company Information";
        FA: Record "Fixed Asset";
        Hrmgt: Codeunit "HR Management";

    procedure EmployeeBirthday()
    var
        BirthDate: Integer;
        BirthMonth: Integer;
        TodayDate: Integer;
        TodayMonth: Integer;
        Employee: Record Employee;
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        email: Codeunit email;
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        EmailBody: Label 'Dear %1, <br>Congratulations! You have Successfully secured a position at the <strong>Institute of Energy Studies & Research</strong>. <br>Kindly visit  your applicatioin Portal to Download the Admission Letter.';
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">HAPPY BIRTHDAY<br> Enjoy!<br> Thank you. <br> Kind Regards, <br> %2';
        MailSuccess: Label 'Employees have been notified successfully.';
    begin
        TodayDate := Date2DMY(Today, 1);
        TodayMonth := Date2DMY(Today, 2);
        BirthDate := 0;
        BirthMonth := 0;
        Employee.Reset;
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetRange("No.", Employee."No.");
        if Employee.Find('-') then begin
            BirthDate := Date2DMY(Employee."Birth Date", 1);
            BirthMonth := Date2DMY(Employee."Birth Date", 2);
            if (BirthDate = TodayDate) and (BirthMonth = TodayMonth) then begin
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient := Employee."E-Mail";
                Subject := 'Happy Birthday';
                TimeNow := Format(Time);
                //SMTP.CreateMessage(SenderName, SenderAddress, Receipient, Subject, '', true);
                SMTP.AppendtoBody(StrSubstNo(NewBody, Employee."First Name", CompanyInfo.Name));
                /* if RecipientCC <> '' then
                    SMTP.AddCC(RecipientCC); */
                email.Send(SMTP);
            end;
        end;
    end;

    procedure ContractEndNotice(EmployeeNo: Code[50])
    var
        Employee: Record Employee;
        ContractEndDate: Date;
        TodayDate: Date;
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: Text;
        Subject: Text;
        email: Codeunit email;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        EmailBody: Label 'Dear %1, <br>Congratulations! You have Successfully secured a position at the <strong>Institute of Energy Studies & Research</strong>. <br>Kindly visit  your applicatioin Portal to Download the Admission Letter.';
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your Contract is ending<br> Kindly Re-Apply for another Contract<br> Thank you. <br> Kind Regards, <br> %2';
        MailSuccess: Label 'Employees have been notified successfully.';
    begin
        TodayDate := Today;
        Employee.Reset;
        Employee.SetRange(Status, Employee.Status::Active);
        //Employee.SETRANGE("Contract Type",Employee."Contract Type"::);
        if Employee.Find('-') then begin
            ContractEndDate := Employee."Contract End Date";
            if TodayDate = CalcDate('-9M', ContractEndDate) then begin
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient := Employee."E-Mail";
                Subject := 'Contract End';
                TimeNow := Format(Time);
                //SMTP.CreateMessage(SenderName, SenderAddress, Receipient, Subject, '', true);
                SMTP.AppendtoBody(StrSubstNo(NewBody, Employee."First Name", CompanyInfo.Name));
                /* if RecipientCC <> '' then
                    SMTP.AddCC(RecipientCC); */
                email.Send(SMTP)
            end;
        end;
    end;

    procedure FleetNextService(FleetNo: Code[10]) EmployeeEmail: Text
    var
        Maintain: Record "Maintenance Registration";
        NextService: Date;
        TodayDate: Date;
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: Text;
        Subject: Text;
        FileName: Text;
        email: Codeunit Email;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        FA: Record "Fixed Asset";
        NewBody: Label 'Body';
    begin
        TodayDate := Today;
        Maintain.Reset;
        Maintain.SetRange("FA No.", FleetNo);
        if Maintain.Find('-') then begin
            if TodayDate = CalcDate('-1D', Today) then begin
                CompanyInfo.Get;
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient := EmployeeEmail;
                Subject := 'Vehicle Service';
                TimeNow := Format(Time);
                //SMTP.CreateMessage(SenderName, SenderAddress, Receipient, Subject, '', true);
                SMTP.AppendtoBody(StrSubstNo(NewBody));
                /*  if RecipientCC <> '' then
                     SMTP.AddCC(RecipientCC); */
                email.Send(SMTP);
            end;
        end;
    end;
}

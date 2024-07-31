report 50244 "Mail Bulk P9s"
{
    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = FILTER(Active));

            trigger OnAfterGetRecord()
            begin
                Employee.testfield("Company E-Mail");
                //Check Period Entries
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Employee No", Employee."No.");
                // AssignMatrix.SetRange("Payroll Period", PayPeriod);
                if not AssignMatrix.Find('-') then CurrReport.Skip;
                Percentage := (Round(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, (Format(Employee."No.") + '-' + Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"));
                if (Employee."Birth Date" <> 0D) then begin
                    Employee.Validate("Birth Date");
                    Employee.Modify;
                end;
                Commit;
                //Send Payslips
                Receipient.add(Employee."Company E-Mail");
                Subject := 'P9 for  Period - ' + PayPeriodText;
                TimeNow := Format(Time);
                FileName := HRSetup."Payslips Path" + PayPeriodText + '-' + Employee."No." + '.pdf';
                //Save Pdf
                EmpRec.Reset;
                EmpRec.SetRange("No.", Employee."No.");
                if EmpRec.FindFirst then begin
                    Clear(P9Report);
                    P9Report.SetTableView(EmpRec);
                    P9Report.GetDefaults(Year);
                    //eddieP9Report.SaveAs('',Format(FileName),);
                end;
                SMTP.Create(Receipient, Subject, '', true);
                //SMTP.CreateMessage(SenderName, SenderAddress, Employee."Company E-Mail", Subject, '', TRUE);
                SMTP.AppendtoBody(StrSubstNo(NewBody, Employee."First Name", PayPeriodText));
                SMTP.AddAttachment(FileName, PayPeriodText + '-' + Employee."No." + '.pdf', '');
                email.Send(SMTP);
                //Delete
                //FileManagement.DeleteClientFile(FileName);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
                Message('P9s sent Successfully!');
            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Sending P9s: @1@@@@@@@@@@@@@@@' + 'Employee:#2###############');
                TotalCount := Count;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                // field("End Date"; EndDate)
                // {
                // }
            }
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
        if StringDate = 0D then error('Start date must have a value');
        if EndDate = 0D then error('End date must have a value');
        //Init File System
        HRSetup.Get;
        HRSetup.TestField("Payslips Path");
        HRSetup.TestField("General Payslip Message");
        HRSetup.TestField("Human Resource Emails");
        CompanyInfo.Get;
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");
        PayPeriodText := Format(StringDate, 0, '<Month Text> <Year4>') + '-' + Format(EndDate, 0, '<Month Text> <Year4>');
        SenderName := CompanyInfo.Name;
        SenderAddress := CompanyInfo."E-Mail";
    end;

    var
        Payroll: Codeunit Payroll;
        PayPeriod: Date;
        Error0001: Label 'Please define a payment period';
        //FileSystem: Automation BC;
        FormattedAppNo: Code[100];
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        email: Codeunit Email;
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        PayPeriodText: Text;
        HRSetup: Record "Human Resources Setup";
        CompanyInfo: Record "Company Information";
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly find attached your P9 for the Month of <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong></Strong>';
        EmpRec: Record Employee;
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        AssignMatrix: Record "Assignment Matrix-X";
        P9Report: Report "P9A Report";
        StringDate: Date;
        outstream: OutStream;
        EndDate: Date;
        Year: Integer;
}

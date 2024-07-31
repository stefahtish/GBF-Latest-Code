report 50242 "Mail Bulk Payslips"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = FILTER(Active));

            trigger OnAfterGetRecord()
            begin
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Employee No", Employee."No.");
                AssignMatrix.SetRange("Payroll Period", PayPeriod);
                if not AssignMatrix.Find('-') then CurrReport.Skip;
                EmailManager.RunPayslip(Employee, true, true, PayPeriod);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
                Message('Payslips sent Successfully!');
            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Sending Payslips: @1@@@@@@@@@@@@@@@' + 'Employee:#2###############');
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
                field("Pay Period"; PayPeriod)
                {
                    TableRelation = "Payroll PeriodX"."Starting Date";
                    ApplicationArea = All;
                }
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
        if PayPeriod = 0D then Error(Error0001);
        //Init File System
        HRSetup.Get;
        HRSetup.TestField("Payslips Path");
        HRSetup.TestField("General Payslip Message");
        HRSetup.TestField("Human Resource Emails");
        CompanyInfo.Get;
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");
        PayPeriodText := Format(PayPeriod, 0, '<Month Text> <Year4>');
        SenderName := HRSetup."General Payslip Message";
        SenderAddress := HRSetup."Human Resource Emails";
    end;

    var
        Payroll: Codeunit Payroll;
        PayPeriod: Date;
        Error0001: Label 'Please define a payment period';
        //FileSystem: Automation BC;
        FormattedAppNo: Code[100];
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "Email Message";
        Email: Codeunit email;
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
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly find attached your Payslip for the Month of <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong>Kenya Dairy Board Salaries</Strong>';
        EmpRec: Record Employee;
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        AssignMatrix: Record "Assignment Matrix-X";
        RecRef: RecordRef;
        OutStr: OutStream;
        InStr: InStream;
        EmailManager: Codeunit "Email Notification Manager";

    local procedure SetEmailingReport(RecID: Integer; FileName: Text)
    var
        LocalRecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Test: Text;
        GetFilter: Text;
        LocalPayments: Record Payments;
        OutStr: OutStream;
        InStr: InStream;
    begin
        Clear(TempBlob);
        if LocalPayments.FindFirst() then begin
            LocalRecRef.GetTable(LocalPayments);
            TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
            Report.SaveAs(Report::"New Payslipx", '', ReportFormat::Pdf, OutStr, LocalRecRef);
            TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
            SMTP.AddAttachment('', FileName, ''); //eddie
        end;
    end;

    procedure SetPayPeriod(Period: Date)
    var
        myInt: Integer;
    begin
        PayPeriod := period;
    end;
}

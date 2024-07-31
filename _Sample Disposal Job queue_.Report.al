report 50421 "Sample Disposal Job queue"
{
    ApplicationArea = All;
    dataset
    {
        dataitem(SampleHeader; "Sample Reception Header")
        {
            trigger OnAfterGetRecord()
            var
                SampleDisposal: record "Sample Disposal";
                SampleRec: Record "Sample Reception Header";
                Employee: Record Employee;
            begin
                if SampleHeader."Sample Disposal Date" <= Today then begin
                    SampleDisposal.Reset();
                    SampleDisposal.SetRange("Sample Reception No.", SampleHeader."Entry No.");
                    if not SampleDisposal.FindFirst() then begin
                        SampleDisposal.Init();
                        SampleDisposal."Sample Reception No." := SampleHeader."Entry No.";
                        SampleDisposal.Insert(true);
                        if SampleHeader."Entry Officer No." <> '' then begin
                            Employee.Reset();
                            Employee.SetRange("No.", SampleHeader."Entry Officer No.");
                            Employee.SetFilter("Company E-Mail", '<>%1', '');
                            if Employee.FindFirst() then begin
                                //Send email
                                Clear(Receipient);
                                Name := Employee."First Name";
                                CompanyInfo.GET;
                                CompanyInfo.TESTFIELD(Name);
                                CompanyInfo.TESTFIELD("E-Mail");
                                SenderName := CompanyInfo.Name;
                                SenderAddress := CompanyInfo."E-Mail";
                                Receipient.Add(Employee."Company E-Mail");
                                TimeNow := FORMAT(TIME);
                                Subject := 'Sample Disposal';
                                SMTP.Create(Receipient, Subject, '', TRUE);
                                SMTP.AppendTOBody(STRSUBSTNO(BodyTxt, Name, SampleHeader.SampleID, SampleHeader."Entry No.", SampleDisposal."No."));
                                EMAIL.Send(SMTP);
                                SampleRec.Reset();
                                SampleRec.SetRange("Entry No.", SampleHeader."Entry No.");
                                if SampleRec.FindFirst() then begin
                                    SampleRec.Disposed := true;
                                    SampleRec.Modify();
                                end;
                            end;
                        end;
                    end;
                end;
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
    var
        CompanyInfo: Record "Company Information";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        ReceipientCC: List of [Text];
        TimeNow: Text;
        Subject: Text;
        Name: Text[50];
        SMTP: Codeunit "email message";
        email: Codeunit email;
        BodyTxt: Label 'Dear %1, <br><br>This is to inform you that disposal date of sample ID %2 with entry no %3 is today. Sample disposal %4 has been created.<br><br>Thank you.<br><br>Kind Regards,<br><br>';
}

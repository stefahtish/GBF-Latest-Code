report 50401 "FA Service Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(FA; "Fixed Asset")
        {
            trigger OnAfterGetRecord()
            var
                FixedAsset: Record "Fixed Asset";
            begin
                IF ((FA."Current Odometer Reading" >= (FA."Next Service Mileage" - PurchPayables."Notification Mileage")) and (FA."Next Service Date" < Today)) THEN BEGIN
                    FixedAsset.SetRange("No.", FA."No.");
                    if FixedAsset.FindFirst() then begin
                        FixedAsset."Next Service Date" := Today;
                        FixedAsset."Next Service Date" := CalcDate('1D', "Next Service Date");
                        FixedAsset.Modify();
                    END;
                    CompanyInfo.GET;
                    CompanyInfo.TESTFIELD(Name);
                    CompanyInfo.TESTFIELD("E-Mail");
                    PurchSetup.Get;
                    PurchSetup.TestField("Procurement Email");
                    PurchSetup.TestField("Stores Email");
                    SenderName := CompanyInfo.Name;
                    SenderAddress := CompanyInfo."E-Mail";
                    Receipient.Add(PurchSetup."Asset Manager Email");
                    Subject := 'Fixed asset due for service.';
                    TimeNow := FORMAT(TIME);
                    SMTP.Create(Receipient, Subject, '', TRUE);
                    SMTP.AppendtoBody(STRSUBSTNO(FABodyTxt, FA."No.", FA.Description, FA."Current Odometer Reading", FA."Next Service Mileage", FA."Next Service Date"));
                    IF ReceipientCC.Count <> 0 THEN //eddieSMTP.AddCC(ReceipientCC);
                        email.Send(SMTP);
                end;
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        PurchPayables.Get;
        PurchPayables.TestField("Asset Manager Email");
        PurchPayables.TestField("Notification Mileage");
    end;

    var
        CompanyInfo: Record "Company Information";
        SenderName: Text;
        PurchPayables: record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        SenderAddress: Text;
        Receipient: List of [Text];
        ReceipientCC: List of [Text];
        TimeNow: Text;
        Subject: Text;
        SMTP: Codeunit "Email Message";
        Email: Codeunit Email;
        PurchSetup: Record "Purchases & Payables Setup";
        FABodyTxt: Label '<br><br>The Asset %1 - %2 is due for service. Its current mileage is %3 and next service is at mileage reading %4. The next service date has been scheduled for %5. <br><br>Thank you.<br><br>Regards,<br><br>';
}

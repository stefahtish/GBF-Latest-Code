report 50347 "Vehicle Inspection Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            trigger OnAfterGetRecord()
            var
                DateDue: Date;
            begin
                DateDue := CalcDate('-14D', Today);
                FixedAsset.Reset;
                FixedAsset.SetRange("Fixed Asset Type", FixedAsset."Fixed Asset Type"::Fleet);
                FixedAsset.SetFilter("Inspection Due Date", '=%1', DateDue);
                IF FixedAsset.Find('-') THEN BEGIN
                    CompanyInfo.GET;
                    CompanyInfo.TESTFIELD(Name);
                    CompanyInfo.TESTFIELD("E-Mail");
                    PurchSetup.Get;
                    PurchSetup.TestField("Procurement Email");
                    PurchSetup.TestField("Stores Email");
                    SenderName := CompanyInfo.Name;
                    SenderAddress := CompanyInfo."E-Mail";
                    Receipient.Add(PurchSetup."Stores Email");
                    ReceipientCC.Add(PurchSetup."Procurement Email");
                    Subject := 'Vehicle Inspection Date';
                    TimeNow := FORMAT(TIME);
                    SMTP.Create(Receipient, Subject, '', TRUE);
                    SMTP.AppendtoBody(STRSUBSTNO(InspectionBodyTxt, FixedAsset."Registration No", FixedAsset."Inspection Due Date"));
                    IF ReceipientCC.Count <> 0 THEN //eddie SMTP.AddCC(ReceipientCC);
                        Email.Send(SMTP);
                END;
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
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        ReceipientCC: List of [Text];
        TimeNow: Text;
        Subject: Text;
        SMTP: Codeunit "Email Message";
        Email: Codeunit Email;
        PurchSetup: Record "Purchases & Payables Setup";
        InspectionBodyTxt: Label '<br><br>This is to notify you that the vehicle with registration number %1 is due for inspection on %2.<br><br>Thank you.<br><br>Regards,<br><br>';
}

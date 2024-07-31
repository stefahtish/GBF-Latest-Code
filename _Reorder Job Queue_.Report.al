report 50397 "Reorder Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord()
            begin
                //Update KRIs
                IF ((Item."Reorder Point" <= Item.Inventory) and (Item."Reorder Point" > 0)) THEN BEGIN
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
                    Subject := 'Item reorder level.';
                    TimeNow := FORMAT(TIME);
                    SMTP.Create(Receipient, Subject, '', TRUE);
                    SMTP.AppendtoBody(STRSUBSTNO(ReorderBodyTxt, Item."No.", Item.Description, Item."Reorder Point"));
                    IF ReceipientCC.Count <> 0 THEN //eddie  SMTP.AddCC(ReceipientCC);
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
        ReorderBodyTxt: Label '<br><br>The Item %1 has reached the reorder level of quantity %2.<br><br>Thank you.<br><br>Regards,<br><br>';
}

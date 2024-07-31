page 50900 "Audit Communication"
{
    PageType = Card;
    SourceTable = "Communication Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Communication Type"; Rec."Communication Type")
                {
                }
                group(Control13)
                {
                    ShowCaption = false;
                    Visible = (Rec."Communication Type" = Rec."Communication Type"::"E-Mail"); //"Communication Type" = "Communication Type"::"E-Mail & SMS")

                    label("Email Details:")
                    {
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("Sender Email"; Rec."Sender Email")
                    {
                    }
                    field("E-Mail Subject"; Rec."E-Mail Subject")
                    {
                    }
                    field("Email Message"; EmailTxt)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.CALCFIELDS("E-Mail Body");
                            rec."E-Mail Body".CREATEINSTREAM(InStrm);
                            EmailBigTxt.READ(InStrm);
                            IF EmailTxt <> FORMAT(EmailBigTxt) THEN BEGIN
                                CLEAR(Rec."E-Mail Body");
                                CLEAR(EmailBigTxt);
                                EmailBigTxt.ADDTEXT(EmailTxt);
                                rec."E-Mail Body".CREATEOUTSTREAM(OutStrm);
                                EmailBigTxt.WRITE(OutStrm);
                            END;
                        end;
                    }
                    field("Receipient E-Mail"; Rec."Receipient E-Mail")
                    {
                    }
                }
                group(Control14)
                {
                    ShowCaption = false;
                    Visible = false;

                    //Visible = (("Communication Type" = "Communication Type"::"SMS") OR ("Communication Type" = "Communication Type"::"E-Mail & SMS"));
                    field("SMS Message"; SMSTxt)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.CALCFIELDS("SMS Text");
                            rec."SMS Text".CREATEINSTREAM(SMSInStrm);
                            SMSBigTxt.READ(SMSInStrm);
                            IF SMSTxt <> FORMAT(SMSBigTxt) THEN BEGIN
                                CLEAR(Rec."SMS Text");
                                CLEAR(SMSBigTxt);
                                SMSBigTxt.ADDTEXT(SMSTxt);
                                rec."SMS Text".CREATEOUTSTREAM(SMSOutStrm);
                                SMSBigTxt.WRITE(SMSOutStrm);
                            END;
                        end;
                    }
                }
                // field(Attachment; Attachment)
                // {
                //     Editable = false;
                //     trigger OnAssistEdit()
                //     begin
                //         /*
                //         IF FileManagement.CanRunDotNetOnClient THEN
                //             Attachment := FileManagement.OpenFileDialog('Choose File:', '', 'All files (*.*)|*.*')
                //         ELSE
                //             Attachment := FileManagement.UploadFile('Choose file:', Attachment);
                //         */
                //     end;
                // }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send Email")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditMgt.SendRiskCommunication(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("E-Mail Body");
        rec."E-Mail Body".CREATEINSTREAM(InStrm);
        EmailBigTxt.READ(InStrm);
        EmailTxt := FORMAT(EmailBigTxt);
        Rec.CALCFIELDS("SMS Text");
        rec."SMS Text".CREATEINSTREAM(SMSInStrm);
        SMSBigTxt.READ(SMSInStrm);
        SMSTxt := FORMAT(SMSBigTxt);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Audit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Audit;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Sent THEN CurrPage.EDITABLE(FALSE);
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
        SMSTxt: Text;
        MessageTxt: Text;
        ClearNotification: Notification;
        SMSInStrm: InStream;
        SMSOutStrm: OutStream;
        HRMgt: Codeunit "HR Management";
        FileManagement: Codeunit "File Management";
        FileName: Text[250];
        AuditMgt: Codeunit "Internal Audit Management";
}

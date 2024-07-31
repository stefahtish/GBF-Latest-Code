page 50885 "Client Email/SMS Header Card"
{
    Caption = 'Client Communication';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Generate,Send,Clear';
    SourceTable = "Email/SMS Logging Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'General';
                Editable = NOT Complete;

                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Communication Type"; Rec."Communication Type")
                {
                    trigger OnValidate()
                    begin
                        IsCommunicationTypeEditable(Rec."Communication Type");
                    end;
                }
                group(Control26)
                {
                    ShowCaption = false;
                    Visible = NOT CommunicationTypeSMSEditable;

                    field("Document Email Type"; Rec."Document Email Type")
                    {
                    }
                }
                field(Status; Rec.Status)
                {
                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
                group(Control28)
                {
                    ShowCaption = false;
                    Visible = Rec."Communication Type" <> Rec."Communication Type"::"SMS";

                    field("HTML Formatted"; Rec."HTML Formatted")
                    {
                    }
                    field("E-Mail Body"; EmailTxt)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.CalcFields("E-Mail Body Text");
                            rec."E-Mail Body Text".CreateInStream(InStrm);
                            EmailBigTxt.Read(InStrm);
                            if EmailTxt <> Format(EmailBigTxt) then begin
                                Clear(Rec."E-Mail Body Text");
                                Clear(EmailBigTxt);
                                EmailBigTxt.AddText(EmailTxt);
                                rec."E-Mail Body Text".CreateOutStream(OutStrm);
                                EmailBigTxt.Write(OutStrm);
                                if Rec."Communication Type" = Rec."Communication Type"::SMS then begin
                                    Clear(EmailTxt);
                                    ClearBodyFields(Rec."Communication Type", Format(Rec.FieldCaption("E-Mail Body Text")));
                                end;
                            end;
                        end;
                    }
                }
                group(Control25)
                {
                    ShowCaption = false;
                    Visible = Rec."Communication Type" = Rec."Communication Type"::"SMS";

                    field("SMS Message"; SMSTxt)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.CalcFields("SMS Body Text");
                            rec."SMS Body Text".CreateInStream(InStrm);
                            SMSBigTxt.Read(InStrm);
                            if SMSTxt <> Format(SMSBigTxt) then begin
                                Clear(Rec."SMS Body Text");
                                Clear(SMSBigTxt);
                                SMSBigTxt.AddText(SMSTxt);
                                rec."SMS Body Text".CreateOutStream(OutStrm);
                                SMSBigTxt.Write(OutStrm);
                                if (Rec."Communication Type" = Rec."Communication Type"::"E-Mail") then Clear(SMSTxt);
                                ClearBodyFields(Rec."Communication Type", Format(Rec.FieldCaption("SMS Body Text")));
                            end;
                        end;
                    }
                }
                field("Total Items"; Rec."Total Items")
                {
                }
                field("Total Sent"; Rec."Total Sent")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
            }
            part(Control12; "Client Email/SMS Logging Lines")
            {
                Editable = NOT Complete;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control15; "SMS Logging Lines Listpart")
            {
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Action24)
            {
                action("Email/SMS Account Notifications")
                {
                    Caption = 'Email/SMS Account Notifications';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // CLEAR(EmailDispatcher2);
                        // CLEAR(NotificationType);
                        // IF CONFIRM(Text000,FALSE) THEN BEGIN
                        // Selection:=STRMENU(Text001,1);
                        // CASE TRUE OF
                        // Selection=1:
                        //  NotificationType[1]:=TRUE;
                        // Selection=2:
                        //  NotificationType[2]:=TRUE;
                        // END;
                        //
                        // EmailDispatcher2.GetNo(Rec,NotificationType);
                        //
                        // EmailDispatcher2.RUN;
                        //
                        // Status:=Status::Complete;
                        // MODIFY;
                        // END;
                    end;
                }
                separator(Action20)
                {
                }
                action("Send SMS Message")
                {
                    Caption = 'Send SMS Message';
                    Enabled = Rec."Communication Type" = Rec."Communication Type"::SMS;
                    Image = SendToMultiple;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
            }
            group("Generate E-Mail & SMS Users")
            {
                Caption = 'Generate E-Mail & SMS Users';
                Image = ChangeCustomer;
                ToolTip = 'Generates the Users to be sent the form of communication';

                action(GenerateUsers)
                {
                    Caption = 'Generate Receipients';
                    Image = CoupledUsers;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm(Text006, false, Rec."No.") then begin
                            CommunicationMgt.ClearLines(Rec);
                            Commit;
                            CommunicationMgt.GenerateCommUsers(Rec);
                        end;
                    end;
                }
                action("Send E-mail")
                {
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then CommunicationMgt.SendCorporateEmails(Rec."No.");
                    end;
                }
                action(ClearLines)
                {
                    Caption = 'Clear Lines';
                    Image = DeleteQtyToHandle;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then CommunicationMgt.ClearLines(Rec);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("E-Mail Body Text");
        rec."E-Mail Body Text".CreateInStream(InStrm);
        EmailBigTxt.Read(InStrm);
        EmailTxt := Format(EmailBigTxt);
        Rec.CalcFields("SMS Body Text");
        rec."SMS Body Text".CreateInStream(InStrm);
        SMSBigTxt.Read(InStrm);
        SMSTxt := Format(SMSBigTxt);
        SetPageView;
    end;

    trigger OnOpenPage()
    begin
        // CALCFIELDS("E-Mail Body Text");
        // "E-Mail Body Text".CREATEINSTREAM(InStrm);
        // EmailBigTxt.READ(InStrm);
        // EmailTxt:=FORMAT(EmailBigTxt);
        //
        // CALCFIELDS("SMS Body Text");
        // "SMS Body Text".CREATEINSTREAM(InStrm);
        // SMSBigTxt.READ(InStrm);
        // SMSTxt:=FORMAT(SMSBigTxt);
        IsCommunicationTypeEditable(Rec."Communication Type");
        SetPageView;
    end;

    var
        NotificationType: array[2] of Boolean;
        CommunicationTypeSMSEditable: Boolean;
        CommunicationTypeEmailEditable: Boolean;
        CommunicationTypeEmail_SMSEditable: Boolean;
        Complete: Boolean;
        Selection: Integer;
        Text000: Label 'You are about to generate client notifications for the selected period of the selected member(s) / Do you want to Proceed?';
        Text001: Label 'Email Client Notifications,&SMS Client Notifications';
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
        SMSTxt: Text;
        Text002: Label 'Please do not fill this when the Communication Status is ::%1';
        MessageTxt: Text;
        ClearNotification: Notification;
        Text003: Label 'The %1 field has been cleared since the Communication Type is %2.';
        Text004: Label 'Generate SMS User line for who?';
        Text005: Label 'Customer,Vendor,Students';
        Text006: Label 'Generate %1 User Lines. Would you like to proceed? ';
        CommunicationMgt: Codeunit "Communication Mgt";

    local procedure ClearBodyFields(CommunicationType: Option "E-Mail",SMS,"E-Mail & SMS"; "Field": Text)
    begin
        MessageTxt := StrSubstNo(Text003, Format(Field), Format(Rec."Communication Type"));
        ClearNotification.Message := MessageTxt;
        ClearNotification.Send;
    end;

    local procedure IsCommunicationTypeEditable(CommunType: Option "E-Mail",SMS,"E-Mail & SMS")
    begin
        case CommunType of
            CommunType::"E-Mail":
                begin
                    CommunicationTypeEmailEditable := true;
                    CommunicationTypeEmail_SMSEditable := false;
                    CommunicationTypeSMSEditable := false;
                end;
            CommunType::"E-Mail & SMS":
                begin
                    CommunicationTypeEmailEditable := false;
                    CommunicationTypeEmail_SMSEditable := false;
                    CommunicationTypeSMSEditable := false;
                end;
            CommunType::SMS:
                begin
                    CommunicationTypeEmailEditable := false;
                    CommunicationTypeEmail_SMSEditable := false;
                    CommunicationTypeSMSEditable := true;
                end;
        end;
    end;

    local procedure SetPageView()
    begin
        if Rec.Status = Rec.Status::Complete then
            Complete := true
        else
            Complete := false;
    end;
}

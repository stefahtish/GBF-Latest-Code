page 50712 "ICT Escalation card"
{
    Caption = 'ICT Escalation card';
    PageType = Card;
    SourceTable = "User Support Incident";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field("Escalation Option"; EscalationOption)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Clear(Rec."New Escalator No.");
                        Clear(Rec."Escalation User ID");
                        Clear(EscalatorName);
                        Clear(EscalationEmail);
                        SetControlAppearance
                    end;
                }
                group(Internal)
                {
                    ShowCaption = false;
                    Visible = InternalEsc;

                    field("Escalator No."; Rec."New Escalator No.")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        var
                            Emp: Record Employee;
                            usersetup: Record "User Setup";
                        begin
                            Emp.SetRange("No.", Rec."New Escalator No.");
                            if Emp.FindFirst() then begin
                                EscalatorName := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                                EscalationEmail := Emp."Company E-Mail";
                                usersetup.SetRange("Employee No.", Emp."No.");
                                if usersetup.FindFirst() then EscalatorUserID := usersetup."User ID";
                            end;
                        end;
                    }
                    field("Escalator User ID"; "EscalatorUserID")
                    {
                        Enabled = false;
                        ApplicationArea = All;
                    }
                }
                group(External)
                {
                    ShowCaption = false;
                    Enabled = ExtEsc;

                    field("Escalator Name"; EscalatorName)
                    {
                        Caption = 'Name';
                        ApplicationArea = All;
                    }
                    field("Escalation Email"; "EscalationEmail")
                    {
                        Caption = 'Email';
                        ApplicationArea = All;
                    }
                }
                field("Email Message"; EmailTxt)
                {
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("E-Mail Body");
                        REC."E-Mail Body".CREATEINSTREAM(InStrm);
                        EmailBigTxt.READ(InStrm);
                        IF EmailTxt <> FORMAT(EmailBigTxt) THEN BEGIN
                            CLEAR(Rec."E-Mail Body");
                            CLEAR(EmailBigTxt);
                            EmailBigTxt.ADDTEXT(EmailTxt);
                            REC."E-Mail Body".CREATEOUTSTREAM(OutStrm);
                            EmailBigTxt.WRITE(OutStrm);
                        END;
                    end;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Attachments")
            {
                Visible = ExtEsc;

                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        //  FromFile := DocumentManagement.UploadDocument(Rec."Incident Reference", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("E-Mail Body");
        REC."E-Mail Body".CREATEINSTREAM(InStrm);
        EmailBigTxt.READ(InStrm);
        EmailTxt := FORMAT(EmailBigTxt);
    end;

    var
        EscalationOption: Option "",Internal,External;
        EscalatorName: code[100];
        EscalatorUserID: Code[100];
        EscalationEmail: Text[100];
        InternalEsc: Boolean;
        ExtEsc: Boolean;
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
        // [RunOnClient]
        //DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    procedure SetControlAppearance()
    begin
        if EscalationOption = EscalationOption::Internal then
            InternalEsc := true
        else
            InternalEsc := false;
        if EscalationOption = EscalationOption::External then
            ExtEsc := true
        else
            ExtEsc := false;
    end;

    procedure GetNewDetails(var EscOption: Option; var EscNo: Code[20]; var EscName: Code[100]; var EscEmail: Text[100])
    begin
        EscOption := EscalationOption;
        EscNo := Rec."New Escalator No.";
        EscName := EscalatorName;
        EscEmail := EscalationEmail;
    end;
}

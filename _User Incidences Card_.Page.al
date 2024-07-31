page 50559 "User Incidences Card"
{
    Caption = 'ICT HelpDesk';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "User Support Incident";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Incident Logging")
            {
                Caption = 'Issue Logging';

                field("Incident Reference"; Rec."Incident Reference")
                {
                    Enabled = false;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Enabled = false;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    Enabled = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                }
                field("User email Address"; Rec."User email Address")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Enabled = false;
                }
                field(Category; Rec.Category2)
                {
                    caption = 'Category';
                }
                field(Issue; Rec.Issue)
                {
                }
                field(Priority; Rec.Priority)
                {
                    //enabled = false;
                }
                field("Category Description"; Rec."Category Description")
                {
                    Enabled = false;
                }
                field(Sent; Rec.Sent)
                {
                    Enabled = false;
                    Visible = false;
                }
                field(Stage; Rec.Status)
                {
                    Enabled = false;
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Enabled = false;
                    Visible = false;
                }
                field(User; Rec.User)
                {
                    Visible = false;
                }
                field(Asset; Rec.Asset)
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                group(AssetDetails)
                {
                    ShowCaption = false;
                    Visible = Rec.Asset;

                    field("Asset No."; Rec."Asset No.")
                    {
                    }
                    field("Asset Description"; Rec."Asset Description")
                    {
                        Enabled = false;
                    }
                    field("Serial Number"; Rec."Serial Number")
                    {
                        Enabled = false;
                    }
                    field("Tag Number"; Rec."Tag Number")
                    {
                        Enabled = false;
                    }
                }
            }
            group("Incident attachment")
            {
                Caption = 'Attachment';
                Enabled = Rec."Status" = Rec."Status"::Open;

                field("Incident Description"; Rec."Incident Description")
                {
                    Caption = 'Support Service Request';
                    MultiLine = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //FileName:=FileMgnt.UploadFile("Incident Reference",jpg);
                    end;
                }
                field("Screen Shot"; Rec."Screen Shot")
                {
                }
            }
            group(Escalations)
            {
                Visible = Rec.sent;

                field("Escalation option"; Rec."Escalation option")
                {
                }
                field("Escalate To Name"; Rec."Escalate To Name")
                {
                }
                field("Escalation email Address"; Rec."Escalation email Address")
                {
                }
            }
            group(Resolution)
            {
                Visible = Rec.sent;

                field("User Remarks"; Rec."User Remarks")
                {
                }
            }
            group("Asset Resolution")
            {
                Visible = Rec.sent;

                field("Service Provider"; Rec."Service Provider")
                {
                }
                field("Service provider Name"; Rec."Service provider Name")
                {
                }
                field("Service provided"; Rec."Service provided")
                {
                }
            }
            group(Feedback)
            {
                visible = Rec.sent;

                field("Feedback on Completion"; Rec."Feedback on Completion")
                {
                }
            }
            // part("User Incidences Assets"; "User Incidences Assets")
            // {
            //     Caption = 'Assets';
            //     SubPageLink = "Employee No." = field("Employee No"), "Incident Ref" = field("Incident Reference");
            // }
        }
        area(FactBoxes)
        {
            systempart(links; Links)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Report Incident")
            {
                Caption = 'Report issue';
                Enabled = NOT Rec.Sent;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Open;

                trigger OnAction()
                var
                    BodyPart: Text[1024];
                begin
                    if not ICTSetup.Get then Error(Err0001);
                    if Rec.Sent = true then Error(Err0002);
                    ICTSetup.TestField("Screenshot Path");
                    if Confirm('Do you want to send this Incident?') then begin
                        Rec.CalcFields("Screen Shot");
                        if rec."Screen Shot".HasValue then begin
                            // eddie rec."Screen Shot".CreateInStream(InStr);
                            // FileRec.Create(ICTSetup."Screenshot Path" + Rec."Incident Reference" + '.jpg');
                            // FileRec.CreateOutStream(OutStr);
                            // CopyStream(OutStr, InStr);
                            // FileRec.Close;
                        end;
                        //Send Incident
                        ClaimAssignment.SendIncident(Rec."Incident Reference");
                        //
                        Rec.Sent := true;
                        Rec.Status := Rec.Status::Pending;
                        Rec.Modify;
                        Message('The Incident %1 has been sent successfully', Rec."Incident Reference");
                        CurrPage.Close;
                    end
                    else
                        exit;
                end;
            }
            action("Resolve Incident")
            {
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Sent;

                trigger OnAction()
                begin
                    if Rec."User Remarks" = '' then Error('Please enter your remarks');
                    Rec."Incident Status" := Rec."Incident Status"::Resolved;
                    Rec.Modify(true);
                    Message('The Incident has been resolved successfully');
                    CurrPage.Close;
                end;
            }
            action("Close Incident")
            {
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Incident Status" = Rec."Incident Status"::Resolved;

                trigger OnAction()
                begin
                    Rec."Action Date" := Today;
                    Rec."Action Time" := time;
                    Rec.Status := Rec.Status::Closed;
                    Message('The Incident has been closed successfully');
                    CurrPage.Close;
                end;
            }
            action("Escalate Incident")
            {
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.sent;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Incident);
                    Clear(EscalationCard);
                    EscalationCard.SetTableView(Incident);
                    // EscalationCard.LookupMode(true);                    
                    IF EscalationCard.RUNMODAL = ACTION::OK THEN BEGIN
                        EscalationCard.GetNewDetails(EscOption, EscNo, EscName, EscEmail);
                        if EscEmail = '' then Error('Escalation email must be entered');
                        ClaimAssignment.EscalateIncident(Rec."Incident Reference", EscOption, EscNo, EscName, EscEmail);
                    end;
                end;
            }
            action("Notify Escalated User")
            {
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.sent;

                trigger OnAction()
                begin
                    ClaimAssignment.NotifyEscalatedIncident(Rec."Incident Reference");
                end;
            }
            action("Escalation Log")
            {
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                visible = Rec.sent;
                RunObject = page "Helpdesk Escalation Log";
                RunPageLink = "No." = field("Incident Reference");
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if ApprovalsMgmt.CheckUserIncidencesWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendUserIncidencesForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        ApprovalsMgmt.OnCancelUserIncidencesApprovalRequest(Rec);
                        CurrPage.Close;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", Database::"User Support Incident");
                        ApprovalEntry.SetRange("Document No.", Rec."Incident Reference");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::ICT;
        Rec.User := UserId;
        Users.Get(UserId);
        Rec."User email Address" := Users."E-Mail";
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE(User,USERID);
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        SMTP: Codeunit "Email Message";
        compinfo: Record "Company Information";
        Users: Record "User Setup";
        Employee: Record Employee;
        emp2: Record Employee;
        Body: Text[250];
        RSetup: Record "Resources Setup";
        Err0001: Label 'Resources setup doesn''t exist';
        Err0002: Label 'The incidence has already been sent!';
        Text001: Label 'Are you sure you want to close this incident?';
        Text002: Label 'You want to resend the incident?';
        Text003: Label '\Attachment.%1';
        InStr: InStream;
        Fullname: Text[1024];
        FileRec: File;
        OutStr: OutStream;
        ICTSetup: Record "ICT Setup";
        Err0003: Label 'The issues has not been reolved.';
        jpg: Label '.jpg';
        FileMgnt: Codeunit "File Management";
        FileName: Text;
        Attachment: Text;
        Incident: Record "User Support Incident";
        SenderName: Text[250];
        SenderAddress: Text[250];
        Receipient: list of [text];
        Subject: Text[250];
        TimeNow: Text;
        ReceipientCC: List of [text];
        ReceipientBCC: list of [text];
        UserSetup: Record "User Setup";
        CCRecipients: Integer;
        BCCRecipients: Integer;
        EscalationCard: page "ICT Escalation card";
        EscNo: code[20];
        EscOption: Option "",Internal,External;
        EscName: code[100];
        EscUserID: Code[100];
        EscEmail: Text[100];
        ClaimAssignment: codeunit "Claim Assignment";
}

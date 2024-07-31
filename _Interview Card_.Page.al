page 50471 "Interview Card"
{
    PageType = Card;
    SourceTable = "Applicant job applied";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Interviewed" = FALSE;

                field("Application No."; Rec."Application No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field';
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the First Name field';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Middle Name field';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Name field';
                    ApplicationArea = All;
                }
                field(Job; Rec.Job)
                {
                    caption = 'Job Applied For';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Applied For field';
                    ApplicationArea = All;
                }
                field(Interviewed; Rec.Interviewed)
                {
                    ToolTip = 'Specifies the value of the Interviewed field';
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Qualified field';
                    ApplicationArea = All;
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    ToolTip = 'Specifies the value of the Expected Reporting Date field';
                    ApplicationArea = All;
                }
                field(Oral; Rec.Oral)
                {
                    ToolTip = 'Specifies the value of the Oral field';
                    ApplicationArea = All;
                }
                field(Practical; Rec.Practical)
                {
                    ToolTip = 'Specifies the value of the Practical field';
                    ApplicationArea = All;
                }
                field(Classroom; Rec.Classroom)
                {
                    caption = 'Aptitude';
                    ToolTip = 'Specifies the value of the Aptitude field';
                    ApplicationArea = All;
                }
                group(Scores)
                {
                    ShowCaption = false;

                    label("Interview Scores")
                    {
                        Caption = 'Interview Scores';
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("Practical Score"; Rec."Practical Score")
                    {
                        ToolTip = 'Specifies the value of the Practical Score field';
                        ApplicationArea = All;
                    }
                    field("Classroom Score"; Rec."Classroom Score")
                    {
                        caption = 'Aptitude Score';
                        ToolTip = 'Specifies the value of the Aptitude Score field';
                        ApplicationArea = All;
                    }
                    field("Oral Score"; Rec."Oral Score")
                    {
                        ToolTip = 'Specifies the value of the Oral Score field';
                        ApplicationArea = All;
                    }
                    field("Oral (Board) Score"; Rec."Oral (Board) Score")
                    {
                        ToolTip = 'Specifies the value of the Oral (Board) Score field';
                        ApplicationArea = All;
                    }
                }
            }
            label(Academic)
            {
                Style = Strong;
                StyleExpr = TRUE;
                Visible = false;
            }
            part(Control16; "Interview Form")
            {
                Editable = Rec."Interviewed" = FALSE;
                SubPageLink = "Applicant No" = FIELD("Application No.");
                ApplicationArea = All;
            }
            label(Administration)
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(Control25; "Oral Interview")
            {
                SubPageLink = "Applicant No" = FIELD("No.");
                Visible = Rec."Oral" = TRUE;
                ApplicationArea = All;
            }
            part(Control26; "Oral Interview (Board)")
            {
                SubPageLink = "Applicant No" = FIELD("No.");
                Visible = Rec."Oral (Board)" = TRUE;
                ApplicationArea = All;
            }
            part(Control27; "Practical Interview")
            {
                SubPageLink = "Applicant No" = FIELD("No.");
                Visible = Rec."Practical" = TRUE;
                ApplicationArea = All;
            }
            part(Control33; "Classroom Interview")
            {
                Caption = 'Aptitude test';
                SubPageLink = "Applicant No" = FIELD("No.");
                Visible = Rec."Classroom" = TRUE;
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    begin
                        //   FromFile := DocumentManagement.UploadDocument("No.", CurrPage.Caption, RecordId);
                    end;
                }
            }
            action("Complete Interview")
            {
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Complete Interview action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to complete this Interview?', true) = false then begin
                        exit
                    end
                    else begin
                        Rec.Interviewed := true;
                        Rec.Modify()
                    end;
                    /*
                        ShortCriteria.RESET;
                        ShortCriteria.SETRANGE("Recruitment Need","Need Code");
                        IF ShortCriteria.FIND('-') THEN
                          BEGIN
                            IF "Interview Score">=ShortCriteria."Desired Interview Score" THEN
                              BEGIN
                                Qualified:=TRUE;
                                MODIFY;
                              END ELSE
                                Qualified:=FALSE;
                                MODIFY;
                          END;
                        */
                    // if ShortCriteria.Get("Need Code") then begin
                    // end;
                end;
            }
            action("Create Employee")
            {
                Enabled = Rec.Interviewed;
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create Employee action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to create this employee?', true) = false then begin
                        exit
                    end
                    else begin
                        HrMgmt.CreateEmployee(Rec."Application No.");
                    end;
                end;
            }
            action("Notify User on Success")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
                //  ToolTip = 'Executes the Offer Letter action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    DateFromatted := (Format(Rec."Interview Date", 0, 4));
                    InterviewInvitation(Rec."Application No.", DateFromatted);
                    // Message('Candidate %1 notified on success', Rec."First Name");
                    /*
                        Applicants.RESET;
                        Applicants.SETRANGE("No.","No.");
                        REPORT.RUN(51519304,TRUE,FALSE,Applicants);
                        */
                end;
            }
        }
    }
    var
        ShortCriteria: Record "R.Shortlisting Header";
        Applicants: Record Applicants2;
        DateFromatted: Text;
        HrMgmt: Codeunit "HR Management";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    procedure InterviewInvitation(ApplicantNo: Code[50]; InterviewDate: Text)
    var
        Applicants: Record Applicants2;
        CompanyInfo: Record "Company Information";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        Attachment: Text;
        ErrorMsg: Text;
        NewBody: Label 'Dear %1, <br><br>We refer to the interview which was held on <Strong>%2</Strong> at %3, you are a successful candidate. Kindly pick your offer letter from the Human Resource Office<br> <br> <br>Kind Regards <br><br>%4.';
    begin
        Applicants.Reset;
        Applicants.SetRange("No.", ApplicantNo);
        if Applicants.Find('-') then begin
            CompanyInfo.Get;
            CompanyInfo.TestField(Name);
            CompanyInfo.TestField("E-Mail");
            SenderName := CompanyInfo.Name;
            SenderAddress := CompanyInfo."E-Mail";
            Receipient.Add(Applicants."E-Mail");
            Subject := 'Job Offer Letter';
            TimeNow := (Format(Time));
            EmailMessage.Create(Receipient, Subject, StrSubstNo(NewBody, Applicants."First Name", CompanyInfo.Name, InterviewDate, CompanyInfo.Name), true);
            Email.send(EmailMessage, enum::"Email Scenario"::Default);
            /* if RecipientCC <> '' then
                SMTP.AddCC(RecipientCC); */
            // SMTP.Send;
            Applicants.Employ := true;
            Applicants.Modify();
            Message('Candidate %1 notified on success', Rec."First Name");
        end;
    end;
}

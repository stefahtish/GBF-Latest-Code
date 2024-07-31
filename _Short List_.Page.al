page 50468 "Short List"
{
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Recruitment Needs";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Positions; Rec.Positions)
                {
                    ToolTip = 'Specifies the value of the Positions field';
                    ApplicationArea = All;
                }
                field("Shortlisting Closed"; Rec."Shortlisting Closed")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortlisting Closed field';
                    ApplicationArea = All;
                }
            }
            group(Details)
            {
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field of Study field';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Education Level field';
                }
                field("Education Type"; Rec."Education Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Education Type field';
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proficiency Level field';
                }
                field("Experience industry"; Rec."Experience industry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Experience industry field';
                }
                field("Minimum years of experience"; Rec."Minimum years of experience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum years of experience field';
                }
                field("Maximum years of experience"; Rec."Maximum years of experience")
                {
                    Caption = 'Years of experience in senior level';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Years of experience in senior level field';
                }
                field("Professional Course"; Rec."Professional Course")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Professional Course field';
                }
                field("Professional Membership"; Rec."Professional Membership")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Professional Membership field';
                }
                field("County Code"; Rec."County Code")
                {
                    ToolTip = 'Specifies the value of the County Code field';
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the County field';
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                    ApplicationArea = All;
                }
            }
            group(Interview)
            {
                field("Total Written Score"; Rec."Total Written Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Written Score field';
                }
                field("Total Practical Score"; Rec."Total Practical Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Practical Score field';
                }
                field("Total Oral Score"; Rec."Total Oral Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Oral Score field';
                }
            }
            part("Qualified Applied Applicants"; "Applied Applicants")
            {
                SubPageLink = "Need Code" = FIELD("No."), Qualified = const(true);
                ApplicationArea = All;
                Caption = 'Shortlisted Applicants';
                // UpdatePropagation = Both;
            }
            part("Unqualified Applied Applicants"; "Applied Applicants2")
            {
                SubPageLink = "Need Code" = FIELD("No."), Qualified = const(false);
                Caption = 'All Applicants';
                ApplicationArea = All;
                // UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Short List")
            {
                Caption = 'Short List';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Short List action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    HRNotify.ShortlistApplicants(Rec."No.");
                    CurrPage.Update;
                end;
            }
            action("Mail Qualified Applicants")
            {
                Caption = 'Mail Qualified Applicants';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Mail Qualified Applicants action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm(Text0001, true) = false then begin
                        exit
                    end;
                    MailQualified(Rec);
                    MailUnqualified(Rec);
                    Message(Text0002);
                    Message(Text0003, Rec."No.", Rec.Description);
                    Rec."Shortlisting Closed" := true;
                    CurrPage.Close;
                end;
            }
            action(Reports)
            {
                ToolTip = 'Executes the Reports action';
                ApplicationArea = All;

                trigger OnAction()
                var
                    JobsApplied: Record "Applicant job applied";
                    RecruitmentReport: report "Recruitment Report";
                begin
                    JobsApplied.Reset();
                    JobsApplied.SetRange("Need Code", Rec."No.");
                    RecruitmentReport.SetTableView(JobsApplied);
                    RecruitmentReport.Run();
                end;
            }
            action(ShReport)
            {
                ApplicationArea = All;
                Caption = 'Shortlisted Applicants';

                trigger OnAction()
                var
                    ShortlistedReport: Report "Shortlisting Report";
                    RecruitmentNeeds: Record "Recruitment Needs";
                begin
                    RecruitmentNeeds.Reset();
                    RecruitmentNeeds.SetRange("No.", Rec."No.");
                    ShortlistedReport.SetTableView(RecruitmentNeeds);
                    ShortlistedReport.Run();
                end;
            }
            action("Interview Results")
            {
                ToolTip = 'Executes the Interview Results action';
                ApplicationArea = All;
            }
            action(Reopen)
            {
                ToolTip = 'Executes the Reopen action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec."Shortlisting Closed" := false;
                end;
            }
        }
    }
    var
        StageShortList: Record "Stage Shortlist";
        Applications: Record Applicants2;
        JobReq: Record "Job Requirements";
        ApplicantQual: Record "Applicants Qualification";
        ApplicantsRec: Record Applicants2;
        Criteria: Record "R.Shortlisting Header";
        RecruitmentNeeds: Record "Recruitment Needs";
        HRNotify: Codeunit "HR Management";
        Recruitment: Record "Recruitment Needs";
        Counter: Integer;
        Text0001: Label 'Do you want to E-mail Applicants?';
        Text0002: Label 'Applicants invited for the Interview Successfully.';
        Text0003: Label 'Shortlisting %1 for Job %2 Closed';
        Academic: Boolean;
        Experience: Boolean;
        AcademicAndExp: Boolean;
        AcademicOrExp: Boolean;
        PQualification: Boolean;
        PMembership: Boolean;
        FieldOfStudyFilter: Text;

    local procedure MailQualified(RecNeeds: Record "Recruitment Needs")
    var
        Applicants: Record Applicants2;
        JobsApplied: Record "Applicant job applied";
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
        CompanyInfo: Record "Company Information";
        Body: text;
        NewBody: Label 'Dear %1, <br>This is to invite you for an Inteview for the job Position of <Strong>%2</Strong>.The Interview will be conducted at our office on %3, at %4.<br><br>Kind Regards, <br><br><Strong>%5 </Strong>.  ';
    begin
        JobsApplied.Reset();
        JobsApplied.SetRange("Need Code", RecNeeds."No.");
        JobsApplied.SetRange(Qualified, true);
        if JobsApplied.Find('-') then begin
            repeat
                Applicants.Reset;
                Applicants.SetRange("No.", JobsApplied."Application No.");
                if Applicants.Find('-') then;
                begin
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("E-Mail");
                    SenderName := CompanyInfo.Name;
                    SenderAddress := CompanyInfo."E-Mail";
                    Receipient.Add(Applicants."E-Mail");
                    //MESSAGE(Receipient);
                    Subject := 'Interview Invite';
                    TimeNow := (Format(Time));
                    EmailMessage.Create(Receipient, Subject, StrSubstNo(NewBody, Applicants."First Name", Applicants."Job Description", JobsApplied."Interview Date", JobsApplied."Interview Time", CompanyInfo.Name), true);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                end;
            until JobsApplied.Next = 0;
        end;
    end;

    local procedure MailUnqualified(RecNeeds: Record "Recruitment Needs")
    var
        Applicants: Record Applicants2;
        JobsApplied: Record "Applicant job applied";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        // SMTP: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        CompanyInfo: Record "Company Information";
        Emp: Record Employee;
        SenderFirstName: code[100];
        UserSetup: Record "User Setup";
        NewBody: Label 'Dear %1, <br>We trust you are well and keeping safe.<br> We would like to thank you for expressing your interest for the position of %2 at %3.<br>Unfortunately, we regret to inform you that your application was unsuccessful on this occasion.<br>We would like to thank you for the time invested during this process and encourage you to regularly view our website for any other opportunities.<br>Once again, we thank you for your cooperation throughout this process and wish you the very best in your future endeavors.<br><br>Kind Regards, <br><br>%4';
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.Find('-') then begin
            Emp.SetRange("No.", UserSetup."Employee No.");
            if Emp.FindFirst() then SenderFirstName := emp."First Name";
        end;
        JobsApplied.Reset();
        JobsApplied.SetRange("Need Code", RecNeeds."No.");
        JobsApplied.SetRange(Qualified, false);
        if JobsApplied.Find('-') then begin
            repeat
                Applicants.Reset;
                Applicants.SetRange("No.", JobsApplied."Application No.");
                if Applicants.Find('-') then;
                begin
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("E-Mail");
                    SenderName := CompanyInfo.Name;
                    SenderAddress := CompanyInfo."E-Mail";
                    Receipient.add(Applicants."E-Mail");
                    Subject := 'Job Application';
                    TimeNow := (Format(Time));
                    EmailMessage.Create(Receipient, Subject, StrSubstNo(NewBody, Applicants."First Name", Applicants."Job Description", CompanyInfo.Name), true);
                    Email.Send(EmailMessage, enum::"Email Scenario"::Default);
                    // SMTP.Send;
                end;
            until JobsApplied.Next = 0;
        end;
    end;
}

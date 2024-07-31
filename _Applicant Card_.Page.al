page 50465 "Applicant Card"
{
    PageType = Card;
    SourceTable = Applicants2;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                    ApplicationArea = All;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Applicant Type field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        EmployeeView();
                    end;
                }
                group(Employee)
                {
                    Visible = Employee;

                    field("Employee No"; Rec."Employee No")
                    {
                        ToolTip = 'Specifies the value of the Employee No field';
                        ApplicationArea = All;
                    }
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field';
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field';
                    ApplicationArea = All;
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
                field(Employ; Rec.Employ)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employ field';
                    ApplicationArea = All;
                }
                field("Applicant Status"; Rec."Applicant Status")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Applicant Status field';
                    ApplicationArea = All;
                }
                field(Applied; Rec.Applied)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Applied field';
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group(Personal)
                {
                    Caption = 'Personal';

                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field';
                        ApplicationArea = All;
                    }
                    field("Marital Status"; Rec."Marital Status")
                    {
                        ToolTip = 'Specifies the value of the Marital Status field';
                        ApplicationArea = All;
                    }
                    field("Ethnic Origin"; Rec."Ethnic Origin")
                    {
                        ToolTip = 'Specifies the value of the Ethnic Origin field';
                        ApplicationArea = All;
                    }
                    field(Disabled; Rec.Disabled)
                    {
                        ToolTip = 'Specifies the value of the Disabled field';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            DisabilityView;
                        end;
                    }
                    group(Control17)
                    {
                        ShowCaption = false;
                        Visible = Disabling;

                        field("Disabling Details"; Rec."Disabling Details")
                        {
                            ToolTip = 'Specifies the value of the Disabling Details field';
                            ApplicationArea = All;
                        }
                    }
                    field("Date Of Birth"; Rec."Date Of Birth")
                    {
                        ToolTip = 'Specifies the value of the Date Of Birth field';
                        ApplicationArea = All;
                    }
                    field(Age; Rec.Age)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Age field';
                        ApplicationArea = All;
                    }
                }
                group(Communication)
                {
                    Caption = 'Communication';

                    field("Cellular Phone Number"; Rec."Cellular Phone Number")
                    {
                        ToolTip = 'Specifies the value of the Cellular Phone Number field';
                        ApplicationArea = All;
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ToolTip = 'Specifies the value of the E-Mail field';
                        ApplicationArea = All;
                    }
                    field("Postal Address"; Rec."Postal Address")
                    {
                        ToolTip = 'Specifies the value of the Postal Address field';
                        ApplicationArea = All;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ToolTip = 'Specifies the value of the Post Code field';
                        ApplicationArea = All;
                    }
                    field("Residential Address"; Rec."Residential Address")
                    {
                        ToolTip = 'Specifies the value of the Residential Address field';
                        ApplicationArea = All;
                    }
                }
            }
            part(JobApplied; "Jobs Applied")
            {
                SubPageLink = "Application No." = field("No.");
                ApplicationArea = All;
            }
            part(Education; "Applicant Job Education")
            {
                SubPageLink = "Applicant No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(Experience; "Applicant Job Experience")
            {
                SubPageLink = "Applicant No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(ProfessionalCourses; "Applicant Job Prof Course")
            {
                SubPageLink = "Applicant No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(ProfessionalMembership; "Applicant Job Prof Membership")
            {
                SubPageLink = "Applicant No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(Attachments; "Job Attachments")
            {
                SubPageLink = "Job ID" = FIELD("No.");
                ApplicationArea = All;
            }
            part(Qualification; "Applicant Qualification")
            {
                Caption = 'Qualification';
                SubPageLink = No = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Referees; Referees)
            {
                SubPageLink = No = FIELD("No.");
                ApplicationArea = All;
            }
            part(Hobbies; "Applicant Hobbies")
            {
                Caption = 'Hobbies';
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            // systempart(Control53; Links)
            // {
            //     ApplicationArea = All;
            // }
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
            action(Submit)
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Submit action';
                ApplicationArea = All;
                Visible = Rec.Applied = false;

                trigger OnAction()
                begin
                    if Confirm('Do you want to submit your application?') = true then begin
                        Rec.TestField("E-Mail");
                        HRMgt.SubmitAplication(Rec."No.");
                        Rec.Applied := true;
                        Rec.Modify();
                        // "Applicant Status" := "Applicant Status"::Submitted;
                    end;
                    CurrPage.Close;
                end;
            }
            action("Qualify Applicant")
            {
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Caption = 'Qualify Applicant';

                trigger OnAction()
                var
                    ApplicantRec: Record "Applicant job applied";
                    JobApplied: Record "Applicant job applied";
                begin
                    if not Confirm('Are you sure you want to send this applicant for shortlisting?', false) then
                        exit
                    else begin
                        JobApplied.Reset();
                        JobApplied.SetRange("Application No.", Rec."No.");
                        if not JobApplied.FindFirst() then
                            Error('There are no details of this applications')
                        else
                            JobApplied.TestField("Application Date");
                        Rec.Processed := true;
                        Rec.Modify();
                        ApplicantRec.Reset();
                        ApplicantRec.SetRange("Application No.", Rec."No.");
                        if ApplicantRec.FindFirst() then begin
                            ApplicantRec.Qualified := true;
                            ApplicantRec.Modify();
                        end;
                    end;
                end;
            }
        }
    }
    trigger OnInit()
    begin
        Employee := false;
    end;

    trigger OnOpenPage()
    begin
        EmployeeView();
        DisabilityView;
    end;

    var
        Employee: Boolean;
        Visibility: Boolean;
        Disabling: Boolean;
        HRNotify: Codeunit "HR Management";
        Dates: Codeunit "Dates ManagementHR";
        StartDate: Date;
        CompanyInformation: Record "Company Information";
        HRMgt: Codeunit "HR Management";
        Academics: Record "Company Job Education";
        Experience: Record "Company Job Experience";
        AppAcademics: Record "Applicant Job Education2";
        AppExperience: Record "Applicant Job Experience2";
        FieldOfStudy: Code[50];
        Ind: Code[50];

    local procedure EmployeeView()
    begin
        if Rec."No." <> '' then begin
            if Rec."Applicant Type" <> Rec."Applicant Type"::Internal then begin
                Employee := false;
            end
            else
                Employee := true;
        end;
    end;

    local procedure EmployeeField()
    begin
        Rec."Employee No" := '';
    end;

    local procedure DisabilityView()
    begin
        if Rec.Disabled = Rec.Disabled::Yes then
            Disabling := true
        else
            Disabling := false;
    end;

    local procedure GetAge(StartDate: Date) AgeText: Text[200]
    var
        Dates: Codeunit "Dates ManagementHR";
    begin
        Rec.Age := '';
        if StartDate = 0D then begin
            StartDate := Today;
        end;
        Rec.Age := Dates.DetermineAge(Rec."Date Of Birth", Today);
    end;
}

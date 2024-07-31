page 51291 "Applicant job applied"
{
    Caption = 'Applicant job applied';
    PageType = Card;
    SourceTable = "Applicant job applied";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Application No."; Rec."Application No.")
                {
                    Caption = 'Applicant No.';
                    ApplicationArea = All;
                }
                field("Need Code"; Rec."Need Code")
                {
                    ApplicationArea = All;
                }
                field(Job; Rec.Job)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Minimum Salary"; Rec."Minimum Salary")
                {
                }
                field("Maximum Salary"; Rec."Maximum Salary")
                {
                }
                field(Resume; ResumeTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    visible = false;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Resume);
                        rec.Motivation.CREATEINSTREAM(Instr);
                        ResumeBigTxt.READ(Instr);
                        IF ResumeTxt <> FORMAT(ResumeBigTxt) THEN BEGIN
                            CLEAR(Rec.Resume);
                            ResumeBigTxt.ADDTEXT(ResumeTxt);
                            rec.Resume.CREATEOUTSTREAM(OutStr);
                            ResumeBigTxt.WRITE(OutStr);
                        END;
                    end;
                }
                field(Motivation; MotivationTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    visible = false;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Motivation);
                        rec.Motivation.CREATEINSTREAM(Instr);
                        MotivationBigTxt.READ(Instr);
                        IF MotivationTxt <> FORMAT(MotivationBigTxt) THEN BEGIN
                            CLEAR(Rec.Motivation);
                            MotivationBigTxt.ADDTEXT(MotivationTxt);
                            rec.Motivation.CREATEOUTSTREAM(OutStr);
                            MotivationBigTxt.WRITE(OutStr);
                        END;
                    end;
                }
            }
            part(Attachments; "Job Attachments")
            {
                Visible = false;
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
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

                trigger OnAction()
                begin
                    if Confirm('Do you want to submit your application?') = true then begin
                        HRMgt.SubmitAplication(Rec."No.");
                    end;
                    CurrPage.Close;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Resume, Motivation);
        rec.Resume.CREATEINSTREAM(Instr);
        ResumeBigTxt.READ(Instr);
        ResumeTxt := FORMAT(ResumeBigTxt);
        rec.Motivation.CREATEINSTREAM(Instr);
        MotivationBigTxt.READ(Instr);
        MotivationTxt := FORMAT(MotivationBigTxt)
    end;

    var
        CompanyInformation: Record "Company Information";
        HRMgt: Codeunit "HR Management";
        ResumeBigTxt: BigText;
        ResumeTxt: Text;
        Instr: InStream;
        OutStr: OutStream;
        MotivationBigTxt: BigText;
        MotivationTxt: Text;
}

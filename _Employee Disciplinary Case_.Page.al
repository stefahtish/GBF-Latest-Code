page 50404 "Employee Disciplinary Case"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Payroll';
    SourceTable = "Employee Discplinary";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Editable;

                field("Disciplinary Nos"; Rec."Disciplinary Nos")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                }
                field("Date of Join"; Rec."Date of Join")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Case Closed';
                    Editable = false;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    Editable = false;
                }
                field(Escalate; Rec.Escalate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Escalate field.';
                }
            }
            group("Committee Email")
            {
                Caption = 'Committee E-Mail Notification';
                Editable = Editable;
                Visible = Rec.Escalate = true;

                field("Committee No"; Rec."Committee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committee No field.';
                }
                field("Date Escalated"; Rec."Date Escalated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Escalated field.';
                }
                field("Select Email Type"; Rec."Select Email Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Select Email Type field.';
                }
                field("Committee Recipient Email"; Rec."Committee Recipient Email")
                {
                    Enabled = Rec."Select Email Type" = Rec."Select Email Type"::"Committee Email";
                }
                field(" Committee Recipient CC"; Rec."Committee Recipient CC")
                {
                    Enabled = Rec."Select Email Type" = Rec."Select Email Type"::"Committee Email";
                }
                field("Committee Recipient BCC"; Rec."Committee Recipient BCC")
                {
                    Enabled = Rec."Select Email Type" = Rec."Select Email Type"::"Committee Email";
                }
                field("Committee E-Mail Subject"; Rec."Committee E-Mail Subject")
                {
                }
                field("Committee E-Mail Body Text"; CommitteeEmailTxt)
                {
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Committee E-Mail Body Text");
                        rec."Committee E-Mail Body Text".CreateInStream(InStrm);
                        CommitteeEmailBigTxt.Read(InStrm);
                        if CommitteeEmailTxt <> Format(CommitteeEmailBigTxt) then begin
                            Clear(Rec."Committee E-Mail Body Text");
                            Clear(CommitteeEmailBigTxt);
                            CommitteeEmailBigTxt.AddText(CommitteeEmailTxt);
                            rec."Committee E-Mail Body Text".CreateOutStream(OutStrm);
                            CommitteeEmailBigTxt.Write(OutStrm);
                        end;
                    end;
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Email Sent field.';
                }
            }
            group(Email)
            {
                Caption = 'E-Mail Notification';
                Editable = Editable;

                field("Recipient Email"; Rec."Recipient Email")
                {
                    Caption = 'Staff Email';
                }
                field("Recipient CC"; Rec."Recipient CC")
                {
                }
                field("Recipient BCC"; Rec."Recipient BCC")
                {
                }
                field("E-Mail Subject"; Rec."E-Mail Subject")
                {
                }
                field("E-Mail Body Text"; EmailTxt)
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
                        end;
                    end;
                }
            }
            part("Committee Member Lines"; "Committee Member Lines")
            {
                Caption = 'Committee Members';
                Visible = Rec.Escalate = true;
                SubPageLink = "Batch No." = FIELD("Committee No");
                Enabled = false;
            }
            label("Disciplinary Cases")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(Control10; "Emp Disciplinary Cases")
            {
                Caption = 'Employee disciplinary case lines';
                Editable = Editable;
                SubPageLink = "Refference No" = FIELD("Disciplinary Nos"), "Employee No" = FIELD("Employee No");
            }
            part(Control12; "Other Incidents")
            {
                SubPageLink = "Request No" = FIELD("Employee No");
                SubPageView = WHERE("Student Programme Name" = CONST('Yes'));
                Visible = false;
            }
        }
        area(FactBoxes)
        {
            systempart(Control53; Links)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Notify & Escalate Case")
            {
                Enabled = NOT Rec.Posted;
                Visible = (Rec.Escalate = true) and (Rec."Email Sent" = False);
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Select Email Type");
                    if Confirm('Do you want to Escalate this case?', true) then begin
                        HRMgt.NotifyCommitteeDisciplinary(Rec);
                        Rec."Date Escalated" := Today;
                        Rec."Email Sent" := true;
                        Rec.Modify;
                    end;
                    CurrPage.Close;
                end;
            }
            action("Notify & Close Case")
            {
                Visible = NOT Rec.Posted;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to post this case?', true) then begin
                        HRMgt.NotifyStaffDisciplinary(Rec);
                        Rec.Posted := true;
                        Rec."Date Closed" := Today;
                        Rec.Modify;
                    end;
                    Commit;
                    CurrPage.Close;
                end;
            }
            action("Assign Deductions")
            {
                Caption = 'Assign Payroll Deduction';
                Enabled = NOT Rec.Posted;
                Image = SuggestCustomerBill;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure?', false) then exit;
                    AssignmentMatrixX.Reset;
                    AssignmentMatrixX.SetRange("Employee No", Rec."Employee No");
                    AssignmentMatrixX.SetRange(Type, AssignmentMatrixX.Type::Deduction);
                    AssignmentMatrixX.SetRange(Closed, false);
                    Deductions.SetTableView(AssignmentMatrixX);
                    Deductions.RunModal;
                end;
            }
            action(Notify)
            {
                Caption = 'Send E-mail Notification';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) then HRMgt.NotifyStaffDisciplinary(Rec);
                end;
            }
            group("Attachments")
            {
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
                        //    FromFile := DocumentManagement.UploadDocument(Rec."Disciplinary Nos", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action("Track perfomance")
            {
                Image = Track;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Appraisal: Record "Employee Appraisal";
                begin
                    Appraisal.SetRange("Employee No", Rec."Employee No");
                    if Appraisal.FindLast() then begin
                        PAGE.RUN(Page::"Appraisal Card-Completed", Appraisal);
                    end;
                end;
            }
        }
        // area(Creation)
        // {
        //     action(Training)
        //     {
        //         Caption = 'Create a Training need';
        //         Image = Card;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         // trigger OnAction()
        //         // begin
        //         //     TrainHeader.Init;
        //         //     HRSetup.Get();
        //         //     TrainHeader.Code := NoSeriesMgmt.GetNextNo(HRSetup."Training Needs Nos", TODAY, TRUE);
        //         //     TrainHeader.Insert;
        //         //     TrainHeader.Modify;
        //         //     PAGE.RUN(51519491, TrainHeader);
        //         //     51519495
        //         // end;
        //         trigger OnAction()
        //         var
        //             TrainingNeedRequest: Record "Training Needs Request";
        //         begin
        //             TrainingNeedRequest.SetRange("Source Document No", "Disciplinary Nos");
        //             if TrainingNeedRequest.FindFirst() then begin
        //                 PAGE.RUN(51519545, TrainingNeedRequest);
        //             end else begin
        //                 TrainingNeedRequest.Reset();
        //                 TrainingNeedRequest.Init;
        //                 TrainingNeedRequest.No := '';
        //                 TrainingNeedRequest."Employee No" := "Employee No";
        //                 TrainingNeedRequest.Validate("Employee No");
        //                 TrainingNeedRequest."Source Document No" := "Disciplinary Nos";
        //                 TrainingNeedRequest."Need Source" := TrainingNeedRequest."Need Source"::Disciplinary;
        //                 TrainingNeedRequest.Insert(true);
        //                 TrainingNeedRequest.SetRange("Source Document No", "Disciplinary Nos");
        //                 if FindFirst() then
        //                     PAGE.RUN(51519545, TrainingNeedRequest);
        //             end;
        //         end;
        //     }
        // }
    }
    trigger OnAfterGetRecord()
    begin
        SetEditable();
        //Staff Email Body
        Rec.CalcFields("E-Mail Body Text");
        rec."E-Mail Body Text".CreateInStream(InStrm);
        EmailBigTxt.Read(InStrm);
        EmailTxt := Format(EmailBigTxt);
        //Committee Email Body
        Rec.CalcFields("Committee E-Mail Body Text");
        rec."Committee E-Mail Body Text".CreateInStream(InStrm);
        CommitteeEmailBigTxt.Read(InStrm);
        CommitteeEmailTxt := Format(CommitteeEmailBigTxt);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetEditable();
    end;

    trigger OnOpenPage()
    begin
        SetEditable();
    end;

    var
        Editable: Boolean;
        HRMgt: Codeunit "HR Management";
        Deductions: Page Payments_Deductions;
        AssignmentMatrixX: Record "Assignment Matrix-X";
        TrainHeader: Record "Training Need";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        CommitteeEmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
        CommitteeEmailTxt: Text;
        SMSTxt: Text;
        TrainingHeader: Record "Training Need";
        Nosermng: Codeunit NoSeriesManagement;
        RecRef: RecordRef;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    local procedure SetEditable()
    begin
        if Rec.Posted = true then begin
            Editable := false
        end
        else
            Editable := true;
    end;
}

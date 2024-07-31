report 50483 "Open Committee Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './OpenCommitteReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Tender Committees"; "Tender Committees")
        {
            column(Appointment_No; "Appointment No")
            {
            }
            column(Tender_Quotation_No; "Tender/Quotation No")
            {
            }
            column(Appointment_letter_Ref_No_; "Appointment letter Ref No.")
            {
            }
            column(Committee_Name; "Committee Name")
            {
            }
            column(Submission_Date; "Submission Date")
            {
            }
            column(Submission_Time; "Submission Time")
            {
            }
            column(Title; Title)
            {
            }
            column(Logo; CompInfor.Picture)
            {
            }
            column(Company_Name; CompInfor.Name)
            {
            }
            column(ReportTitle; 'APPOINTMENT TO QUOTATION OPENING COMMITTEE')
            {
            }
            column(Paragraph1; Paragraph1)
            {
            }
            column(Paragraph2; Paragraph2)
            {
            }
            column(Paragraph3; Paragraph3)
            {
            }
            column(ApprovalName; ApprovalName)
            {
            }
            column(ApprovalTitle; ApprovalTitle)
            {
            }
            column(SubmissionDate; SubmissionDate)
            {
            }
            dataitem("Commitee Member"; "Commitee Member")
            {
                DataItemLink = "Appointment No" = field("Appointment No");

                column(Employee_No; "Employee No")
                {
                }
                column(Name; Name)
                {
                }
                column(Role; UpperCase(format(Role)))
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Clear(SubmissionDate);
                Clear(ApprovalName);
                Clear(ApprovalTitle);
                Paragraph1 := 'Pursuant to section 78 of the Public Procurement & Asset Disposal Act (2015), you have been appointed as a member to the quotation opening committee for the following quotation(s):';
                Paragraph2 := 'You are expected to abide by the Procurement Laws/Regulations and PPRA Circular No.02/2020 including completing the assignment within the time required.';
                Paragraph3 := 'The quotations will be closing /opening on' + ' ' + Format("Submission Date") + ' ' + 'at ' + Format("Submission Time");
                ApprovalEntr.Reset();
                ApprovalEntr.SetRange(Status, ApprovalEntr.Status::Approved);
                ApprovalEntr.Setrange("Document No.", "Appointment No");
                if ApprovalEntr.FindLast() then begin
                    UserRec.Reset();
                    UserRec.SetRange("User Name", ApprovalEntr."Approver ID");
                    if UserRec.FindFirst() then begin
                        ApprovalName := UserRec."Full Name";
                        ApprovalTitle := 'EXECUTIVE DIRECTOR';
                    end;
                end;
                ProqReq.Reset();
                ProqReq.SetRange(ProqReq."No.", "Tender Committees"."Tender/Quotation No");
                if ProqReq.FindFirst() then SubmissionDate := ProqReq."Portal Submission Date";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfor.Get();
        CompInfor.CalcFields(Picture);
    end;

    var
        ProqReq: Record "Procurement Request";
        SubmissionDate: Date;
        CompInfor: Record "Company Information";
        Paragraph1: Text;
        Paragraph2: Text;
        Paragraph3: Text;
        ApprovalEntr: Record "Approval Entry";
        UserRec: Record User;
        ApprovalTitle: Text;
        ApprovalName: Text;
}

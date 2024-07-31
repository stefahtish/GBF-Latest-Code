report 50502 "Proc Summary Report"
{
    Caption = 'Proc Summary Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521634 ProcurementSummaryReport1.rdl';

    dataset
    {
        dataitem(ProcurementRequest; "Procurement Request")
        {
            RequestFilterFields = "No.";

            column(No; ProcurementRequest."No.")
            {
            }
            column(Title; ProcurementRequest.Title)
            {
            }
            column(RequisitionNo; ProcurementRequest."Requisition No")
            {
            }
            column(ShortcutDimension1Code; ProcurementRequest."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; ProcurementRequest."Shortcut Dimension 2 Code")
            {
            }
            column(Category; ProcurementRequest.Category)
            {
            }
            column(CategoryDescription; ProcurementRequest."Category Description")
            {
            }
            column(QuotationDeadline; ProcurementRequest."Quotation Deadline")
            {
            }
            column(ExpectedClosingTime; ProcurementRequest."Expected Closing Time")
            {
            }
            column(ProcurementPlanNo; ProcurementRequest."Procurement Plan No")
            {
            }
            column(ProcessType; ProcurementRequest."Process Type")
            {
            }
            column(CreationDate; ProcurementRequest."Creation Date")
            {
            }
            column(ProcurementPlanItemRec; ProcurementPlanNoRec)
            {
            }
            column(Logo; CompanyInformation.Picture)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPostCode; CompanyInformation."Post Code")
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(Homepage; CompanyInformation."Home Page")
            {
            }
            column(CommOpeningDate; OpeningDate)
            {
            }
            column(CommSubmissionOpenDate; SubmissionOpenDate)
            {
            }
            column(CommClosingDate; ClosingDate)
            {
            }
            column(CommSubmissionClosingDate; SubmissionClosingDate)
            {
            }
            dataitem(SupplierSelection; "Supplier Selection")
            {
                DataItemLinkReference = ProcurementRequest;
                DataItemLink = "Reference No."=field("No."), "Supplier Category"=field(Category);

                column(ReferenceNo; SupplierSelection."Reference No.")
                {
                }
                column(SupplierCategory; SupplierSelection."Supplier Category")
                {
                }
                column(SupplierCode; SupplierSelection."Supplier Code")
                {
                }
                column(SupplierName; SupplierSelection."Supplier Name")
                {
                }
            }
            dataitem(OpeningCommitee; "Commitee Member")
            {
                DataItemLinkReference = ProcurementRequest;
                DataItemLink = "Tender No."=field("No.");
                DataItemTableView = where("Committee Type"=filter(Opening));

                column(OpeningAppointmentNo; OpeningCommitee."Appointment No")
                {
                }
                column(OpeningEmployeeNo; OpeningCommitee."Employee No")
                {
                }
                column(OpeningName; OpeningCommitee.Name)
                {
                }
                column(OpeningRole; OpeningCommitee.Role)
                {
                }
                column(OpeningCommitteeType; OpeningCommitee."Committee Type")
                {
                }
            }
            dataitem(EvaluationCommitee; "Commitee Member")
            {
                DataItemLinkReference = ProcurementRequest;
                DataItemLink = "Tender No."=field("No.");
                DataItemTableView = where("Committee Type"=filter(Evaluation));

                column(EvalAppointmentNo; EvaluationCommitee."Appointment No")
                {
                }
                column(EvalEmployeeNo; EvaluationCommitee."Employee No")
                {
                }
                column(EvalName; EvaluationCommitee.Name)
                {
                }
                column(EvalRole; EvaluationCommitee.Role)
                {
                }
                column(EvalCommitteeType; EvaluationCommitee."Committee Type")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                GetProcurementPlanNo();
                GetTenderOpenSubmissionDate();
                GetTenderOpenSubmissionDate();
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var CompanyInformation: Record "Company Information";
    K: Integer;
    ProcurementPlanNoRec: Code[100];
    OpeningDate: Date;
    SubmissionOpenDate: Date;
    ClosingDate: Date;
    SubmissionClosingDate: Date;
    //Get thw Requistion Procurement Plan Item No.
    procedure GetProcurementPlanNo()
    var
        ProcRequest: Record "Procurement Request";
        ProcRequestLines: Record "Procurement Request Lines";
    begin
        ProcRequest.Reset();
        ProcRequest.SetRange("No.", ProcurementRequest."No.");
        if ProcRequest.FindFirst()then begin
            ProcRequestLines.Reset();
            ProcRequestLines.SetRange("Requisition No", ProcRequest."No.");
            if ProcRequestLines.FindFirst()then begin
                ProcurementPlanNoRec:=ProcRequestLines."Procurement Plan Item";
            end;
        end;
    end;
    //Procedure to get the Creation Date and Submission Date of Opening Commitee:
    procedure GetTenderOpenSubmissionDate()
    var
        ProcurementRec: Record "Procurement Request";
        TenderCommitte: Record "Tender Committees";
    begin
        ProcurementRec.Reset();
        ProcurementRec.SetRange("No.", ProcurementRequest."No.");
        if ProcurementRec.FindFirst()then begin
            TenderCommitte.Reset();
            TenderCommitte.SetRange("Tender/Quotation No", ProcurementRec."No.");
            TenderCommitte.SetFilter("Committee Type", '%1', TenderCommitte."Committee Type"::Opening);
            if TenderCommitte.FindFirst()then begin
                OpeningDate:=TenderCommitte."Creation Date";
                SubmissionOpenDate:=TenderCommitte."Submission Date";
            end;
        end;
    end;
    //Procedure to Get Creation Date and Submission Date of Ecaluation Commitee:
    procedure GetTenderEvalSubmissionDate()
    var
        ProcurementEvalRec: Record "Procurement Request";
        TenderEvalCommitte: Record "Tender Committees";
    begin
        ProcurementEvalRec.Reset();
        ProcurementEvalRec.SetRange("No.", ProcurementRequest."No.");
        if ProcurementEvalRec.FindFirst()then begin
            TenderEvalCommitte.Reset();
            TenderEvalCommitte.SetRange("Tender/Quotation No", ProcurementEvalRec."No.");
            TenderEvalCommitte.SetFilter("Committee Type", '%1', TenderEvalCommitte."Committee Type"::Evaluation);
            if TenderEvalCommitte.FindFirst()then begin
                ClosingDate:=TenderEvalCommitte."Creation Date";
                SubmissionClosingDate:=TenderEvalCommitte."Submission Date";
            end;
        end;
    end;
}

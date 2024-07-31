report 50501 "Procurement Summary Report"
{
    Caption = 'Procurement Summary Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521633 ProcurementSummaryReport.rdl';

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
            dataitem(InvitedBids; "Prospective Tender Line")
            {
                DataItemLinkReference = ProcurementRequest;
                DataItemLink = "Tender No."=field("No.");

                column(TenderNo; InvitedBids."Tender No.")
                {
                }
                column(ProcurementPlans; InvitedBids."Procurement Plan")
                {
                }
                column(ProcurementPlanItemNo; InvitedBids."Procurement Plan Item")
                {
                }
                column(BiddedAmount; InvitedBids."Amount LCY")
                {
                }
                column(AmountQuoted; InvitedBids."Amount Inclusive VAT")
                {
                }
                column(ResponseNo; InvitedBids."Response No")
                {
                }
                column(BidType; InvitedBids.Type)
                {
                }
                column(BidNo; InvitedBids.No)
                {
                }
                column(BidderName; BiddersName)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    GetBidderName();
                end;
            }
            dataitem("Internal Request Line"; "Internal Request Line")
            {
                DataItemLink = "Document No."=FIELD("No.");

                column(ProcurementPlanItem_InternalRequestLine; "Internal Request Line"."Procurement Plan Item")
                {
                }
                column(Description_InternalRequestLine; "Internal Request Line".Description)
                {
                }
            }
            dataitem("Internal Request Header"; "Internal Request Header")
            {
                column(No_InternalRequestHeader; "Internal Request Header"."No.")
                {
                }
                column(Department; "Internal Request Header"."Shortcut Dimension 2 Code")
                {
                }
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                column(No_PurchaseHeader; "No.")
                {
                }
                column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
                {
                }
                column(DocumentDate_PurchaseHeader; "Document Date")
                {
                }
                column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    column(AmountIncludingVAT_PurchaseLine; "Amount Including VAT")
                    {
                    }
                    column(Amount_PurchaseLine; Amount)
                    {
                    }
                }
            }
            dataitem("Prospective Suppliers"; "Prospective Suppliers")
            {
                column(No_ProspectiveSuppliers; "No.")
                {
                }
                column(AgpoGroup_ProspectiveSuppliers; "Agpo Group")
                {
                }
                column(AgpoNumber_ProspectiveSuppliers; "Agpo Number")
                {
                }
                column(SupplierType_ProspectiveSuppliers; "Supplier Type")
                {
                }
                dataitem("Prospective Supplier Directors"; "Prospective Supplier Directors")
                {
                    column(Name_ProspectiveSupplierDirectors; Name)
                    {
                    }
                }
            }
            dataitem("G/L Budget Name"; "G/L Budget Name")
            {
                column(Name_GLBudgetName; Name)
                {
                }
                dataitem("Procurement Plan"; "Procurement Plan")
                {
                    column(No_ProcurementPlan; "No.")
                    {
                    }
                }
            }
            dataitem(CommiteeMembers; "Tender Committees")
            {
                DataItemLinkReference = ProcurementRequest;
                DataItemLink = "Tender/Quotation No"=field("No.");
                DataItemTableView = where(Status=const(Released));

                column(TenderQuotationNo; CommiteeMembers."Tender/Quotation No")
                {
                }
                column(AppointmentNo; CommiteeMembers."Appointment No")
                {
                }
                column(OpeningDate; CommiteeMembers."Submission Date")
                {
                }
                column(SubmissionTime; CommiteeMembers."Submission Time")
                {
                }
                column(CommitteeType; CommiteeMembers."Committee Type")
                {
                }
                column(CommCreationDate; CommiteeMembers."Creation Date")
                {
                }
                dataitem(OpeningCommitee; "Commitee Member")
                {
                    DataItemLinkReference = CommiteeMembers;
                    DataItemLink = "Appointment No"=field("Appointment No");
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
                    DataItemLinkReference = CommiteeMembers;
                    DataItemLink = "Appointment No"=field("Appointment No");
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
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var CompanyInformation: Record "Company Information";
    BiddersName: Text[250];
    //Procedure to Get Bidders Name
    procedure GetBidderName()
    var
        ProspectSupp: Record "Prospective Suppliers";
    begin
        ProspectSupp.Reset();
        ProspectSupp.SetRange("No.", InvitedBids."Response No");
        if ProspectSupp.FindFirst()then begin
            BiddersName:=ProspectSupp.Name;
        end;
    end;
}

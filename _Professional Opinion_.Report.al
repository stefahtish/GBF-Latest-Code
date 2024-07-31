report 50443 "Professional Opinion"
{
    ApplicationArea = All;
    Caption = 'Professional Opinion';
    DefaultLayout = RDLC;
    RDLCLayout = './Professional Opinion.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(EOIEvaluationHeader; "Procurement Request")
        {
            RequestFilterFields = "No.";

            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(QuoteNo_EOIEvaluationHeader; "No.")
            {
            }
            column(CreationDate_EOIEvaluationHeader; "Creation Date")
            {
            }
            column(DateofAward_EOIEvaluationHeader; "Creation Date")
            {
            }
            column(Title; Title)
            {
            }
            column(BidsCount; BidsCount)
            {
            }
            column(TenderCount; TenderCount)
            {
            }
            column(MOP; MOP)
            {
            }
            column(Today; Today)
            {
            }
            dataitem("Quote Evaluation Header"; "Quote Evaluation Header")
            {
                DataItemLinkReference = EOIEvaluationHeader;
                DataItemLink = "Quote No"=field("No.");

                column(Legal_Aspects; "Legal Aspects")
                {
                }
                dataitem(QuoteEvaluation; "Quote Evaluation")
                {
                    DataItemLinkReference = "Quote Evaluation Header";
                    DataItemLink = "Quote No"=field("Quote No");
                    DataItemTableView = sorting("No.");

                    column(Item; "No.")
                    {
                    }
                    column(Vendor_No; "Vendor No")
                    {
                    }
                    column(Description; Description)
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(Unit_of_Measure; "Unit of Measure")
                    {
                    }
                    column(Unit_Amount; "Unit Amount")
                    {
                    }
                    column(Vendor_Name; "Vendor Name")
                    {
                    }
                    column(GetSuggestedVendor; GetSuggestedVendor("Vendor No"))
                    {
                    }
                    column(m; m)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        m+=1;
                    end;
                }
            }
            dataitem(TenderCommittees; "Tender Committees")
            {
                DataItemLinkReference = EOIEvaluationHeader;
                DataItemLink = "Tender/Quotation No"=field("No.");
                DataItemTableView = sorting("Appointment No");

                column(Appointment_letter_Ref_No_; "Appointment letter Ref No.")
                {
                }
                column(Submission_Date; "Submission Date")
                {
                }
                dataitem(CommitteeMembers; "Commitee Member")
                {
                    DataItemLinkReference = TenderCommittees;
                    DataItemLink = "Appointment No"=field("Appointment No");

                    column(EmployeeNo_CommitteeMembers; "Employee No")
                    {
                    }
                    column(Name_CommitteeMembers; Name)
                    {
                    }
                    column(Role_CommitteeMembers; Role)
                    {
                    }
                    column(i; i)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        i+=1;
                    end;
                }
            }
            dataitem(EvaluationCommitteeMembers; "Commitee Member")
            {
                DataItemLinkReference = EOIEvaluationHeader;
                DataItemLink = "Tender No."=field("No.");
                DataItemTableView = where("Committee Type"=Const("Evaluation"));

                column(EvaluationEmployeeNo_CommitteeMembers; "Employee No")
                {
                }
                column(EvaluationName_CommitteeMembers; Name)
                {
                }
                column(EvaluationRole_CommitteeMembers; Role)
                {
                }
            }
            dataitem(BidderSelection; "Bidders Selection")
            {
                DataItemLinkReference = EOIEvaluationHeader;
                DataItemLink = "Reference No."=field("No.");
                DataItemTableView = sorting("Line No.");

                column(Supplier_Code; "Reference No.")
                {
                }
                column(Supplier_Name; "Supplier Name")
                {
                }
                column(j; j)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    j+=1;
                end;
            }
            dataitem(InternalRequestLine; "Internal Request Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = where(Type=Const(Item));

                column(ItemNo; "No.")
                {
                }
                column(ItemDescription; "Description")
                {
                }
            }
            dataitem(SupplierTender; "Prospective Supplier Tender")
            {
                DataItemLinkReference = EOIEvaluationHeader;
                DataItemLink = "Tender No."=field("No.");
                DataItemTableView = sorting("Prospect No.");

                column(Invited; Invited("Prospect No."))
                {
                }
                column(Responded; Responded("Tender No.", "Prospect No."))
                {
                }
                column(k; k)
                {
                }
                column(l; l)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Invited("Prospect No.") <> '' then K+=1;
                    if Responded("Tender No.", "Prospect No.") <> '' then l+=1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                BidsCount:=0;
                TenderCount:=0;
                BidSelection.Reset();
                BidSelection.SetRange("Reference No.", EOIEvaluationHeader."No.");
                If BidSelection.FindSet()then begin
                    BidsCount:=BidSelection.Count();
                    BidderNo:=BidSelection."Supplier Code";
                    BidderName:=BidSelection."Supplier Name";
                end;
                ProsTender.Reset();
                ProsTender.SetRange("Tender No.", EOIEvaluationHeader."No.");
                if ProsTender.FindSet()then begin
                    TenderCount:=ProsTender.Count;
                    if ProsTender.Type = 0 then MOP:='Tender'
                    else if ProsTender.Type = 1 then MOP:='Request For Quotation'
                        else if ProsTender.Type = 2 then MOP:='Request For Proposal'
                            else if ProsTender.Type = 3 then MOP:='EOI'
                                else if ProsTender.Type = 4 then MOP:='Restricted' end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
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
            }
        }
    }
    trigger OnPreReport()
    begin
        Clear(i);
        Clear(j);
        Clear(k);
        Clear(j);
        Clear(m);
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;
    procedure Responded(TenderNo: Code[20]; ProspectNo: Code[20]): Text[250]var
        TenderLine: Record "Prospective Tender Line";
        Tender: Record "Prospective Supplier Tender";
        ProsSupplier: Record "Prospective Suppliers";
    begin
        TenderLine.Reset();
        TenderLine.SetFilter("Tender No.", '%1', TenderNo);
        TenderLine.SetFilter("Response No", '%1', ProspectNo);
        TenderLine.SetFilter(Amount, '>%1', 0);
        if TenderLine.FindFirst()then begin
            ProsSupplier.Reset();
            ProsSupplier.SetFilter("No.", '%1', ProspectNo);
            if ProsSupplier.FindFirst()then exit(ProsSupplier.Name)
            else
                exit('');
        end
        else
            exit('');
    end;
    procedure Invited(SupplierCode: Code[20]): Text[250]var
        ProsSupplier: Record "Prospective Suppliers";
    begin
        ProsSupplier.Reset();
        ProsSupplier.SetFilter("No.", '%1', SupplierCode);
        if ProsSupplier.FindFirst()then exit(ProsSupplier.Name)
        else
            exit('');
    end;
    procedure GetSuggestedVendor(Vendor: Code[20]): Text[150]var
        QuoteValuation: Record "Quote Evaluation";
    begin
        QuoteValuation.Reset();
        QuoteValuation.SetFilter("Vendor No", '%1', Vendor);
        QuoteValuation.SetRange(Suggested, true);
        if QuoteValuation.FindFirst()then exit(QuoteValuation."Vendor Name");
    end;
    var CompInfo: Record "Company Information";
    PurchReqLines: Record "Internal Request Line";
    ItemDescription: Text[100];
    BidSelection: Record "Bidders Selection";
    ProsTender: Record "Prospective Supplier Tender";
    BidsCount: Decimal;
    TenderCount: Decimal;
    MOP: Text[100];
    QuoteLines: Record "EOI Evaluation Line";
    BidderNo: Code[100];
    BidderName: Text[250];
    ItemNo: Code[100];
    IntVar: Integer;
    i: Integer;
    j: Integer;
    k: Integer;
    l: Integer;
    m: Integer;
}

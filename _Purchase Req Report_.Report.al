report 50505 "Purchase Req Report"
{
    Caption = 'Purchase Requistion Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521637 PurchaseReq Report.rdl';

    dataset
    {
        dataitem(InternalRequestHeader; "Internal Request Header")
        {
            RequestFilterFields = "No.", Status;

            column(No; InternalRequestHeader."No.")
            {
            }
            column(DocumentType; InternalRequestHeader."Document Type")
            {
            }
            column(DocumentDate; InternalRequestHeader."Document Date")
            {
            }
            column(OrderDate; InternalRequestHeader."Order Date")
            {
            }
            column(EmployeeNo; InternalRequestHeader."Employee No.")
            {
            }
            column(EmployeeName; InternalRequestHeader."Employee Name")
            {
            }
            column(RequestedBy; InternalRequestHeader."Requested By")
            {
            }
            column(Status; InternalRequestHeader.Status)
            {
            }
            column(ShortcutDim1; InternalRequestHeader."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDim2; InternalRequestHeader."Shortcut Dimension 2 Code")
            {
            }
            column(PurchaseOrderNo; PurchaseOrderNo)
            {
            }
            column(Approver; Approver[1])
            {
            }
            column(ApproverDate; ApproverDateConv)
            {
            }
            column(CmpLogo; CompanyInformation.Picture)
            {
            }
            column(CmpAddress; CompanyInformation.Address)
            {
            }
            column(CmpPostcode; CompanyInformation."Post Code")
            {
            }
            column(CmpPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CmpCity; CompanyInformation.City)
            {
            }
            column(CmpEmail; CompanyInformation."E-Mail")
            {
            }
            column(Homepage; CompanyInformation."Home Page")
            {
            }
            column(CountRows; CountRows)
            {
            }
            dataitem(InternalRequestLine; "Internal Request Line")
            {
                DataItemLinkReference = InternalRequestHeader;
                DataItemLink = "Document No."=field("No.");

                //"Document Type" = field("Document Type"), "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code"), "Procurement Plan" = field("Procurement Plan")
                column(DocumentNo; InternalRequestLine."Document No.")
                {
                }
                column(DocumentLineType; InternalRequestLine."Document Type")
                {
                }
                column(ShortcutDimension2Line; InternalRequestLine."Shortcut Dimension 2 Code")
                {
                }
                column(ProcurementPlan; InternalRequestLine."Procurement Plan")
                {
                }
                column(ProcurementPlanItem; InternalRequestLine."Procurement Plan Item")
                {
                }
                column(ProcurementPlanDescription; InternalRequestLine."Procurement Plan Description")
                {
                }
                column(LPO; InternalRequestLine.LPO)
                {
                }
                column(Supplier; InternalRequestLine.Supplier)
                {
                }
                column(SupplierName; InternalRequestLine."Supplier Name")
                {
                }
                column(Specification2; InternalRequestLine.Specification2)
                {
                }
                column(Quantity; InternalRequestLine.Quantity)
                {
                }
                column(PlannedQuantity; InternalRequestLine."Planned Quantity")
                {
                }
                column(DirectUnitCost; InternalRequestLine."Direct Unit Cost")
                {
                }
                column(LineAmount; InternalRequestLine."Line Amount")
                {
                }
                column(AmountIncludingVAT; InternalRequestLine."Amount Including VAT")
                {
                }
                column(TotalEstimatedCost; InternalRequestLine."Total Estimated Cost")
                {
                }
                column(VATBaseAmount; InternalRequestLine."VAT Base Amount")
                {
                }
                column(SpecificationsTxt; SpecificationTxt)
                {
                }
                column(RequestedBy_InternalRequestLine; "Requested By")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    InternalRequestLine.CalcFields(Specification2);
                    InternalRequestLine.Specification2.CreateInStream(Instrm);
                    SpecificationBigTXT.Read(Instrm);
                    SpecificationTxt:=Format(SpecificationBigTXT);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //Getting the Number of Rows
                CountRows+=1;
                GetPurchaseOrdr();
                //Getting the Approval Date
                if InternalRequestHeader.Status = InternalRequestHeader.Status::Released then begin
                    Clear(ApproverDateConv);
                    ApprovalEntries.Reset();
                    ApprovalEntries.SetCurrentKey("Sequence No.");
                    ApprovalEntries.SetRange("Table ID", 50126);
                    ApprovalEntries.SetRange("Document No.", InternalRequestHeader."No.");
                    ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                    if ApprovalEntries.FindSet()then begin
                        repeat if ApprovalEntries."Sequence No." = 3 then begin
                                Approver[1]:=ApprovalEntries."Last Modified By User ID";
                                ApproverDate[1]:=ApprovalEntries."Last Date-Time Modified";
                                ApproverDateConv:=DT2Date(ApproverDate[1]);
                            end;
                        until ApprovalEntries.Next() = 0;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var CompanyInformation: Record "Company Information";
    SpecificationTxt: Text;
    SpecificationBigTXT: BigText;
    Instrm: InStream;
    PurchaseOrderNo: Code[100];
    Approver: array[10]of Code[50];
    ApprovalEntries: Record "Approval Entry";
    ApproverDate: array[10]of DateTime;
    ApproverDateConv: Date;
    CountRows: Integer;
    //Getting the Purchase Order from Purchase Requisition:
    procedure GetPurchaseOrdr()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Tender/Quotation ref no", InternalRequestHeader."No.");
        if PurchaseHeader.FindFirst()then PurchaseOrderNo:=PurchaseHeader."Tender/Quotation ref no"
        else
            PurchaseOrderNo:='NA';
    end;
}

table 50439 "Prospective Supplier Tender"
{
    fields
    {
        field(50000; "Prospect No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Tender No."; Code[100])
        {
            DataClassification = ToBeClassified;
            ValidateTableRelation = false;
            TableRelation = if(Type=const(Tender))"Procurement Request" where("Process Type"=const(Tender), "Tender Type"=const(open), "Submitted To Portal"=const(true), Status=filter(<>Archived))
            else if(Type=const(Restricted))"Procurement Request" where("Process Type"=const(Tender), "Tender Type"=const(Restricted), "Submitted To Portal"=const(true), Status=filter(<>Archived))
            else if(Type=const(RFP))"Procurement Request" where("Process Type"=const(RFP), "Submitted To Portal"=const(true), Status=filter(<>Archived))
            else if(Type=const(RFQ))"Procurement Request" where("Process Type"=const(RFQ), "Submitted To Portal"=const(true), Status=filter(<>Archived))
            else if(Type=const(EOI))"Procurement Request" where("Process Type"=const(EOI), "Submitted To Portal"=const(true), Status=filter(<>Archived));

            trigger OnValidate()
            begin
                TenderRec.Reset();
                TenderRec.SetRange("No.", "Tender No.");
                if TenderRec.FindFirst()then begin
                    TransferFields(TenderRec);
                    //Insert Lines
                    TenderLine.Reset();
                    TenderLine.SetRange(TenderLine."Requisition No", TenderRec."No.");
                    if TenderLine.Find('-')then begin
                        repeat ProspectiveTenderLine.Init;
                            ProspectiveTenderLine."Response No":="Prospect No.";
                            ProspectiveTenderLine."Tender No.":=TenderRec."No.";
                            ProspectiveTenderLine."Line No":=TenderLine."Line No";
                            ProspectiveTenderLine.Type:=TenderLine.Type;
                            ProspectiveTenderLine.No:=TenderLine."No";
                            TenderLine.CalcFields(Specification2);
                            ProspectiveTenderLine.Specification2:=TenderLine.Specification2;
                            ProspectiveTenderLine.Description:=TenderLine.Description;
                            ProspectiveTenderLine.Quantity:=TenderLine.Quantity;
                            ProspectiveTenderLine."Unit of Measure":=TenderLine."Unit of Measure";
                            ProspectiveTenderLine."Procurement Plan":=TenderLine."Procurement Plan";
                            ProspectiveTenderLine."Procurement Plan Item":=TenderLine."Procurement Plan Item";
                            ProspectiveTenderLine."Budget Line":=TenderLine."Budget Line";
                            ProspectiveTenderLine."Shortcut Dimension 1 Code":=TenderLine."Shortcut Dimension 1 Code";
                            ProspectiveTenderLine.Validate("Shortcut Dimension 1 Code");
                            ProspectiveTenderLine."Shortcut Dimension 2 Code":=TenderLine."Shortcut Dimension 2 Code";
                            ProspectiveTenderLine.Validate("Shortcut Dimension 2 Code");
                            ProspectiveTenderLine."Request Date":=TenderRec.TenderOpeningDate;
                            ProspectiveTenderLine."Expected Receipt Date":=DT2Date(TenderRec.TenderClosingDate);
                            ProspectiveTenderLine.Committed:=TenderLine.Committed;
                            ProspectiveTenderLine.Specification2:=TenderLine.Specification2;
                            ProspectiveTenderLine."VAT Prod. Posting Group":=TenderLine."VAT Prod. Posting Group";
                            ProspectiveTenderLine."VAT %":=TenderLine."VAT %";
                            ProspectiveTenderLine."Amount Inclusive VAT":=TenderLine."Amount Inclusive VAT";
                            if not ProspectiveTenderLine.Get(ProspectiveTenderLine."Response No", ProspectiveTenderLine."Tender No.", ProspectiveTenderLine."Line No")then ProspectiveTenderLine.Insert(true);
                        until TenderLine.Next = 0;
                    end;
                end;
            end;
        }
        field(2; Title; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Requisition No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Internal Request Header"."No." WHERE("Document Type"=FILTER(Purchase), Status=FILTER(Released));
        }
        field(4; "Procurement Plan No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan";
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Procurement type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Process Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI;
        }
        field(10; "Procurement Plan Item"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan"."Plan Item No" WHERE("Plan Year"=FIELD("Procurement Plan No"));
        }
        field(11; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(14; TenderOpeningDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Tender Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released, "Pending Approval", Approved, "Pending Prepayment", Rejected, Closed;
        }
        field(16; TenderClosingDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Quotation Deadline"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(23; "Expected Closing Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Submitted To Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Ref No."; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Sent for Evaluation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Pre-qualified"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Prospective Suppliers"."Pre Qualified" where("No."=field("Prospect No.")));
        }
        field(50003; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Tender, RFQ, RFP, EOI, Restricted;
        }
        field(50004; "Passed Technical"; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50005; "Passed Preliminary"; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50006; "Average Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Passed Financial"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Prospect No.", "Tender No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    RequisitionLines: Record "Internal Request Line";
    RequisitionHeader: Record "Internal Request Header";
    QuotationLines: Record "Procurement Request Lines";
    LineNo: Integer;
    TenderRec: Record "Procurement Request";
    ProspectiveTenderLine: Record "Prospective Tender Line";
    TenderLine: Record "Procurement Request Lines";
}

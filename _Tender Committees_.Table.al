table 50139 "Tender Committees"
{
    fields
    {
        field(1; "Tender/Quotation No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if("Procurement Method"=const(Tender))"Procurement Request" where("Process Type"=const(Tender))
            ELSE IF("Procurement Method"=const(Quotation))"Procurement Request" where("Process Type"=const(RFQ))
            ELSE IF("Procurement Method"=const(RFP))"Procurement Request" where("Process Type"=const(RFP))
            ELSE IF("Procurement Method"=const(EOI))"Procurement Request" where("Process Type"=const(EOI));

            trigger OnValidate()
            begin
                TenderCommittees.Reset();
                TenderCommittees.SetRange(TenderCommittees."Tender/Quotation No", "Tender/Quotation No");
                TenderCommittees.SetRange(TenderCommittees."Committee Type", "Committee Type");
                if TenderCommittees.FindFirst then Error(AnotherCommitteeExistsErr, TenderCommittees."Appointment No", "Tender/Quotation No");
                if TenderRec.Get("Tender/Quotation No")then begin
                    Title:=TenderRec.Title;
                    "Submission Date":=TenderRec."Quotation Deadline";
                    "Submission Time":=TenderRec."Expected Closing Time";
                end;
            end;
        }
        field(2; "Committee ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Committees";

            trigger OnValidate()
            begin
            // if ProcurementComittee.Get("Committee ID") then begin
            //     "Committee Name" := ProcurementComittee.Description;
            // end;
            end;
        }
        field(3; "Committee Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Title; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Appointment No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released, "Pending Approval";
        }
        field(10; "Procurement Method"; Option)
        {
            OptionMembers = Tender, Quotation, RFP, EOI, "Asset Disposal";
            DataClassification = ToBeClassified;
        }
        field(11; "Submission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Submission Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Committee Type"; Option)
        {
            OptionMembers = Opening, Evaluation, Negotiation, Inspection, Specialized;
            DataClassification = ToBeClassified;
        }
        field(14; "Contract No."; Code[50])
        {
            DataClassification = ToBeClassified;
        // TableRelation = "Project Header" where(Verified = const(true), Status = filter(Suspended | "Extended Contracts"));
        }
        field(15; Contract; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Contract Type"; Option)
        {
            OptionMembers = "", Suspension, Extension, Termination;
            DataClassification = ToBeClassified;
        }
        field(17; "Venue"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Appointment letter Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Evaluation Comment"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appointment No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Appointment No" = '' then begin
            PurchSetup.get;
            PurchSetup.testfield("Committe Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Committe Nos", xrec."No. Series", 0D, "Appointment No", "No. Series");
        end;
        "User ID":=CopyStr(UserId, 1, 50);
        "Creation Date":=Today;
    end;
    var ProcurementComittee: Record "Procurement Committees";
    TenderRec: Record "Procurement Request";
    PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    TenderCommittees: Record "Tender Committees";
    AnotherCommitteeExistsErr: Label 'Another Tender Committee %1 already exists for Tender No. %2';
    procedure GetEmpUserID(EmpCode: Code[20]): Code[50]var
        EmpRec: record Employee;
    begin
        if EmpRec.get(EmpCode)then begin
            EmpRec.TestField("User ID");
            exit(EmpRec."User ID")end;
    end;
}

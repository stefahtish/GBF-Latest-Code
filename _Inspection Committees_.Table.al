table 50176 "Inspection Committees"
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
                InspectionCommittees.Reset();
                InspectionCommittees.SetRange(InspectionCommittees."Tender/Quotation No", "Tender/Quotation No");
                if InspectionCommittees.FindFirst then Error(AnotherCommitteeExistsErr, InspectionCommittees."Appointment No", "Tender/Quotation No");
                if InspectionRec.Get("Tender/Quotation No")then begin
                    Title:=InspectionRec.Title;
                end;
            end;
        }
        field(2; "Committee Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Title; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Appointment No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment";
        }
        field(10; "Procurement Method"; Option)
        {
            OptionMembers = Tender, Quotation, RFP, EOI;
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
            PurchSetup.testfield("Inspection Committee Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Inspection Committee Nos", xrec."No. Series", 0D, "Appointment No", "No. Series");
        end;
        "User ID":=CopyStr(UserId, 1, 20);
        "Creation Date":=Today;
    end;
    var // ProcurementComittee: Record "Procurement Committees";
    InspectionRec: Record "Procurement Request";
    PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    InspectionCommittees: Record "Inspection Committees";
    AnotherCommitteeExistsErr: Label 'Another Tender Committee %1 already exists for Tender No. %2';
    procedure GetEmpUserID(EmpCode: Code[20]): Code[50]var
        EmpRec: record Employee;
    begin
        if EmpRec.get(EmpCode)then begin
            EmpRec.TestField("User ID");
            exit(EmpRec."User ID")end;
    end;
}

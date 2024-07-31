table 50431 "Supplier Evaluation Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            Caption = 'Quote/Tender No.';
            TableRelation = if("Procurement Method"=const(Tender))"Procurement Request" where("Process Type"=const(Tender))
            ELSE IF("Procurement Method"=const(Quotation))"Procurement Request" where("Process Type"=const(RFQ))
            ELSE IF("Procurement Method"=const(RFP))"Procurement Request" where("Process Type"=const(RFP))
            ELSE IF("Procurement Method"=const(EOI))"Procurement Request" where("Process Type"=const(EOI));

            trigger OnValidate()
            var
                ProcRequest: Record "Procurement Request";
                Bidders: Record "Prospective Suppliers";
                EvaluationLine: Record "Supplier Evaluation Line";
                ScoreSetup: Record "Supplier Evaluation SetUp";
                Scores: Record "Supplier Evaluation Score";
                LineNo: Integer;
            begin
                Suppliers.Reset();
                Suppliers.SetRange(Suppliers."quote no", "quote no");
                Suppliers.SetRange(Suppliers."Supplier Code", "supplier code");
                if Suppliers.FindFirst then Error(AnotherSupplierExistsErr, Suppliers."Supplier Code", "Quote no");
                if ProcRequest.get("Quote No")then Title:=ProcRequest.Title;
            end;
        // DataClassification = ToBeClassified;
        // NotBlank = true;
        // TableRelation = "Procurement Request";
        // trigger OnValidate()
        // var
        //     ProcRequest: Record "Procurement Request";
        //     Bidders: Record "Prospective Suppliers";
        //     EvaluationLine: Record "Supplier Evaluation Line";
        //     ScoreSetup: Record "Supplier Evaluation SetUp";
        //     Scores: Record "Supplier Evaluation Score";
        //     LineNo: Integer;
        // begin
        //     if ProcRequest.get("Quote No") then
        //         Title := ProcRequest.Title;
        //     /* Bidders.Reset();
        //      Bidders.SetRange("Tender No.", "Quote No");
        //      Bidders.SetRange("Pre Qualified", true);
        //      if Bidders.Find('-') then begin
        //          repeat
        //              LineNo := LineNo + 10000;
        //              EvaluationLine.Init();
        //              EvaluationLine."Quote No" := "No.";
        //              EvaluationLine."Tender No." := "Quote No";
        //              EvaluationLine."Line No." := LineNo;
        //              EvaluationLine.Supplier := Bidders."No.";
        //              EvaluationLine."Supplier Name" := Bidders.Name;
        //              EvaluationLine.Insert();
        //              //Insert Score Parameters
        //              ScoreSetup.Reset();
        //              if ScoreSetup.Find('-') then begin
        //                  repeat
        //                      Scores.Init();
        //                      Scores."Document No." := "No.";
        //                      Scores."Supplier Code" := Bidders."No.";
        //                      Scores."Score Parameter" := ScoreSetup.Code;
        //                      Scores."Score Description" := ScoreSetup."Evalueation Description";
        //                      Scores."Maximum Score" := ScoreSetup."Maximum Score";
        //                      Scores.Insert();
        //                  until ScoreSetup.Next = 0;
        //              end;
        //              Bidders."Supplier Status" := bidders."Supplier Status"::Evaluation;
        //              Bidders.Modify();
        //          until Bidders.Next = 0;
        //      end;
        //  end;*/
        // end;
        }
        field(2; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                User:=UserId;
                PurchSetup.Get;
                if Type in[Type::Tender, Type::EOI, Type::quotation, Type::RFP]then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."Supplier Evaluation Nos");
                end;
                if Type = Type::Existing then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."Vendor Evaluation Nos");
                end;
            end;
        }
        field(3; Title; Text[250])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; User; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Submitted,Rejected,Pending Approval';
            OptionMembers = New, Approved, Rejected, "Pending Approval";
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Supplier Code"; Code[50])
        {
            // if Type = Type::Tender then TableRelation = "Prospective Suppliers";
            // Type::Tender, Type::EOI, type::quotation, type::RFP:
            TableRelation = IF(Type=CONST(Tender))"Prospective Suppliers"
            ELSE IF(Type=const(Existing))Vendor WHERE("Vendor Type"=const(Vendor));

            trigger OnValidate()
            begin
                case Type of Type::Tender, Type::EOI, type::quotation, type::RFP: begin
                    if ProspectRec.get("Supplier Code")then begin
                        "Supplier Name":=ProspectRec.Name;
                        Description:='Supplier Evaluation for ' + "Supplier Name";
                    end;
                end;
                Type::Existing: if Vendors.get("Supplier Code")then begin
                        "Supplier Name":=Vendors.Name;
                        Description:="Supplier Name";
                    end;
                end;
            end;
        }
        field(9; "Supplier Name"; text[100])
        {
        }
        field(10; Description; text[250])
        {
        }
        field(11; "Committee No."; code[50])
        {
        }
        field(12; "Total Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Score".Score where("Document No."=field("No.")));
            Editable = false;
        }
        field(13; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Tender, Existing, quotation, RFP, EOI;
        }
        field(14; Period; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Evaluation Periods" where(Active=const(true));
        }
        field(15; Stage; Option)
        {
            OptionMembers = " ", Preliminary, Technical, Prices, Archived, Opening;
            DataClassification = ToBeClassified;
        }
        field(16; "Procurement Method"; Option)
        {
            OptionMembers = Tender, Quotation, RFP, EOI, "Asset Disposal";
            DataClassification = ToBeClassified;
        }
        field(17; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; Processed; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(19; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Prospective Tender Line".Amount where("Response No"=field("Supplier Code"), "Tender No."=field("Quote No")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        case Type of Type::Tender, Type::EOI, type::quotation, type::RFP: begin
            PurchSetup.TestField("Supplier Evaluation Nos");
            if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."Supplier Evaluation Nos", xRec."No. Series", 0D, "No.", "No. Series");
            "Document Date":=today;
        end;
        Type::Existing: begin
            PurchSetup.TestField("Vendor Evaluation Nos");
            if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."Vendor Evaluation Nos", xRec."No. Series", 0D, "No.", "No. Series");
            "Document Date":=today;
        end;
        end;
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Commett: Record "Commitee Member";
    ProspectRec: Record "Prospective Suppliers";
    Suppliers: Record "Supplier Evaluation Header";
    Vendors: Record Vendor;
    AnotherSupplierExistsErr: Label 'Another Supplier %1 already exists for Supplier Evaluation No. %2';
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
    end;
}

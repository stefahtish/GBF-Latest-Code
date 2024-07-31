table 50415 "Procurement Request"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            //  NotBlank = true;
            trigger OnValidate()
            begin
                PurchSetup.Get;
                if "Process Type" = "Process Type"::RFQ then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."Quotation Nos");
                end;
                if "Process Type" = "Process Type"::RFP then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."RFP Nos.");
                end;
                if "Process Type" = "Process Type"::Tender then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."Tender Nos.");
                end;
                if "Process Type" = "Process Type"::EOI then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."EOI Nos");
                end;
                if "Process Type" = "Process Type"::"FA Disposal Quote" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(PurchSetup."FA Disposal Quote Nos");
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
            TableRelation = "Internal Request Header"."No." WHERE("Document Type"=FILTER(Purchase), Status=FILTER(Released), "Tender No."=filter(''));

            trigger OnValidate()
            var
                lineNo: Integer;
            begin
                RequisitionHeader.Reset();
                if RequisitionHeader.Get("Requisition No")then begin
                    "Procurement Plan No":=RequisitionHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code":=RequisitionHeader."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code":=RequisitionHeader."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    Category:=RequisitionHeader."Supplier category";
                    "Category Description":=RequisitionHeader."Supplier category Description";
                    RequisitionLines.reset();
                    RequisitionLines.SetRange(RequisitionLines."Document No.", RequisitionHeader."No.");
                    if RequisitionLines.Find('-')then begin
                        QuotationLines.Reset();
                        QuotationLines.setrange("Requisition No", "No.");
                        QuotationLines.DeleteAll();
                        repeat lineNo+=1000;
                            //Message(RequisitionLines."Procurement Plan Item");
                            QuotationLines.Init;
                            QuotationLines."Requisition No":="No.";
                            //QuotationLines."Line No" := RequisitionLines."Line No.";
                            QuotationLines."Line No":=lineNo;
                            QuotationLines.Type:=RequisitionLines.Type;
                            QuotationLines.No:=RequisitionLines."No.";
                            QuotationLines.Description:=RequisitionLines.Description;
                            RequisitionLines.CalcFields(Specification2);
                            QuotationLines.Specification2:=RequisitionLines.Specification2;
                            QuotationLines.Quantity:=RequisitionLines.Quantity;
                            QuotationLines."Unit of Measure":=RequisitionLines."Unit of Measure";
                            QuotationLines."Procurement Plan":=RequisitionLines."Procurement Plan";
                            QuotationLines."Procurement Plan Item":=RequisitionLines."Procurement Plan Item";
                            QuotationLines."Budget Line":=RequisitionLines."Budget Line";
                            QuotationLines."Shortcut Dimension 1 Code":=RequisitionLines."Shortcut Dimension 1 Code";
                            QuotationLines.Validate("Shortcut Dimension 1 Code");
                            QuotationLines."Shortcut Dimension 2 Code":=RequisitionLines."Shortcut Dimension 2 Code";
                            QuotationLines.Validate("Shortcut Dimension 2 Code");
                            QuotationLines."Request Date":=RequisitionHeader."Requested Receipt Date";
                            QuotationLines."Expected Receipt Date":=RequisitionHeader."Expected Receipt Date";
                            QuotationLines.Committed:=RequisitionLines.Committed;
                            QuotationLines.Specification2:=RequisitionLines.Specification2;
                            QuotationLines."VAT Prod. Posting Group":=RequisitionLines."VAT Prod. Posting Group";
                            QuotationLines."VAT %":=RequisitionLines."VAT %";
                            QuotationLines."Unit Price":=RequisitionLines."Direct Unit Cost";
                            QuotationLines."Amount Inclusive VAT":=RequisitionLines."Amount Including VAT";
                            if not QuotationLines.Get(QuotationLines."Requisition No", QuotationLines."Line No")then QuotationLines.Insert(true);
                        until RequisitionLines.Next = 0;
                    end;
                    RequisitionHeader."Tender No.":="No.";
                    RequisitionHeader.Modify();
                end;
            end;
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
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Process Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI, "FA Disposal Quote";
        }
        field(10; "Procurement Plan Item"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan"."Plan Item No" WHERE("Plan Year"=FIELD("Procurement Plan No"));
        }
        field(11; Category; Code[20])
        {
            Caption = 'Supplier Code';
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";

            trigger OnValidate()
            var
                SuppCategory: Record "Supplier Category";
            begin
                SuppCategory.Reset();
                If SuppCategory.Get(Category)then "Category Description":=SuppCategory.Description;
            end;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(14; TenderOpeningDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Tender Status"; Option)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released, "Pending Approval", Approved, "Pending Prepayment", Rejected, Closed;
        }
        field(16; TenderClosingDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Addedum; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; SiteView; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Archived,Opening,Pending Approval,Approved,Rejected,Terminated';
            OptionMembers = New, Archived, Opening, "Pending Approval", Approved, Rejected, Terminated;
        }
        field(21; "Quotation Deadline"; Date)
        {
            Caption = 'Closing Date';
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
            Caption = 'Closing Time';
            DataClassification = ToBeClassified;
        }
        field(24; "Invited Suppliers"; Integer)
        {
            CalcFormula = Count("Supplier Selection" WHERE("Reference No."=FIELD("No."), Invited=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "E-Mail Body Text"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "E-Mail Subject"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Attachment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Specify Body"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Tender Type";Enum TenderTypes)
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
        field(32; "FA Disposal No."; code[20])
        {
            TableRelation = "FA Disposal" where(Status=const(Approved));

            trigger OnValidate()
            begin
                if FADisposal.Get("FA Disposal No.")then begin
                    Title:=FADisposal.Comments;
                    FADisposalLine.SetRange(FADisposalLine."Document No.", FADisposal."No.");
                    if FADisposalLine.FindSet(true, false)then begin
                        repeat QuotationLines.Init;
                            QuotationLines."Requisition No":="No.";
                            QuotationLines."Line No":=FADisposalLine."Line No.";
                            QuotationLines.Type:=QuotationLines.Type::"Fixed Asset";
                            QuotationLines.No:=FADisposalLine."FA No.";
                            QuotationLines.Description:=FADisposalLine.Description;
                            QuotationLines.Quantity:=1;
                            QuotationLines."FA Disposal Doc No.":="FA Disposal No.";
                            QuotationLines."Staff No.":="Staff No.";
                            QuotationLines."Staff Name":="Staff Name";
                            if not QuotationLines.Get("No.", QuotationLines."Line No")then QuotationLines.Insert(true)
                            else
                            begin
                                QuotationLines.Type:=QuotationLines.Type::"Fixed Asset";
                                QuotationLines.No:=FADisposalLine."FA No.";
                                QuotationLines.Description:=FADisposalLine.Description;
                                QuotationLines.Quantity:=1;
                                QuotationLines."FA Disposal Doc No.":="FA Disposal No.";
                                QuotationLines."Staff No.":="Staff No.";
                                QuotationLines."Staff Name":="Staff Name";
                                QuotationLines.Modify();
                            end;
                        until FADisposalLine.Next = 0;
                    end;
                end;
            end;
        }
        field(33; "Staff No."; Code[50])
        {
        }
        field(34; "Staff Name"; Text[100])
        {
        }
        field(35; "Committee Submission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Committee Submission Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Prospect No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Prospective Customers";

            trigger OnValidate()
            var
                Customer: Record "Prospective Customers";
            begin
                if Customer.Get("Customer No.")then "Customer Name":=Customer.Name;
            end;
        }
        field(38; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Customer No.")then "Customer Name":=Customer.Name;
            end;
        }
        field(40; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New, Existing, Staff;
        }
        field(41; "Reference No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(Employee)then "Customer Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(43; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Termination Reason"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(45; Terminated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Termination Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Termination Method";

            trigger OnValidate()
            var
                Terminations: Record "Procurement Termination Method";
            begin
                Terminations.Reset();
                Terminations.SetRange(Code, "Termination Code");
                if Terminations.FindFirst()then "Termination Reason":=Terminations.Description;
            end;
        }
        field(47; "EOI No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "EOI Evaluation Header" where(Stage=Const(Evaluation));

            // TableRelation = "EOI Evaluation Header" where(Status = Const(Approved), Stage = Const(Evaluation));
            trigger OnValidate()
            var
                EOI: Record "EOI Evaluation Header";
                Docs: Record "Document Required";
                ProcMeth: Record "Procurement Method";
                DocsRequired: Record "Document required";
                LineNo: Integer;
                ProcReq: Record "Procurement Request";
            begin
                EOI.Reset();
                if EOI.Get("EOI No.")then begin
                    "Requisition No":=EOI."Requisition No";
                    Title:=EOI.Title;
                    Validate("Requisition No");
                    //add RFP No.
                    // ModifyEOIDocuments(ProcMeth.Type::EOI, "No.", EOI."Quote No");
                    ProcReq.Reset();
                    If ProcReq.Get("EOI No.")then begin
                        "Reference No.":='RFP/' + Format(ProcReq."Ref No.");
                        Category:=ProcReq.Category;
                        "Category Description":=ProcReq."Category Description";
                        "Shortcut Dimension 1 Code":=ProcReq."Shortcut Dimension 1 Code";
                        "Shortcut Dimension 2 Code":=ProcReq."Shortcut Dimension 2 Code";
                    end;
                end;
            end;
        }
        field(48; "Category Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Addendum"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Stage; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New, Portal, Opening, Periliminary, Technical, Financial, Archived;
        }
        field(51; Analyzed; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(52; "Preliminary Analyzed"; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(53; "Evaluation Generatated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Portal Submission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55; Introdcution; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(56; Recommendation; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Opening Venue"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Submission Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = , "Electronic Submission", Written, Physical, Hardcopy;
        }
        field(59; "Financial Year"; Text[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Financial Year";
        }
        field(60; "Procurement Methods"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = , "Open Tenders", Restricted, "Direct Procurement", "Framework Contract/Agreement", "Prequalification", Registration, "Disposal Of Asset", "Alternative Selection", "Method for Consultancy";
        }
        field(61; AGPO; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = , Women, Youth, "PWD's";
        }
        field(62; "Eligible  bidders"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = , "MSME's", "AGPO", "Local Content (40%)", "Citizen Contractors";
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Title)
        {
        }
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        case "Process Type" of "Process Type"::RFQ: begin
            PurchSetup.TestField(PurchSetup."Quotation Nos");
            if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."Quotation Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Process Type"::RFP: begin
            PurchSetup.TestField(PurchSetup."RFP Nos.");
            if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."RFP Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Process Type"::Tender: begin
            PurchSetup.TestField(PurchSetup."Tender Nos.");
            if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."Tender Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            //Insert mandatory docs
            InsertProcurementDocuments("Process Type");
        end;
        "Process Type"::EOI: begin
            PurchSetup.TestField(PurchSetup."EOI Nos");
            if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."EOI Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Process Type"::"FA Disposal Quote": begin
            PurchSetup.TestField(PurchSetup."FA Disposal Quote Nos");
            if "No." = '' then NoSeriesMgt.InitSeries(PurchSetup."FA Disposal Quote Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        end;
        "Creation Date":=Today;
        "User ID":=UserId;
        if UserSetup.get(UserId)then begin
            UserSetup.TestField("Employee No.");
            "Staff No.":=UserSetup."Employee No.";
            if EmpRec.get("Staff No.")then "Staff Name":=EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
        end;
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    RequisitionLines: Record "Internal Request Line";
    RequisitionHeader: Record "Internal Request Header";
    QuotationLines: Record "Procurement Request Lines";
    LineNo: Integer;
    FADisposal: Record "FA Disposal";
    FADisposalLine: Record "FA Disposal Line";
    UserSetup: Record "User Setup";
    EmpRec: record Employee;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    procedure InsertProcurementDocuments(DocType: Integer)
    var
        Methods: Record "Procurement Method";
        Documents: Record "Procurement Document";
        DocsRequired: Record "Document required";
        LineNo: Integer;
    begin
        Methods.Reset();
        Methods.SetRange(Type, DocType);
        if Methods.FindFirst then begin
            Documents.Reset();
            Documents.SetRange(Type, Methods.Type);
            if Documents.Find('-')then repeat LineNo:=LineNo + 10000;
                    DocsRequired."Quote No":="No.";
                    DocsRequired."Line No":=LineNo;
                    DocsRequired."Document Code":=Documents."Document Code";
                    DocsRequired."Document Name":=Documents.Description;
                    DocsRequired.Mandatory:=Documents.Mandatory;
                    DocsRequired.Insert();
                until Documents.Next = 0;
        end;
    end;
    procedure ModifyEOIDocuments(DocType: Integer; RFQNo: Code[30]; QuoteNo: Code[20])
    var
        DocsRequired: Record "Document required";
        LineNo: Integer;
    begin
        DocsRequired.Reset();
        DocsRequired.SetRange("Quote No", QuoteNo);
        if DocsRequired.Find('-')then begin
            repeat DocsRequired."RFQ No.":=RFQNo;
                DocsRequired.Modify();
            until DocsRequired.Next() = 0;
        end;
    end;
}

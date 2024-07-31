tableextension 50134 PurchInvLineExt extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; Supplier; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.Get(Supplier)then "Supplier Name":=Vend.Name;
            end;
        }
        field(50001; "Supplier Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Encumberd; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Committment; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; Specification2; Blob)
        {
            Caption = 'Specifications';
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(52000; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54000; "Transaction Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*IF TransCode.GET("Transaction Code") THEN BEGIN
                  VALIDATE(Type,TransCode.Type);
                  "No.":=TransCode."No.";
                
                END;
                */
            end;
        }
        field(54002; "Quantity In Stock"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No."=FIELD("No."), "Location Code"=FIELD("Location Code")));
            Caption = 'Quantity In Stock';
            DecimalPlaces = 0: 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(54003; "Location Narration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54004; "VOrder No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type"=CONST(Order), "Buy-from Vendor No."=FIELD(Supplier), Status=CONST(Open));
        }
        field(54005; "Requested For"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54006; "Staff Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54007; "Budgeted Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54008; "Internal Control No."; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(54009; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54010; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54011; "Last Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54012; "Last Modified By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54013; "Needed By Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54014; "Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54015; "Requisition Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54016; Priority; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54017; "Requisition Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Purchase, Internal;
        }
        field(54018; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Approval Pending,Transfer Budget Pending,Approved,Disapproved,Committed,Fulfilled,Canceled';
            OptionMembers = New, "Approval Pending", "Transfer Budget Pending", Approved, Disapproved, Committed, Fulfilled, Canceled;
        }
        field(54019; "Previous Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Approval Pending,Transfer Budget Pending,Approved,Disapproved,Committed,Fulfilled,Canceled';
            OptionMembers = New, "Approval Pending", "Transfer Budget Pending", Approved, Disapproved, Committed, Fulfilled, Canceled;
        }
        field(54020; "Source Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54021; "Procurement Plan"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(54022; "Procurement Plan Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan"."Plan Item No" WHERE("Plan Year"=FIELD("Procurement Plan"), "Shortcut Dimension 1 Code"=FIELD("Shortcut Dimension 1 Code"), "Shortcut Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code"));

            trigger OnValidate()
            begin
            /*IF ProcurementPlan.GET("Procurement Plan","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Procurement Plan Item") THEN
                BEGIN
                IF ProcurementPlan."Procurement Type"=ProcurementPlan."Procurement Type"::Goods THEN
                BEGIN
                 Type:=Type::Item;
                  "No.":=ProcurementPlan."No.";
                END;
                IF ProcurementPlan."Procurement Type"<>ProcurementPlan."Procurement Type"::Goods THEN
                BEGIN
                 Type:=Type::"G/L Account";
                 "No.":=ProcurementPlan."Source of Funds";
                END;
                  "Budget Line":=ProcurementPlan."Source of Funds";
                   Description:=ProcurementPlan."Item Description";
                  "Unit of Measure":=ProcurementPlan."Unit of Measure";
                  "Unit Cost":=ProcurementPlan."Unit Price";
                  "Direct Unit Cost":=ProcurementPlan."Unit Price";

                END;*/
            end;
        }
        field(54023; "Budget Line"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54024; "Approved Budget Amount"; Decimal)
        {
            CalcFormula = Sum("Procurement Plan"."Estimated Cost" WHERE("No."=FIELD("No."), "Plan Year"=FIELD("Procurement Plan"), "Shortcut Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code"), "Plan Item No"=FIELD("Procurement Plan Item")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(54025; "Commitment Amount"; Decimal)
        {
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(Account=FIELD("Budget Line"), "Global Dimension 1"=FIELD("Shortcut Dimension 1 Code"), "Global Dimension 2"=FIELD("Shortcut Dimension 2 Code"), "Commitment Type"=FILTER(Commitment|"Commitment Reversal")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(54026; "Actual Expense"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("Budget Line"), "Global Dimension 1 Code"=FIELD("Shortcut Dimension 1 Code"), "Global Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(54027; "Available amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(54028; "Requisitions No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54029; "Item G/L Budget Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54030; Specifications; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(54031; "Vendor Invoice No."; Code[35])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("No."=FIELD("Document No.")));
            Caption = 'Vendor Invoice No.';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

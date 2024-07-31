tableextension 50110 PurchasesPayablesExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50001; "Effective Procurement Plan"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name;
        }
        field(50003; "Appointment Nos."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50100; "Default Requisition Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = item;
        }
        field(50004; "Daily Tax Exempt Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Inspection Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50008; "RFQ Path"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(54001; "RFQ Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54002; "RFP Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54003; "Tender Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54004; "Prequalification Resp. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54005; "RFQ Resp. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54006; "RFP Resp. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54007; "Tender Resp. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54008; "Store Req. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54009; "Purchase Req. Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54010; "Vendor App. Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54011; "Committe Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54012; "Payroll Vendor Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54013; "Update Cost From Item Card"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54014; "Store Return Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54015; "Staff Req Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54016; "Default Staff Req. G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54017; "EOI Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54018; "Supplier Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54019; "Supplier Evaluation Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54020; "Vendor Evaluation Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54021; "Inspection Committee Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54022; "Order Inspection Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54023; "Termination Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60000; "Admin Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Quotation Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60002; "Max Open Documents"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Store Transfer Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60004; "Item Transfer Journal Template"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template".Name;
        }
        field(60005; "Item Transfer Journal Batch"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name"=FIELD("Item Transfer Journal Template"));
        }
        field(60006; "Rounding Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Up,Nearest,Down';
            OptionMembers = Up, Nearest, Down;
        }
        field(60007; "Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60008; "Proc Plan Inclusive VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Prospective Suppliers Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60010; "Supplier Category Nos"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60011; "Procurement Documents Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60012; "Default Vendor Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(60013; "Def Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
            end;
        }
        field(60014; "Def VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }
        field(60015; "Procurement Plan Item Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(60016; "FA Disposal Quote Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(60017; "Order Due Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(60018; "Acknowledgement Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60019; "Procurement Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60020; "Stores Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60021; "Prospective Customer Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60022; "Annual Asset Disposal Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60023; "Notification Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60024; "Asset Manager Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60025; "Fuel Balance Transfer Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60026; "Def VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Product. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(60027; "Facilities Mgmt Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60028; "GPR Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60029; "Project Mgt Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60031; "Contract Mgt Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60030; "Task Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60032; "Shortlisted Suppliers"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60033; "RFP Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60034; "Technical Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60035; "Financial Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60036; "LPO Creation Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(60037; "Contract Verification Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(60038; "Send Requisition Notifications"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60039; "REquisition File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60040; "Send Re-Order Notifications"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60041; "Re-order Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60042; "Contract Extension No.s"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60043; "Contract Notification Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(60044; "Notify Committee Members"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60045; "Comittee File Path"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(60046; "Procurement Req. Change No.s"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60047; "Committee File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60048; "Def Gen. Prod Posting"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60049; "GRN Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'GRN Nos';
            TableRelation = "No. Series";
        }
    }
}

pageextension 50102 PurchasesAndPayablesExt extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Rounding Type"; Rec."Rounding Type")
            {
                ApplicationArea = All;
            }
            field("Rounding Precision"; Rec."Rounding Precision")
            {
                ApplicationArea = All;
            }
            field("Effective Procurement Plan"; Rec."Effective Procurement Plan")
            {
                ApplicationArea = All;
            }
            field("Max Open Documents"; Rec."Max Open Documents")
            {
                ApplicationArea = All;
            }
            field("Default Requisition Item No."; Rec."Default Requisition Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Requisition Item No. field.', Comment = '%';
            }
            field("Procurement Documents Path"; Rec."Procurement Documents Path")
            {
                ApplicationArea = All;
            }
            field("Notify Committee Members"; Rec."Notify Committee Members")
            {
                ApplicationArea = all;
            }
            field("Comittee File Path"; Rec."Comittee File Path")
            {
                ApplicationArea = All;
            }
            field("Procurement Req. Change No.s"; Rec."Procurement Req. Change No.s")
            {
                ApplicationArea = all;
            }
            field("Default Vendor Posting Group"; Rec."Default Vendor Posting Group")
            {
                ApplicationArea = All;
            }
            field("Def Gen. Bus. Posting Group"; Rec."Def Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Def VAT Bus. Posting Group"; Rec."Def VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Def VAT Prod. Posting Group"; Rec."Def VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Proc Plan Inclusive VAT"; Rec."Proc Plan Inclusive VAT")
            {
                ApplicationArea = All;
            }
            field("Order Due Days"; Rec."Order Due Days")
            {
                ApplicationArea = All;
            }
            field("Financial Percentage"; Rec."Financial Percentage")
            {
                Caption = 'RFP Financial (%)';
                ApplicationArea = All;
            }
            field("Technical Percentage"; Rec."Technical Percentage")
            {
                Caption = 'RFP Technical (%)';
                ToolTip = 'Specifies the value of the RFP Technical Percentage field.';
                ApplicationArea = All;
            }
            field("LPO Creation Duration"; Rec."LPO Creation Duration")
            {
                ToolTip = 'Specifies the value of the LPO Creation Duration field.';
                ApplicationArea = All;
            }
            field("Contract Verification Duration"; Rec."Contract Verification Duration")
            {
                ToolTip = 'Specifies the value of the Contract Verification Duration field.';
                ApplicationArea = All;
            }
            field("Def Gen. Prod Posting"; Rec."Def Gen. Prod Posting")
            {
                ApplicationArea = All;
            }
        }
        addlast("Number Series")
        {
            field("Purchase Req. Nos"; Rec."Purchase Req. Nos")
            {
                ApplicationArea = All;
            }
            field("Store Req. Nos."; Rec."Store Req. Nos.")
            {
                ApplicationArea = All;
            }
            field("Project Mgt Nos"; Rec."Project Mgt Nos")
            {
                ToolTip = 'Specifies the value of the Project Mgt Nos field.';
                ApplicationArea = All;
            }
            field("Contract Mgt Nos"; Rec."Contract Mgt Nos")
            {
                ToolTip = 'Specifies the value of the Contract Mgt Nos field.';
                ApplicationArea = All;
            }
            field("Order Nos"; Rec."Order Nos.")
            {
                Caption = 'Order Nos.';
                ToolTip = 'Specifies the value of the Order Nos. field.';
                ApplicationArea = All;
            }
            // field("Contract Management Nos"; Rec."Project Mgt Nos")
            // {
            //     ToolTip = 'Specifies the value of the Project Mgt Nos field.';
            //     ApplicationArea = All;
            // }
            field("Task Nos"; Rec."Task Nos")
            {
                ToolTip = 'Specifies the value of the Task Nos field.';
                ApplicationArea = All;
            }
            field("Store Transfer Nos"; Rec."Store Transfer Nos")
            {
                ApplicationArea = All;
            }
            field("GPR Nos"; Rec."GPR Nos")
            {
                ToolTip = 'Specifies the value of the GPR Nos field.';
                ApplicationArea = All;
            }
            field("Facilities Mgmt Nos"; Rec."Facilities Mgmt Nos")
            {
                ToolTip = 'Specifies the value of the Facilities Mgmt Nos field.';
                ApplicationArea = All;
            }
            field("Quotation Nos"; Rec."Quotation Nos")
            {
                ApplicationArea = All;
            }
            field("RFQ Nos."; Rec."RFQ Nos.")
            {
                ApplicationArea = All;
            }
            field("RFP Nos."; Rec."RFP Nos.")
            {
                ApplicationArea = All;
            }
            field("RFQ Path"; Rec."RFQ Path")
            {
                Caption = 'Documents Path';
                ApplicationArea = All;
            }
            field("EOI Nos"; Rec."EOI Nos")
            {
                ApplicationArea = All;
            }
            field("Tender Nos."; Rec."Tender Nos.")
            {
                ApplicationArea = All;
            }
            field("Termination Nos."; Rec."Termination Nos.")
            {
                ApplicationArea = All;
            }
            field("Supplier Nos"; Rec."Supplier Nos")
            {
                ApplicationArea = All;
            }
            field("Supplier Evaluation Nos"; Rec."Supplier Evaluation Nos")
            {
                ApplicationArea = All;
            }
            field("Vendor Evaluation Nos"; Rec."Vendor Evaluation Nos")
            {
                ApplicationArea = All;
            }
            field("Prospective Suppliers Nos"; Rec."Prospective Suppliers Nos")
            {
                ApplicationArea = All;
            }
            field("Prospective Customer Nos"; Rec."Prospective Customer Nos")
            {
                ApplicationArea = All;
            }
            field("Committe Nos"; Rec."Committe Nos")
            {
                ApplicationArea = All;
            }
            field("Inspection Committee Nos"; Rec."Inspection Committee Nos")
            {
                ApplicationArea = All;
            }
            field("Order Inspection Nos"; Rec."Order Inspection Nos")
            {
                ApplicationArea = All;
            }
            field("Supplier Category Nos"; Rec."Supplier Category Nos")
            {
                ApplicationArea = All;
            }
            field("Procurement Plan Item Nos"; Rec."Procurement Plan Item Nos")
            {
                ApplicationArea = All;
            }
            field("FA Disposal Quote Nos"; Rec."FA Disposal Quote Nos")
            {
                ApplicationArea = All;
            }
            field("Annual Asset Disposal Nos"; Rec."Annual Asset Disposal Nos")
            {
                ApplicationArea = All;
            }
            field("Acknowledgement Nos"; Rec."Acknowledgement Nos")
            {
                ApplicationArea = All;
            }
            field("Fuel Balance Transfer Nos"; Rec."Fuel Balance Transfer Nos")
            {
                ApplicationArea = All;
            }
            field("Contract Extension No.s"; Rec."Contract Extension No.s")
            {
                ApplicationArea = all;
            }
            field("GRN Nos"; Rec."GRN Nos")
            {
                ApplicationArea = All;
            }
        }
        addafter("Number Series")
        {
            group(Communication)
            {
                field("Procurement Email"; Rec."Procurement Email")
                {
                    ApplicationArea = All;
                }
                field("Stores Email"; Rec."Stores Email")
                {
                    ApplicationArea = All;
                }
                field("Notification Mileage"; Rec."Notification Mileage")
                {
                    ApplicationArea = All;
                }
                field("Asset Manager Email"; Rec."Asset Manager Email")
                {
                    ApplicationArea = All;
                }
                field("Send Requisition Notifications"; Rec."Send Requisition Notifications")
                {
                    ApplicationArea = all;
                }
                field("Send Re-Order Notifications"; Rec."Send Re-Order Notifications")
                {
                    ApplicationArea = all;
                }
                field("REquisition File Path"; Rec."REquisition File Path")
                {
                    ApplicationArea = all;
                }
                field("Re-order Path"; Rec."Re-order Path")
                {
                    ApplicationArea = all;
                }
                field("Contract Notification Period"; Rec."Contract Notification Period")
                {
                    ApplicationArea = all;
                }
                field("Committee File Path"; Rec."Committee File Path")
                {
                    ApplicationArea = All;
                    Caption = 'Committee notification file path';
                }
            }
        }
    }
}

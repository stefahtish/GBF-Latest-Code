page 51267 "Procurement Management Cues"
{
    Caption = 'Supply Chain Management';
    PageType = CardPart;
    SourceTable = "Procurement Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Purchases)
            {
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                }
                field("Purchase Invoice"; Rec."Purchase Invoice")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Invoices";
                }
                field("Purchase Quotes"; Rec."Purchase Quotes")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Quotes";
                }
                field("Purchase request list"; Rec."Purchase request list")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Request List";
                }
                field("Purchase request list Approved"; Rec."Purchase request list Approved")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Request Approved";
                }
                field("Purchase return order"; Rec."Purchase return order")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Return Order List";
                }
                field("Blanket Purchase order"; Rec."Blanket Purchase order")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Purchase Orders";
                }
                field("Purchase Credit Memo"; Rec."Purchase Credit Memo")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Credit Memos";
                }
                field("Store Requests"; Rec."Store Requests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Store Request List";
                }
                field("Open Store Requests"; Rec."Open Store Requests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Store Request List";
                }
                field("Approved Store Requests"; Rec."Approved Store Requests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Approved Store Request";
                }
                field("Request for Quote & Order"; Rec."Request for Quote & Order")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Request for Quote & Order";
                }
                field("Procurement Plans"; Rec."Procurement Plans")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Procurement Plans";
                }
            }
            cuegroup("Procurement Methods")
            {
                field("Open Tenders"; Rec."Open Tenders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = Tenders;
                }
                field("Restricted Tenders"; Rec."Restricted Tenders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Tenders";
                }
                field("Prospective Suppliers"; Rec."Prospective Suppliers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Prospective Supplier List";
                }
                field("Prequalified Suppliers"; Rec."Prequalified Suppliers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Prequalified Suppliers";
                }
                field(EOI; Rec.EOI)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "EOI List";
                }
                field("EOI under Evaluation"; Rec."EOI under Evaluation")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "EOI Evaluation List";
                }
                field("Request For Proposal"; Rec."Request For Proposal")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "RFP List";
                }
                field("RFP Evaluation List"; Rec."RFP Evaluation List")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "RFP Evaluation List";
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Approval Request Entries";
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID Filter", UserId);
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

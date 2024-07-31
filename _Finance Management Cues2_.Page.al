page 51260 "Finance Management Cues2"
{
    Caption = 'Finance Management Cues';
    PageType = CardPart;
    SourceTable = "Finance Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Receivables")
            {
                field(Customers; Rec.Customers)
                {
                    ApplicationArea = All;
                }
                field("Sales Invoices"; Rec."Sales Invoices")
                {
                    ApplicationArea = All;
                }
                field("Posted Sales Invoices"; Rec."Posted Sales Invoices")
                {
                    ApplicationArea = All;
                }
            }
            cuegroup(Payables)
            {
                field(Vendors; Rec.Vendors)
                {
                    ApplicationArea = All;
                }
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoices"; Rec."Purchase Invoices")
                {
                    ApplicationArea = All;
                }
                field("Posted Purchase Invoices"; Rec."Posted Purchase Invoices")
                {
                    ApplicationArea = All;
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
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

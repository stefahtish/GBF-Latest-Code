page 51407 "RFP Supplier Selection"
{
    PageType = List;
    SourceTable = "RFP Supplier Selection";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Code"; Rec."Supplier Code")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(City; Rec.City)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field(County; Rec.County)
                {
                }
                field("Supplier Email"; Rec."Supplier Email")
                {
                }
                field(Invited; Rec.Invited)
                {
                    Caption = 'Invite';
                }
                field(Notified; Rec.Notified)
                {
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            // group("Supplier Selection")
            // {
            //     Caption = 'Supplier Selection';
            //     action("Generate Quote Evaluation")
            //     {
            //         Caption = 'Generate Quote Evaluation';
            //         Image = CreatePutAway;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         Visible = false;
            //         trigger OnAction()
            //         var
            //             SupplierSelection: Record "Supplier Selection";
            //         begin
            //             SupplierSelection.SetRange(SupplierSelection.Invited, true);
            //             SupplierSelection.SetRange(SupplierSelection."Reference No.", "Reference No.");
            //             if SupplierSelection.FindFirst then begin
            //                 repeat
            //                 //SupplierSelection.CreateQuoteEvaluation(SupplierSelection);
            //                 until SupplierSelection.Next = 0;
            //             end;
            //             SupplierSelection.SetRange(Invited);
            //         end;
            //     }
            // }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Invited := true;
    end;
}

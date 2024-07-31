page 50762 "Supplier Selection"
{
    PageType = List;
    SourceTable = "Supplier Selection";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Code"; Rec."Supplier Code")
                {
                    // ToolTip = 'Specifies the value of the Supplier Code field';
                    // ApplicationArea = All;
                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     Prequest: Record "Procurement Request";
                    //     PrequestLines: record "Procurement Request categories";
                    //     PreqCodes: Record "Prequalified Supplier Codes";
                    //     PreqList: page "Prospective Supplier List";
                    //     Prospectives: Record "Prospective Suppliers";
                    // begin
                    //     if Prequest."Process Type" = Prequest."Process Type"::Tender then begin
                    //         PrequestLines.Reset();
                    //         PrequestLines.SetRange("No.", "Reference No.");
                    //         if PrequestLines.FindSet() then;
                    //         PreqCodes.Reset();
                    //         PreqCodes.SetRange("Category Code", PrequestLines.Category);
                    //         if PreqCodes.FindSet() then;
                    //         Prospectives.Reset();
                    //         Prospectives.SetRange("Vendor No", PreqCodes.Vendor);
                    //         if Prospectives.FindSet() then;
                    //         PreqList.SetTableView(Prospectives);
                    //         PreqList.SetRecord(Prospectives);
                    //         PreqList.LookupMode := true;
                    //         if ACTION::LookupOK = PreqList.RunModal() then begin
                    //             PreqList.GetRecord(Prospectives);
                    //             "Supplier Code" := Prospectives."No.";
                    //             Validate("Supplier Code");
                    //         end;
                    //     end;
                    // end;
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

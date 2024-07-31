page 50747 "Bidders Selection"
{
    PageType = Card;
    SourceTable = "Bidders Selection";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Supplier; Rec.Supplier)
                {
                    Caption = 'Supplier Code';
                    ToolTip = 'Specifies the value of the Supplier field.';
                    ApplicationArea = All;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = all;
                }
                field("Supplier Email"; Rec."Supplier Email")
                {
                    ApplicationArea = all;
                }
                field(Invited; Rec.Invited)
                {
                    ApplicationArea = all;
                    Caption = 'Invite';
                }
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = all;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Supplier Selection")
            {
                Caption = 'Supplier Selection';

                action("Generate Quote Evaluation")
                {
                    Caption = 'Generate Quote Evaluation';
                    Image = CreatePutAway;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Supplier Selection";
                    begin
                        SupplierSelection.SetRange(SupplierSelection.Invited, true);
                        SupplierSelection.SetRange(SupplierSelection."Reference No.", Rec."Reference No.");
                        if SupplierSelection.FindFirst then begin
                            repeat //SupplierSelection.CreateQuoteEvaluation(SupplierSelection);
                            until SupplierSelection.Next = 0;
                        end;
                        SupplierSelection.SetRange(Invited);
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Invited := true;
    end;
}

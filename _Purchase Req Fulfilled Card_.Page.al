page 51153 "Purchase Req Fulfilled Card"
{
    DeleteAllowed = false;
    Caption = 'Purchase Request Fulfilled';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Purchase));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Supplier category"; Rec."Supplier category")
                {
                    Editable = false;
                    Caption = 'Supply code';
                    ApplicationArea = All;
                }
                field("Supplier category Description"; Rec."Supplier category Description")
                {
                    Caption = 'Supply code description';
                    Editable = false;
                    //Enabled = false;
                }
                field("Supplier Subcategory"; Rec."Supplier Subcategory")
                {
                    Editable = false;
                    Caption = 'Supply subcode';
                    ApplicationArea = All;
                }
                field("Supplier Subcategory Desc"; Rec."Supplier Subcategory Desc")
                {
                    Caption = 'Supply subcode description';
                    Editable = false;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Caption = 'Reason/Description';
                    Editable = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field("Type of Supplier"; Rec."Type of Supplier")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                }
                field("Combine Order"; Rec."Combine Order")
                {
                    Caption = 'Combine Quote';
                    Visible = false;
                }
                group(Control22)
                {
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Editable = false;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                }
                field("Rejection Comment"; Rec."Rejection Comment")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            part(PurchaseRequestSubform; "Purchase Request Subform")
            {
                Caption = 'Purchase Request Subform';
                SubPageLink = "Document No." = FIELD("No."), "Procurement Plan" = FIELD("Procurement Plan"), "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code");
                Editable = false;
            }
        }
        area(factboxes)
        {
            systempart(Control12; Links)
            {
            }
            systempart(Control35; Notes)
            {
            }
            systempart(Control16; MyNotes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Print)
            {
                Caption = 'Print Requisition';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Released;

                trigger OnAction()
                begin
                    PurchReq.Reset;
                    PurchReq.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Purchase Request", true, true, PurchReq);
                end;
            }
            action(Reports)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Caption = 'Inspection Report';
                Image = Report;

                trigger OnAction()
                begin
                    PurchaseHeaderRec.Reset();
                    PurchaseHeaderRec.SetFilter("No.", Rec."No.");
                    AcceptanceInspection.SetTableView(PurchaseHeaderRec);
                    AcceptanceInspection.Run();
                end;
            }
        }
    }
    var
        PurchReq: Record "Internal Request Header";
        PurchaseHeaderRec: Record "Purchase Header";
        AcceptanceInspection: Report "Inspection & Acceptance Report";
}

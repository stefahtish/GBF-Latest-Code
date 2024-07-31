page 50321 "Acknowledgement Header"
{
    Caption = 'Acknowledgement Header';
    PageType = Card;
    SourceTable = "Acknowledgement Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            part("Acknowledgement Lines"; "Acknowledgement Lines")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Submitted")
            {
                Caption = '&Submit';
                Ellipsis = true;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                Visible = not Rec.Acknowledged;

                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                begin
                    Rec.Acknowledged := true;
                    Message('You have successfully acknowledged the receipt of the items');
                    PurchHeader.Reset();
                    PurchHeader.SetRange("No.", Rec."Order No");
                    if PurchHeader.FindFirst() then begin
                        PurchHeader.Acknowledged := true;
                        PurchHeader.Modify();
                    end;
                end;
            }
        }
    }
}

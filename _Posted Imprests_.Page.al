page 50135 "Posted Imprests"
{
    CardPageID = "Approved/Post Imprest Card";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST(Imprest), Status = CONST(Released), Posted = CONST(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = all;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = all;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = all;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = all;
                    Caption = 'User Remarks';
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = all;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                }
                field(Surrendered; Rec.Surrendered)
                {
                    ApplicationArea = all;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = all;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = all;
                }
                field("Imprest Posted by PV"; Rec."Imprest Posted by PV")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
            }
            systempart(Control13; MyNotes)
            {
            }
            systempart(Control14; Links)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Navigate)
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec.Modify(true);
    end;
}

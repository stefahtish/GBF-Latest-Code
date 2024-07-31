page 50159 "Posted InterBank Transfer"
{
    CardPageID = "App/Posted InterBank Transfer";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Bank Transfer"), Status = CONST(Released), Posted = CONST(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                }
                field(Status; DocStatus)
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
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
            part("FactBox"; "Payments FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
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
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnOpenPage()
    begin
        //DocStatus:=FormatStatus(Status);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
}

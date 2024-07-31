page 50129 "Approved Petty Cash Surrenders"
{
    CardPageID = "Approved Petty Cash Surrender";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Petty Cash Surrender"), Status = CONST(Released), Posted = CONST(false));
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
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                }
                field("Actual Petty Cash Amount Spent"; Rec."Actual Petty Cash Amount Spent")
                {
                }
                field("Staff No."; Rec."Staff No.")
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
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        DocStatus := Rec.FormatStatus(Rec.Status);
    end;

    trigger OnOpenPage()
    begin
        // DocStatus:=FormatStatus(Status);
        // IF UserSetup.GET(USERID) THEN
        //  BEGIN
        //    IF UserSetup."Show All"=FALSE THEN
        //      SETRANGE("Created By",USERID);
        //  END;
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        UserSetup: Record "User Setup";
}

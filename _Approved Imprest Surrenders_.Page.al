page 50140 "Approved Imprest Surrenders"
{
    CardPageID = "Approved/Post Imp Surr. Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Imprest Surrender"), Status = CONST(Released), Posted = CONST(false));
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
                field("Pay Mode"; Rec."Pay Mode")
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
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = all;
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = all;
                }
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
                {
                    ApplicationArea = all;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = all;
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
        //DocStatus:=FormatStatus(Status);
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

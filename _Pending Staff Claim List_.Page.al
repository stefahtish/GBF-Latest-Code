page 50251 "Pending Staff Claim List"
{
    CardPageID = "Approved/Post Staff Claim Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Staff Claim"), Status = FILTER("Pending Approval"), Posted = CONST(false));
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
                    Caption = 'Purpose';
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Staff Claim Amount';
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
    }
    trigger OnAfterGetRecord()
    begin
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnOpenPage()
    begin
        // IF UserSetup.GET(USERID) THEN
        //  BEGIN
        //    IF NOT UserSetup."Show All" THEN
        //      BEGIN
        //        FILTERGROUP(2);
        //        SETRANGE("Created By",USERID);
        //      END;
        //  END ELSE
        //    ERROR('%1 does not exist in the Users Setup',USERID);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        UserSetup: Record "User Setup";
}

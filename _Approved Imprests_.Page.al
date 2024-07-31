page 50134 "Approved Imprests"
{
    CardPageID = "Approved/Post Imprest Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST(Imprest), Status = CONST(Released), Posted = CONST(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = basic, suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = basic, suite;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = basic, suite;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = basic, suite;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = basic, suite;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'User Remarks';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = basic, suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = basic, suite;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = basic, suite;
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = basic, suite;
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
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        
        Rec.Modify();
        // DocStatus:=FormatStatus(Status);
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
        IsRecordEditable: Boolean;
}

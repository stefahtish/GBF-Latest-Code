page 50769 "RFQ List"
{
    CardPageID = RFQ;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(RFQ));
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
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field("Requested By"; Rec."Requested By")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control14; Links)
            {
            }
            systempart(Control13; Notes)
            {
            }
            systempart(Control12; MyNotes)
            {
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        // DocStatus:=PaymentsRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnOpenPage()
    begin
        //DocStatus:=PaymentsRec.FormatStatus(Status);
        //SETRANGE("Requested By",USERID);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved",Released,Fulfilled;
        PaymentsRec: Record "Internal Request Header";
        UserSetup: Record "User Setup";
}

page 50254 "Pending Purchase Request List"
{
    CardPageID = "Purchase Request Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Purchase), "Fully Ordered" = CONST(false), Status = FILTER("Pending Approval"));
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
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control14; Links)
            {
            }
            part("FactBox"; "Requests FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
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
        //DocStatus:=PaymentsRec.FormatStatus(Status);//NOT (UserSetup."Show All") OR
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Requested By", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved",Released,Fulfilled;
        PaymentsRec: Record "Internal Request Header";
        UserSetup: Record "User Setup";
}

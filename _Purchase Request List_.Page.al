page 50160 "Purchase Request List"
{
    CardPageID = "Purchase Request";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Purchase), "Fully Ordered" = CONST(false), Status = FILTER(Open));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = basic, Suite;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = basic, Suite;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    ApplicationArea = basic, Suite;
                    Enabled = false;
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

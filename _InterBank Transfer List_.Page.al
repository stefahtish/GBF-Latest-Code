page 50156 "InterBank Transfer List"
{
    CardPageID = "InterBank Transfer";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Bank Transfer"), Status = FILTER(Open), Posted = CONST(false));
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
                field("Source Bank"; Rec."Source Bank")
                {
                }
                field("Source Bank Amount"; Rec."Source Bank Amount")
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
                }
            }
        }
        area(factboxes)
        {
            part("Document Attachment"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No."), "Table ID" = const(50121);
            }
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
        // SetRange("Created By", UserId);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        UserSetup: Record "User Setup";
}

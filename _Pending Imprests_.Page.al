page 50201 "Pending Imprests"
{
    CardPageID = "Approved/Post Imprest Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST(Imprest), Status = FILTER("Pending Approval"), Posted = CONST(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
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
            part(Control26; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(50000), "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control25; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(50000), "Document No." = FIELD("No.");
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = NOT IsOfficeAddin;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control17; Links)
            {
            }
            part("FactBox"; "Payments FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control16; Notes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("View Approval Entries")
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        // DocStatus:=FormatStatus(Status);
    end;

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Created By", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        UserSetup: Record "User Setup";
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        JobQueuesUsed: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        CreateIncomingDocumentVisible: Boolean;
        CreateIncomingDocFromEmailAttachment: Boolean;
        IncomingDocEmailAttachmentEnabled: Boolean;
        UserPersonalization: Record "User Personalization";
}

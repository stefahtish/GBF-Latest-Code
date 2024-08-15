page 50136 Imprests
{
    ApplicationArea = None;
    CardPageID = Imprest;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST(Imprest), Status = FILTER(Open | "Pending Approval"), Posted = CONST(false));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Staff No."; Rec."Staff No.")
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
                    Caption = 'User Remarks';
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
                field("Imprest Amount"; Rec."Imprest Amount")
                {
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
                Visible = false;
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
            systempart(Control16; Notes)
            {
            }
        }
    }
    actions
    {
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

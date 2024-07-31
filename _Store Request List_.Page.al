page 50748 "Store Request List"
{
    CardPageID = "Store Request";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Stock), Status = FILTER(Open | "Pending Approval"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting date';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Requested By"; Rec."Requested By")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Reason Description"; Rec."Reason Description")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Collected By ID No."; Rec."Collected By ID No.")
                {
                }
                field("Collected By"; Rec."Collected By")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control20; Links)
            {
            }
            systempart(Control17; Notes)
            {
            }
            systempart(Control5; MyNotes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                    IF Posted THEN
                      ERROR(Text001)
                    ELSE
                    */
                    ProcurementManager.PostInternalRequest(Rec);
                end;
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*IF ApprovalsMgmt.CheckIntReqApprovalPossible(Rec) THEN
                          ApprovalsMgmt.OnSendIntReqDocForApproval(Rec);
                        */
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                ToolTip = 'Cancel the approval request.';
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // ApprovalsMgmt.OnCancelIntReqApprovalRequest(Rec);
                end;
            }
            action("Create Purchase Request")
            {
                Caption = 'Create Purchase Request';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                    //DocManager.CreatePurchaseRequest(Rec);
                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    /*ApprovalEntries.Setfilters(DATABASE::"Internal Request Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    IR.Reset;
                    IR.SetRange("No.", Rec."No.");
                    REPORT.Run(39005475, true, true, IR);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
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
        ProcurementManager: Codeunit "Procurement Management";
        Text001: Label 'IR has already been posted';
        IR: Record "Internal Request Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RequestLines: Record "Internal Request Line";
        UserSetup: Record "User Setup";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;

    local procedure testDimensions(DimId: Integer)
    begin
        case DimId of
            1:
                begin
                    RequestLines.Reset;
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 1 Code");
                        until RequestLines.Next = 0;
                end;
            2:
                begin
                    RequestLines.Reset;
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 3 Code");
                        until RequestLines.Next = 0;
                end;
            3:
                begin
                    RequestLines.Reset;
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 3 Code");
                        until RequestLines.Next = 0;
                end;
        end;
    end;
}

page 51330 "Activity Work Program"
{
    Caption = 'Activity WorkPlan';
    PageType = Card;
    SourceTable = "Activity Work Programme";
    PromotedActionCategories = 'New,Process,Report,Approvals';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                group("category 1")
                {
                    // showcaption = false;
                    field("No."; Rec."No.")
                    {
                        ToolTip = 'Specifies the value of the No. field';
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field(Description; Rec.Description)
                    {
                        ToolTip = 'Specifies the value of the Description field';
                        ApplicationArea = All;
                    }
                    field(Objective; Rec.Objective)
                    {
                        ToolTip = 'Specifies the value of the Objective field';
                        ApplicationArea = All;
                    }
                    field("Workplan No."; Rec."Workplan No.")
                    {
                        ToolTip = 'Specifies the value of the Workplan No. field';
                        ApplicationArea = All;
                    }
                    field("Workplan Description"; Rec."Workplan Description")
                    {
                        ToolTip = 'Specifies the value of the Workplan Description field';
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field("Criteria Code"; Rec."Criteria Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Criteria Description"; Rec."Criteria Description")
                    {
                        ApplicationArea = All;
                    }
                    field("Perfomance Indicator Code"; Rec."Perfomance Indicator Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Indicator Description"; Rec."Indicator Description")
                    {
                        ApplicationArea = All;
                    }
                    field("Shortcut Dimension 3 Code"; ShortcutDimCode[3])
                    {
                        ApplicationArea = All;
                        ShowCaption = true;
                        Caption = 'Activity Budget Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));

                        trigger Onvalidate()
                        begin
                            Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        end;
                    }
                }
                group("category 2")
                {
                    showcaption = false;

                    field("Activity Code"; Rec."Activity Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Activity Description"; Rec."Activity Description")
                    {
                        ApplicationArea = All;
                    }
                    field("Activity Start Date"; Rec."Activity Start Date")
                    {
                        ToolTip = 'Specifies the value of the Activity Start Date field';
                        ApplicationArea = All;
                    }
                    field("Activity End Date"; Rec."Activity End Date")
                    {
                        ToolTip = 'Specifies the value of the Activity End Date field';
                        ApplicationArea = All;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Document Date"; Rec."Document Date")
                    {
                        ToolTip = 'Specifies the value of the Document Date field';
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field';
                        ApplicationArea = All;
                    }
                    field("Total Amount"; Rec."Total Amount")
                    {
                        ApplicationArea = All;
                    }
                    field("Created By"; Rec."Created By")
                    {
                        ApplicationArea = All;
                    }
                    field("Purchase Requisition No."; Rec."Purchase Requisition No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(Items; "Work Programme Items")
            {
                SubPageLink = "No." = field("No."), Type = const(Items);
                UpdatePropagation = Both;
            }
            part(Facilitators; "Facilitators")
            {
                SubPageLink = "No." = field("No."), Type = const(Facilitators);
                UpdatePropagation = Both;
            }
            part(Partcipants; "Work Programme Participants")
            {
                SubPageLink = "No." = field("No."), Type = const(Participants);
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                Enabled = Open;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    OnlineMgmt: Codeunit "Online Portal Services";
                begin
                    Committment.CheckWPCommittment(Rec);
                    // Committment.WPCommittment(Rec, ErrorMsg);
                    if ErrorMsg <> '' then Error(ErrorMsg);
                    Commit;
                    //    OnlineMgmt.SendActivityWorkProgrammeforApproval("No.");
                    if ApprovalsMgmt.CheckWorkprogrammeWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendWorkprogrammeForApproval(Rec);
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                Enabled = Pending;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    ApprovalsMgmt.OnCancelWorkprogrammeApprovalRequest(Rec);
                    CurrPage.Close();
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", Database::"Activity Work Programme");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.RunModal();
                end;
            }
            action("Create Purchase request")
            {
                Image = Approval;
                Enabled = not Rec."Requisition Made";
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PRequest: Record "Internal Request Header";
                    PRequest2: Record "Internal Request Header";
                    PRequestLines: Record "Internal Request Line";
                    WorkPlanHeader: Record "Activity Work Programme";
                    WPItems: Record "Activity Work Programme Lines";
                    LineNo: Integer;
                    LineNoLine: Integer;
                    Committment: Codeunit Committment;
                    ErrorMsg: Text[100];
                    ItemNos: code[20];
                begin
                    ItemNos := '';
                    WorkPlanHeader.Reset();
                    WorkPlanHeader.SetRange("No.", Rec."No.");
                    if WorkPlanHeader.Find('-') then begin
                        WPItems.Reset();
                        WPItems.SetRange("No.", WorkPlanHeader."No.");
                        WPItems.SetRange(Type, WPItems.Type::Items);
                        WPItems.SetRange("Purchase Type", WPItems."Purchase Type"::"Procurement Process");
                        if WPItems.Find('-') then begin
                            LineNo += 1000;
                            PRequest.init;
                            PRequest."Document Type" := PRequest."Document Type"::Purchase;
                            PRequest."Shortcut Dimension 3 Code" := Rec."Shortcut Dimension 3 Code";
                            PRequest."Activity Description" := Rec.Description;
                            PRequest."Activity Workplan No." := WorkPlanHeader."No.";
                            PRequest.Insert(true);
                            //lines
                            repeat
                                LineNoLine += 1000;
                                PRequestLines.init;
                                PRequestLines."Document No." := PRequest."No.";
                                PRequestLines."Document Type" := PRequestLines."Document Type"::Purchase;
                                PRequestLines."No." := WPItems."Item No.";
                                PRequestLines.Validate("No.");
                                PRequestLines."Line No." := LineNoLine;
                                PRequestLines."Procurement Plan" := PRequest."Procurement Plan";
                                PRequestLines.Type := PRequestLines.Type::Item;
                                PRequestLines.Description := WPItems.Description;
                                PRequestLines.Quantity := WPItems.Quantity;
                                PRequestLines."Direct Unit Cost" := WPItems."Unit Cost";
                                PRequestLines.Insert();
                                PRequestLines.Validate("Direct Unit Cost");
                                PRequestLines."Remaining Quantity" := 0;
                                PRequestLines.Modify();
                            until WPItems.Next() = 0;
                            //end lines
                            Rec."Requisition Made" := true;
                            Rec."Purchase Requisition No." := PRequest."No.";
                            PRequest.Status := PRequest.Status::Released;
                            PRequest.modify;
                            ItemNos := WPItems."Item No.";
                            Committment.CheckPurchReqCommittmentWorkplan(PRequest, ItemNos);
                            Committment.PurchReqCommittmentWorkplan(PRequest, ErrorMsg, ItemNos);
                            IF ErrorMsg <> '' THEN ERROR(ErrorMsg);
                        end;
                        Message('Purchase requisition %1 created successfully', Rec."Purchase Requisition No.");
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetontrolAppearance();
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        SetontrolAppearance();
    end;

    var
        Open: Boolean;
        Pending: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        Committment: Codeunit Committment;
        ErrorMsg: Text;

    procedure SetontrolAppearance()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Open then
            Open := true
        else
            Open := false;
        if Rec.Status = Rec.Status::"Pending Approval" then
            Pending := true
        else
            Pending := false;
    end;
}

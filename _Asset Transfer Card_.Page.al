page 50241 "Asset Transfer Card"
{
    Caption = 'Asset Transfer Card';
    PageType = Card;
    SourceTable = "Asset Allocation and Transfer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Transferred;

                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Asset; Rec.Asset)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Tag Number"; Rec."Tag Number")
                {
                    Enabled = false;
                }
                group(NonVehicle)
                {
                    ShowCaption = false;
                    Visible = OtherVisible;

                    field("Serial No."; Rec."Serial No.")
                    {
                        Enabled = false;
                    }
                }
                group(Vehicle)
                {
                    Visible = VehicleVisible;

                    field("Car Registration No."; Rec."Car Registration No.")
                    {
                        ApplicationArea = all;
                        Enabled = false;
                    }
                    field("Chasis Number"; Rec."Chasis Number")
                    {
                        ApplicationArea = all;
                        Enabled = false;
                    }
                    field("Engine Number"; Rec."Engine Number")
                    {
                        ApplicationArea = all;
                        Enabled = false;
                    }
                }
                field("Current Branch"; Rec."Current Branch")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Current Department"; Rec."Current Department")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Current Employee No."; Rec."Current Employee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Current Employee name"; Rec."Current Employee name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New Employee No."; Rec."New Employee No.")
                {
                    Caption = 'Transferred to Employee No';
                    ApplicationArea = All;
                }
                field("New Employee Name"; Rec."New Employee Name")
                {
                    Caption = 'Employee Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Transfer date';
                    ApplicationArea = All;
                }
                field("Transfer Branch"; Rec."Transfer Branch")
                {
                    ApplicationArea = All;
                }
                field("Transfer Department"; Rec."Transfer Department")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                group("Acknowlwedge receipt")
                {
                    ShowCaption = false;
                    Enabled = AcknowledgeEditble;

                    field(Acknowledge; Rec.Acknowledge)
                    {
                        Enabled = false;
                    }
                    field("Asset Condition"; Rec."Asset Condition")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                Enabled = Rec.Status = Rec."Status"::Open;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if ApprovalManagement.CheckAssetTransWorkflowEnabled(Rec) then ApprovalManagement.OnSendAssetTransApproval(Rec);
                    Commit;
                    exit;
                end;
            }
            action("Cancel Approval request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelAssetTransApproval(Rec);
                    ;
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Approvalentries: Page "Approval Entries";
                    Approvals: Record "Approval Entry";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Asset Allocation and Transfer");
                    Approvals.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.RunModal();
                end;
            }
            action(Acknowledgment)
            {
                Caption = 'Acknowledge';
                Visible = AcknowledgeEditble;
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Acknowledge := true;
                end;
            }
            action(Transfer)
            {
                Enabled = Rec."Status" = Rec."Status"::Released;
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Transfer action';

                trigger OnAction()
                begin
                    HrManagement.TransferAsset(Rec."No.");
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Transfer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Transfer;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance()
    end;

    var
        HrManagement: Codeunit "HR Management";
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;
        VehicleVisible: Boolean;
        OtherVisible: Boolean;
        AcknowledgeEditble: Boolean;

    procedure SetControlAppearance()
    var
        FA: Record "Fixed Asset";
        UserSetup: Record "User Setup";
    begin
        FA.SetRange("No.", Rec.Asset);
        FA.SetRange("Fixed Asset Type", FA."Fixed Asset Type"::Fleet);
        if FA.FindFirst() then
            VehicleVisible := true
        else
            VehicleVisible := false;
        FA.SetRange("No.", Rec.Asset);
        FA.SetFilter("Fixed Asset Type", '<>%1', FA."Fixed Asset Type"::Fleet);
        if FA.FindFirst() then
            OtherVisible := true
        else
            OtherVisible := false;
        if Rec.Transferred = true then begin
            if UserSetup.Get(UserId) then begin
                if UserSetup."Employee No." = Rec."New Employee No." then
                    AcknowledgeEditble := true
                else
                    AcknowledgeEditble := false;
            end;
        end;
    end;
}

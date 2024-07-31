page 50239 "Asset Allocation Card"
{
    PromotedActionCategories = 'New,Process,Report,Approvals';
    Caption = 'Asset Allocation';
    PageType = Card;
    SourceTable = "Asset Allocation and Transfer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Allocated;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
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
                    Enabled = false;
                }
                // field("Asset Condition"; Rec."Asset Condition")
                // {
                //     ApplicationArea = All;
                // }
                field("Tag Number"; Rec."Tag Number")
                {
                    Enabled = false;
                }
                group(NonVehicle)
                {
                    Visible = OtherVisible;
                    ShowCaption = false;

                    field("Serial No."; Rec."Serial No.")
                    {
                        Enabled = false;
                    }
                }
                group(Vehicle)
                {
                    Visible = VehicleVisible;
                    ShowCaption = false;

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
                field("Branch"; Rec."Current Branch")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Department"; Rec."Current Department")
                {
                    ApplicationArea = All;
                }
                field("New Employee No."; Rec."New Employee No.")
                {
                    Caption = 'Employee No';
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
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
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
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    if ApprovalManagement.CheckAssetAllocationWorkflowEnabled(Rec) then ApprovalManagement.OnSendAssetAllocationApproval(Rec);
                    // Commit;
                    // exit;
                end;
            }
            action("Cancel Approval request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelAssetTransApproval(Rec);
                    ;
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
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

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
            action(Allocate)
            {
                Enabled = NotAllocated;
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Allocation action';

                trigger OnAction()
                begin
                    HrManagement.AllocateAsset(Rec."No.");
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Initial Allocation";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Initial Allocation";
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
        NotAllocated: Boolean;
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
        if (Rec.Status = Rec.Status::Released) and (Rec.Allocated = false) then
            NotAllocated := true
        else
            NotAllocated := false;
        if Rec.Allocated = true then begin
            if UserSetup.Get(UserId) then begin
                if UserSetup."Employee No." = Rec."New Employee No." then
                    AcknowledgeEditble := true
                else
                    AcknowledgeEditble := false;
            end;
        end;
    end;
}

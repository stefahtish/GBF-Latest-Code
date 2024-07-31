page 50704 "Transport Incident"
{
    Caption = 'Transport Incident';
    PageType = Card;
    SourceTable = "Transport Incident";
    PromotedActionCategories = 'New,Process,Report,Approvals';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Reported;

                field("Incident Reference"; Rec."Incident Reference")
                {
                    ApplicationArea = All;
                }
                field("Incident date"; Rec."Incident date")
                {
                    ApplicationArea = All;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    ApplicationArea = All;
                }
                field("Incident Location"; Rec."Incident Location")
                {
                    ApplicationArea = All;
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    ApplicationArea = All;
                }
                field(Accident; Rec.Accident)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Insurance details"; Rec."Insurance details")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("System Support Email Address"; Rec."System Support Email Address")
                {
                    ApplicationArea = All;
                }
                field("User Email Address"; Rec."User Email Address")
                {
                    ApplicationArea = All;
                }
                field("User Remarks"; Rec."User Remarks")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Registration"; Rec."Vehicle Registration")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                }
                group(AccidentDetails)
                {
                    ShowCaption = false;
                    visible = Rec.Accident;

                    field(Abstract; Rec.Abstract)
                    {
                        ApplicationArea = All;
                    }
                    field(Image; Rec.Image)
                    {
                        ApplicationArea = All;
                    }
                    field("Insurance Company"; Rec."Insurance Company")
                    {
                        ApplicationArea = All;
                    }
                    field("Insurance Commencement Date"; Rec."Insurance Commencement Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Hotline Number"; Rec."Hotline Number")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Inspection Due Date"; Rec."Inspection Due Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = not Approved;

                    trigger OnAction()
                    begin
                        if Rec.Accident then begin
                            Rec.TestField(Abstract);
                            Rec.TestField(Image);
                        end;
                        Rec.Reported := true;
                        Rec.Modify();
                        if ApprovalsMgmt.CheckTransportIncidentWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendTransportIncidentForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = not Approved;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        ApprovalsMgmt.OnCancelTransportIncidentApprovalRequest(Rec);
                        CurrPage.Close;
                    end;
                }
                action(Approvals)
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
                        ApprovalEntry.SetRange("Table ID", Database::"Transport Incident");
                        ApprovalEntry.SetRange("Document No.", Rec."Incident Reference");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
        }
    }
    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        Approved: Boolean;

    trigger OnOpenPage()

    begin

        if Rec.Status = Rec.Status::Approved then
            Approved := true;

    end;

}

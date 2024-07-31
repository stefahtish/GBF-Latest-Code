page 50706 "Driver Logging"
{
    Caption = 'Driver Logging';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Driver Logging";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Submitted;

                field("Log No."; Rec."Log No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Log time"; Rec."Log time")
                {
                    ApplicationArea = All;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Location From"; Rec."Location From")
                {
                    ApplicationArea = All;
                }
                field("Location To"; Rec."Location To")
                {
                    ApplicationArea = All;
                }
                field("Date of Travel"; Rec."Date of Travel")
                {
                    ApplicationArea = All;
                }
                field("Time of Travel"; Rec."Time of Travel")
                {
                    ApplicationArea = All;
                }
                field("Date of Arrival"; Rec."Date of Arrival")
                {
                    ApplicationArea = All;
                }
                field("Time of Arrival"; Rec."Time of Arrival")
                {
                    ApplicationArea = All;
                }
                field("Car Registration Number"; Rec."Car Registration Number")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Car Fuel Intakes"; Rec."Car Fuel Intakes")
                {
                    Caption = 'Car fuel intakes(Ksh)';
                    ApplicationArea = All;
                }
                field("Car Mileage"; Rec."Car Mileage")
                {
                    Caption = 'Current Mileage reading';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Mileage reading after travel"; Rec."Mileage reading after travel")
                {
                    ApplicationArea = All;
                }
                field("Car Status"; Rec."Car Status")
                {
                    ApplicationArea = All;
                }
                field("Travel Request"; Rec."Travel Request")
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = all;
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Insurance Commencement Date"; Rec."Insurance Commencement Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Hotline Number"; Rec."Hotline Number")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inspection Due Date"; Rec."Inspection Due Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field(Submitted; Rec.Submitted)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
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
                    var
                        FA: Record "Fixed Asset";
                        ProcMgmt: Codeunit "Procurement Management";
                    begin
                        FA.setrange("No.", Rec."FA No.");
                        if FA.FindFirst() then FA."Current Odometer Reading" := Rec."Mileage reading after travel";
                        FA.Modify();
                        Rec.Submitted := true;
                        ProcMgmt.FuelUsage(Rec);
                        if ApprovalsMgmt.CheckDriverLoggingWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendDriverLoggingForApproval(Rec);
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
                        ApprovalsMgmt.OnCancelDriverLoggingApprovalRequest(Rec);
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
                        ApprovalEntry.SetRange("Table ID", Database::"Driver Logging");
                        ApprovalEntry.SetRange("Document No.", Rec."Log No.");
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

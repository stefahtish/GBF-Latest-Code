page 50453 "Transport Request"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Transport Management';
    SourceTable = "Travel Requests";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Enabled = Rec."Status" = Rec."Status"::Open;

                field("Request No."; Rec."Request No.")
                {
                    Enabled = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Request Time"; Rec."Request Time")
                {
                    Enabled = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    Caption = 'Nature of Employement';
                    Enabled = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    // Enabled = false;
                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;

                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
                label("Travel Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Reason for Travel"; Rec."Reason for Travel")
                {
                }
                field("Mode of Travel"; Rec."Mode of Travel")
                {
                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
                field(Destination; Rec.Destination)
                {
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                }
                field("Return Time"; Rec."Return Time")
                {
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Enabled = false;
                }
                field("No. of Non Employees"; Rec."No. of Non Employees")
                {
                    Enabled = false;
                    Visible = false;
                }
                field("No of Vehicles"; Rec."No of Vehicles")
                {
                    Caption = 'Vehicles Used';
                    Visible = Rec."Status" = Rec."Status"::Open;
                }
                field("Transport Status"; Rec."Transport Status")
                {
                    Enabled = false;
                }
            }
            part("Travelling Employees"; "Travelling Employees")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                SubPageLink = "Request No." = FIELD("Request No.");
                UpdatePropagation = Both;
            }
            part(Trips; "Transport Trips")
            {
                SubPageLink = "Request No" = FIELD("Request No.");
                Visible = TripsVisible;
            }
            part("Travel Expense"; "Travel Expense")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                SubPageLink = "Document No" = FIELD("Request No.");
                Visible = false;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TLines: Record "Travelling Employee";
                begin
                    Rec.TestField(Destination);
                    TLines.Reset;
                    TLines.SetRange("Request No.", Rec."Request No.");
                    if not TLines.FindFirst() then Error('Please choose travelling employees');
                    if ApprovalMgt.CheckTransportWorkflowEnabled(Rec) then ApprovalMgt.OnSendTransportApprovalRequest(Rec);
                    Commit;
                    // //Check HOD approver
                    // IF UserSetup.GET(USERID) THEN
                    //  BEGIN
                    //    IF UserSetup."Customer No." THEN
                    //      BEGIN
                    //        ApprovalEntry.RESET;
                    //        ApprovalEntry.SETRANGE("Table ID",51519334);
                    //        ApprovalEntry.SETRANGE("Document No.","Request No.");
                    //        ModifyHODApprovals.SETTABLEVIEW(ApprovalEntry);
                    //        ModifyHODApprovals.RUNMODAL;
                    //      END;
                    //  END;
                    CurrPage.Close;
                end;
            }
            action("Cancel Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelTransportApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", Database::"Travel Requests");
                    ApprovalEntry.SetRange("Document No.", Rec."Request No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.RunModal();
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = false;

                trigger OnAction()
                begin
                    Travel.Reset;
                    Travel.SetRange("Request No.", Rec."Request No.");
                    REPORT.Run(Report::"Travel Request", true, false, Travel);
                end;
            }
            separator(Action19)
            {
            }
            group("Transport Management")
            {
                Caption = 'Transport Management';

                action(Vehicles)
                {
                    Image = Delivery;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    RunObject = Page "Fleet List";
                    Visible = false;
                }
                action("Assign Vehicle")
                {
                    Enabled = Rec."Transport Status" = Rec."Transport Status"::"Requisition";
                    Image = NewShipment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if ACTION::LookupOK = PAGE.RunModal(Page::"Fleet List", FA, FA."No.") then begin
                            Transport.Init;
                            Transport."Vehicle No" := FA."No.";
                            Transport."Request No" := Rec."Request No.";
                            Transport.Date := Today;
                            Transport.Validate("Vehicle No");
                            Transport.Insert;
                        end;
                    end;
                }
                action("Notify Driver and Employees")
                {
                    Image = Delivery;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = Rec."Status" = Rec."Status"::"Released";

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to notify the Employee and Driver via mail?', false) then HRManagement.NotifyTransportEmployees(Rec."Request No.");
                    end;
                }
                action("Trip Start")
                {
                    Enabled = Rec."Transport Status" = Rec."Transport Status"::"Requisition";
                    Image = Delivery;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = Rec."Status" = Rec."Status"::"Released";

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to Start the Trip %1 to %2?', true, Rec."Request No.", Rec.Destination) = false then exit;
                        if Rec."Mode of Travel" = Rec."Mode of Travel"::Road then begin
                            Transport.Reset;
                            Transport.SetRange("Request No", Rec."Request No.");
                            if Transport.Find('-') then Transport.TestField(Driver);
                            Transport."Time Out" := Time;
                            Transport.Modify;
                            begin
                                repeat
                                    if FA.Get(Transport."Vehicle No") then begin
                                        FA."On Trip" := true;
                                        FA.Modify;
                                    end;
                                until Transport.Next = 0;
                            end;
                        end;
                        Rec."Transport Status" := Rec."Transport Status"::"On Trip";
                        Rec.Modify;
                        if Confirm('Do you want to notify the Employee and Driver via mail?', false) then HRManagement.NotifyTransportEmployees(Rec."Request No.");
                        Message('The Transport trip %1 from %2 has been Initiated', Rec."Request No.", Rec.Destination);
                        CurrPage.Close;
                    end;
                }
                action("Complete Trip")
                {
                    Enabled = Rec."Transport Status" = Rec."Transport Status"::"On Trip";
                    Image = Default;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = Rec."Status" = Rec."Status"::Released;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to Complete the Trip %1 from %2?', true, Rec."Request No.", Rec.Destination) = false then exit;
                        if Rec."Mode of Travel" = Rec."Mode of Travel"::Road then begin
                            Transport.Reset;
                            Transport.SetRange("Request No", Rec."Request No.");
                            if Transport.Find('-') then Transport.TestField("Time In");
                            Transport.TestField("End of Journey KM");
                            begin
                                repeat
                                    if FA.Get(Transport."Vehicle No") then begin
                                        FA."On Trip" := false;
                                        FA."Current Odometer Reading" := Transport."End of Journey KM";
                                        FA.Modify;
                                    end;
                                until Transport.Next = 0;
                            end;
                        end;
                        Rec."Transport Status" := Rec."Transport Status"::Completed;
                        Rec.Modify;
                        Message('The Transport trip %1 from %2 has been Completed', Rec."Request No.", Rec.Destination);
                        CurrPage.Close;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetPageView;
    end;

    trigger OnOpenPage()
    begin
        SetPageView;
    end;

    var
        Travel: Record "Travel Requests";
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        FA: Record "Fixed Asset";
        Transport: Record "Transport Trips";
        TransPage: Page "Fleet List";
        Road: Boolean;
        Approved: Boolean;
        Branch: Boolean;
        TripsVisible: Boolean;
        HRManagement: Codeunit "HR Management";
        Dimensionvalues: Record "Dimension Value";

    procedure SetPageView()
    begin
        case Rec."Mode of Travel" of
            Rec."Mode of Travel"::Road, Rec."Mode of Travel"::" ":
                Road := true
            else
                Road := false;
        end;
        if Rec.Status = Rec.Status::Released then
            Approved := true
        else
            Approved := false;
        // if "Shortcut Dimension 1" <> '' then begin
        Dimensionvalues.reset;
        Dimensionvalues.SetRange(Code, Rec."Shortcut Dimension 1 Code");
        Dimensionvalues.SetRange(HQ, false);
        if Dimensionvalues.FindFirst() then begin
            Branch := true;
        end
        else
            Branch := false;
        //end;
        if ((Road = true) AND (Approved = true)) OR (Branch = true) then
            TripsVisible := true
        else
            TripsVisible := false;
    end;
}

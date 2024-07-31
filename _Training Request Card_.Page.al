page 50430 "Training Request Card"
{
    PageType = Card;
    SourceTable = "Training Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::"Open";

                field("Request No."; Rec."Request No.")
                {
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                    Editable = false;
                }
                field(Adhoc; Rec.Adhoc)
                {
                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                    end;
                }
                field("Training Need"; Rec."Training Need")
                {
                    Visible = not NeedRequest;
                }
            }
            group("Training Details")
            {
                Caption = 'Training Details';
                Editable = true;
                Visible = NeedRequest = false;

                field(Description; Rec.Description)
                {
                    Caption = 'Training Description';
                }
                field("Training Objective"; Rec."Training Objective")
                {
                    Visible = false;
                }
                field("Planned Start Date"; Rec."Planned Start Date")
                {
                    Caption = 'From';
                    Editable = true;
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    Caption = 'To';
                    Editable = true;
                }
                field("No. Of Days"; Rec."No. Of Days")
                {
                    Enabled = false;
                }
                field(Destination; Rec.Destination)
                {
                    Visible = true;
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Country Code"; Rec."Country Code")
                {
                    Visible = false;
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Employee Cost"; Rec."Employee Cost")
                {
                    Caption = 'Employee Training Cost Estimation';
                }
                field("Cost of Training"; Rec."Cost of Training")
                {
                    //Editable = false;
                    Visible = false;
                }
                field("Cost of Training (LCY)"; Rec."Cost of Training (LCY)")
                {
                    //Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    // Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                    end;
                }
            }
            part("Training Need Request"; "Training Needs Request")
            {
                Visible = NeedRequest;
                ApplicationArea = all;
                SubPageLink = "Source Document No" = field("Request No."), "Employee No" = field("Employee No"), "Need Source" = const(Adhoc);
            }
            part(TrainingRequestLines; "Training Request Lines")
            {
                Visible = false;
                SubPageLink = "Document No." = FIELD("Request No."), "Training Need No" = FIELD("Training Need");
            }
            part("Travelling Employees"; "Travelling Employees List")
            {
                Visible = false;
                Caption = 'Travelling Employees';
                SubPageLink = "Request No." = FIELD("Request No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckTrainingRequestWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendTrainingRequestforApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelTrainingRequestApproval(Rec);
                end;
            }
            action("View Approvals")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Transport Request","Leave Application","Training Request";
                begin
                    DocumentType := DocumentType::"Training Request";
                    ApprovalEntries.Setrecordfilters(DATABASE::"Training Request", DocumentType, Rec."Request No.");
                    ApprovalEntries.Run;
                end;
            }
            action("Budget Comparision")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.SetFilter("Request No.", rec."Request No.");
                    if Rec.FindFirst() then begin
                        REPORT.Run(50516, true, true, rec);
                    end;

                end;
            }
            action("Apply Imprest")
            {
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = DocReleased;

                trigger OnAction()
                var
                    payments: Record Payments;
                    paymentlines: Record "Payment Lines";
                    TrainingLines: Record "Training Request Lines";
                    ImprestTypes: Record "Receipts and Payment Types";
                    DocNo: Code[50];
                begin
                    payments.Init;
                    payments."No." := '';
                    payments.TrainingNo := Rec."Training Need";
                    //payments."Account No." := "Employee No";
                    //payments.Validate("Account No.");
                    payments."Payment Type" := payments."Payment Type"::Imprest;
                    payments.Destination := Rec.Destination;
                    payments."Date of Project" := Rec."Planned Start Date";
                    payments."Date of Completion" := Rec."Planned End Date";
                    payments."No of Days" := Rec."No. Of Days";
                    payments."Account Type" := payments."Account Type"::Customer;
                    payments.Insert(true);
                    DocNo := payments."No.";
                    TrainingLines.Reset();
                    TrainingLines.SetRange("Document No.", Rec."Request No.");
                    if TrainingLines.Find('-') then
                        repeat
                            paymentlines.Init;
                            paymentlines.No := DocNo;
                            paymentlines."Payment Type" := paymentlines."Payment Type"::Imprest;
                            ImprestTypes.SetRange(Type, ImprestTypes.Type::Imprest);
                            ImprestTypes.SetRange(Training, true);
                            if ImprestTypes.FindFirst() then paymentlines."Expenditure Type" := ImprestTypes.Code;
                            paymentlines.Validate("Expenditure Type");
                            paymentlines.Amount := TrainingLines.Amount;
                            paymentlines.Insert(true);
                        until TrainingLines.Next() = 0;
                    PAGE.RUN(Page::Imprest, payments);
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
        SetControlAppearance;
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        userSetup: Record "User Setup";
        DocReleased: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocPosted: Boolean;
        NeedRequest: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId); //FALSE
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        if (Rec.Adhoc = true) then
            NeedRequest := true
        else
            NeedRequest := false;
    end;
}

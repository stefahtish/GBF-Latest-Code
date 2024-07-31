page 51047 "Stake. Support Activity Plan"
{
    Caption = 'Capacity building';
    PageType = Card;
    SourceTable = "Research Activity Plan";
    SourceTableView = WHERE("Research Type" = CONST(Support));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            Group(General)
            {
                Editable = not Rec.Submitted;

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Support Activity Type"; Rec."Support Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Description of activity"; Rec."Description of activity")
                {
                    ApplicationArea = All;
                }
                field("Type of participants"; Rec."Type of participants")
                {
                    ApplicationArea = All;
                }
                field("Other types of participants"; Rec."Other types of participants")
                {
                    ApplicationArea = All;
                }
                field("Target Number of participants"; Rec."Target Number of participants")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                group("Area")
                {
                    field(Country; Rec.Country)
                    {
                        ApplicationArea = All;

                        trigger Onvalidate()
                        var
                            myInt: Integer;
                        begin
                            CurrPage.Update();
                            SetPageView();
                        end;
                    }
                    group(Location)
                    {
                        ShowCaption = false;
                        Visible = Localvisible;

                        field(County; Rec.County)
                        {
                            ApplicationArea = All;
                        }
                        field("County Name"; Rec."County Name")
                        {
                            ApplicationArea = All;
                        }
                        field(Subcounty; Rec.Subcounty)
                        {
                            ApplicationArea = All;
                        }
                        field("Sub-County Name"; Rec."Sub-County Name")
                        {
                            ApplicationArea = All;
                        }
                    }
                }
                field(Town; Rec.Town)
                {
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
            }
            group(Details)
            {
                ShowCaption = false;
                Enabled = Rec.Submitted;

                field("Actual Number of participants"; Rec."Actual Number of participants")
                {
                    ApplicationArea = All;
                }
                field("Actual Venue"; Rec."Actual Venue")
                {
                }
                field(Conclusion; ConclusionTxt)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Conclusion);
                        rec.Conclusion.CreateInStream(InStrm);
                        ConclusionBigTxt.Read(InStrm);
                        if ConclusionTxt <> Format(ConclusionBigTxt) then begin
                            Clear(Rec.Conclusion);
                            Clear(ConclusionBigTxt);
                            ConclusionBigTxt.AddText(ConclusionTxt);
                            rec.Conclusion.CreateOutStream(OutStrm);
                            ConclusionBigTxt.Write(OutStrm);
                        end;
                    end;
                }
            }
            part(Objectives; "Gen Objectives")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), "Patnership line type" = CONST(Objectives);
            }
            part(Recommendations; "Research Recommendations")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), Type = CONST(Recommendations);
            }
            part(Budget; "Budget Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD(Code), Activity = const(Stakeholders);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Approvals)
            {
                action("Send For Approval")
                {
                    Enabled = Rec.Status = Rec."Status"::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if ApprovalsMgmt.CheckResearchActivityWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendResearchActivityForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Image = CancelApprovalRequest;
                    Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request for %1?', false, Rec.Code) = true then begin
                            ApprovalsMgmt.OnCancelResearchActivityApprovalRequest(Rec);
                        end;
                    end;
                }
                action(ViewApprovals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Approvalentries: Page "Approval Entries";
                        Approvals: Record "Approval Entry";
                    begin
                        Approvals.Reset();
                        Approvals.SetRange("Table ID", Database::"Research Activity Plan");
                        Approvals.SetRange("Document No.", Rec.Code);
                        ApprovalEntries.SetTableView(Approvals);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action("Stakeholder Support Activity Plan")
            {
                Visible = Rec.Status = Rec.Status::Released;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Report;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Workplan: Record "Research Activity Plan";
                begin
                    Workplan.RESET;
                    Workplan.SETRANGE(Code, Rec.Code);
                    REPORT.RUN(Report::"Support Activity", TRUE, FALSE, Workplan);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Research type" := Rec."Research type"::Support;
        Rec.Localctry := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Conclusion);
        rec.Conclusion.CreateInStream(InStrm);
        ConclusionBigTxt.Read(InStrm);
        ConclusionTxt := Format(ConclusionBigTxt);
        SetPageView();
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;
        OutputBigTxt: BigText;
        OutputTxt: Text;
        RecommendationBigTxt: BigText;
        RecommendationTxt: Text;
        ConclusionBigTxt: BigText;
        ConclusionTxt: Text;
        Localvisible: Boolean;
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        Countries: Record "Country/Region";

    procedure SetPageView()
    begin
        if Rec.Country <> '' then begin
            Countries.reset;
            Countries.SetRange(Code, Rec.Country);
            Countries.SetRange(Local, True);
            if Countries.FindFirst() then
                Localvisible := true
            else
                Localvisible := false;
        end;
    end;
}

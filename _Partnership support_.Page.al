page 51052 "Partnership support"
{
    Caption = 'Partnership';
    PageType = Card;
    SourceTable = "Partnerships Activity Plan";
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
                field("Name of partnership"; Rec."Name of partnership")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    Enabled = false;
                }
                field(Country; Rec.Country)
                {
                    Caption = 'Implementing Country';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ;
                    end;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;
                }
            }
            group(Details)
            {
                ShowCaption = false;
                Enabled = Rec.Submitted;

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
            part("Patnership Location"; "Patnership Location")
            {
                caption = 'Implementing Counties';
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code);
            }
            part(Partners; "Support partners")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Partners';
                SubPageLink = Code = FIELD(Code), "Patnership line type" = CONST(Patners);
            }
            part(FundingPlan; "Partners Funding Plan")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Funding Plan';
                SubPageLink = Code = FIELD(Code), "Patnership line type" = CONST(Patners);
            }
            part(Objectives; "Gen Objectives")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), "Patnership line type" = CONST(Objectives);
            }
            part(Activities; "Partnership Activities")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), "Patnership line type" = CONST(Activities);
            }
            part(Recommendations; "Research Recommendations")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), Type = CONST(Recommendations);
            }
            part(Budget; "Budget Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD(Code), Activity = const(Partnership);
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
                        if ApprovalsMgmt.CheckPartnershipActivityWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendPartnershipActivityForApproval(Rec);
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
                            ApprovalsMgmt.OnCancelPartnershipActivityApprovalRequest(Rec);
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
                action(Reviews)
                {
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Partnership Reviews";
                    RunPageLink = Code = field(Code);
                }
            }
            action("Partnership Activity plan")
            {
                Visible = Rec.Status = Rec.Status::Released;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Workplan: Record "Partnerships Activity Plan";
                begin
                    Workplan.RESET;
                    Workplan.SETRANGE(Code, Rec.Code);
                    REPORT.RUN(Report::"Partnership Activity", TRUE, FALSE, Workplan);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        SetPageView();
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
        Countries: Record "Country/Region";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;

    procedure SetPageView()
    begin
        if Rec.Country <> '' then begin
            Countries.reset;
            // Countries.SetRange(Code, Country);
            Countries.SetRange(Local, True);
            if Countries.FindFirst() then Rec.Country := Countries.Code;
            Rec.Validate(Country);
        end;
    end;
}

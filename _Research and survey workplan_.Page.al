page 51057 "Research and survey workplan"
{
    Caption = 'Research';
    PageType = Card;
    SourceTable = "Research and survey Workplan";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            Group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Name of research"; Rec."Name of research")
                {
                    Caption = 'Title of Research/Survey';
                    ApplicationArea = All;
                    Editable = not Rec.Submitted;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Editable = not Rec.Submitted;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = not Rec.Submitted;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = not Rec.Submitted;
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    Editable = not Rec.Submitted;
                }
                field("Service provider Name"; Rec."Service provider Name")
                {
                    Editable = not Rec.Submitted;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    Editable = not Rec.Submitted;
                }
                field(Country; Rec.Country)
                {
                    Caption = 'Implementing Country';
                    Editable = not Rec.Submitted;
                }
                field(Venue; Rec.Venue)
                {
                    Editable = not Rec.Submitted;
                }
                field(Town; Rec.Town)
                {
                    Editable = not Rec.Submitted;
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
            }
            part("Patnership Location"; "Patnership Location")
            {
                caption = 'Implementing Counties';
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code);
            }
            part(Objectives; "Research Objectives")
            {
                //Editable = not Submitted;
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), Type = CONST(Objectives);
            }
            part(Partners; "Research scope")
            {
                Caption = 'Research Activities';
                //Editable = not Submitted;
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), Type = CONST(Scope);
            }
            part(Activities; "Research partners")
            {
                //Editable = not Submitted;
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), Type = CONST(Patners);
            }
            part(Recommendations; "Research Recommendations")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code), Type = CONST(Recommendations);
            }
            part(Budget; "Budget Lines")
            {
                Editable = not Rec.Submitted;
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD(Code), Activity = const(Research);
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
                        if ApprovalsMgmt.CheckResearchSurveyWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendResearchSurveyForApproval(Rec);
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
                            ApprovalsMgmt.OnCancelResearchSurveyApprovalRequest(Rec);
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
                        Approvals.SetRange("Table ID", Database::"Research and survey Workplan");
                        Approvals.SetRange("Document No.", Rec.Code);
                        ApprovalEntries.SetTableView(Approvals);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action("Research and Survey Activity plan")
            {
                Visible = Rec.Status = Rec.Status::Released;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Workplan: Record "Research and survey Workplan";
                begin
                    Workplan.RESET;
                    Workplan.SETRANGE(Code, Rec.Code);
                    REPORT.RUN(Report::"Research Workplan", TRUE, FALSE, Workplan);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Conclusion, Recommendations, Output);
        rec.Output.CreateInStream(InStrm);
        OutputBigTxt.Read(InStrm);
        OutputTxt := Format(OutputBigTxt);
        rec.Recommendations.CreateInStream(InStrm);
        RecommendationBigTxt.Read(InStrm);
        RecommendationTxt := Format(RecommendationBigTxt);
        rec.Conclusion.CreateInStream(InStrm);
        ConclusionBigTxt.Read(InStrm);
        ConclusionTxt := Format(ConclusionBigTxt);
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
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
}

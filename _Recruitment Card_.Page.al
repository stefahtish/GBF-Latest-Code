page 50463 "Recruitment Card"
{
    PageType = Card;
    SourceTable = "Recruitment Needs";
    PromotedActionCategories = 'New,Process,Report,Approvals,Portal Controls';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Job ID"; Rec."Job ID")
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Positions; Rec.Positions)
                {
                    Editable = false;
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    Editable = false;
                }
                field("Appointment Type Description"; Rec."Appointment Type Description")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                    MultiLine = true;
                    Visible = false;
                }
                field(Priority; Rec.Priority)
                {
                    Editable = false;
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    Caption = 'Expected vacancy announcement date';
                }
                field("Reason for Recruitment(text)"; Rec."Reason for Recruitment(text)")
                {
                    Caption = 'Reason for Recruitment';
                    MultiLine = true;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Approved; Rec.Approved)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                }
                field("Shortlisting Started"; Rec."Shortlisting Started")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("View Approvals")
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
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
            group("Portal Controls")
            {
                Visible = true;

                action("Shortlist Started")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = AddContacts;
                    Visible = true;
                    applicationarea = all;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := false;
                            Rec."Shortlisting Started" := true;
                            Rec.Modify();
                            CurrPage.Close();
                        end;
                    end;
                }
                action("Submit To Portal")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = AddContacts;
                    applicationarea = all;

                    trigger OnAction()
                    begin
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Remove from Portal")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = RemoveContacts;
                    applicationarea = all;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := false;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        SetEditable();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetEditable();
    end;

    trigger OnOpenPage()
    begin
        SetEditable();
    end;

    var
        NOTEditable: Boolean;
        Released: Boolean;
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;

    local procedure SetEditable()
    begin
        if Rec.Status = Rec.Status::Released then begin
            NOTEditable := false
        end
        else
            NOTEditable := true;
        if Rec.Status = Rec.Status::Released then begin
            Released := true
        end
        else
            Released := false;
    end;
}

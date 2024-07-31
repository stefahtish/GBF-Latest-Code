page 50824 "Restricted Tender Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks';
    SourceTable = "Procurement Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                }
                field("Requisition No"; Rec."Requisition No")
                {
                }
                field("Ref No."; Rec."Ref No.")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Category; Rec.Category)
                {
                }
                // field("Reference No."; "Reference No.")
                // {
                // }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    Caption = 'Tender Deadline';
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Tender Type"; Rec."Tender Type")
                {
                    Editable = false;
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                }
                group(Termination)
                {
                    field("Termination Date"; Rec."Termination Date")
                    {
                    }
                    field("Termination Reason"; Rec."Termination Reason")
                    {
                    }
                }
            }
            part(Control13; "Procurement Documents Sub Form")
            {
                SubPageLink = "Quote No" = FIELD("No.");
            }
            part(Control12; "Procurement Request Lines")
            {
                SubPageLink = "Requisition No" = FIELD("No.");
            }
            part(Scope; "Tender Scope of Work")
            {
                SubPageLink = "Tender No." = field("No.");
            }
            part(Amounts; "Tender Amounts")
            {
                SubPageLink = "Tender No." = field("No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Attachments)
            {
                action("Upload Tender Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        //FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                        // DocumentManagement.InsertProcurementLinks(Rec);
                    end;
                }
            }
            group("Request for Tender")
            {
                Caption = 'Request for Tender';

                action("Select Suppliers To Notify")
                {
                    Visible = not Opening;
                    Caption = 'Select Suppliers to invite';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Supplier Selection";
                    RunPageLink = "Reference No." = FIELD("No."), "Supplier Category" = field(Category);

                    trigger OnAction()
                    begin
                        TestTheFields;
                    end;
                }
                action("Send for opening")
                {
                    Visible = not Opening;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        OpeningCommitee: Record "Tender Committees";
                    begin
                        // TestField(Status, Status::Approved);
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Tender);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Opening);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved opening Restricted Tender committee for RFP %1', Rec."No.");
                        Rec.Status := Rec.Status::Opening;
                        Commit();
                        CurrPage.Close();
                    end;
                }
                action("Select Suppliers")
                {
                    Visible = Opening;
                    Caption = 'Select Suppliers from applicants';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Bidders Selection";
                    RunPageLink = "Reference No." = FIELD("No.");

                    trigger OnAction()
                    begin
                        TestTheFields;
                    end;
                }
                action(Links)
                {
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = Page "Procurement Documents Links";
                    RunPageLink = "No." = FIELD("No."), "Process Type" = field("Process Type");
                }
                action("Request for Quotations")
                {
                    Caption = 'Request for Tender';
                }
                action("Print RFQ's")
                {
                    Caption = 'Print Tender''s';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestTheFields;
                        SupplierSelect.Reset;
                        SupplierSelect.SetFilter(SupplierSelect."Reference No.", Rec."No.");
                        REPORT.Run(Report::Tender, true, false, SupplierSelect);
                    end;
                }
                action("Suppliers under Evaluation")
                {
                    Visible = Opening;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SupplierEval: Record "Supplier Evaluation Header";
                    begin
                        TestTheFields;
                        SupplierEval.Reset;
                        SupplierEval.SetRange("Quote No", Rec."No.");
                        SupplierEvaluation.SetTableView(SupplierEval);
                        SupplierEvaluation.Run();
                    end;
                }
                action("Prospective Suppliers")
                {
                    Visible = Opening;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Prosp: Record "Prospective Supplier Tender";
                    begin
                        TestTheFields;
                        Prosp.Reset;
                        Prosp.SetRange("Tender No.", Rec."No.");
                        Prospectives.SetTableView(Prosp);
                        Prospectives.Run();
                    end;
                }
                action(Notify)
                {
                    Visible = Opening;
                    Caption = 'Notify Suppliers who Applied';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestTheFields;
                        if Confirm('Are you sure you want to notify the selected suppliers via mail?', false) = true then
                            ProcurementManagement.NotifySuppliers(Rec."No.")
                        else
                            exit;
                    end;
                }
                action("Send Suppliers for Evaluation")
                {
                    Visible = Opening;
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProcMgt: Codeunit "Procurement Management";
                        Prospectives: Record "Prospective Suppliers";
                        TendersApp: Record "Prospective Supplier Tender";
                        OpeningCommitee: Record "Tender Committees";
                    begin
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::Tender);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved evaluation tender committee for Tender %1', Rec."No.");
                        if Confirm('Are you sure?', false) then begin
                            ProcMgt.SendProspectiveSuppliersForEvaluation(Rec."No.");
                        end;
                        CurrPage.Close();
                    end;
                }
                action("Generate Quote Evaluation")
                {
                    Visible = Opening;
                    Caption = 'Generate Tender Evaluation';
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Bidders Selection";
                    begin
                        TestTheFields;
                        if Confirm('Are you sure you want to generate a Tender Evaluation?', false) = true then begin
                            SupplierSelection.Reset;
                            SupplierSelection.SetRange(SupplierSelection."Reference No.", Rec."No.");
                            SupplierSelection.SetRange(SupplierSelection.Invited, true);
                            if SupplierSelection.Find('-') then begin
                                ProcurementManagement.CreaTenderEvaluation(Rec);
                            end;
                        end;
                        Commit;
                        CurrPage.Close;
                    end;
                }
            }
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
                    //Visible = Approved;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = AddContacts;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Remove from Portal")
                {
                    //Visible = Approved;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = RemoveContacts;

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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
        Rec."Tender Type" := Rec."Tender Type"::Restricted;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
        Rec."Tender Type" := Rec."Tender Type"::Restricted;
    end;

    trigger OnOPenPage()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        SupplierSelect: Record "Bidders Selection";
        Prospectives: Report "Prospective Suppliers";
        SupplierEvaluation: Report "Suppliers Under Evaluation";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Opening: Boolean;
        NewVisible: Boolean;
        Approved: Boolean;

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
        Rec.TestField(Title);
        Rec.TestField("Quotation Deadline");
        Rec.TestField("Expected Closing Time");
    end;

    procedure SetControlAppearance()
    begin
        if (Rec.Status = Rec.Status::Opening) then
            Opening := true
        else
            Opening := false;
        if (Rec.Status = Rec.Status::New) then
            NewVisible := true
        else
            NewVisible := false;
        if (Rec.Status = Rec.Status::Approved) then
            Approved := true
        else
            Approved := false;
    end;
}

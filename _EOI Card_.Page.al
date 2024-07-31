page 50781 "EOI Card"
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
                field("Category Description"; Rec."Category Description")
                {
                    ToolTip = 'Specifies the value of the Category Description field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Ref No." := Rec."Reference No.";
                        Rec."Reference No." := 'EOI/' + Format(Rec."Reference No.");
                    end;
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    Caption = 'EOI Deadline';
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Process Type"; Rec."Process Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    ApplicationArea = All;
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                }
            }
            part(Control13; "Procurement Documents Sub Form")
            {
                ApplicationArea = all;
                SubPageLink = "Quote No" = FIELD("No.");
            }
            part(Control12; "Procurement Request Lines")
            {
                SubPageLink = "Requisition No" = FIELD("No.");
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
                        //   FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                        // DocumentManagement.InsertProcurementLinks(Rec);
                    end;
                }
            }
            group("EOI")
            {
                Caption = 'EOI';

                action("Select Suppliers")
                {
                    Caption = 'Select Suppliers';
                    Image = SelectEntries;
                    Promoted = true;
                    Visible = Opening;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Bidders Selection";
                    RunPageLink = "Reference No." = FIELD("No.");

                    trigger OnAction()
                    begin
                        TestTheFields;
                    end;
                }
                action("Print RFQ's")
                {
                    Caption = 'Print EOI''s';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestTheFields;
                        SupplierSelect.Reset;
                        SupplierSelect.SetFilter(SupplierSelect."Reference No.", Rec."No.");
                        EOIReport.SetTableView(SupplierSelect);
                        EOIReport.Run();
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
                action(Notify)
                {
                    Caption = 'Notify Suppliers';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestTheFields;
                        if Confirm('Are you sure you want to notify the selected suppliers via mail?', false) = true then
                            ProcurementManagement.NotifyEOISuppliers(Rec."No.")
                        else
                            exit;
                    end;
                }
                action("Send Suppliers for Evaluation")
                {
                    Visible = Opening;
                    Image = SendElectronicDocument;
                    Promoted = true;
                    ApplicationArea = all;
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
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::EOI);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved Quotation evaluation committee for EOI %1', Rec."No.");
                        if Confirm('Are you sure?', false) = true then begin
                            ProcMgt.SendProspectiveSuppliersForEvaluationEOI(Rec."No.");
                        end;
                        CurrPage.Close();
                    end;
                }
                action("Send for opening")
                {
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
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::EOI);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Opening);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved opening EOI committee for EOI %1', Rec."No.");
                        Rec.Status := Rec.Status::Opening;
                        Commit();
                        CurrPage.Close();
                    end;
                }
                action("Generate EOI Evaluation")
                {
                    Caption = 'Generate EOI Evaluation';
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = Opening;

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Bidders Selection";
                    begin
                        TestTheFields;
                        if Confirm('Are you sure you want to generate a EOI Evaluation?', false) = true then ProcurementManagement.CreateEOIEvaluation(Rec."No.");
                        Commit;
                        CurrPage.Close;
                    end;
                }
            }
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
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
        Rec."Process Type" := Rec."Process Type"::EOI;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::EOI;
    end;

    trigger OnafterGetrecord()
    begin
        SetControlAppearance();
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        SupplierSelect: Record "Supplier Selection";
        Opening: Boolean;
        NewVisible: Boolean;
        ApprovedEditable: Boolean;
        EOIReport: Report "EOI Analysis";
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

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
            ApprovedEditable := true
        else
            ApprovedEditable := false;
    end;
}

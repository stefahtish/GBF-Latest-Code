page 50806 "RFP Card"
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
                field("EOI No."; Rec."EOI No.")
                {
                    ToolTip = 'Specifies the value of the EOI No. field.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        If Rec."EOI No." = '' then begin
                            EOINotBlank := true;
                        end
                        else
                            EOINotBlank := False;
                    end;
                }
                field(Title; Rec.Title)
                {
                    Editable = EOINotBlank;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    Editable = EOINotBlank;
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
                    Editable = EOINotBlank;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = EOINotBlank;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Category; Rec.Category)
                {
                    Editable = EOINotBlank;
                }
                field("Category Description"; Rec."Category Description")
                {
                    Enabled = false;
                    Caption = 'Supply Code Description';
                    ToolTip = 'Specifies the value of the Category Description field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Editable = EOINotBlank;
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                }
                field("Process Type"; Rec."Process Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                }
            }
            part(Control13; "Procurement Documents Sub Form")
            {
                Visible = false;
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
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                        // DocumentManagement.InsertProcurementLinks(Rec);
                    end;
                }
            }
            group("Request for Quotation")
            {
                Caption = 'Request for RFP';

                action("Select Suppliers")
                {
                    Caption = 'Select Suppliers to invite';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "RFP Supplier Selection";
                    RunPageLink = "Reference No." = FIELD("EOI No."), "Supplier Category" = field(Category);

                    trigger OnAction()
                    begin
                        TestTheFields;
                    end;
                }
                action("Print RFP's")
                {
                    Caption = 'Print RFP''s';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RFPSupplierSelect: Record "RFP Supplier Selection";
                    begin
                        TestTheFields;
                        RFPSupplierSelect.Reset;
                        RFPSupplierSelect.SetFilter(RFPSupplierSelect."Reference No.", Rec."EOI No.");
                        RFPReport.SetTableView(RFPSupplierSelect);
                        RFPReport.run;
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
                            ProcurementManagement.NotifyRFPSuppliers(Rec."EOI No.")
                        else
                            exit;
                    end;
                }
                action("Select Suppliers for evaluation")
                {
                    Visible = Opening;
                    Caption = 'Select Suppliers for evaluation';
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
                action("Send Suppliers for Evaluation")
                {
                    Visible = Opening;
                    Image = SelectEntries;
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
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::RFP);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved Quotation Evaluation Committee for Tender %1', Rec."No.");
                        if Confirm('Are you sure?', false) = true then begin
                            ProcMgt.SendRFPProspectiveSuppliersForEvaluationRFP("rec");
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
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::RFP);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Opening);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved opening RFP committee for RFP %1', Rec."No.");
                        Rec.Status := Rec.Status::Opening;
                        Commit();
                        CurrPage.Close();
                    end;
                }
                action("Generate RFP Evaluation")
                {
                    Caption = 'Generate RFP Evaluation';
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = Opening;

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Supplier Selection";
                        OpeningCommitee: Record "Tender Committees";
                    begin
                        OpeningCommitee.Reset();
                        OpeningCommitee.SetRange("Procurement Method", OpeningCommitee."Procurement Method"::RFP);
                        OpeningCommitee.SetRange("Committee Type", OpeningCommitee."Committee Type"::Evaluation);
                        OpeningCommitee.SetRange("Tender/Quotation No", Rec."No.");
                        OpeningCommitee.SetRange(Status, OpeningCommitee.Status::Released);
                        if not OpeningCommitee.FindFirst() then Error('There is no approved RFP evaluation committee for RFP %1', Rec."No.");
                        TestTheFields;
                        if Confirm('Are you sure you want to generate a RFP Evaluation?', false) = true then ProcurementManagement.CreateRFPEvaluation(Rec."No.");
                        Commit;
                        CurrPage.Close;
                    end;
                }
            }
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
                    //Visible = ApprovedEditable;
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
                    //Visible = ApprovedEditable;
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
        Rec."Process Type" := Rec."Process Type"::RFP;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::RFP;
    end;

    trigger OnafterGetrecord()
    begin
        SetControlAppearance();
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        SupplierSelect: Record "Supplier Selection";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        Opening: Boolean;
        RFPReport: Report "RFP";
        NewVisible: Boolean;
        ApprovedEditable: Boolean;
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;
        EOINotBlank: Boolean;

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

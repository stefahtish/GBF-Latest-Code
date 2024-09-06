page 51501 "Purchase Request Subformv"
{
    PageType = ListPart;
    SourceTable = "Internal Request Line";
    SourceTableView = WHERE("Document Type" = CONST(Purchase));
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                    Visible = false;

                    // Visible = true;
                    trigger OnValidate()
                    begin
                    end;
                }
                field("Vendor Type"; Rec."Vendor Type")
                {
                    ToolTip = 'Specifies the value of the Vendor Type field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Visible();
                        Visible2();

                    end;
                }

                field("ExternalSupplier Name"; Rec."ExternalSupplier Name")
                {
                    ToolTip = 'Specifies the value of the ExternalSupplier Name field.';
                    Visible = false;
                    Caption = 'Supplier Name';

                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Buy-from Vendor No. field.';
                    Caption = 'Supplier No.';
                    Visible = false;
                    Editable = enabledSee;
                    Enabled = enabledSee;


                }
                field(Supplier; Rec.Supplier)
                {
                    ToolTip = 'Specifies the value of the Supplier field.';
                    Visible = enabledSee;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                    caption = 'Supplier Name.';
                    Visible = TRUE;
                    Editable = TRUE;
                }
                field("Quote Amount"; Rec."Quote Amount")
                { }
                field("Date Received"; Rec."Date Received")
                { }
                field("Line No"; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    // Enabled = false;
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Upload Document")
            {
                Image = Attach;
                ToolTip = 'Upload documents for the record.';
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    //   FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                end;
            }
            action(Links)
            {
                Image = Links;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecLinks: Record "Record Link";
                    DocLinks: page "Document Links";
                begin
                    RecLinks.reset;
                    RecLinks.SetRange("Record ID", Rec.RecordId);
                    DocLinks.SetTableView(RecLinks);
                    DocLinks.Run();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Specification2);
        REC.Specification2.CreateInStream(InStrm);
        SpecificationBigTxt.Read(InStrm);
        SpecificationTxt := Format(SpecificationBigTxt);
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::Fulfilled) then
                ShowSupplier := true
            else
                ShowSupplier := false
        end;
        SetControlAppearance();
        LineFieldEditable;
    end;

    trigger OnInit()
    begin
        ShowSupplier := false;
        IsStatusPending := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //  Rec.TestField("Requested Receipt Date");
        Rec.Type := Rec.Type::Item;
        Rec."Document Type" := Rec."Document Type"::Purchase;
        GetPurchaseHeader;
        //"Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Item;
        PurchSetup.Get;
        Rec."Procurement Plan" := PurchSetup."Effective Procurement Plan";
        Rec."No." := PurchSetup."Default Requisition Item No.";
        GetPurchaseHeader;
        //"Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
    end;

    trigger OnOpenPage()
    begin
        //ShowShortcutDimCode(ShortcutDimCode);
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::Fulfilled) then
                ShowSupplier := true
            else
                ShowSupplier := false
        end;
        SetControlAppearance();
        LineFieldEditable;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        GetPurchaseHeader2();
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        ShowDim: Boolean;
        ShowSupplier: Boolean;
        CanEdit: Boolean;
        IsStatusPending: Boolean;
        VATVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        InStrm: InStream;
        OutStrm: OutStream;
        SpecificationBigTxt: BigText;
        SpecificationTxt: Text;
        PurchaseRequest: Page "Purchase Request";
        Status: Integer;
        PurchSetup: Record "Purchases & Payables Setup";
        ProcurementPlan: Record "Procurement Plan";
        PurchaseHeader: Record "Internal Request Header";
        ExpectedQty: Decimal;
        Item: Record Item;
        UOM: Record "Item Unit of Measure";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        FromActivity: Boolean;
        enabledSee: Boolean;
        enabledSee2: Boolean;


    procedure ShowFields(MultiDonor: Boolean)
    begin
        /* if MultiDonor then
                ShowDim := true
            else
                ShowDim := false;
            CurrPage.Update; */
    end;

    local procedure ShowSup(var Show: Boolean)
    begin
        if Show = true then
            ShowSupplier := true
        else
            ShowSupplier := false;
        CurrPage.Update;
    end;

    local procedure LineFieldEditable()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntry: Record "Approval Entry";
    begin
        if PurchaseHeader.Get(Rec."Document No.") then begin
            case PurchaseHeader.Status of
                PurchaseHeader.Status::Released:
                    begin
                        CanEdit := true;
                        IsStatusPending := false;
                    end;
                PurchaseHeader.Status::"Pending Approval":
                    begin
                        CanEdit := false;
                        IsStatusPending := true;
                    end
                else begin
                    CanEdit := false;
                    IsStatusPending := false;
                end;
            end;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InternalRequestHeader: Record "Internal Request Header";
    begin
        //OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        GetPurchaseHeader();
        if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = Rec.Status::Disapproved) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(PurchaseHeader.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(PurchaseHeader.RecordId);
        // if PurchaseHeader."Activity Programme" <> '' then
        //     FromActivity := true
        // else
        //     FromActivity := false;
        // MESSAGE(FORMAT(OpenApprovalEntriesExist));
        // MESSAGE('%1',PurchaseHeader."No.");
    end;

    local procedure GetPurchaseHeader()
    begin
        if PurchaseHeader.Get(Rec."Document No.") then;
    end;

    local procedure GetPurchaseHeader2()
    begin
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::"Pending Approval") then IF Rec.Completed then Error('You cannot not modify a create a new line because the document has gone throught the approval process');
        end;
    end;

    local procedure GetPurchaseHeader3()
    begin
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::"Pending Approval") then Error('You cannot not modify a create a new line because the document has gone throught the approval process');
        end;
    end;

    local procedure Visible()
    var

    begin
        if rec."Vendor Type" = rec."Vendor Type"::Existing then
            enabledSee := true
        else
            enabledSee := false;
        CurrPage.Update;
    end;

    local procedure Visible2()
    var

    begin
        if rec."Vendor Type" = rec."Vendor Type"::External then
            enabledSee2 := true
        else
            enabledSee2 := false;
        CurrPage.Update;
    end;
}


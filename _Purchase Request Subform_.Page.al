page 50161 "Purchase Request Subform"
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    //sEnabled = not OpenApprovalEntriesExist;
                    Enabled = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;

                    // Visible = true;
                    trigger OnValidate()
                    begin
                    end;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Procurement Plan Item"; Rec."Procurement Plan Item")
                {
                    ApplicationArea = Basic, Suite;
                    // Visible = not FromActivity;
                    Visible = false;
                    Enabled = not OpenApprovalEntriesExist;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = Basic, Suite;
                    //  Visible = not FromActivity;
                    Enabled = not OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = NOT IsStatusPending;
                    Visible = false;
                }
                field("Document Created"; Rec."Document Created")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document Created ?';
                    Editable = false;
                    Visible = false;
                }
                field("Procurement Plan Description"; Rec."Procurement Plan Description")
                {
                    ToolTip = 'Specifies the value of the Procurement Plan Description field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                    // Enabled = ;
                    //  Visible = false;
                }
                // field(SpecificationTxt; SpecificationTxt)
                // {
                //     Caption = 'Specification';
                //     Description = 'Specification';
                //     ApplicationArea = All;
                //     ShowMandatory = fale;
                //     NotBlank = true;
                //     //MultiLine = true;
                //     Enabled = NOT OpenApprovalEntriesExist;
                //     // trigger OnValidate()
                //     // begin
                //     //     Rec.CalcFields(Specification2);
                //     //     REC.Specification2.CreateInStream(InStrm);
                //     //     SpecificationBigTxt.Read(InStrm);
                //     //     if SpecificationTxt <> Format(SpecificationBigTxt) then begin
                //     //         Clear(Rec.Specification2);
                //     //         Clear(SpecificationBigTxt);
                //     //         SpecificationBigTxt.AddText(SpecificationTxt);
                //     //         REC.Specification2.CreateOutStream(OutStrm);
                //     //         SpecificationBigTxt.Write(OutStrm);
                //     //     end;
                //     // end;
                // }
                // field("General Expense Code"; "General Expense Code")
                // {
                //     Enabled = not OpenApprovalEntriesExist;
                //     ApplicationArea = All;
                // }
                field(Quantity; Rec.Quantity)
                {
                    Enabled = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    NotBlank = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if Item.Get(Rec."No.") then begin
                            UOM.Reset;
                            UOM.SetRange("Item No.", Rec."No.");
                            UOM.SetRange(Code, Item."Purch. Unit of Measure");
                            if UOM.Find('-') then begin
                                ExpectedQty := Rec.Quantity * UOM."Qty. per Unit of Measure";
                            end;
                        end;
                        CurrPage.Update();
                    end;
                }
                field("Planned Quantity"; Rec."Planned Quantity")
                {
                    ApplicationArea = Basic, Suite;
                    // Visible = not FromActivity;
                    Enabled = false;
                    Visible = false;
                }
                // field("Remaining Quantity"; "Remaining Quantity")
                // {
                //      Visible = not FromActivity;
                //     Enabled = false;
                // }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ShowMandatory = true;
                    Visible = false;
                    NotBlank = true;
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    Enabled = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                    Caption = 'Total Planned Estimated Amount';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("Qty. to Order"; Rec."Qty. to Receive")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = NOT IsStatusPending;
                    Caption = 'Qty. to Order';
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist;
                }
                // field("Purchase Type"; "Purchase Type")
                // {
                //     Visible = CanEdit;
                // }
                field(Type2; Rec.Type2)
                {
                    ApplicationArea = Basic, Suite;
                    //sEnabled = not OpenApprovalEntriesExist;
                    //Enabled = false;
                    caption = 'Charge to Type';

                    trigger OnValidate()
                    begin
                        if Rec.completed then error('You cannot modify if the PO has already been created')
                    end;
                }
                field("Charge to No."; Rec."Charge to No.")
                {
                    ApplicationArea = Basic, Suite;
                    //sEnabled = not OpenApprovalEntriesExist;
                    //Enabled = false;
                    caption = 'Charge to No.';

                    trigger OnValidate()
                    begin
                        if Rec.completed then error('You cannot modify if the PO has already been created')
                    end;
                }
                field(LPO; Rec.LPO)
                {
                    ApplicationArea = Basic, Suite;

                    //Editable = false;
                    Visible = false;
                    //Editable = OpenApprovalEntriesExist;
                    //Enabled = not OpenApprovalEntriesExist;
                    trigger OnValidate()
                    var
                        InternalRequestHeader: Record "Internal Request Header";
                    begin
                        if Rec.completed then error('You cannot modify if the PO has already been created');
                        InternalRequestHeader.SetRange("No.", Rec."Document No.");
                        InternalRequestHeader.SetRange(Status, InternalRequestHeader.Status::Released);
                        if not InternalRequestHeader.FindFirst() then Error('Document not approved');
                    end;
                }
                field(Supplier; Rec.Supplier)
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = false;
                    //Visible = Not Rec.completed;
                    Visible = false;

                    //Enabled = not OpenApprovalEntriesExist;
                    trigger OnValidate()
                    var
                        InternalRequestHeader: Record "Internal Request Header";
                    begin
                        InternalRequestHeader.SetRange("No.", Rec."Document No.");
                        InternalRequestHeader.SetRange(Status, InternalRequestHeader.Status::Released);
                        if not InternalRequestHeader.FindFirst() then Error('Document not approved');
                        if Rec.completed then error('You cannot modify if the PO has already been created')
                    end;
                }
                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completed field.', Comment = '%';
                    Editable = false;
                    Visible = false;
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO No. field.', Comment = '%';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = NOT IsStatusPending;
                    Visible = ShowDim;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = NOT IsStatusPending;
                    Visible = ShowDim;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Approved Budget Amount"; Rec."Approved Budget Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Plan Amount';
                    Visible = false;
                }
                field("Commitment Amount"; Rec."Commitment Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Actual Expense"; Rec."Actual Expense")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Available amount"; Rec."Available amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("<Control21>"; ShortcutDimCode[8])
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,2,8';
                    Caption = '<Control21>';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Quantity Ordered"; Rec."Quantity Received")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quantity Ordered';
                    Visible = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = NOT IsStatusPending;
                    // Visible = ShowSupplier;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Quantity Expected"; ExpectedQty)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Total Estimated Cost"; Rec."Total Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Total Estimated Cost field.';
                    ApplicationArea = All;
                    Caption = 'Planned Estimated Cost';
                    Visible = false;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = NOT IsStatusPending;
                    Visible = false;
                }
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
}

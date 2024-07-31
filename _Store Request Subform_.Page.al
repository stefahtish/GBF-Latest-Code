page 50768 "Store Request Subform"
{
    PageType = ListPart;
    SourceTable = "Internal Request Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    Enabled = NOT CanEdit AND NOT IsStatusPending;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Enabled = NOT CanEdit AND NOT IsStatusPending;
                }
                field("No."; Rec."No.")
                {
                    Enabled = NOT CanEdit AND NOT IsStatusPending;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Enabled = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Enabled = NOT CanEdit AND NOT IsStatusPending;
                }
                field(Quantity; Rec.Quantity)
                {
                    Enabled = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Quantity In Stock"; Rec."Quantity In Stock")
                {
                    Editable = false;
                }
                field("Qty. to Issue"; Rec."Qty. to Issue")
                {
                    Enabled = CanEdit AND NOT IsStatusPending;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        LineFieldEditable();
                        CurrPage.Update();
                    end;
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    // Editable = CanEdit;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Visible = false;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    Visible = RemarksVisible;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Editable = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = NOT CanEdit AND NOT IsStatusPending;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Enabled = NOT CanEdit AND NOT IsStatusPending;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
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
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        LineFieldEditable;
    end;

    trigger OnAfterGetRecord()
    begin
        LineFieldEditable;
    end;

    trigger OnInit()
    begin
        CanEdit := true;
    end;

    trigger OnOpenPage()
    begin
        LineFieldEditable;
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        ShowDim: Boolean;
        CanEdit: Boolean;
        IsStatusPending: Boolean;
        InternalRequestHeader: Record "Internal Request Header";
        RemarksVisible: Boolean;

    procedure ShowFields(MultiDonor: Boolean)
    begin
        if MultiDonor then
            ShowDim := true
        else
            ShowDim := false;
        CurrPage.Update;
    end;

    local procedure LineFieldEditable()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntry: Record "Approval Entry";
        DocStatus: Option Open,Released,"Pending Approval","Pending Prepayment",Canceled,Disapproved,Committed,Fulfilled;
    begin
        if InternalRequestHeader.Get(Rec."Document No.") then begin
            DocStatus := InternalRequestHeader.Status;
            case InternalRequestHeader.Status of
                InternalRequestHeader.Status::Released:
                    begin
                        CanEdit := true;
                        IsStatusPending := false;
                    end;
                InternalRequestHeader.Status::"Pending Approval":
                    begin
                        CanEdit := false;
                        IsStatusPending := true;
                    end
                else
                    CanEdit := false;
                    IsStatusPending := false;
            end;
        end;
        if Rec.Quantity > Rec."Qty. to Issue" then
            RemarksVisible := true
        else
            RemarksVisible := false;
    end;
}

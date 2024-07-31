page 50155 "Staff Claim Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Payment Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    Caption = 'Claim Type';
                    ShowMandatory = true;
                    Editable = IsRecordEditable;

                }
                field("Account Type"; Rec."Account Type")
                {
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = IsRecordEditable;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ShowMandatory = true;
                    Editable = IsRecordEditable;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the related project.';
                    Editable = IsRecordEditable;
                    trigger OnValidate()
                    begin
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the related project task.';
                    Editable = IsRecordEditable;
                    trigger OnValidate()
                    begin
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = IsRecordEditable;
                    ShowMandatory = true;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }   //Editable = PageEditable;
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    trigger OnValidate()
                    begin
                        //TestField("Shortcut Dimension 1 Code");
                    end;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = IsRecordEditable;
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
                        if ShortcutDimCode[5] = '' then Error(ERROR001);
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
                        if ShortcutDimCode[6] = '' then Error(ERROR002);
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
                field("Claim Receipt No."; Rec."Claim Receipt No.")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Expenditure Date"; Rec."Expenditure Date")
                {
                    ShowMandatory = true;
                    Editable = IsRecordEditable;
                }
                field("Expenditure Description"; Rec."Expenditure Description")
                {
                    ShowMandatory = true;
                    Editable = IsRecordEditable;
                }
                field(No; Rec.No)
                {
                    Enabled = false;
                    Editable = IsRecordEditable;
                }
                field("Line No"; Rec."Line No")
                {
                    Enabled = false;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Enabled = false;
                    Editable = IsRecordEditable;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Dimensions)
            {
                Enabled = false;
                Image = Dimensions;

                trigger OnAction()
                begin
                    Rec.ShowDimensions;
                    CurrPage.SaveRecord;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        IsRecordEditable := Rec.Status <> Rec.Status::Released;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        IsRecordEditable := Rec.Status <> Rec.Status::Released;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes;
        IsRecordEditable := Rec.Status <> Rec.Status::Released;
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        ShowDim: Boolean;
        ERROR001: Label 'Activity must have a value';
        ERROR002: Label 'Sub Activity must have a value';
        IsRecordEditable: Boolean;



    procedure ShowFields(MultiDonor: Boolean)
    begin
        if MultiDonor then
            ShowDim := true
        else
            ShowDim := false;
        CurrPage.Update;
    end;



}

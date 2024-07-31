page 50139 "Imprest Surrender Lines"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
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
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Receiving Bank"; Rec."Receiving Bank")
                {
                    ApplicationArea = all;
                    Visible = Show;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ApplicationArea = all;
                    Enabled = NOT Show;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    ApplicationArea = all;
                    Editable = CashReceiptEditable;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Imprest Receipt No."; Rec."Imprest Receipt No.")
                {
                    ApplicationArea = all;
                    Caption = 'Surrender Receipt No.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = NOT EditColumn;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = NOT EditColumn;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    ApplicationArea = all;
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
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    Editable = NOT EditColumn;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    ApplicationArea = all;
                    Editable = NOT EditColumn;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                }
                field(No; Rec.No)
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Line No"; Rec."Line No")
                {
                    Enabled = false;
                    ApplicationArea = all;
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
        ShowColumns();
        EditColumn := Rec.ImprestLineExist();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EditColumn := Rec.ImprestLineExist();
        Rec.InsertPaymentTypes;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EditColumn := Rec.ImprestLineExist();
    end;

    trigger OnOpenPage()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        EditColumn := Rec.ImprestLineExist();
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        PaymentRec: Record Payments;
        [InDataSet]
        Show: Boolean;
        [InDataSet]
        EditColumn: Boolean;
        CashReceiptEditable: Boolean;

    procedure ShowColumns()
    begin
        Show := false;
        if PaymentRec.Get(Rec.No) then;
        if (PaymentRec.Status = PaymentRec.Status::Released) and (Rec."Imprest Receipt No." = '') then begin
            Show := true;
        end;
        if Rec."Imprest Receipt No." <> '' then
            CashReceiptEditable := false
        else
            CashReceiptEditable := true;
    end;
}

page 50730 "Imprest Surrender Lines2"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Payment Lines";
    SourceTableView = where("Line Type" = filter("Running Cost"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    Caption = 'Imprest Type';
                    ShowMandatory = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Visible = Released;
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    Visible = Released;
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Visible = Released;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    //Enabled = NOT Show;
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    //Editable = CashReceiptEditable;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    //Editable = false;
                }
                field("Imprest Receipt No."; Rec."Imprest Receipt No.")
                {
                    Caption = 'Surrender Receipt No.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Shortcut Dimension 1 Code");
                    end;
                }
                field(No; Rec.No)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Visible = false;
                    ApplicationArea = All;
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
                ApplicationArea = All;

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
        // ShowShortcutDimCode(ShortcutDimCode);
        ShowColumns();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.InsertPaymentTypes;
        Rec."Line Type" := Rec."Line Type"::"Running Cost";
        //ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes;
        //ShowFields();
        Rec."Line Type" := Rec."Line Type"::"Running Cost";
    end;

    var
        PaymentRec: Record Payments;
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        ShowDim: Boolean;
        ERROR001: Label 'Activity must have a value';
        ERROR002: Label 'Sub Activity must have a value';
        Released: Boolean;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    procedure ShowColumns()
    begin
        Released := false;
        if PaymentRec.Get(Rec.No) then;
        if (PaymentRec.Status = PaymentRec.Status::Released) and (Rec."Imprest Receipt No." = '') then begin
            Released := true;
        end;
    end;
}

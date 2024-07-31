page 50196 "Imprest Lines2"
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Visible = false;
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
        ShowFields();
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

    procedure ShowFields()
    begin
    end;
}

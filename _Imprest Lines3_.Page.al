page 50198 "Imprest Lines3"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Payment Lines";
    SourceTableView = where("Line Type" = filter(Item));
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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Estimated Unit Cost"; Rec."Estimated Unit Cost")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;

                    // Enabled = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Activity Maximum Amount"; Rec."Activity Maximum Amount")
                {
                    Visible = IsActivity;
                    Caption = 'Planned Amount';
                    ApplicationArea = All;
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
        Rec."Line Type" := Rec."Line Type"::Item;
        //ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes;
        //ShowFields();
        Rec."Line Type" := Rec."Line Type"::Item;
    end;

    var
        PaymentRec: Record Payments;
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        ShowDim: Boolean;
        IsActivity: Boolean;
        ERROR001: Label 'Activity must have a value';
        ERROR002: Label 'Sub Activity must have a value';

    procedure ShowFields()
    begin
        IsActivity := false;
        PaymentRec.Reset();
        PaymentRec.SetRange("No.", Rec.No);
        if PaymentRec.FindFirst() then begin
            if PaymentRec.Requisition = true then begin
                IsActivity := true;
            end;
        end;
    end;
}

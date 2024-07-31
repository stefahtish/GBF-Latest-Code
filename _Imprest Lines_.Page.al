page 50133 "Imprest Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Payment Lines";
    ApplicationArea = All;

    //  RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    // Enabled = EditableTrue;
                    Caption = 'Imprest Type';
                    ApplicationArea = basic, suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    VAR
                        payment: Record Payments;
                    begin
                        CurrPage.Update();

                    end;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = basic, suite;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = true;
                    ApplicationArea = basic, suite;

                    // trigger OnValidate()
                    // var
                    //     PaymentLine: Record "Payment Lines";
                    //     Pyament: record payments;
                    // begin
                    //     PaymentLine.Reset;
                    //     // PaymentLine.SetRange("Payment Type", "Payment Type");
                    //     PaymentLine.SetRange(No, Pyament."No.");
                    //     if PaymentLine.FindSet() then begin
                    //         PaymentLine."Shortcut Dimension 1 Code" := Pyament."Shortcut Dimension 1 Code";
                    //         PaymentLine."Shortcut Dimension 2 Code" := Pyament."Shortcut Dimension 2 Code";
                    //         PaymentLine.Modify()
                    //     end;
                    // end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = basic, suite;
                }
                field(Description; Rec.Description)
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the related project.';

                    trigger OnValidate()
                    var
                        PaymentLine: record "Payment Lines";
                        pay: record payments;
                    begin
                        PaymentLine.Reset;
                        // PaymentLine.SetRange("Payment Type", "Payment Type");
                        PaymentLine.SetRange(No, pay."No.");
                        if PaymentLine.FindSet() then begin
                            PaymentLine."Shortcut Dimension 1 Code" := rec."Shortcut Dimension 1 Code";
                            PaymentLine."Shortcut Dimension 2 Code" := rec."Shortcut Dimension 2 Code";
                            PaymentLine.Modify()
                        end;

                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the related project task.';

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the project planning line number that the usage should be linked to when the project journal is posted. You can only link to project planning lines that have the Apply Usage Link option enabled.';
                    Visible = false;
                }
                field("Based On Travel Rates"; Rec."Based On Travel Rates")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field("No of Days"; Rec."No of Days")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field(Amount; Rec.Amount)
                {
                    // Enabled = EditableTrue;
                    Caption = 'Total Amount';
                    ApplicationArea = basic, suite;

                    trigger OnValidate()
                    var

                    begin
                        ValidatePaymentNarration();
                        CurrPage.Update();
                    end;


                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Shortcut Dimension 1 Code");
                    end;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    Enabled = false;
                    CaptionClass = '1,2,3';
                    ApplicationArea = basic, suite;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    Enabled = false;
                    CaptionClass = '1,2,4';
                    ApplicationArea = basic, suite;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    Enabled = false;
                    CaptionClass = '1,2,5';
                    ApplicationArea = basic, suite;
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
                    Enabled = false;
                    CaptionClass = '1,2,6';
                    ApplicationArea = basic, suite;
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
                    Enabled = false;
                    CaptionClass = '1,2,7';
                    ApplicationArea = basic, suite;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    Enabled = false;
                    CaptionClass = '1,2,8';
                    ApplicationArea = basic, suite;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                    Visible = false;
                }
                field(No; Rec.No)
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field("Line No"; Rec."Line No")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Enabled = false;
                    ApplicationArea = basic, suite;
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
                ApplicationArea = basic, suite;

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
        PaymentRec.reset();
        PaymentRec.SetRange("No.", Rec.No);
        If PaymentRec.FindFirst() then begin
            If PaymentRec.Status = PaymentRec.Status::Released then begin
                EditableTrue := false;
            end
            else begin
                EditableTrue := true;
            end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.InsertPaymentTypes;
        //ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes;
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        ShowDim: Boolean;
        ERROR001: Label 'Activity must have a value';
        ERROR002: Label 'Sub Activity must have a value';
        PaymentRec: Record "Payments";
        EditableTrue: Boolean;

    procedure ShowFields(MultiDonor: Boolean)
    begin
        if MultiDonor then
            ShowDim := true
        else
            ShowDim := false;
        CurrPage.Update;
    end;

    procedure ValidatePaymentNarration()
    var
        PaymentLine: record "Payment Lines";
        Payments: Record Payments;
    begin
        PaymentLine.Reset;
        PaymentLine.SetRange(No, Payments."No.");
        if PaymentLine.FindSet() then begin
            PaymentLine."Shortcut Dimension 1 Code" := Payments."Shortcut Dimension 1 Code";
            PaymentLine."Shortcut Dimension 2 Code" := Payments."Shortcut Dimension 2 Code";
            PaymentLine.Modify();
        end;
    end;

}

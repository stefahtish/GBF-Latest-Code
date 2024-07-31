page 50797 "EFT File Gen Lines"
{
    caption = 'Payment File Gen Lines';
    AutoSplitKey = true;
    DeleteAllowed = false;
    // Editable = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "EFT Lines New";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ToolTip = 'Specifies the value of the Total VAT Amount field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Total Witholding Tax Amount field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pop Code"; Rec."Pop Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pop Code field.';
                    Editable = false;
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee Name field.';
                }
                field("Payee Bank Account No"; Rec."Payee Bank Account No")
                {
                    ToolTip = 'Specifies the value of the Payee Bank Account No field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payee Bank Code"; Rec."Payee Bank Code")
                {
                    ToolTip = 'Specifies the value of the Payee Bank Code field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payee Bank Branch Code"; Rec."Payee Bank Branch Code")
                {
                    ToolTip = 'Specifies the value of the Payee Bank Branch Code field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payee Email"; Rec."Payee Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payee Email field.';
                }
                field("Payment Description1"; Rec."Payment Description1")
                {
                    ToolTip = 'Specifies the value of the Payment Description1 field.';
                    ApplicationArea = All;
                }
                field("Payment Description2"; Rec."Payment Description2")
                {
                    ToolTip = 'Specifies the value of the Payment Description2 field.';
                    ApplicationArea = All;
                }
                field("Payment Description3"; Rec."Payment Description3")
                {
                    ToolTip = 'Specifies the value of the Payment Description3 field.';
                    ApplicationArea = All;
                }
                field("Payment Description4"; Rec."Payment Description4")
                {
                    ToolTip = 'Specifies the value of the Payment Description4 field.';
                    ApplicationArea = All;
                }
                field("Purpose Pay"; Rec."Purpose Pay")
                {
                    ToolTip = 'Specifies the value of the Purpose Pay field.';
                    ApplicationArea = All;
                }
                field("Customer Ref"; Rec."Customer Ref")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Customer Ref field';
                }
                field("Pmt Document Path"; Rec."Pmt Document Path")
                {
                    Caption = 'Document path';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(PRN; Rec.PRN)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the PRN field';
                }
                field("Payee Bank Code Name"; Rec."Payee Bank Code Name")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Payee Bank Code Name field';
                    ApplicationArea = All;
                }
                field("Payee Bank Branch Name"; Rec."Payee Bank Branch Name")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Payee Bank Branch Name field';
                    ApplicationArea = All;
                }
                field("Payee Swift Code"; Rec."Payee Swift Code")
                {
                    ToolTip = 'Specifies the value of the Payee Swift Code field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ToolTip = 'Specifies the value of the Cashier field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ToolTip = 'Specifies the value of the Payment Narration field';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("PV Posted"; Rec."PV Posted")
                {
                    ToolTip = 'Specifies the value of the PV Posted field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("S2B Customer Ref"; Rec."S2B Customer Ref")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(View)
            {
                Caption = 'View Document';
                Image = View;
                RunObject = Page "Approved/Posted PV Card";
                RunPageLink = "No." = FIELD("No.");
                RunPageMode = View;
                ToolTip = 'Executes the View Document action';
                ApplicationArea = All;
            }
            separator(Separator30)
            {
            }
            action(Unselect)
            {
                Caption = 'Unselect Document';
                Image = RemoveLine;
                visible = not CanMarkUnsuccessfull;
                ToolTip = 'Executes the Unselect Document action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to unselect this document(s)', false, Rec."No.") then begin
                        CurrPage.SetSelectionFilter(EFTFiles);
                        EFTFiles.FindSet();
                        repeat
                            if Payments.Get(EFTFiles."No.") then begin
                                Payments.Select := false;
                                Payments."EFT File Generated" := false;
                                Payments."EFT Reference" := '';
                                Payments."EFT Date" := 0D;
                                Payments."Selected By" := '';
                                Payments.Modify;
                            end;
                            EFTFiles.Delete;
                        until EFTFiles.Next() = 0;
                    end;
                end;
            }
            action("Mark as unsuccessful")
            {
                //Caption = 'Unselect Document';
                Image = RemoveLine;
                visible = CanMarkUnsuccessfull;
                //ToolTip = 'Executes the Unselect Document action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this document(s) as unsuccessful', false) then begin
                        CurrPage.SetSelectionFilter(EFTFiles);
                        EFTFiles.FindSet();
                        repeat
                            if Payments.Get(EFTFiles."No.") then begin
                                Payments.Select := false;
                                Payments."Selected By" := '';
                                Payments."EFT File Generated" := false;
                                Payments."EFT Reference" := '';
                                Payments."EFT Date" := 0D;
                                Payments.Modify;
                            end;
                        until EFTFiles.Next() = 0;
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Pmts: Record Payments;
    begin
        Pmts.Reset();
        Pmts.SetRange("Payment Type", Rec."Payment Type"::"EFT File Gen");
        Pmts.SetRange("No.", Rec."Document No.");
        if Pmts.FindFirst() then begin
            if Pmts."EFT File Generated" = true then
                CanMarkUnsuccessfull := true
            else
                CanMarkUnsuccessfull := false;
        end;
    end;

    trigger OnOpenPage()
    var
        Pmts: Record Payments;
    begin
        Pmts.Reset();
        Pmts.SetRange("Payment Type", Rec."Payment Type"::"EFT File Gen");
        Pmts.SetRange("No.", Rec."Document No.");
        if Pmts.FindFirst() then begin
            if Pmts."EFT File Generated" = true then
                CanMarkUnsuccessfull := true
            else
                CanMarkUnsuccessfull := false;
        end;
    end;

    var
        PVCard: Page "Approved/Posted PV Card";
        Payments: Record Payments;
        CanMarkUnsuccessfull: Boolean;
        EFTFiles: Record "EFT Lines New";
}

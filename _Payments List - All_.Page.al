page 50799 "Payments List - All"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = Payments;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    Caption = 'Select Payment';
                    ToolTip = 'Specifies the value of the Select Payment field';
                    ApplicationArea = All;
                }
                field("Selected By"; Rec."Selected By")
                {
                    ToolTip = 'Specifies the value of the Selected By field';
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document Type field';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                    ApplicationArea = All;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Net Amount field';
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Amount field';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pay Mode field';
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payee field';
                    ApplicationArea = All;
                }
                field("Created By User Name"; Rec."Created By User Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

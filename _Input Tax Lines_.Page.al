page 50299 "Input Tax Lines"
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
                    Caption = 'Type';
                    ShowMandatory = true;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Visible = NOT DocReleased;
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc Type")
                {
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Apply Entries")
            {
                Caption = 'Apply Entries';
                Ellipsis = true;
                Image = ApplyEntries;
                ShortCutKey = 'Shift+F11';
                ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';
                Visible = NOT DocPosted;

                trigger OnAction()
                begin
                    PaymentMgt.ApplyEntry(Rec);
                end;
            }
            action("View Applied Entries")
            {
                Image = Approve;
                Visible = DocPosted;

                trigger OnAction()
                begin
                    PaymentMgt.ViewAppliedEntries(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetPageView;
    end;

    trigger OnInit()
    begin
        DocReleased := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes;
    end;

    trigger OnOpenPage()
    begin
        SetPageView;
    end;

    var
        PaymentMgt: Codeunit "Payments Management";
        DocReleased: Boolean;
        DocPosted: Boolean;
        Payments: Record Payments;

    local procedure SetPageView()
    begin
        if Payments.Get(Rec.No) then begin
            if Payments.Status = Payments.Status::Released then
                DocReleased := true
            else
                DocReleased := false;
            if Payments.Posted then
                DocPosted := true
            else
                DocPosted := false;
        end;
    end;
}

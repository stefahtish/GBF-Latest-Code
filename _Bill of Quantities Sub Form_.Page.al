page 51364 "Bill of Quantities Sub Form"
{
    UsageCategory = lists;
    PageType = ListPart;
    SourceTable = "Tender Evaluation Line";
    SourceTableView = WHERE("Awarded"=FILTER(true));
    applicationarea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No"; Rec."Vendor No")
                {
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    visible = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    visible = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Specifies the value of the Quantity Received field.';
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    Editable = false;
                }
                field("Negotiated Unit Amount"; Rec."Negotiated Unit Amount")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    Editable = false;
                    visible = false;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Editable = false;
                    visible = false;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = false;
                    visible = false;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Visible = false;
                //visible=false;
                }
                field(Suggested; Rec.Suggested)
                {
                    Editable = false;
                    visible = false;
                }
                field(Awarded; Rec.Awarded)
                {
                    Caption = 'Award';
                    Editable = false;
                    visible = false;
                }
                field(Comment; Rec.Comment)
                {
                    Editable = false;
                    visible = false;
                }
                field("Quote No"; Rec."Quote No")
                {
                    Editable = false;
                    visible = false;
                }
            }
        }
    }
    actions
    {
    }
// trigger OnAfterGetRecord()
// begin
//     //SetcontrolAppearance();
// end;
// var
//     Negotiation: Boolean;
// procedure SetcontrolAppearance()
// var
//     TenderEval: Record "Tender Evaluation Header";
// begin
//     TenderEval.SetRange("Quote No", "Quote No");
//     if TenderEval.FindFirst() then begin
//         if TenderEval.Stage = TenderEval.Stage::Negotiation then
//             Negotiation := true
//         else
//             Negotiation := false;
//     end;
// end;
}

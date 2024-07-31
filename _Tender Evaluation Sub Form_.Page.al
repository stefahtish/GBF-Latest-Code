page 50804 "Tender Evaluation Sub Form"
{
    PageType = ListPart;
    SourceTable = "Tender Evaluation Line";
    ApplicationArea = All;

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
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = all;
                }
                /*field("Unit Amount"; "Unit Amount")
                {
                }*/
                field("Negotiated Unit Amount"; Rec."Negotiated Unit Amount")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("Negotiated Amount"; Rec."Negotiated Amount")
                {
                    Visible = Negotiation;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    Editable = false;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = false;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Visible = false;
                }
                field(Suggested; Rec.Suggested)
                {
                    Editable = false;
                }
                field(Awarded; Rec.Awarded)
                {
                    Caption = 'Awarded';
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Quote No"; Rec."Quote No")
                {
                    Visible = false;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Award Manually")
            {
                ApplicationArea = All;
                Image = AddWatch;

                trigger OnAction()
                var
                    TenderEvalLine: Record "Tender Evaluation Line";
                    TenderEvalLine2: Record "Tender Evaluation Line";
                    TenderEvalLine3: Record "Tender Evaluation Line";
                    ProcRequest: Record "Procurement Request";
                begin
                    ProcRequest.Reset();
                    ProcRequest.SetRange("No.", Rec."Quote No");
                    if ProcRequest.FindFirst() then begin
                        if (ProcRequest.Status = ProcRequest.Status::Approved) OR (ProcRequest.Status = ProcRequest.Status::"Pending Approval") then Error('This action cannot be performed for tenders pending approval or those approved');
                    end;
                    TenderEvalLine.Reset();
                    TenderEvalLine.SetRange("No.", Rec."No.");
                    TenderEvalLine.SetRange(Awarded, true);
                    TenderEvalLine.SetRange("Quote No", Rec."Quote No");
                    TenderEvalLine.SetRange("Vendor No", Rec."Vendor No");
                    if TenderEvalLine.FindFirst() then
                        Error('The selected line has already been awarded.')
                    else begin
                        Rec.TestField(Comment);
                        TenderEvalLine2.Reset();
                        TenderEvalLine2.SetRange("No.", Rec."No.");
                        TenderEvalLine2.SetRange("Quote No", Rec."Quote No");
                        TenderEvalLine2.SetRange("Vendor No", Rec."Vendor No");
                        TenderEvalLine2.SetRange(Awarded, true);
                        if TenderEvalLine2.FindFirst() then
                            Error('The selected line has already been awarded')
                        else begin
                            TenderEvalLine3.Reset();
                            TenderEvalLine3.SetRange("No.", Rec."No.");
                            TenderEvalLine3.SetRange("Quote No", Rec."Quote No");
                            TenderEvalLine3.SetRange(Awarded, true);
                            TenderEvalLine3.SetRange("Line No", Rec."Line No");
                            if TenderEvalLine3.FindSet() then
                                repeat
                                    TenderEvalLine3.Awarded := false;
                                    TenderEvalLine3.Modify();
                                until TenderEvalLine3.Next() = 0;
                        end;
                        Rec.Awarded := true;
                        Rec.Modify();
                    end;
                    Message(StrSubstNo('Vendor %1 has been successfully awarded'), Rec."Vendor No");
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetcontrolAppearance();
    end;

    var
        Negotiation: Boolean;

    procedure SetcontrolAppearance()
    var
        TenderEval: Record "Tender Evaluation Header";
    begin
        /*TenderEval.SetRange("Quote No", "Quote No");
            if TenderEval.FindFirst() then begin
                if TenderEval.Stage = TenderEval.Stage::Negotiation then
                    Negotiation := true
                else
                    Negotiation := false;
            end;*/
    end;
}

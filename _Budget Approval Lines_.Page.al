page 50272 "Budget Approval Lines"
{
    PageType = ListPart;
    SourceTable = "Budget Approval Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    Visible = false;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field(Date; Rec.Date)
                {
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Document No." <> '' then begin
            BudgetApprovalHeader.Reset;
            BudgetApprovalHeader.SetRange(BudgetApprovalHeader."Document No.", Rec."Document No.");
            if BudgetApprovalHeader.FindFirst then begin
                if BudgetApprovalHeader."Budget Name" = '' then
                    BudgetApprovalHeader.TestField("Budget Name")
                else begin
                    Rec."Budget Name" := BudgetApprovalHeader."Budget Name";
                    Rec."Global Dimension 1 Code" := BudgetApprovalHeader."Global Dimension 1 Code";
                    Rec."Global Dimension 2 Code" := BudgetApprovalHeader."Global Dimension 2 Code";
                    Rec.Validate("Global Dimension 1 Code");
                    Rec.Validate("Global Dimension 2 Code");
                    Rec."User ID" := UserId;
                    Rec.Date := CalcDate('<CM-1M+1D>', Today);
                end;
            end;
        end;
    end;

    var
        BudgetApprovalHeader: Record "Budget Approval Header";
}

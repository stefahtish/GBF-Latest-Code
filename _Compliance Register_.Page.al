page 51185 "Compliance Register"
{
    Caption = 'Compliance Card';
    PageType = Card;
    SourceTable = "Audit Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Code';
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date Created';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
            }
            part(ComplianceRegSubform; "Compliance Reg. Subform")
            {
                Caption = 'Compliance Subform';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Compliance);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Audit.RESET;
                    Audit.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Compliance Register", TRUE, FALSE, Audit);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Compliance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Compliance;
    end;

    var
        Audit: Record "Audit Header";
}

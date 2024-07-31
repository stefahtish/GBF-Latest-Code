page 51226 "Department Risk Register Card"
{
    Caption = 'Department Risk Register';
    PageType = Card;
    Editable = false;
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
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Sender E-Mail"; Rec."Sender E-Mail")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                }
            }
            part(Control11; "Operations Risk")
            {
                Caption = 'Risk Category';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Internal Risk");
            }
            part(Control12; "External Risks")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("External Risk");
            }
            part(Control13; "Risk Mitigation Proposal")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Mitigation");
                Visible = false;
            }
            part(Control14; "Risk Opportunities")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Opportunities");
                Visible = false;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Survey Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditHead.RESET;
                    AuditHead.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Risk Survey", TRUE, FALSE, AuditHead);
                end;
            }
        }
    }
    var
        AuditHead: Record "Audit Header";
}

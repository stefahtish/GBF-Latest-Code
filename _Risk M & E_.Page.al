page 51197 "Risk M & E"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Risk Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("M & E Type"; Rec."M & E Type")
                {
                }
                field("No."; Rec."ME Line No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Mitigation Status"; Rec."Mitigation Status")
                {
                    Editable = Rec."M & E Type" = Rec."M & E Type"::Mitigation;
                }
                field("KRI(s) Status"; Rec."KRI(s) Status")
                {
                    Editable = Rec."M & E Type" = Rec."M & E Type"::KRI;
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Update Frequency"; Rec."Update Frequency")
                {
                }
                field("Update Date"; Rec."Update Date")
                {
                }
                field("Update Stopped"; Rec."Update Stopped")
                {
                }
                field("Send to Register"; Rec."Send to Register")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("KRI(s)")
            {
                Image = DocumentEdit;

                trigger OnAction()
                begin
                    RiskMgt.GetRiskKRI(Rec, TRUE);
                end;
            }
            action(Mitigation)
            {
                Image = DocumentEdit;

                trigger OnAction()
                begin
                    RiskMgt.GetRiskKRI(Rec, FALSE);
                end;
            }
            action("Update Status")
            {
                Image = DocumentEdit;

                trigger OnAction()
                begin
                    //RiskMgt.UpdateRiskMitigation(Rec);
                    RiskMgt.UpdateRiskMitigation2(Rec);
                end;
            }
        }
    }
    var
        RiskMgt: Codeunit "Internal Audit Management";
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

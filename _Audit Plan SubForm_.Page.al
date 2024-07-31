page 51165 "Audit Plan SubForm"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AuditArea; DNotesText)
                {
                    Caption = 'Area of Audit Valuation';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Description);
                        rec.Description.CREATEINSTREAM(Instr);
                        DNotes.READ(Instr);
                        IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                            CLEAR(Rec.Description);
                            CLEAR(DNotes);
                            DNotes.ADDTEXT(DNotesText);
                            rec.Description.CREATEOUTSTREAM(OutStr);
                            DNotes.WRITE(OutStr);
                        END;
                    end;
                }
                field("Review Type"; Rec."Review Type")
                {
                    ApplicationArea = All;
                }
                field(Days; Rec.Days)
                {
                    Caption = 'Current year';
                    ApplicationArea = All;
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                }
                field(FieldWork; Rec.FieldWork)
                {
                    ApplicationArea = All;
                }
                field("Report to Audit Committee"; Rec."Report to Audit Committee")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Assessment Rating"; Rec."Assessment Rating")
                {
                    Caption = 'Risk Assessment Rating';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Audit Type"; Rec."Audit Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Audit Type Description"; Rec."Audit Type Description")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS(Description);
        rec.Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Description);
        rec.Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

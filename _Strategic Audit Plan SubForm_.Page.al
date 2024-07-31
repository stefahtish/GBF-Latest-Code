page 51238 "Strategic Audit Plan SubForm"
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
                    Caption = 'Key risks to be audited';
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
                field("Audit Category"; Rec."Audit Category")
                {
                    ApplicationArea = All;
                }
                field("Audit Subcategory"; Rec."Audit Subcategory")
                {
                    ApplicationArea = All;
                }
                field("Audit Subctegory description"; Rec."Audit Subctegory description")
                {
                    ApplicationArea = All;
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                    Caption = 'Risk assessment';
                    ApplicationArea = All;
                }
                field("Audit Frequency"; Rec."Audit Frequency")
                {
                    Caption = 'Audit frequency (1,2 or 3 year rotation)';
                    ApplicationArea = All;
                }
                field("Year 1"; Rec."Year 1")
                {
                    ApplicationArea = All;
                }
                field("Year 2"; Rec."Year 2")
                {
                    ApplicationArea = All;
                }
                field("Year 3"; Rec."Year 3")
                {
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

page 50921 "Audit Scope"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scope Selected"; Rec."Scope Selected")
                {
                    Editable = true;
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'No.';
                    Visible = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Scope';
                    Editable = FieldEditable;
                }
                field(Description; DNotesText)
                {
                    Caption = 'Audit Area Scope';
                    Editable = FieldEditable;

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
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    Editable = FieldEditable;
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
        GetHeader();
        FieldEditable := true;
        if AuditHeader.Status = AuditHeader.Status::Released then FieldEditable := false;
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
        AuditHeader: Record "Audit Header";
        FieldEditable: Boolean;

    procedure GetSelectionFilter(): Text
    var
        AuditLine: Record "Audit Lines";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(AuditLine);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForProgramScope(AuditLine));
    end;

    local procedure SelectInScopeListPart(var AuditLine: Record "Audit Lines"): Text
    var
        AuditProgScope: Page "Audit Scope";
    begin
        AuditProgScope.SETTABLEVIEW(AuditLine);
        AuditProgScope.LOOKUPMODE(TRUE);
        IF AuditProgScope.RUNMODAL = ACTION::LookupOK THEN EXIT(AuditProgScope.GetSelectionFilter);
    end;

    procedure SelectActiveScopeForWorkpaper(AuditHeader: Record "Audit Header"): Text
    var
        AuditLine: Record "Audit Lines";
    begin
        AuditLine.RESET;
        AuditLine.SETRANGE("Document No.", AuditHeader."Audit Program No.");
        AuditLine.SETRANGE("Audit Line Type", AuditLine."Audit Line Type"::Scope);
        EXIT(SelectInScopeListPart(AuditLine));
    end;

    procedure GetHeader()
    begin
        if AuditHeader.get(Rec."Document No.") then;
    end;
}

page 50926 "Workpaper Result"
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
                ShowCaption = false;

                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                }
                field("Test Description"; DNotesTextD2)
                {
                    Caption = 'Notes';

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Description 2 Blob");
                        rec."Description 2 Blob".CREATEINSTREAM(InstrD2);
                        DNotesD2.READ(InstrD2);
                        IF DNotesTextD2 <> FORMAT(DNotesD2) THEN BEGIN
                            CLEAR(Rec."Description 2 Blob");
                            CLEAR(DNotesD2);
                            DNotesD2.ADDTEXT(DNotesTextD2);
                            rec."Description 2 Blob".CREATEOUTSTREAM(OutStrD2);
                            DNotesD2.WRITE(OutStrD2);
                        END;
                    end;
                }
                // field(Image; Image)
                // {
                // }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Description 2 Blob");
        rec."Description 2 Blob".CREATEINSTREAM(InstrD2);
        DNotesD2.READ(InstrD2);
        DNotesTextD2 := FORMAT(DNotesD2);
    end;

    var
        DNotesD2: BigText;
        InstrD2: InStream;
        DNotesTextD2: Text;
        OutStrD2: OutStream;
}

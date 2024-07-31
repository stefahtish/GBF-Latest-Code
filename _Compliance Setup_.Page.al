page 50940 "Compliance Setup"
{
    PageType = Card;
    SourceTable = "Compliance Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Application Dairy managers Nos"; Rec."App Dairy managers No.")
                {
                    Caption = 'Permit Applicant Registration Nos';
                    ApplicationArea = All;
                }
                field("Application Enterprise Nos"; Rec."App Enterprise No.")
                {
                    ApplicationArea = All;
                }
                field("Enforcement Nos"; Rec."Enforcement Nos")
                {
                    ApplicationArea = All;
                }
                field("License/Permit App No."; Rec."License/Permit App No.")
                {
                    Caption = 'Permit Application Nos';
                    ApplicationArea = All;
                }
                field("Monthly Returns No."; Rec."Monthly Returns No.")
                {
                    ApplicationArea = All;
                }
                field("Attachments Path"; Rec."Attachments Path")
                {
                }
                field("License Renewal No."; Rec."License Renewal No.")
                {
                    Caption = 'Regulatory Permit Renewal No.';
                }
                field("License No"; Rec."License No")
                {
                    Caption = 'Regulatory Permit No.';
                }
                field("Compliance Notification Time"; Rec."Compliance Notification Time")
                {
                    ApplicationArea = All;
                }
            }
            group("License Report")
            {
                field("License Background image"; Rec."License Background image")
                {
                    ApplicationArea = All;
                }
                field(Notes; LicenseNotesText)
                {
                    Caption = 'Header';
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Notes);
                        rec.Notes.CREATEINSTREAM(Instr);
                        LicenseNote.READ(Instr);
                        IF LicenseNotesText <> FORMAT(LicenseNote) THEN BEGIN
                            CLEAR(Rec.Notes);
                            CLEAR(LicenseNote);
                            LicenseNote.ADDTEXT(LicenseNotesText);
                            rec.Notes.CREATEOUTSTREAM(OutStr);
                            LicenseNote.WRITE(OutStr);
                        END;
                    end;
                }
            }
            part("License Notes"; "License notes")
            {
                SubPageLink = "Primary Key" = field("Primary Key");
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Notes);
        rec.Notes.CREATEINSTREAM(Instr);
        LicenseNote.READ(Instr);
        LicenseNotesText := FORMAT(LicenseNote);
    end;

    var
        LicenseNote: BigText;
        LicenseNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

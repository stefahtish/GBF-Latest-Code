page 51067 "Antibiotic Residues"
{
    AutoSplitKey = true;
    Caption = 'Antibiotic Residues';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Sulfonamide; Rec.Sulfonamide)
                {
                    ApplicationArea = All;
                }
                field("Beta-Lactam"; Rec."Beta-Lactam")
                {
                    ApplicationArea = All;
                }
                field(Tetracycline; Rec.Tetracycline)
                {
                    ApplicationArea = All;
                }
                field("Remarks(PassFail)"; Rec."Remarks(PassFail)")
                {
                    ApplicationArea = All;
                }
                field("Cannot be done"; Rec."Cannot be done")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

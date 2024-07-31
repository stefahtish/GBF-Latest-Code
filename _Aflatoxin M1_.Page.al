page 51092 "Aflatoxin M1"
{
    Caption = 'Aflatoxin M1';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Results; Rec.Results)
                {
                    Caption = 'Results in ppb';
                    ApplicationArea = All;
                }
                field(Specifications; Rec.Specifications)
                {
                    Caption = 'Specifications in ppb';
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

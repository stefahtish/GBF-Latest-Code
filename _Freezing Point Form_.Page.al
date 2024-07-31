page 51040 "Freezing Point Form"
{
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
                    Caption = 'Results';
                    ApplicationArea = All;
                }
                field(Specifications; Rec.Specifications)
                {
                    Caption = 'Specifications (-0.525˚C to -0.550˚C)';
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

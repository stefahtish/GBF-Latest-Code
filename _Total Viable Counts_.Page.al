page 51078 "Total Viable Counts"
{
    AutoSplitKey = true;
    Caption = 'Total Viable Counts';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Volume inoculated in ml(v)"; Rec."Volume inoculated in ml(v)")
                {
                    ApplicationArea = All;
                }
                field("Number of plates 1st dilution"; Rec."Number of plates 1st dilution")
                {
                    ApplicationArea = All;
                }
                field("Number of plates 2nd dilution"; Rec."Number of plates 2nd dilution")
                {
                    ApplicationArea = All;
                }
                field("Counts 1st dilution"; Rec."Counts 1st dilution")
                {
                    ApplicationArea = All;
                }
                field("Counts 2d dilution"; Rec."Counts 2d dilution")
                {
                    ApplicationArea = All;
                }
                field("Sum of counts(x  + y)"; Rec."Sum of counts(x  + y)")
                {
                    ApplicationArea = All;
                }
                field("Dilution factor used in n1(d)"; Rec."Dilution factor code")
                {
                    ApplicationArea = All;
                }
                field("Constant (0.1)"; Rec."Constant (0.1)")
                {
                    ApplicationArea = All;
                }
                field("Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d"; Rec."Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d")
                {
                    ApplicationArea = All;
                }
                field("Specification (CFU/ml)"; Rec."Specification (CFU/ml)")
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

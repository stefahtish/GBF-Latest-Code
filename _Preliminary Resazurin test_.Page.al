page 51089 "Preliminary Resazurin test"
{
    Caption = 'Preliminary Resazurin test';
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
                field("Resazurin test results"; Rec."Resazurin test results")
                {
                    Caption = 'Resazurin test results (Grade1,2,3,4,5,6)';
                    ApplicationArea = All;
                }
                field("Resazurin Test Specifications"; Rec."Resazurin Test Specifications")
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

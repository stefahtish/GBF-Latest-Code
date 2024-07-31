page 51066 "Preliminary Test"
{
    AutoSplitKey = true;
    Caption = 'Preliminary Test - Alcohol test form';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Alcohol Test Results"; Rec."Alcohol Test Results")
                {
                    ApplicationArea = All;
                }
                field("Alcohol Test Specifications"; Rec."Alcohol Test Specifications2")
                {
                    ApplicationArea = All;
                }
                field("Resazurin test results"; Rec."Resazurin test results")
                {
                    ApplicationArea = All;
                }
                field("Resazurin Test Specifications"; Rec."Resazurin Test Specifications2")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Res: Decimal;
                        Alcohol: Decimal;
                    begin
                        //Res := Format("Resazurin Test Specifications");
                    end;
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

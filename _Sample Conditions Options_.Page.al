page 50981 "Sample Conditions Options"
{
    Caption = 'Sample Conditions Options';
    PageType = List;
    SourceTable = "Sample Condition Options";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Option; Rec.Option)
                {
                    ApplicationArea = All;
                }
                field(Condition; Rec.Condition)
                {
                    ApplicationArea = All;
                }
                field("Batch Number needed"; Rec."Batch Number needed")
                {
                    ApplicationArea = all;
                }
                field("Explanation Needed"; Rec."Explanation Needed")
                {
                    ApplicationArea = All;
                }
                field("Expiry date needed"; Rec."Expiry date needed")
                {
                    ApplicationArea = All;
                }
                field("Has Manufacturing Date"; Rec."Has Manufacturing Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

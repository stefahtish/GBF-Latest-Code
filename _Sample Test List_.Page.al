page 51063 "Sample Test List"
{
    Caption = 'Sample Test List';
    PageType = List;
    CardPageId = "Sample Test Header";
    SourceTable = "Sample Test Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Test No."; Rec."Test No.")
                {
                    ApplicationArea = All;
                }
                field("Lab section"; Rec."Lab section")
                {
                    ApplicationArea = All;
                }
                field(Test; Rec.Test)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = All;
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

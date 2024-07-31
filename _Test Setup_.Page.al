page 50982 "Test Setup"
{
    Caption = 'Test Setup';
    PageType = List;
    SourceTable = "Test Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Test; Rec.Test)
                {
                    ApplicationArea = All;
                }
                field("Test Form"; Rec."Test Form")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

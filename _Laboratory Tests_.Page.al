page 50984 "Laboratory Tests"
{
    Caption = 'Tests to be conducted';
    PageType = List;
    SourceTable = "Laboratory Test Setup";
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
            }
        }
    }
}

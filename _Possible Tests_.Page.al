page 50983 "Possible Tests"
{
    Caption = 'Possible Tests';
    PageType = List;
    SourceTable = "Products Test Setup2";
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

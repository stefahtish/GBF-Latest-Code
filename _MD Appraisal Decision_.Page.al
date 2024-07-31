page 51300 "MD Appraisal Decision"
{
    PageType = ListPart;
    SourceTable = "Appraisal Decision";
    Caption = 'Managing Director Decision';
    SourceTableView = where(Person = filter(MD));
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("MD Decision"; Rec."MD Decision")
                {
                    Caption = 'Decision by Managing Director';
                }
            }
        }
    }
}
